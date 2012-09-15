From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:34:29 -0400
Subject: [PATCH 00/15] KVM/ARM Implementation
Message-ID: <20120915153359.21241.86002.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements KVM support for ARM processors,
specifically on the Cortex A-15 platform.  We feel this is ready to be
merged.

Work is done in collaboration between Columbia University, Virtual Open
Systems and ARM/Linaro.

The patch series applies to Linux 3.6-rc5 with a number of merges:
 1. git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
        branch: io (fc8a08c3a3a)
 2. git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
        branch: hyp-mode-boot-next (e5a04cb0b4a)
 3. git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
        branch: timers-next (437814c44c)
 4. git://git.kernel.org/pub/scm/virt/kvm/kvm.git
        branch: next (7de5bdc96c3)

This is Version 11 of the patch series, the first 10 versions were
reviewed on the KVM/ARM and KVM mailing lists. Changes can also be
pulled from:
    git://github.com/virtualopensystems/linux-kvm-arm.git
        branch: kvm-arm-v11
        branch: kvm-arm-v11-vgic
        branch: kvm-arm-v11-vgic-timers

A non-flattened edition of the patch series, which can always be merged,
can be found at:
 git://github.com/virtualopensystems/linux-kvm-arm.git kvm-arm-master

This patch series requires QEMU compatibility.  Use the branch
 git://github.com/virtualopensystems/qemu.git kvm-arm

Following this patch series, which implements core KVM support are two
other patch series implementing Virtual Generic Interrupt Controller
(VGIC) support and Architected Generic Timers.  All three patch series
should be applied for full QEMU compatibility.

The implementation is broken up into a logical set of patches, the first
are preparatory patches:
  1. ARM: Add mem_type prot_pte accessor
  2. ARM: Add page table defines for KVM
  3. ARM: Section based HYP idmaps
  4. ARM: Only initialize HYP idmap when HYP mode is available
  5. ARM: Expose PMNC bitfields for KVM use

The main implementation is broken up into separate patches, the first
containing a skeleton of files, makefile changes, the basic user space
interface and KVM architecture specific stubs.  Subsequent patches
implement parts of the system as listed:
  6. Skeleton and reset hooks
  7. Hypervisor initialization
  8. Memory virtualization setup (hyp mode mappings and 2nd stage)
  9. Inject IRQs and FIQs from userspace
 10. World-switch implementation and Hyp exception vectors
 11. Emulation framework and coproc emulation
 12. Coproc user space API
 13. Handle guest user memory aborts
 14. Handle guest MMIO aborts
 15. Support guest wait-for-interrupt instructions

Testing:
 Tested on FAST Models and Versatile Express test-chip2.  Tested by
 running three simultaenous VMs, all running SMP, on an SMP host, each
 VM running hackbench and cyclictest and with extreme memory pressure
 applied to the host with swapping enabled to provoke page eviction.
 Also tested KSM merging and GCC inside VMs.  Fully boots both Ubuntu
 (user space Thumb-2) and Debian (user space ARM) guests.

For a guide on how to set up a testing environment and try out these
patches, see:
 http://www.virtualopensystems.com/media/pdf/kvm-arm-guide.pdf


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

Christoffer Dall (11):
      ARM: Add page table and page defines needed by KVM
      KVM: ARM: Initial skeleton to compile KVM support
      KVM: ARM: Hypervisor inititalization
      KVM: ARM: Memory virtualization setup
      KVM: ARM: Inject IRQs and FIQs from userspace
      KVM: ARM: World-switch implementation
      KVM: ARM: Emulation framework and CP15 emulation
      KVM: ARM: User space API for getting/setting co-proc registers
      KVM: ARM: Handle guest faults in KVM
      KVM: ARM: Handle I/O aborts
      KVM: ARM: Guest wait-for-interrupts (WFI) support

Marc Zyngier (3):
      ARM: add mem_type prot_pte accessor
      ARM: Section based HYP idmap
      ARM: idmap: only initialize HYP idmap when HYP mode is available

Rusty Russell (1):
      ARM: Expose PMNC bitfields for KVM use


 Documentation/virtual/kvm/api.txt           |  125 +++
 arch/arm/Kconfig                            |    2 
 arch/arm/Makefile                           |    1 
 arch/arm/include/asm/idmap.h                |    7 
 arch/arm/include/asm/kvm.h                  |  109 +++
 arch/arm/include/asm/kvm_arm.h              |  197 +++++
 arch/arm/include/asm/kvm_asm.h              |   56 +
 arch/arm/include/asm/kvm_coproc.h           |   40 +
 arch/arm/include/asm/kvm_emulate.h          |  137 ++++
 arch/arm/include/asm/kvm_host.h             |  211 ++++++
 arch/arm/include/asm/kvm_mmu.h              |   46 +
 arch/arm/include/asm/mach/map.h             |    1 
 arch/arm/include/asm/perf_bits.h            |   56 +
 arch/arm/include/asm/pgtable-3level-hwdef.h |    5 
 arch/arm/include/asm/pgtable-3level.h       |   13 
 arch/arm/include/asm/pgtable.h              |    5 
 arch/arm/kernel/asm-offsets.c               |   44 +
 arch/arm/kernel/perf_event_v7.c             |   51 -
 arch/arm/kernel/vmlinux.lds.S               |    6 
 arch/arm/kvm/Kconfig                        |   45 +
 arch/arm/kvm/Makefile                       |   21 +
 arch/arm/kvm/arm.c                          | 1030 +++++++++++++++++++++++++++
 arch/arm/kvm/coproc.c                       |  946 +++++++++++++++++++++++++
 arch/arm/kvm/emulate.c                      |  793 +++++++++++++++++++++
 arch/arm/kvm/exports.c                      |   39 +
 arch/arm/kvm/guest.c                        |  212 ++++++
 arch/arm/kvm/init.S                         |  156 ++++
 arch/arm/kvm/interrupts.S                   |  823 ++++++++++++++++++++++
 arch/arm/kvm/mmu.c                          |  998 ++++++++++++++++++++++++++
 arch/arm/kvm/reset.c                        |   74 ++
 arch/arm/kvm/trace.h                        |  170 ++++
 arch/arm/mm/idmap.c                         |   92 ++
 arch/arm/mm/mmu.c                           |    9 
 include/linux/kvm.h                         |    3 
 mm/memory.c                                 |    2 
 35 files changed, 6454 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm.h
 create mode 100644 arch/arm/include/asm/kvm_arm.h
 create mode 100644 arch/arm/include/asm/kvm_asm.h
 create mode 100644 arch/arm/include/asm/kvm_coproc.h
 create mode 100644 arch/arm/include/asm/kvm_emulate.h
 create mode 100644 arch/arm/include/asm/kvm_host.h
 create mode 100644 arch/arm/include/asm/kvm_mmu.h
 create mode 100644 arch/arm/include/asm/perf_bits.h
 create mode 100644 arch/arm/kvm/Kconfig
 create mode 100644 arch/arm/kvm/Makefile
 create mode 100644 arch/arm/kvm/arm.c
 create mode 100644 arch/arm/kvm/coproc.c
 create mode 100644 arch/arm/kvm/emulate.c
 create mode 100644 arch/arm/kvm/exports.c
 create mode 100644 arch/arm/kvm/guest.c
 create mode 100644 arch/arm/kvm/init.S
 create mode 100644 arch/arm/kvm/interrupts.S
 create mode 100644 arch/arm/kvm/mmu.c
 create mode 100644 arch/arm/kvm/reset.c
 create mode 100644 arch/arm/kvm/trace.h

-- 
