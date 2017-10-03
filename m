From: jintack.lim@linaro.org (Jintack Lim)
Date: Mon,  2 Oct 2017 22:08:29 -0500
Subject: [RFC PATCH v2 00/31] Nested Virtualization on KVM/ARM - memory
 virtualization
Message-ID: <1507000109-3536-1-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second part of nested virtualization patch series v2 - memory
virtualization. You can find the first part (cpu virtualization) here [1].

For memory virtualization, the biggest issue is that we now have more than two
stages of translation when running nested VMs while hardware only supports two
stages. We choose to merge two stage-2 page tables (one from the guest
hypervisor and the other from the host hypervisor) and create shadow stage-2
page tables, which have mappings from the nested VM?s physical addresses to the
machine physical addresses. Stage-1 translation is done by the hardware as is
done for the normal VMs. Patch 2 to 14 handle the shadow page table. Note that
patch 1 is borrowed from Dave Martin's SVE patches [2], so that we can fake
ID_AA64MMFR0_EL1 register value to the guest hypervisor in patch 2.

The second half of the patch series (15 to 30) are to handle AT and TLBI
instructions from the guest hypervisor. To get an idea of the AT instruction
emulation, I'd recommend you start with patch 19. For TLBI instructions, see
individual patches from patch 24 to 30. Note that we need to forward AT and
TLBI instructions to the virtual EL2 if corresponding bits are set in the
virtual HCR_EL2. This is mostly for recursive virtualization, and handled in
patch 29 and 30.

This patch set is tested on the FastModel with the v8.3 extension for arm64. I
used a cubietruck for arm32 and was able to boot a VM without a problem. See
the test setup here [3, 4].

This patch series is based on kvm/next d38338e and cpu virtualization patch set
[1].  The whole patch series including cpu, memory, VGIC, and timer patches is
available here:

git at github.com:columbia/nesting-pub.git rfc-v2-mem

TODO:
- Implement the reverse mapping feature to handle mmu notifiers more
  efficiently.

v1-->v2:
- Fixed a bug on arm32 (patch 5).
- Removed most of TODOs.
- Updated comments and commit messages.
- Put change notes for each patches if any.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2017-July/026388.html
[2] https://lists.cs.columbia.edu/pipermail/kvmarm/2017-August/026961.html
[3] https://lists.cs.columbia.edu/pipermail/kvmarm/2017-July/026427.html
[4] https://github.com/columbia/nesting-pub/wiki/Nested-virtualization-on-ARM-setup

Christoffer Dall (12):
  KVM: arm/arm64: Remove unused params in mmu functions
  KVM: arm/arm64: Abstract stage-2 MMU state into a separate structure
  KVM: arm/arm64: Support mmu for the virtual EL2 execution
  KVM: arm64: Invalidate virtual EL2 TLB entries when needed
  KVM: arm64: Setup vttbr_el2 on each VM entry
  KVM: arm/arm64: Make mmu functions non-static
  KVM: arm/arm64: Unmap/flush shadow stage 2 page tables
  KVM: arm64: Implement nested Stage-2 page table walk logic
  KVM: arm/arm64: Handle shadow stage 2 page faults
  KVM: arm/arm64: Move kvm_is_write_fault to header file
  KVM: arm/arm64: Forward the guest hypervisor's stage 2 permission
    faults
  KVM: arm64: Fixes to toggle_cache for nesting

Dave Martin (1):
  arm64: KVM: Hide unsupported AArch64 CPU features from guests

Jintack Lim (18):
  KVM: arm64: Expose limited memory management support to the virtual
    EL2
  KVM: arm/arm64: Manage mmus for nested VMs
  KVM: arm64: Move system register helper functions around
  KVM: arm64: Introduce sys_reg_desc.forward_trap
  KVM: arm64: Rework the system instruction emulation framework
  KVM: arm64: Enumerate AT and TLBI instructions to emulate
  KVM: arm64: Describe AT instruction emulation design
  KVM: arm64: Implement AT instruction handling
  KVM: arm64: Emulate AT S1E[01] instructions
  KVM: arm64: Emulate AT S1E2 instructions
  KVM: arm64: Emulate AT S12E[01] instructions
  KVM: arm64: Emulate TLBI ALLE2(IS) instruction
  KVM: arm64: Emulate TLBI VAE2* instrutions
  KVM: arm64: Emulate TLBI ALLE1(IS)
  KVM: arm64: Emulate TLBI VMALLS12E1(IS) instruction
  KVM: arm64: Emulate TLBI IPAS2E1* instructions
  KVM: arm64: Respect the virtual HCR_EL2.AT and NV setting
  KVM: arm64: Emulate TLBI instructions accesible from EL1

 arch/arm/include/asm/kvm_asm.h       |   7 +-
 arch/arm/include/asm/kvm_emulate.h   |  19 +
 arch/arm/include/asm/kvm_host.h      |  42 +-
 arch/arm/include/asm/kvm_mmu.h       |  44 ++
 arch/arm/kvm/hyp/switch.c            |   3 +-
 arch/arm/kvm/hyp/tlb.c               |  15 +-
 arch/arm64/include/asm/esr.h         |   1 +
 arch/arm64/include/asm/kvm_arm.h     |   5 +
 arch/arm64/include/asm/kvm_asm.h     |  12 +-
 arch/arm64/include/asm/kvm_emulate.h |  29 ++
 arch/arm64/include/asm/kvm_host.h    |  45 +-
 arch/arm64/include/asm/kvm_mmu.h     |  69 ++-
 arch/arm64/include/asm/sysreg.h      |  56 +++
 arch/arm64/kvm/Makefile              |   1 +
 arch/arm64/kvm/context.c             |  12 +
 arch/arm64/kvm/hyp/Makefile          |   1 +
 arch/arm64/kvm/hyp/at.c              | 131 +++++
 arch/arm64/kvm/hyp/switch.c          |   8 +-
 arch/arm64/kvm/hyp/tlb.c             | 114 ++++-
 arch/arm64/kvm/mmu-nested.c          | 441 +++++++++++++++++
 arch/arm64/kvm/sys_regs.c            | 907 ++++++++++++++++++++++++++++++-----
 arch/arm64/kvm/sys_regs.h            |   6 +
 virt/kvm/arm/arm.c                   |  77 ++-
 virt/kvm/arm/mmio.c                  |  12 +-
 virt/kvm/arm/mmu.c                   | 361 +++++++++-----
 25 files changed, 2084 insertions(+), 334 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/at.c
 create mode 100644 arch/arm64/kvm/mmu-nested.c

-- 
1.9.1
