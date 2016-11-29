From: labbott@redhat.com (Laura Abbott)
Date: Tue, 29 Nov 2016 10:55:19 -0800
Subject: [PATCHv4 00/10] CONFIG_DEBUG_VIRTUAL for arm64
Message-ID: <1480445729-27130-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This is v4 of the series to add CONFIG_DEBUG_VIRTUAL for arm64. This mostly
expanded on __pa_symbol conversion with a few new sites found. There's also
some reworking done to avoid calling __va too early. __va relies on having
memstart_addr set so very early code in early_fixmap_init and early KASAN
initialization can't just call __va(__Ipa_symbol(...)) to get the linear map
alias. I found this while testing with DEBUG_VM.

All of this could use probably use more testing under more configurations.
KVM, Xen, kexec, hibernate should all be tested.

Thanks,
Laura

Laura Abbott (10):
  lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
  mm/cma: Cleanup highmem check
  arm64: Move some macros under #ifndef __ASSEMBLY__
  arm64: Add cast for virt_to_pfn
  arm64: Use __pa_symbol for kernel symbols
  xen: Switch to using __pa_symbol
  kexec: Switch to __pa_symbol
  mm/kasan: Switch to using __pa_symbol and lm_alias
  mm/usercopy: Switch to using lm_alias
  arm64: Add support for CONFIG_DEBUG_VIRTUAL

 arch/arm64/Kconfig                        |  1 +
 arch/arm64/include/asm/kvm_mmu.h          |  4 +-
 arch/arm64/include/asm/memory.h           | 67 ++++++++++++++++++++++---------
 arch/arm64/include/asm/mmu_context.h      |  6 +--
 arch/arm64/include/asm/pgtable.h          |  2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/cpu-reset.h             |  2 +-
 arch/arm64/kernel/cpufeature.c            |  2 +-
 arch/arm64/kernel/hibernate.c             | 13 +++---
 arch/arm64/kernel/insn.c                  |  2 +-
 arch/arm64/kernel/psci.c                  |  2 +-
 arch/arm64/kernel/setup.c                 |  8 ++--
 arch/arm64/kernel/smp_spin_table.c        |  2 +-
 arch/arm64/kernel/vdso.c                  |  4 +-
 arch/arm64/mm/Makefile                    |  2 +
 arch/arm64/mm/init.c                      | 11 ++---
 arch/arm64/mm/kasan_init.c                | 21 ++++++----
 arch/arm64/mm/mmu.c                       | 32 +++++++++------
 arch/arm64/mm/physaddr.c                  | 28 +++++++++++++
 arch/x86/Kconfig                          |  1 +
 drivers/firmware/psci.c                   |  2 +-
 drivers/xen/xenbus/xenbus_dev_backend.c   |  2 +-
 drivers/xen/xenfs/xenstored.c             |  2 +-
 include/linux/mm.h                        |  4 ++
 kernel/kexec_core.c                       |  2 +-
 lib/Kconfig.debug                         |  5 ++-
 mm/cma.c                                  | 15 +++----
 mm/kasan/kasan_init.c                     | 12 +++---
 mm/usercopy.c                             |  4 +-
 29 files changed, 167 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm64/mm/physaddr.c

-- 
2.7.4
