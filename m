From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 13:51:29 +0100
Subject: [GIT PULL] KVM/ARM updates for v4.17
Message-ID: <20180328125254.31380-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paolo, Radim,

This is the (rather big) set of updates for KVM/ARM for v4.17. The
main features are the set of VHE optimizations taking advantage of
CPUs implementing ARMv8.1, together with the EL2 randomization patches
that are the foundation for mitigating the so-called variant 3a
security issue (affecting Cortex-A57 and A72).

The rest is the usual mix of vgic fixes and minor improvements.

Note that the breakup below is slightly misleading, as it includes
fixes that have already landed in mainline (I've done a direct merge
of the fixes branch in order to spare everyone some horrible
conflicts).

Also, we've had to revert a pretty important patch for Qualcomm
servers due to some more conflicts with the arm64 tree). That patch
will be resent once both trees have been pulled into Linus' (the
sooner, the better).

Please pull.

	M.

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v4.17

for you to fetch changes up to dc6ed61d2f824a595033744fc1f3bf4cb98768b5:

  arm64: Add temporary ERRATA_MIDR_ALL_VERSIONS compatibility macro (2018-03-28 12:57:23 +0100)

----------------------------------------------------------------
KVM/ARM updates for v4.17

- VHE optimizations
- EL2 address space randomization
- Variant 3a mitigation for Cortex-A57 and A72
- The usual vgic fixes
- Various minor tidying-up

----------------------------------------------------------------
Andre Przywara (1):
      KVM: arm/arm64: vgic: Add missing irq_lock to vgic_mmio_read_pending

Ard Biesheuvel (1):
      KVM: arm/arm64: Reduce verbosity of KVM init log

Arnd Bergmann (1):
      ARM: kvm: fix building with gcc-8

Christoffer Dall (42):
      KVM: arm/arm64: Fix arch timers with userspace irqchips
      KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
      KVM: arm/arm64: Reset mapped IRQs on VM reset
      KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN
      KVM: arm/arm64: Move vcpu_load call after kvm_vcpu_first_run_init
      KVM: arm64: Avoid storing the vcpu pointer on the stack
      KVM: arm64: Rework hyp_panic for VHE and non-VHE
      KVM: arm/arm64: Get rid of vcpu->arch.irq_lines
      KVM: arm/arm64: Add kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs
      KVM: arm/arm64: Introduce vcpu_el1_is_32bit
      KVM: arm64: Move debug dirty flag calculation out of world switch
      KVM: arm64: Slightly improve debug save/restore functions
      KVM: arm64: Improve debug register save/restore flow
      KVM: arm64: Factor out fault info population and gic workarounds
      KVM: arm64: Introduce VHE-specific kvm_vcpu_run
      KVM: arm64: Remove kern_hyp_va() use in VHE switch function
      KVM: arm64: Don't deactivate VM on VHE systems
      KVM: arm64: Remove noop calls to timer save/restore from VHE switch
      KVM: arm64: Move userspace system registers into separate function
      KVM: arm64: Rewrite sysreg alternatives to static keys
      KVM: arm64: Introduce separate VHE/non-VHE sysreg save/restore functions
      KVM: arm/arm64: Remove leftover comment from kvm_vcpu_run_vhe
      KVM: arm64: Unify non-VHE host/guest sysreg save and restore functions
      KVM: arm64: Don't save the host ELR_EL2 and SPSR_EL2 on VHE systems
      KVM: arm64: Change 32-bit handling of VM system registers
      KVM: arm64: Rewrite system register accessors to read/write functions
      KVM: arm64: Introduce framework for accessing deferred sysregs
      KVM: arm/arm64: Prepare to handle deferred save/restore of SPSR_EL1
      KVM: arm64: Prepare to handle deferred save/restore of ELR_EL1
      KVM: arm64: Defer saving/restoring 64-bit sysregs to vcpu load/put on VHE
      KVM: arm64: Prepare to handle deferred save/restore of 32-bit registers
      KVM: arm64: Defer saving/restoring 32-bit sysregs to vcpu load/put
      KVM: arm64: Move common VHE/non-VHE trap config in separate functions
      KVM: arm64: Directly call VHE and non-VHE FPSIMD enabled functions
      KVM: arm64: Configure c15, PMU, and debug register traps on cpu load/put for VHE
      KVM: arm64: Cleanup __activate_traps and __deactive_traps for VHE and non-VHE
      KVM: arm/arm64: Get rid of vgic_elrsr
      KVM: arm/arm64: Handle VGICv2 save/restore from the main VGIC code
      KVM: arm/arm64: Move arm64-only vgic-v2-sr.c file to arm64
      KVM: arm/arm64: Handle VGICv3 save/restore from the main VGIC code on VHE
      KVM: arm/arm64: Move VGIC APR save/restore to vgic put/load
      KVM: arm/arm64: Avoid VGICv3 save/restore on VHE with no IRQs

