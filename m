From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 19 Dec 2017 09:47:46 +0000
Subject: [PATCH 0/6] arm64: provide pseudo NMI with GICv3
In-Reply-To: <1512493912-37478-1-git-send-email-julien.thierry@arm.com>
References: <1512493912-37478-1-git-send-email-julien.thierry@arm.com>
Message-ID: <c34057ef-b190-bb76-91cc-297a20dede7d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just a little Christmas ping on this series.

Cheers,

On 05/12/17 17:11, Julien Thierry wrote:
> Hi,
> 
> This series is a continuation of the work started by Daniel [1]. The goal is
> to use GICv3 interrupt priorities to simulate an NMI.
> 
> To achieve this, set two priorities, one for standard interrupts and
> another, higher priority, for NMIs. Whenever we want to disable interrupts,
> we mask the standard priority instead so NMIs can still be raised. Some
> corner cases though still require to actually mask all interrupts
> effectively disabling the NMI.
> 
> Of course, using priority masking instead of PSR.I comes at some cost. On
> hackbench, I notice a ~6-0% drop of performance. When I submitted the RFC,
> the drop seemed always present, now things seem more variable. On a kernel
> build, there still isn't any significan drop of performance.
> KVM Guests do not seem to be affected preformance-wise by the host using
> PMR to mask interrupts or not.
> 
> Results when using this NMI for the arm_pmu interrupt are rather positive
> (at least for _raw_spin_unlock_irq_restore).
> Perf record on hackbench without NMI:
> 
> # Overhead  Command          Symbol
> # ........  ...............  ...........................................
> #
>      12.45%  hackbench        [k] _raw_spin_unlock_irqrestore
>       6.26%  hackbench        [k] el0_svc_naked
>       5.35%  hackbench        [k] unix_stream_read_generic
>       4.42%  hackbench        [k] __arch_copy_to_user
>       3.87%  hackbench        [k] refcount_inc_not_zero
>       3.70%  hackbench        [k] __slab_free
>       3.66%  hackbench        [k] _raw_spin_unlock_irq
>       3.53%  hackbench        [k] skb_release_data
>       3.10%  hackbench        [k] kmem_cache_free
>       2.90%  hackbench        [k] __lock_text_start
> 
> Perf record on hackbench with PseudoNMI:
> 
> # Overhead  Command          Symbol
> # ........  ...............  .................................
> #
>       8.00%  hackbench        [k] _raw_spin_unlock_irqrestore
>       6.27%  hackbench        [k] el0_svc_naked
>       5.53%  hackbench        [k] unix_stream_read_generic
>       4.40%  hackbench        [k] __arch_copy_to_user
>       3.94%  hackbench        [k] refcount_inc_not_zero
>       3.47%  hackbench        [k] __slab_free
>       3.19%  hackbench        [k] kfree
>       3.11%  hackbench        [k] __lock_text_start
>       2.92%  hackbench        [k] kmem_cache_free
>       2.73%  hackbench        [.] 0x0000000000005258
> 
> 
> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
> for now. I don't think there is any reason LPIs should be allowed to be set
> as NMI as they do not have an active state.
> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
> 
> Requirements to use this:
> - Have GICv3
> - SCR_EL3.FIQ is set to 1 when linux runs
> - Select Kernel Feature -> Use ICC system registers for IRQ masking
> 
> * Patches 1 and 2 allows to detect and enable the use of GICv3 system
>    registers during boot time.
> * Patch 3 introduces the masking of IRQs using priorities replacing irq
>    disabling.
> * Patch 4 adds some utility functions
> * Patch 5 add detection of the view linux has on GICv3 priorities, without
>    this we cannot easily mask specific priorities in an accurate manner
> * Patch 6 adds the support for NMIs
> 
> 
> Changes since RFC[2]:
> * The series was rebased to v4.15-rc2 which implied some changes mainly
>    related to the work on exception entries and daif flags by James Morse.
> 
>    - The first patch in the previous series was dropped because no longer
>      applicable.
> 
>    - With the semantics James introduced of "inheriting" daif flags,
>      handling of PMR on exception entry is simplified as PMR is not altered
>      by taking an exception and already inherited from previous state.
> 
>    - James pointed out that taking a PseudoNMI before reading the FAR_EL1
>      register should not be allowed as per the TRM (D10.2.29):
>      "FAR_EL1 is made UNKNOWN on an exception return from EL1."
>      So in this submission PSR.I bit is cleared only after FAR_EL1 is read.
> 
> * For KVM, only deal with PMR unmasking/restoring in common code, and VHE
>    specific code makes sure PSR.I bit is set when necessary.
> 
> * When detecting the GIC priority view (patch 5), wait for an actual
>    interrupt instead of trying only once.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg525077.html
> [2] https://www.spinics.net/lists/arm-kernel/msg610736.html
> 
> Cheers,
> 
> Julien
> 
> --->
> 
> Daniel Thompson (3):
>    arm64: cpufeature: Allow early detect of specific features
>    arm64: alternative: Apply alternatives early in boot process
>    arm64: irqflags: Use ICC sysregs to implement IRQ masking
> 
> Julien Thierry (3):
>    irqchip/gic: Add functions to access irq priorities
>    arm64: Detect current view of GIC priorities
>    arm64: Add support for pseudo-NMIs
> 
>   Documentation/arm64/booting.txt        |   5 +
>   arch/arm64/Kconfig                     |  15 ++
>   arch/arm64/include/asm/alternative.h   |   1 +
>   arch/arm64/include/asm/arch_gicv3.h    |  42 +++++
>   arch/arm64/include/asm/assembler.h     |  25 ++-
>   arch/arm64/include/asm/daifflags.h     |  36 ++--
>   arch/arm64/include/asm/efi.h           |   5 +
>   arch/arm64/include/asm/irqflags.h      | 131 ++++++++++++++
>   arch/arm64/include/asm/processor.h     |   4 +
>   arch/arm64/include/asm/ptrace.h        |  14 +-
>   arch/arm64/include/asm/sysreg.h        |   1 +
>   arch/arm64/kernel/alternative.c        |  39 ++++-
>   arch/arm64/kernel/asm-offsets.c        |   1 +
>   arch/arm64/kernel/cpufeature.c         |  68 +++++---
>   arch/arm64/kernel/entry.S              |  84 ++++++++-
>   arch/arm64/kernel/head.S               |  38 ++++
>   arch/arm64/kernel/process.c            |   6 +
>   arch/arm64/kernel/smp.c                |  14 ++
>   arch/arm64/kvm/hyp/hyp-entry.S         |  20 +++
>   arch/arm64/kvm/hyp/switch.c            |  21 +++
>   arch/arm64/mm/proc.S                   |  23 +++
>   drivers/irqchip/irq-gic-common.c       |  10 ++
>   drivers/irqchip/irq-gic-common.h       |   2 +
>   drivers/irqchip/irq-gic-v3-its.c       |   2 +-
>   drivers/irqchip/irq-gic-v3.c           | 307 +++++++++++++++++++++++++++++----
>   include/linux/interrupt.h              |   1 +
>   include/linux/irqchip/arm-gic-common.h |   6 +
>   include/linux/irqchip/arm-gic.h        |   5 -
>   28 files changed, 841 insertions(+), 85 deletions(-)
> 
> --
> 1.9.1
> 

-- 
Julien Thierry
