From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Mar 2013 17:00:55 +0000
Subject: [PATCH v2 00/30] Port of KVM to arm64
Message-ID: <1364317285-20937-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the second version of KVM for arm64. It depends
on the "pre-arm64 rework" series I posted initially (already in RMK's
tree), the tiny perf patch sent just after (already in Christoffer's
tree), and yet another 32bit rework patch ("ARM: KVM: promote vfp_host
pointer to generic host cpu context").

The code is unsurprisingly extremely similar to the KVM/arm code, and
a lot of it is actually shared with the 32bit version. Some of the
include files are duplicated though (I'm definitely willing to fix
that).

In terms of features:
- Support for 4k and 64k pages
- Support for 32bit and 64bit guests
- PSCI support for SMP booting

Testing has been done on both AEMv8 and Foundation models, with
various 32 and 64bit guests running a variety of distributions (OE,
Ubuntu and openSUSE for 64bit, Debian and Ubuntu on 32bit).

The patches are also available on the following branch:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/kvm

As we do not have a 64bit QEMU port, it has been tested using
kvmtools. Note that some of the changes have broken the userspace
ABI, and you must update and rebuild your kvmtools (the previous
version won't work anymore):
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/kvmtool

>From v1:

- Rework of the world-switch to use common structure between host and
  guests (suggested by Christopher Covington)
- Some additional constants to make the EL1 fault injection clearer
  (suggested by Christopher Covington)
- Use of __u64 instead of "unsigned long" in the userspace API
  (suggested by Michael S. Tsirkin)
- Move the FP/SIMD registers into the "core" registers, dropping the
  specific accessors.
- Generic MPIDR implementation (suggested by Christopher Covington)
- Cleaner handling of the various host implementation

Marc Zyngier (30):
  arm64: add explicit symbols to ESR_EL1 decoding
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

 arch/arm/kvm/arch_timer.c               |    1 +
 arch/arm64/Kconfig                      |    2 +
 arch/arm64/Makefile                     |    2 +-
 arch/arm64/include/asm/esr.h            |   55 ++
 arch/arm64/include/asm/kvm_arch_timer.h |   58 ++
 arch/arm64/include/asm/kvm_arm.h        |  243 ++++++++
 arch/arm64/include/asm/kvm_asm.h        |  104 ++++
 arch/arm64/include/asm/kvm_coproc.h     |   56 ++
 arch/arm64/include/asm/kvm_emulate.h    |  185 ++++++
 arch/arm64/include/asm/kvm_host.h       |  199 ++++++
 arch/arm64/include/asm/kvm_mmio.h       |   59 ++
 arch/arm64/include/asm/kvm_mmu.h        |  126 ++++
 arch/arm64/include/asm/kvm_psci.h       |   23 +
 arch/arm64/include/asm/kvm_vgic.h       |  156 +++++
 arch/arm64/include/asm/pgtable-hwdef.h  |   13 +
 arch/arm64/include/asm/pgtable.h        |   13 +
 arch/arm64/include/uapi/asm/kvm.h       |  168 +++++
 arch/arm64/kernel/asm-offsets.c         |   34 +
 arch/arm64/kernel/entry.S               |   53 +-
 arch/arm64/kernel/vmlinux.lds.S         |   10 +
 arch/arm64/kvm/Kconfig                  |   59 ++
 arch/arm64/kvm/Makefile                 |   18 +
 arch/arm64/kvm/emulate.c                |  154 +++++
 arch/arm64/kvm/guest.c                  |  260 ++++++++
 arch/arm64/kvm/handle_exit.c            |  124 ++++
 arch/arm64/kvm/hyp-init.S               |   89 +++
 arch/arm64/kvm/hyp.S                    |  816 ++++++++++++++++++++++++
 arch/arm64/kvm/idmap.c                  |  141 +++++
 arch/arm64/kvm/idmap.h                  |    8 +
 arch/arm64/kvm/inject_fault.c           |  195 ++++++
 arch/arm64/kvm/regmap.c                 |  168 +++++
 arch/arm64/kvm/reset.c                  |   83 +++
 arch/arm64/kvm/sys_regs.c               | 1035 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.h               |  138 +++++
 arch/arm64/kvm/sys_regs_generic_v8.c    |   95 +++
 arch/arm64/mm/mmu.c                     |    6 +-
 include/uapi/linux/kvm.h                |    1 +
 37 files changed, 4922 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/include/asm/esr.h
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
 create mode 100644 arch/arm64/kvm/sys_regs_generic_v8.c

-- 
1.8.1.4