Dave Martin (1):
      arm64: KVM: Move CPU ID reg trap setup off the world switch path

J?r?my Fangu?de (2):
      KVM: arm64: Enable the EL1 physical timer for AArch32 guests
      KVM: arm: Enable emulation of the physical timer

Marc Zyngier (33):
      KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid
      kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3
      arm64: alternatives: Add dynamic patching feature
      arm64: insn: Add N immediate encoding
      arm64: insn: Add encoder for bitwise operations using literals
      arm64: KVM: Dynamically patch the kernel/hyp VA mask
      arm64: cpufeatures: Drop the ARM64_HYP_OFFSET_LOW feature flag
      KVM: arm/arm64: Do not use kern_hyp_va() with kvm_vgic_global_state
      KVM: arm/arm64: Demote HYP VA range display to being a debug feature
      KVM: arm/arm64: Move ioremap calls to create_hyp_io_mappings
      KVM: arm/arm64: Keep GICv2 HYP VAs in kvm_vgic_global_state
      KVM: arm/arm64: Fix idmap size and alignment
      KVM: arm64: Fix HYP idmap unmap when using 52bit PA
      KVM: arm/arm64: Move HYP IO VAs to the "idmap" range
      arm64; insn: Add encoder for the EXTR instruction
      arm64: insn: Allow ADD/SUB (immediate) with LSL #12
      arm64: KVM: Dynamically compute the HYP VA mask
      arm64: KVM: Introduce EL2 VA randomisation
      arm64: Update the KVM memory map documentation
      arm64: KVM: Move vector offsetting from hyp-init.S to kvm_get_hyp_vector
      arm64: KVM: Move stashing of x0/x1 into the vector code itself
      arm64: KVM: Move BP hardening vectors into .hyp.text section
      arm64: KVM: Reserve 4 additional instructions in the BPI template
      arm64: KVM: Allow far branches from vector slots to the main vectors
      arm/arm64: KVM: Introduce EL2-specific executable mappings
      arm64: Make BP hardening slot counter available
      arm64: KVM: Allow mapping of vectors outside of the RAM region
      arm64: Enable ARM64_HARDEN_EL2_VECTORS on Cortex-A57 and A72
      Merge tag 'kvm-arm-fixes-for-v4.16-2' into HEAD
      KVM: arm/arm64: vgic: Disallow Active+Pending for level interrupts
      KVM: arm/arm64: vgic-its: Fix potential overrun in vgic_copy_lpi_list
      Revert "arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening"
      arm64: Add temporary ERRATA_MIDR_ALL_VERSIONS compatibility macro

Mark Rutland (1):
      arm64/kvm: Prohibit guest LOR accesses

Peter Maydell (1):
      KVM: arm: Reserve bit in KVM_REG_ARM encoding for secure/nonsecure

Shanker Donthineni (2):
      KVM: arm/arm64: No need to zero CNTVOFF in kvm_timer_vcpu_put() for VHE
      arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening

