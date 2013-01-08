From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 08 Jan 2013 13:38:34 -0500
Subject: [PATCH v5 00/14] KVM/ARM Implementation
Message-ID: <20130108183811.46302.58543.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements KVM support for ARM processors,
specifically on the Cortex-A15 platform.

Work is done in collaboration between Columbia University, Virtual Open
Systems and ARM/Linaro.

The patch series applies to Linux 3.8-rc2 with kvm/next merged:
 git://git.kernel.org/pub/scm/virt/kvm/kvm.git
        branch: next (commit e11ae1a102b)

The series relies on two additional patches in Will Deacon's perf tree:
    ARM: Define CPU part numbers and implementors
    ARM: Use implementor and part defines from cputype.h

This is Version 15 of the patch series, the first 10 versions were
reviewed on the KVM/ARM and KVM mailing lists. Changes can also be
pulled from:
    git://github.com/virtualopensystems/linux-kvm-arm.git
        branch: kvm-arm-v15
        branch: kvm-arm-v15-vgic
        branch: kvm-arm-v15-vgic-timers

A non-flattened edition of the patch series, which can always be merged,
can be found at:
 git://github.com/virtualopensystems/linux-kvm-arm.git kvm-arm-master

This patch series requires QEMU compatibility.  Use the branch
 git://github.com/virtualopensystems/qemu.git kvm-arm

There is also WIP QEMU patches to support virtio on ARM:
 git://github.com/virtualopensystems/qemu.git kvm-arm-virtio

There is also a rebasing WIP branch with support for huge pages:
 git://github.com/virtualopensystems/linux-kvm-arm.git kvm-arm-hugetlb

Finally there is kvmtool support available for the mach-virt machine:
 git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git

Following this patch series, which implements core KVM support, are two
other patch series implementing Virtual Generic Interrupt Controller
(VGIC) support and Architected Generic Timers.  All three patch series
should be applied for full QEMU compatibility.

The implementation is broken up into a logical set of patches, the first
are preparatory patches:
  1. ARM: Add page table defines for KVM
  2. ARM: Section based HYP idmaps

The main implementation is broken up into separate patches, the first
containing a skeleton of files, makefile changes, the basic user space
interface and KVM architecture specific stubs.  Subsequent patches
implement parts of the system as listed:
  3. Skeleton and reset hooks
  4. Hypervisor initialization
  5. Memory virtualization setup (hyp mode mappings and 2nd stage)
  6. Inject IRQs and FIQs from userspace
  7. World-switch implementation and Hyp exception vectors
  8. Emulation framework and coproc emulation
  9. Coproc user space API
 10. Demux multiplexed coproc registers
 11. User spac API to get/set VFP registers
 12. Handle guest user memory aborts
 13. Handle guest MMIO aborts
 14. Add an entry in the MAINTAINERS file

Testing:
 Tested on the Versatile Express TC2 devboard and on the Arndale board.
 running simultaenous VMs, all running SMP, on an SMP host, each
 VM running hackbench and cyclictest and with extreme memory pressure
 applied to the host with swapping enabled to provoke page eviction.
 Also tested KSM merging swapping on the host.  Fully boots both Ubuntu
 (user space Thumb-2) and Debian (user space ARM) guests each of which
 can run a number of worloads like apache, mysql, kernel compile, network
 tests, and more.

For a guide on how to set up a testing environment and try out these
patches, see:
 http://www.virtualopensystems.com/media/pdf/kvm-arm-guide.pdf

