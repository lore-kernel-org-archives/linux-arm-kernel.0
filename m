From: james.morse@arm.com (James Morse)
Date: Fri, 21 Sep 2018 23:16:47 +0100
Subject: [PATCH v6 00/18] APEI in_nmi() rework
Message-ID: <20180921221705.6478-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The GHES driver has collected quite a few bugs:

ghes_proc() at ghes_probe() time can be interrupted by an NMI that
will clobber the ghes->estatus fields, flags, and the buffer_paddr.

ghes_copy_tofrom_phys() uses in_nmi() to decide which path to take. arm64's
SEA taking both paths, depending on what it interrupted.

There is no guarantee that queued memory_failure() errors will be processed
before this CPU returns to user-space.

x86 can't TLBI from interrupt-masked code which this driver does all the
time.


This series aims to fix the first three, with an eye to fixing the
last one with a follow-up series.

Previous postings included the SDEI notification calls, which I haven't
finished re-testing. This series is big enough as it is.


Any NMIlike notification should always be in_nmi(), and should use the
ghes estatus cache to hold the CPER records until they can be processed.

The path through GHES should be nmi-safe, without the need to look at
in_nmi(). Abstract the estatus cache, and re-plumb arm64 to always
nmi_enter() before making the ghes_notify_sea() call.

To remove the use of in_nmi(), the locks are pushed out to the notification
helpers, and the fixmap slot to use is passed in. (A future series could
change as many nnotification helpers as possible to not mask-irqs, and
pass in some GHES_FIXMAP_NONE that indicates ioremap() should be used)

Change the now common _in_nmi_notify_one() to use local estatus/paddr/flags,
instead of clobbering those in the struct ghes.

Finally we try and ensure the memory_failure() work will run before this
CPU returns to user-space where the error may be triggered again.


Changes since v5:
 * Fixed phys_addr_t/u64 that failed to build on 32bit x86.
 * Removed buffer/flags from struct ghes, these are now on the stack.

To make future irq/tlbi fixes easier:
 * Moved the locking further out to make it easier to avoid masking interrupts
   for notifications where it isn't needed.
 * Restored map/unmap helpers so they can use ioremap() when interrupts aren't
   masked.


Feedback welcome,

Thanks

James Morse (18):
  ACPI / APEI: Move the estatus queue code up, and under its own ifdef
  ACPI / APEI: Generalise the estatus queue's add/remove and notify code
  ACPI / APEI: don't wait to serialise with oops messages when
    panic()ing
  ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
  ACPI / APEI: Make estatus queue a Kconfig symbol
  KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
  arm64: KVM/mm: Move SEA handling behind a single 'claim' interface
  ACPI / APEI: Move locking to the notification helper
  ACPI / APEI: Let the notification helper specify the fixmap slot
  ACPI / APEI: preparatory split of ghes->estatus
  ACPI / APEI: Remove silent flag from ghes_read_estatus()
  ACPI / APEI: Don't store CPER records physical address in struct ghes
  ACPI / APEI: Don't update struct ghes' flags in read/clear estatus
  ACPI / APEI: Split ghes_read_estatus() to read CPER length
  ACPI / APEI: Only use queued estatus entry during _in_nmi_notify_one()
  ACPI / APEI: Split fixmap pages for arm64 NMI-like notifications
  mm/memory-failure: increase queued recovery work's priority
  arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work

 arch/arm/include/asm/kvm_ras.h       |  14 +
 arch/arm/include/asm/system_misc.h   |   5 -
 arch/arm64/include/asm/acpi.h        |   4 +
 arch/arm64/include/asm/daifflags.h   |   1 +
 arch/arm64/include/asm/fixmap.h      |   4 +-
 arch/arm64/include/asm/kvm_ras.h     |  25 ++
 arch/arm64/include/asm/system_misc.h |   2 -
 arch/arm64/kernel/acpi.c             |  48 +++
 arch/arm64/mm/fault.c                |  25 +-
 drivers/acpi/apei/Kconfig            |   6 +
 drivers/acpi/apei/ghes.c             | 564 +++++++++++++++------------
 include/acpi/ghes.h                  |   2 -
 mm/memory-failure.c                  |  11 +-
 virt/kvm/arm/mmu.c                   |   4 +-
 14 files changed, 426 insertions(+), 289 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_ras.h
 create mode 100644 arch/arm64/include/asm/kvm_ras.h

-- 
2.19.0