Shih-Wei Li (1):
      KVM: arm64: Move HCR_INT_OVERRIDE to default HCR_EL2 guest flag

 Documentation/arm64/memory.txt           |   9 +-
 arch/arm/include/asm/kvm_asm.h           |   5 +-
 arch/arm/include/asm/kvm_emulate.h       |  21 +-
 arch/arm/include/asm/kvm_host.h          |   6 +-
 arch/arm/include/asm/kvm_hyp.h           |   4 +
 arch/arm/include/asm/kvm_mmu.h           |  16 +-
 arch/arm/include/uapi/asm/kvm.h          |   9 +
 arch/arm/kvm/coproc.c                    |  61 +++++
 arch/arm/kvm/emulate.c                   |   4 +-
 arch/arm/kvm/hyp/Makefile                |   6 +-
 arch/arm/kvm/hyp/banked-sr.c             |   4 +
 arch/arm/kvm/hyp/switch.c                |  16 +-
 arch/arm64/Kconfig                       |  16 ++
 arch/arm64/include/asm/alternative.h     |  41 +++-
 arch/arm64/include/asm/cpucaps.h         |   2 +-
 arch/arm64/include/asm/insn.h            |  16 ++
 arch/arm64/include/asm/kvm_arm.h         |   6 +-
 arch/arm64/include/asm/kvm_asm.h         |  19 +-
 arch/arm64/include/asm/kvm_emulate.h     |  78 +++++--
 arch/arm64/include/asm/kvm_host.h        |  53 ++++-
 arch/arm64/include/asm/kvm_hyp.h         |  29 +--
 arch/arm64/include/asm/kvm_mmu.h         | 165 +++++++++----
 arch/arm64/include/asm/mmu.h             |   8 +-
 arch/arm64/include/asm/sysreg.h          |   6 +
 arch/arm64/kernel/Makefile               |   4 +-
 arch/arm64/kernel/alternative.c          |  43 +++-
 arch/arm64/kernel/asm-offsets.c          |   1 +
 arch/arm64/kernel/bpi.S                  |  67 ++++--
 arch/arm64/kernel/cpu_errata.c           |  25 +-
 arch/arm64/kernel/cpufeature.c           |  19 --
 arch/arm64/kernel/head.S                 |   7 +
 arch/arm64/kernel/insn.c                 | 190 ++++++++++++++-
 arch/arm64/kvm/Kconfig                   |   3 +
 arch/arm64/kvm/Makefile                  |   2 +-
 arch/arm64/kvm/debug.c                   |  29 ++-
 arch/arm64/kvm/guest.c                   |   3 -
 arch/arm64/kvm/hyp-init.S                |   1 -
 arch/arm64/kvm/hyp/Makefile              |   2 +-
 arch/arm64/kvm/hyp/debug-sr.c            |  88 ++++---
 arch/arm64/kvm/hyp/entry.S               |   6 +-
 arch/arm64/kvm/hyp/hyp-entry.S           |  86 +++----
 arch/arm64/kvm/hyp/switch.c              | 382 ++++++++++++++++++-------------
 arch/arm64/kvm/hyp/sysreg-sr.c           | 172 +++++++++++---
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  78 +++++++
 arch/arm64/kvm/inject_fault.c            |  24 +-
 arch/arm64/kvm/regmap.c                  |  67 ++++--
 arch/arm64/kvm/sys_regs.c                | 199 +++++++++++++---
 arch/arm64/kvm/sys_regs.h                |   4 +-
 arch/arm64/kvm/sys_regs_generic_v8.c     |   4 +-
 arch/arm64/kvm/va_layout.c               | 227 ++++++++++++++++++
 include/kvm/arm_vgic.h                   |  15 +-
 include/linux/irqchip/arm-gic-v3.h       |   1 +
 include/linux/irqchip/arm-gic.h          |   1 +
 virt/kvm/arm/aarch32.c                   |   2 +-
 virt/kvm/arm/arch_timer.c                | 132 ++++++-----
 virt/kvm/arm/arm.c                       |  57 ++---
 virt/kvm/arm/hyp/timer-sr.c              |  44 ++--
 virt/kvm/arm/hyp/vgic-v2-sr.c            | 159 -------------
 virt/kvm/arm/hyp/vgic-v3-sr.c            | 246 ++++++++++++--------
 virt/kvm/arm/mmu.c                       | 180 ++++++++++++---
 virt/kvm/arm/pmu.c                       |  36 +--
 virt/kvm/arm/vgic/vgic-init.c            |  17 --
 virt/kvm/arm/vgic/vgic-its.c             |  15 +-
 virt/kvm/arm/vgic/vgic-mmio.c            |   3 +
 virt/kvm/arm/vgic/vgic-v2.c              | 163 ++++++++-----
 virt/kvm/arm/vgic/vgic-v3.c              |  75 +++---
 virt/kvm/arm/vgic/vgic.c                 | 120 ++++++++--
 virt/kvm/arm/vgic/vgic.h                 |   6 +
 68 files changed, 2508 insertions(+), 1097 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
 create mode 100644 arch/arm64/kvm/va_layout.c
 delete mode 100644 virt/kvm/arm/hyp/vgic-v2-sr.c
