From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 03:47:16 +0000
Subject: [PATCH 00/29] Port of KVM to arm64
Message-ID: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the implementation of KVM for arm64. It depends
on the "pre-arm64 rework" series I posted earlier, as well as on the
tiny perf patch sent just after.

The code is unsurprisingly extremely similar to the KVM/arm code, and
a lot of it is actually shared with the 32bit version. Some of the
include files are duplicated though (I'm definitely willing to fix
that).

In terms of features:
- Support for 4k and 64k pages
- Support for 32bit and 64bit guests
- PSCI support for SMP booting

As we do not have a 64bit QEMU port, it has been tested using kvmtool
(support has already been merged).

Marc Zyngier (29):
  arm64: KVM: define HYP and Stage-2 translation page flags
  arm64: KVM: HYP mode idmap support
  arm64: KVM: EL2 register definitions
  arm64: KVM: system register definitions for 64bit guests
  arm64: KVM: Basic ESR_EL2 helpers and vcpu register access
  arm64: KVM: fault injection into a guest
  arm64: KVM: architecture specific MMU backend
  arm64: KVM: user space interface
  arm64: KVM: system register handling
  arm64: KVM: Cortex-A57 specific system registers handling
  arm64: KVM: virtual CPU reset
  arm64: KVM: kvm_arch and kvm_vcpu_arch definitions
  arm64: KVM: MMIO access backend
  arm64: KVM: guest one-reg interface
  arm64: KVM: hypervisor initialization code
  arm64: KVM: HYP mode world switch implementation
  arm64: KVM: Exit handling
  arm64: KVM: Plug the VGIC
  arm64: KVM: Plug the arch timer
  arm64: KVM: PSCI implementation
  arm64: KVM: Build system integration
  arm64: KVM: define 32bit specific registers
  arm64: KVM: 32bit GP register access
  arm64: KVM: 32bit conditional execution emulation
  arm64: KVM: 32bit handling of coprocessor traps
  arm64: KVM: 32bit coprocessor access for Cortex-A57
  arm64: KVM: 32bit specific register world switch
  arm64: KVM: 32bit guest fault injection
  arm64: KVM: enable initialization of a 32bit vcpu

 arch/arm/kvm/arch_timer.c               |    1 +
 arch/arm64/Kconfig                      |    2 +
 arch/arm64/Makefile                     |    2 +-
 arch/arm64/include/asm/kvm_arch_timer.h |   58 ++
 arch/arm64/include/asm/kvm_arm.h        |  243 +++++++
 arch/arm64/include/asm/kvm_asm.h        |  104 +++
 arch/arm64/include/asm/kvm_coproc.h     |   56 ++
 arch/arm64/include/asm/kvm_emulate.h    |  181 +++++
 arch/arm64/include/asm/kvm_host.h       |  192 ++++++
 arch/arm64/include/asm/kvm_mmio.h       |   59 ++
 arch/arm64/include/asm/kvm_mmu.h        |  126 ++++
 arch/arm64/include/asm/kvm_psci.h       |   23 +
 arch/arm64/include/asm/kvm_vgic.h       |  156 +++++
 arch/arm64/include/asm/pgtable-hwdef.h  |   13 +
 arch/arm64/include/asm/pgtable.h        |   13 +
 arch/arm64/include/uapi/asm/kvm.h       |  190 ++++++
 arch/arm64/kernel/asm-offsets.c         |   33 +
 arch/arm64/kernel/vmlinux.lds.S         |   10 +
 arch/arm64/kvm/Kconfig                  |   59 ++
 arch/arm64/kvm/Makefile                 |   18 +
 arch/arm64/kvm/emulate.c                |  154 +++++
 arch/arm64/kvm/guest.c                  |  246 +++++++
 arch/arm64/kvm/handle_exit.c            |  124 ++++
 arch/arm64/kvm/hyp-init.S               |   89 +++
 arch/arm64/kvm/hyp.S                    |  826 +++++++++++++++++++++++
 arch/arm64/kvm/idmap.c                  |  141 ++++
 arch/arm64/kvm/idmap.h                  |    8 +
 arch/arm64/kvm/inject_fault.c           |  194 ++++++
 arch/arm64/kvm/regmap.c                 |  168 +++++
 arch/arm64/kvm/reset.c                  |   83 +++
 arch/arm64/kvm/sys_regs.c               | 1113 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.h               |  141 ++++
 arch/arm64/kvm/sys_regs_a57.c           |  118 ++++
 arch/arm64/mm/mmu.c                     |    6 +-
 include/uapi/linux/kvm.h                |    1 +
 35 files changed, 4949 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_arch_timer.h
 create mode 100644 arch/arm64/include/asm/kvm_arm.h
 create mode 100644 arch/arm64/include/asm/kvm_asm.h
 create mode 100644 arch/arm64/include/asm/kvm_coproc.h
 create mode 100644 arch/arm64/include/asm/kvm_emulate.h
 create mode 100644 arch/arm64/include/asm/kvm_host.h
 create mode 100644 arch/arm64/include/asm/kvm_mmio.h
 create mode 100644 arch/arm64/include/asm/kvm_mmu.h
 create mode 100644 arch/arm64/include/asm/kvm_psci.h
 create mode 100644 arch/arm64/include/asm/kvm_vgic.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm.h
 create mode 100644 arch/arm64/kvm/Kconfig
 create mode 100644 arch/arm64/kvm/Makefile
 create mode 100644 arch/arm64/kvm/emulate.c
 create mode 100644 arch/arm64/kvm/guest.c
 create mode 100644 arch/arm64/kvm/handle_exit.c
 create mode 100644 arch/arm64/kvm/hyp-init.S
 create mode 100644 arch/arm64/kvm/hyp.S
 create mode 100644 arch/arm64/kvm/idmap.c
 create mode 100644 arch/arm64/kvm/idmap.h
 create mode 100644 arch/arm64/kvm/inject_fault.c
 create mode 100644 arch/arm64/kvm/regmap.c
 create mode 100644 arch/arm64/kvm/reset.c
 create mode 100644 arch/arm64/kvm/sys_regs.c
 create mode 100644 arch/arm64/kvm/sys_regs.h
 create mode 100644 arch/arm64/kvm/sys_regs_a57.c

-- 
1.7.12.4
