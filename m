From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 05 Jul 2018 11:50:33 +0200
Subject: [PATCH v5 00/20] APEI in_nmi() rework and arm64 SDEI wire-up
In-Reply-To: <20180626170116.25825-1-james.morse@arm.com>
References: <20180626170116.25825-1-james.morse@arm.com>
Message-ID: <4409985.sv3PbRGN0l@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 26, 2018 7:00:56 PM CEST James Morse wrote:
> The aim of this series is to wire arm64's SDEI into APEI.
> 
> On arm64 we have three APEI notifications that are NMI-like, and
> in the unlikely event that all three are supported by a platform,
> they can interrupt each other.
> The GHES driver shouldn't have to deal with this, so this series aims
> to make it re-entrant.
> 
> To do that, we refactor the estatus queue to allow multiple notifications
> to use it, then convert NOTIFY_SEA to always be described as NMI-like,
> and to use the estatus queue.
> 
> From here we push the locking and fixmap choices out to the notification
> functions, and remove the use of per-ghes estatus and flags. This removes
> the in_nmi() 'timebomb' in ghes_copy_tofrom_phys().
> 
> Things get sticky when an NMI notification needs to know how big the
> CPER records might be, before reading it. This series splits
> ghes_estatus_read() to let us peek at the buffer. A side effect of this
> is the 20byte header will get read twice. (how does it work today? it
> reads the records into a per-ghes worst-case sized buffer, allocates
> the correct size and copies the records. in_nmi() use of this per-ghes
> buffer needs eliminating).
> 
> One alternative was to trust firmware's 'max raw data length' and use
> that to allocate 'enough' memory. We don't use this value today, so its
> probably wrong on some sytem somewhere.
> 
> Since v4 patches 5,8-15 are new, otherwise changes are noted in the patch.
> 
> 
> The earlier boiler-plate:
> 
> What's SDEI? Its ARM's "Software Delegated Exception Interface" [0]. It's
> used by firmware to tell the OS about firmware-first RAS events.
> 
> These Software exceptions can interrupt anything, so I describe them as
> NMI-like. They aren't the only NMI-like way to notify the OS about
> firmware-first RAS events, the ACPI spec also defines 'NOTFIY_SEA' and
> 'NOTIFY_SEI'.
> 
> (Acronyms: SEA, Synchronous External Abort. The CPU requested some memory,
> but the owner of that memory said no. These are always synchronous with the
> instruction that caused them. SEI, System-Error Interrupt, commonly called
> SError. This is an asynchronous external abort, the memory-owner didn't say no
> at the right point. Collectively these things are called external-aborts
> How is firmware involved? It traps these and re-injects them into the kernel
> once its written the CPER records).
> 
> APEI's GHES code only expects one source of NMI. If a platform implements
> more than one of these mechanisms, APEI needs to handle the interaction.
> 'SEA' and 'SEI' can interact as 'SEI' is asynchronous. SDEI can interact
> with itself: its exceptions can be 'normal' or 'critical', and firmware
> could use both types for RAS. (errors using normal, 'panic-now' using
> critical).
> 
> 
> ghes.c became clearer to me when I worked out that it has three sets of
> functions with 'estatus' in the name. One is a pool of memory that can be
> allocated-from atomically. This is grown/shrunk when new NMI users are
> allocated.
> The second is the estatus-cache, which holds recent notifications so it
> can suppress notifications we've already handled.
> The last it the estatus-queue, which holds data from NMI-like notifications
> (in pool memory) to be processed from irq_work.
> 
> 
> Testing?
> Tested with the SDEI FVP based software model and a mocked up NOTFIY_SEA using
> KVM. I've added a case where 'corrected errors' are discovered at probe time
> to exercise ghes_probe() during boot. I've only build tested this on x86.
> 
> This series based on v4.18-rc2 can be retrieved from:
> git://linux-arm.org/linux-jm.git -b apei_sdei/v5
> 
> 
> Thanks,
> 
> James
> 
> [0] http://infocenter.arm.com/help/topic/com.arm.doc.den0054a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf
> 
> James Morse (20):
>   ACPI / APEI: Move the estatus queue code up, and under its own ifdef
>   ACPI / APEI: Generalise the estatus queue's add/remove and notify code
>   ACPI / APEI: don't wait to serialise with oops messages when
>     panic()ing
>   ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
>   ACPI / APEI: Make estatus queue a Kconfig symbol
>   KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
>   arm64: KVM/mm: Move SEA handling behind a single 'claim' interface
>   ACPI / APEI: Move locking to the notification helper
>   ACPI / APEI: Let the notification helper specify the fixmap slot
>   ACPI / APEI: preparatory split of ghes->estatus
>   ACPI / APEI: Remove silent flag from ghes_read_estatus()
>   ACPI / APEI: Don't store CPER records physical address in struct ghes
>   ACPI / APEI: Don't update struct ghes' flags in read/clear estatus
>   ACPI / APEI: Split ghes_read_estatus() to read CPER length
>   ACPI / APEI: Only use queued estatus entry during _in_nmi_notify_one()
>   ACPI / APEI: Split fixmap pages for arm64 NMI-like notifications
>   firmware: arm_sdei: Add ACPI GHES registration helper
>   ACPI / APEI: Add support for the SDEI GHES Notification type
>   mm/memory-failure: increase queued recovery work's priority
>   arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work
> 
>  arch/arm/include/asm/kvm_ras.h       |  14 +
>  arch/arm/include/asm/system_misc.h   |   5 -
>  arch/arm64/include/asm/acpi.h        |   4 +
>  arch/arm64/include/asm/daifflags.h   |   1 +
>  arch/arm64/include/asm/fixmap.h      |   8 +-
>  arch/arm64/include/asm/kvm_ras.h     |  25 ++
>  arch/arm64/include/asm/system_misc.h |   2 -
>  arch/arm64/kernel/acpi.c             |  49 ++
>  arch/arm64/mm/fault.c                |  30 +-
>  drivers/acpi/apei/Kconfig            |  11 +
>  drivers/acpi/apei/ghes.c             | 649 ++++++++++++++++-----------
>  drivers/firmware/Kconfig             |   1 +
>  drivers/firmware/arm_sdei.c          |  66 +++
>  include/acpi/ghes.h                  |   2 -
>  include/linux/arm_sdei.h             |   9 +
>  mm/memory-failure.c                  |  11 +-
>  virt/kvm/arm/mmu.c                   |   4 +-
>  17 files changed, 591 insertions(+), 300 deletions(-)
>  create mode 100644 arch/arm/include/asm/kvm_ras.h
>  create mode 100644 arch/arm64/include/asm/kvm_ras.h

Tony, I need your help with reviewing the APEI-related material here.
Can you please have a look at this series and let me know if there are
any concerns regarding it?

Thanks,
Rafael
