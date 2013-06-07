From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 07 Jun 2013 18:03:49 +0100
Subject: [PULL] port of KVM to arm64
Message-ID: <51B21275.2070603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin, Will,

Please consider pulling the following branch to get the current 
KVM/arm64 code to be merged in 3.11.

Note that this code doesn't get built as it stands, as it depends on 
other bits and pieces coming from both the main KVM tree and the
KVM/ARM tree. Once these dependencies are met, I'll post the last
patch enabling the KVM/arm64 code.

Thanks,

	M.

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/kvm-for-3.11

for you to fetch changes up to 6544c4736594302a142e24dea014c472484b53ca:

  arm64: KVM: document kernel object mappings in HYP (2013-06-07 14:17:52 +0100)

----------------------------------------------------------------
Marc Zyngier (33):
      arm64: KVM: define HYP and Stage-2 translation page flags
      arm64: KVM: HYP mode idmap support
      arm64: KVM: EL2 register definitions
      arm64: KVM: system register definitions for 64bit guests
      arm64: KVM: Basic ESR_EL2 helpers and vcpu register access
      arm64: KVM: fault injection into a guest
      arm64: KVM: architecture specific MMU backend
      arm64: KVM: user space interface
      arm64: KVM: system register handling
      arm64: KVM: CPU specific system registers handling
      arm64: KVM: virtual CPU reset
      arm64: KVM: kvm_arch and kvm_vcpu_arch definitions
      arm64: KVM: MMIO access backend
      arm64: KVM: guest one-reg interface
      arm64: KVM: hypervisor initialization code
      arm64: KVM: HYP mode world switch implementation
      arm64: KVM: Exit handling
      arm64: KVM: Plug the VGIC
      ARM: KVM: timer: allow DT matching for ARMv8 cores
      arm64: KVM: Plug the arch timer
      arm64: KVM: PSCI implementation
      arm64: KVM: Build system integration
      arm64: KVM: define 32bit specific registers
      arm64: KVM: 32bit GP register access
      arm64: KVM: 32bit conditional execution emulation
      arm64: KVM: 32bit handling of coprocessor traps
      arm64: KVM: CPU specific 32bit coprocessor access
      arm64: KVM: 32bit specific register world switch
      arm64: KVM: 32bit guest fault injection
      arm64: KVM: enable initialization of a 32bit vcpu
      arm64: KVM: userspace API documentation
      arm64: KVM: MAINTAINERS update
      arm64: KVM: document kernel object mappings in HYP

 Documentation/arm64/memory.txt         |    7 +
 Documentation/virtual/kvm/api.txt      |   58 +++--
 MAINTAINERS                            |    9 +
 arch/arm/kvm/arch_timer.c              |    1 +
 arch/arm64/Makefile                    |    2 +-
 arch/arm64/include/asm/kvm_arm.h       |  245 +++++++++++++++++++
 arch/arm64/include/asm/kvm_asm.h       |  104 ++++++++
 arch/arm64/include/asm/kvm_coproc.h    |   56 +++++
 arch/arm64/include/asm/kvm_emulate.h   |  180 ++++++++++++++
 arch/arm64/include/asm/kvm_host.h      |  202 ++++++++++++++++
 arch/arm64/include/asm/kvm_mmio.h      |   59 +++++
 arch/arm64/include/asm/kvm_mmu.h       |  135 +++++++++++
 arch/arm64/include/asm/kvm_psci.h      |   23 ++
 arch/arm64/include/asm/memory.h        |    6 +
 arch/arm64/include/asm/pgtable-hwdef.h |   19 ++
 arch/arm64/include/asm/pgtable.h       |   12 +
 arch/arm64/include/uapi/asm/kvm.h      |  168 +++++++++++++
 arch/arm64/kernel/asm-offsets.c        |   34 +++
 arch/arm64/kernel/vmlinux.lds.S        |   20 ++
 arch/arm64/kvm/Makefile                |   23 ++
 arch/arm64/kvm/emulate.c               |  158 ++++++++++++
 arch/arm64/kvm/guest.c                 |  265 ++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c           |  124 ++++++++++
 arch/arm64/kvm/hyp-init.S              |  107 +++++++++
 arch/arm64/kvm/hyp.S                   |  831 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/inject_fault.c          |  203 ++++++++++++++++
 arch/arm64/kvm/regmap.c                |  168 +++++++++++++
 arch/arm64/kvm/reset.c                 |  112 +++++++++
 arch/arm64/kvm/sys_regs.c              | 1050 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.h              |  138 +++++++++++
 arch/arm64/kvm/sys_regs_generic_v8.c   |   95 ++++++++
 include/uapi/linux/kvm.h               |    2 +
 32 files changed, 4596 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_arm.h
 create mode 100644 arch/arm64/include/asm/kvm_asm.h
 create mode 100644 arch/arm64/include/asm/kvm_coproc.h
 create mode 100644 arch/arm64/include/asm/kvm_emulate.h
 create mode 100644 arch/arm64/include/asm/kvm_host.h
 create mode 100644 arch/arm64/include/asm/kvm_mmio.h
 create mode 100644 arch/arm64/include/asm/kvm_mmu.h
 create mode 100644 arch/arm64/include/asm/kvm_psci.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm.h
 create mode 100644 arch/arm64/kvm/Makefile
 create mode 100644 arch/arm64/kvm/emulate.c
 create mode 100644 arch/arm64/kvm/guest.c
 create mode 100644 arch/arm64/kvm/handle_exit.c
 create mode 100644 arch/arm64/kvm/hyp-init.S
 create mode 100644 arch/arm64/kvm/hyp.S
 create mode 100644 arch/arm64/kvm/inject_fault.c
 create mode 100644 arch/arm64/kvm/regmap.c
 create mode 100644 arch/arm64/kvm/reset.c
 create mode 100644 arch/arm64/kvm/sys_regs.c
 create mode 100644 arch/arm64/kvm/sys_regs.h
 create mode 100644 arch/arm64/kvm/sys_regs_generic_v8.c

-- 
Jazz is not dead. It just smells funny...
