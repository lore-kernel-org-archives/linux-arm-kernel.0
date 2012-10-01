From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 1 Oct 2012 05:09:05 -0400
Subject: [PATCH v2 00/10] KVM/ARM Implementation
In-Reply-To: <20121001090716.49038.90056.stgit@ubuntu>
References: <20121001090716.49038.90056.stgit@ubuntu>
Message-ID: <CANM98qKa62xY29ZLmn9RjZ-5Sk45HOca=HheaqoSMpGmQafxAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2012 at 5:07 AM, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> The following series implements KVM support for ARM processors,
> specifically on the Cortex A-15 platform.  We feel this is ready to be
> merged.
>
> Work is done in collaboration between Columbia University, Virtual Open
> Systems and ARM/Linaro.
>
> The patch series applies to Linux 3.6 with a number of merges:
>  1. git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>         branch: hyp-mode-boot-next (e5a04cb0b4a)
>  2. git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>         branch: timers-next (437814c44c)
>  3. git://git.kernel.org/pub/scm/virt/kvm/kvm.git
>         branch: next (1e08ec4a)
>
> This is Version 12 of the patch series, the first 10 versions were
> reviewed on the KVM/ARM and KVM mailing lists. Changes can also be
> pulled from:
>     git://github.com/virtualopensystems/linux-kvm-arm.git
>         branch: kvm-arm-v12
>         branch: kvm-arm-v12-vgic
>         branch: kvm-arm-v12-vgic-timers
>
> A non-flattened edition of the patch series, which can always be merged,
> can be found at:
>  git://github.com/virtualopensystems/linux-kvm-arm.git kvm-arm-master
>
> This patch series requires QEMU compatibility.  Use the branch
>  git://github.com/virtualopensystems/qemu.git kvm-arm
>
> Following this patch series, which implements core KVM support are two
> other patch series implementing Virtual Generic Interrupt Controller
> (VGIC) support and Architected Generic Timers.  All three patch series
> should be applied for full QEMU compatibility.
>
> The implementation is broken up into a logical set of patches, the first
> are preparatory patches:
>   1. ARM: Add page table defines for KVM
>   3. ARM: Section based HYP idmaps
>   3. ARM: Factor out cpuid implementor and part_number fields
>
> The main implementation is broken up into separate patches, the first
> containing a skeleton of files, makefile changes, the basic user space
> interface and KVM architecture specific stubs.  Subsequent patches
> implement parts of the system as listed:
>   4. Skeleton and reset hooks
>   5. Hypervisor initialization
>   6. Memory virtualization setup (hyp mode mappings and 2nd stage)
>   7. Inject IRQs and FIQs from userspace
>   8. World-switch implementation and Hyp exception vectors
>   9. Emulation framework and coproc emulation
>  10. Coproc user space API
>  11. Demux multiplexed coproc registers
>  12. User spac API to get/set VFP registers
>  13. Handle guest user memory aborts
>  14. Handle guest MMIO aborts
>
> Testing:
>  Tested on FAST Models and Versatile Express test-chip2.  Tested by
>  running three simultaenous VMs, all running SMP, on an SMP host, each
>  VM running hackbench and cyclictest and with extreme memory pressure
>  applied to the host with swapping enabled to provoke page eviction.
>  Also tested KSM merging and GCC inside VMs.  Fully boots both Ubuntu
>  (user space Thumb-2) and Debian (user space ARM) guests.
>
> For a guide on how to set up a testing environment and try out these
> patches, see:
>  http://www.virtualopensystems.com/media/pdf/kvm-arm-guide.pdf
>
> Changes since v11:
>  - Memory setup and page table defines reworked
>  - We do not export unused perf bitfields anymore
>  - No module support anymore and following cleanup
>  - Hide vcpu register accessors
>  - Fix unmap range mmu notifier race condition
>  - Factored out A15 coprocs in separate file
>  - Factored out world-switch assembly macros to separate file
>  - Add dmux of multiplexed coprocs to user space
>  - Add VFP get/set interface to user space
>  - Addressed various cleanup comments from reviewers
>
> Changes since v10:
>  - Boot in Hyp mode and user HVC to initialize HVBAR
>  - Support VGIC
>  - Support Arch timers
>  - Support Thumb-2 mmio instruction decoding
>  - Transition to GET_ONE/SET_ONE register API
>  - Added KVM_VCPU_GET_REG_LIST
>  - New interrupt injection API
>  - Don't pin guest pages anymore
>  - Fix race condition in page fault handler
>  - Cleanup guest instruction copying.
>  - Fix race when copying SMP guest instructions
>  - Inject data/prefetch aborts when guest does something strange
>
> Changes since v9:
>  - Addressed reviewer comments (see mailing list archive)
>  - Limit the user of .arch_extensiion sec/virt for compilers that need them
>  - VFP/Neon Support (Antonios Motakis)
>  - Run exit handling under preemption and still handle guest cache ops
>  - Add support for IO mapping at Hyp level (VGIC prep)
>  - Add support for IO mapping at Guest level (VGIC prep)
>  - Remove backdoor call to irq_svc
>  - Complete rework of CP15 handling and register reset (Rusty Russell)
>  - Don't use HSTR for anything else than CR 15
>  - New ioctl to set emulation target core (only A15 supported for now)
>  - Support KVM_GET_MSRS / KVM_SET_MSRS
>  - Add page accounting and page table eviction
>  - Change pgd lock to spinlock and fix sleeping in atomic bugs
>  - Check kvm_condition_valid for HVC traps of undefs
>  - Added a naive implementation of kvm_unmap_hva_range
>
> Changes since v8:
>  - Support cache maintenance on SMP through set/way
>  - Hyp mode idmaps are now section based and happen at kernel init
>  - Handle aborts in Hyp mode
>  - Inject undefined exceptions into the guest on error
>  - Kernel-side reset of all crucial registers
>  - Specifically state which target CPU is being virtualized
>  - Exit statistics in debugfs
>  - Some L2CTLR cp15 emulation cleanups
>  - Support spte_hva for MMU notifiers and take write faults
>  - FIX: Race condition in VMID generation
>  - BUG: Run exit handling code with disabled preemption
>  - Save/Restore abort fault register during world switch
>
> Changes since v7:
>  - Traps accesses to ACTLR
>  - Do not trap WFE execution
>  - Upgrade barriers and TLB operations to inner-shareable domain
>  - Restrucure hyp_pgd related code to be more opaque
>  - Random SMP fixes
>  - Random BUG fixes
>  - Improve commenting
>  - Support module loading/unloading of KVM/ARM
>  - Thumb-2 support for host kernel and KVM
>  - Unaligned cross-page wide guest Thumb instruction fetching
>  - Support ITSTATE fields in CPSR for Thumb guests
>  - Document HCR settings
>
> Changes since v6:
>  - Support for MMU notifiers to not pin user pages in memory
>  - Suport build with log debugging
>  - Bugfix: v6 clobbered r7 in init code
>  - Simplify hyp code mapping
>  - Cleanup of register access code
>  - Table-based CP15 emulation from Rusty Russell
>  - Various other bug fixes and cleanups
>
> Changes since v5:
>  - General bugfixes and nit fixes from reviews
>  - Implemented re-use of VMIDs
>  - Cleaned up the Hyp-mapping code to be readable by non-mm hackers
>    (including myself)
>  - Integrated preliminary SMP support in base patches
>  - Lock-less interrupt injection and WFI support
>  - Fixed signal-handling in while in guest (increases overall stability)
>
> Changes since v4:
>  - Addressed reviewer comments from v4
>     * cleanup debug and trace code
>     * remove printks
>     * fixup kvm_arch_vcpu_ioctl_run
>     * add trace details to mmio emulation
>  - Fix from Marc Zyngier: Move kvm_guest_enter/exit into non-preemptible
>    section (squashed into world-switch patch)
>  - Cleanup create_hyp_mappings/remove_hyp_mappings from Marc Zyngier
>    (squashed into hypervisor initialization patch)
>  - Removed the remove_hyp_mappings feature. Removing hypervisor mappings
>    could potentially unmap other important data shared in the same page.
>  - Removed the arm_ prefix from the arch-specific files.
>  - Initial SMP host/guest support
>
> Changes since v3:
>  - v4 actually works, fully boots a guest
>  - Support compiling as a module
>  - Use static inlines instead of macros for vcpu_reg and friends
>  - Optimize kvm_vcpu_reg function
>  - Use Ftrace for trace capabilities
>  - Updated documentation and commenting
>  - Use KVM_IRQ_LINE instead of KVM_INTERRUPT
>  - Emulates load/store instructions not supported through HSR
>   syndrome information.
>  - Frees 2nd stage translation tables on VM teardown
>  - Handles IRQ/FIQ instructions
>  - Handles more CP15 accesses
>  - Support guest WFI calls
>  - Uses debugfs instead of /proc
>  - Support compiling in Thumb mode
>
> Changes since v2:
>  - Performs world-switch code
>  - Maps guest memory using 2nd stage translation
>  - Emulates co-processor 15 instructions
>  - Forwards I/O faults to QEMU.
>
> ---
>
> Marc Zyngier (10):
>       ARM: KVM: Keep track of currently running vcpus
>       ARM: KVM: Initial VGIC infrastructure support
>       ARM: KVM: Initial VGIC MMIO support code
>       ARM: KVM: VGIC distributor handling
>       ARM: KVM: VGIC virtual CPU interface management
>       ARM: KVM: VGIC interrupt injection
>       ARM: KVM: VGIC control interface world switch
>       ARM: KVM: VGIC initialisation code
>       ARM: KVM: vgic: reduce the number of vcpu kick
>       ARM: KVM: Add VGIC configuration option
>
>
>  arch/arm/include/asm/kvm_arm.h  |   12
>  arch/arm/include/asm/kvm_host.h |   16 +
>  arch/arm/include/asm/kvm_vgic.h |  301 +++++++++++
>  arch/arm/kernel/asm-offsets.c   |   12
>  arch/arm/kvm/Kconfig            |    7
>  arch/arm/kvm/Makefile           |    1
>  arch/arm/kvm/arm.c              |  101 +++-
>  arch/arm/kvm/interrupts.S       |    4
>  arch/arm/kvm/interrupts_head.S  |   68 ++
>  arch/arm/kvm/mmu.c              |    3
>  arch/arm/kvm/vgic.c             | 1115 +++++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c             |    5
>  12 files changed, 1640 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/include/asm/kvm_vgic.h
>  create mode 100644 arch/arm/kvm/vgic.c
>
> --

Please disregard this first mail-out, I messed up my stgit config.

-Christoffer