Changes since v14:
 - Fixed permission fault handling by correctly retrieving the IPA on
   Stage-2 permission faults
 - Fix compile error when !CONFIG_KVM_ARM_HOST
 - Support building into separate object directory
 - Fixed the Vodoo Bug (see
   https://github.com/virtualopensystems/linux-kvm-arm/wiki/Voodoo-Bug)
 - Improved some tracepoint debugs
 - Improved and cleaned up VTCR and VTTBR initialization
 - Clarified and unified Stage-2 page table clearing
 - Addressed a large number of concerns from Will Deacon's review,
   including fixing a race condition and removing unused exports.
 - Be a little more verbose when something goes wrong during the init
   process.

Changes since v13:
 - Fix VTTBR mask bug
 - Change KVM_MAX_VCPUS to config option (defualt 4)
 - Go back to struct pt_regs in kvm_regs struct
 - Factor out mmio instruction decoding to a separate file with non
   kvm-specific data structures as the interface.
 - Update kvm_device_address struct to use 64-bit fields
 - Various cleanups and compile fixes

Changes since v12:
 - Documentation updates
 - Change Hyp-ABI to function call based paradigm
 - Cleanup world-switch code
 - Unify HIFAR/HDFAR on the vcpu struct
 - Simplify vcpu register access in sofware
 - Enforce use of vcpu field accessors
 - Factor out mmio handling into separate file
 - Check for overlaps in mmio address mappings
 - Bugfix in mmio decoding
 - Complete rework of ARM mmio load/store instruction

Changes since v11:
 - Memory setup and page table defines reworked
 - We do not export unused perf bitfields anymore
 - No module support anymore and following cleanup
 - Hide vcpu register accessors
 - Fix unmap range mmu notifier race condition
 - Factored out A15 coprocs in separate file
 - Factored out world-switch assembly macros to separate file
 - Add dmux of multiplexed coprocs to user space
 - Add VFP get/set interface to user space
 - Addressed various cleanup comments from reviewers

Changes since v10:
 - Boot in Hyp mode and user HVC to initialize HVBAR
 - Support VGIC
 - Support Arch timers
 - Support Thumb-2 mmio instruction decoding
 - Transition to GET_ONE/SET_ONE register API
 - Added KVM_VCPU_GET_REG_LIST
 - New interrupt injection API
 - Don't pin guest pages anymore
 - Fix race condition in page fault handler
 - Cleanup guest instruction copying.
 - Fix race when copying SMP guest instructions
 - Inject data/prefetch aborts when guest does something strange

Changes since v9:
 - Addressed reviewer comments (see mailing list archive)
 - Limit the user of .arch_extensiion sec/virt for compilers that need them
 - VFP/Neon Support (Antonios Motakis)
 - Run exit handling under preemption and still handle guest cache ops
 - Add support for IO mapping at Hyp level (VGIC prep)
 - Add support for IO mapping at Guest level (VGIC prep)
 - Remove backdoor call to irq_svc
 - Complete rework of CP15 handling and register reset (Rusty Russell)
 - Don't use HSTR for anything else than CR 15
 - New ioctl to set emulation target core (only A15 supported for now)
 - Support KVM_GET_MSRS / KVM_SET_MSRS
 - Add page accounting and page table eviction
 - Change pgd lock to spinlock and fix sleeping in atomic bugs
 - Check kvm_condition_valid for HVC traps of undefs
 - Added a naive implementation of kvm_unmap_hva_range

Changes since v8:
 - Support cache maintenance on SMP through set/way
 - Hyp mode idmaps are now section based and happen at kernel init
 - Handle aborts in Hyp mode
 - Inject undefined exceptions into the guest on error
 - Kernel-side reset of all crucial registers
 - Specifically state which target CPU is being virtualized
 - Exit statistics in debugfs
 - Some L2CTLR cp15 emulation cleanups
 - Support spte_hva for MMU notifiers and take write faults
 - FIX: Race condition in VMID generation
 - BUG: Run exit handling code with disabled preemption
 - Save/Restore abort fault register during world switch

Changes since v7:
 - Traps accesses to ACTLR
 - Do not trap WFE execution
 - Upgrade barriers and TLB operations to inner-shareable domain
 - Restrucure hyp_pgd related code to be more opaque
 - Random SMP fixes
 - Random BUG fixes
 - Improve commenting
 - Support module loading/unloading of KVM/ARM
 - Thumb-2 support for host kernel and KVM
 - Unaligned cross-page wide guest Thumb instruction fetching
 - Support ITSTATE fields in CPSR for Thumb guests
 - Document HCR settings

Changes since v6:
 - Support for MMU notifiers to not pin user pages in memory
 - Suport build with log debugging
 - Bugfix: v6 clobbered r7 in init code
 - Simplify hyp code mapping
 - Cleanup of register access code
 - Table-based CP15 emulation from Rusty Russell
 - Various other bug fixes and cleanups

Changes since v5:
 - General bugfixes and nit fixes from reviews
 - Implemented re-use of VMIDs
 - Cleaned up the Hyp-mapping code to be readable by non-mm hackers
   (including myself)
 - Integrated preliminary SMP support in base patches
 - Lock-less interrupt injection and WFI support
 - Fixed signal-handling in while in guest (increases overall stability)

Changes since v4:
 - Addressed reviewer comments from v4
    * cleanup debug and trace code
    * remove printks
    * fixup kvm_arch_vcpu_ioctl_run
    * add trace details to mmio emulation
 - Fix from Marc Zyngier: Move kvm_guest_enter/exit into non-preemptible
   section (squashed into world-switch patch)
 - Cleanup create_hyp_mappings/remove_hyp_mappings from Marc Zyngier
   (squashed into hypervisor initialization patch)
 - Removed the remove_hyp_mappings feature. Removing hypervisor mappings
   could potentially unmap other important data shared in the same page.
 - Removed the arm_ prefix from the arch-specific files.
 - Initial SMP host/guest support

Changes since v3:
 - v4 actually works, fully boots a guest
 - Support compiling as a module
 - Use static inlines instead of macros for vcpu_reg and friends
 - Optimize kvm_vcpu_reg function
 - Use Ftrace for trace capabilities
 - Updated documentation and commenting
 - Use KVM_IRQ_LINE instead of KVM_INTERRUPT
 - Emulates load/store instructions not supported through HSR
  syndrome information.
 - Frees 2nd stage translation tables on VM teardown
 - Handles IRQ/FIQ instructions
 - Handles more CP15 accesses
 - Support guest WFI calls
 - Uses debugfs instead of /proc
 - Support compiling in Thumb mode

Changes since v2:
 - Performs world-switch code
 - Maps guest memory using 2nd stage translation
 - Emulates co-processor 15 instructions
 - Forwards I/O faults to QEMU.

---

Christoffer Dall (13):
      ARM: Add page table and page defines needed by KVM
      ARM: Section based HYP idmap
      KVM: ARM: Initial skeleton to compile KVM support
      KVM: ARM: Hypervisor initialization
      KVM: ARM: Memory virtualization setup
      KVM: ARM: Inject IRQs and FIQs from userspace
      KVM: ARM: World-switch implementation
      KVM: ARM: Emulation framework and CP15 emulation
      KVM: ARM: User space API for getting/setting co-proc registers
      KVM: ARM: Demux CCSIDR in the userspace API
      KVM: ARM: Handle guest faults in KVM
      KVM: ARM: Handle I/O aborts
      KVM: ARM: Add maintainer entry for KVM/ARM

Rusty Russell (1):
      KVM: ARM: VFP userspace interface


 Documentation/virtual/kvm/api.txt           |   95 ++
 MAINTAINERS                                 |    8 
 arch/arm/Kconfig                            |    2 
 arch/arm/Makefile                           |    1 
 arch/arm/include/asm/idmap.h                |    1 
 arch/arm/include/asm/kvm_arm.h              |  212 +++++
 arch/arm/include/asm/kvm_asm.h              |   84 ++
 arch/arm/include/asm/kvm_coproc.h           |   47 +
 arch/arm/include/asm/kvm_decode.h           |   47 +
 arch/arm/include/asm/kvm_emulate.h          |   64 ++
 arch/arm/include/asm/kvm_host.h             |  158 ++++
 arch/arm/include/asm/kvm_mmio.h             |   51 +
 arch/arm/include/asm/kvm_mmu.h              |   50 +
 arch/arm/include/asm/pgtable-3level-hwdef.h |    5 
 arch/arm/include/asm/pgtable-3level.h       |   18 
 arch/arm/include/asm/pgtable.h              |    7 
 arch/arm/include/uapi/asm/kvm.h             |  148 ++++
 arch/arm/kernel/asm-offsets.c               |   25 +
 arch/arm/kernel/vmlinux.lds.S               |    6 
 arch/arm/kvm/Kconfig                        |   56 +
 arch/arm/kvm/Makefile                       |   21 +
 arch/arm/kvm/arm.c                          |  998 ++++++++++++++++++++++++++
 arch/arm/kvm/coproc.c                       | 1046 +++++++++++++++++++++++++++
 arch/arm/kvm/coproc.h                       |  153 ++++
 arch/arm/kvm/coproc_a15.c                   |  162 ++++
 arch/arm/kvm/decode.c                       |  462 ++++++++++++
 arch/arm/kvm/emulate.c                      |  542 ++++++++++++++
 arch/arm/kvm/guest.c                        |  222 ++++++
 arch/arm/kvm/init.S                         |  114 +++
 arch/arm/kvm/interrupts.S                   |  494 +++++++++++++
 arch/arm/kvm/interrupts_head.S              |  443 +++++++++++
 arch/arm/kvm/mmio.c                         |  154 ++++
 arch/arm/kvm/mmu.c                          |  777 ++++++++++++++++++++
 arch/arm/kvm/reset.c                        |   74 ++
 arch/arm/kvm/trace.h                        |  215 ++++++
 arch/arm/mm/idmap.c                         |   54 +
 arch/arm/mm/mmu.c                           |   22 +
 include/uapi/linux/kvm.h                    |    8 
 38 files changed, 7026 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_arm.h
 create mode 100644 arch/arm/include/asm/kvm_asm.h
 create mode 100644 arch/arm/include/asm/kvm_coproc.h
 create mode 100644 arch/arm/include/asm/kvm_decode.h
 create mode 100644 arch/arm/include/asm/kvm_emulate.h
 create mode 100644 arch/arm/include/asm/kvm_host.h
 create mode 100644 arch/arm/include/asm/kvm_mmio.h
 create mode 100644 arch/arm/include/asm/kvm_mmu.h
 create mode 100644 arch/arm/include/uapi/asm/kvm.h
 create mode 100644 arch/arm/kvm/Kconfig
 create mode 100644 arch/arm/kvm/Makefile
 create mode 100644 arch/arm/kvm/arm.c
 create mode 100644 arch/arm/kvm/coproc.c
 create mode 100644 arch/arm/kvm/coproc.h
 create mode 100644 arch/arm/kvm/coproc_a15.c
 create mode 100644 arch/arm/kvm/decode.c
 create mode 100644 arch/arm/kvm/emulate.c
 create mode 100644 arch/arm/kvm/guest.c
 create mode 100644 arch/arm/kvm/init.S
 create mode 100644 arch/arm/kvm/interrupts.S
 create mode 100644 arch/arm/kvm/interrupts_head.S
 create mode 100644 arch/arm/kvm/mmio.c
 create mode 100644 arch/arm/kvm/mmu.c
 create mode 100644 arch/arm/kvm/reset.c
 create mode 100644 arch/arm/kvm/trace.h

-- 
