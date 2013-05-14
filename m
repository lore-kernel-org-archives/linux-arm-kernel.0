From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:28 +0100
Subject: [PATCH v4 00/32] Port of KVM to arm64
Message-ID: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the fourth version of KVM for arm64.

It depends on the following branche:
- git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/fixes
  a small number of fixes and other files being moved around

The code is unsurprisingly extremely similar to the KVM/arm code, and
a lot of it is actually shared with the 32bit version. Most of the
duplicated code has now been eliminated by moving it to a common,
architecture agnostic location.

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
kvmtools. Note that some of the changes have broken the userspace ABI
in v2 and v3, and you must update and rebuild your kvmtools (the
previous versions won't work anymore):

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/kvmtool

KVM maintainers: this series introduces a new capability
(KVM_CAP_ARM_EL1_32BIT, 93) and a new ONE_REG architecture
(KVM_REG_ARM64, 0x6000000000000000ULL). Can we make sure these won't
clash with any other upcoming patches? If they already do, can you
allocate safe and reserved numbers?

>From v3:
- Now relies on vgic/timer being moved to virt/kvm/arm
- Also relies on quite a few 32bit changes, and mimics some other 32bit
  fixes that have been merged already
- Fixed a number of MMU setup issues (Will, Catalin, Pranavkumar)
- Fixed a number of issues in the sys_regs interface, updated
  documentation (Christoffer)
- Add a short EL2 memory-map section to memory.txt

>From v2:
- Dropped the idmap code and use the new KVM/ARM boot protocol
- New KVM_CAP_ARM_EL1_32BIT capability to let userspace detect if EL1
  is 32bit capable
- Fixed a bug in arch/arm/entry.S, where EL0/EL1 breakpoint handling was
  mixed up (spotted by Catalin Marinas)
- Some sparse fixes (courtesy of Geoff Levand)
- Dropped the "shared" attribute from device mappings (spotted by Catalin)
- Add API documentation
- Add MAINTAINERS entry

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
- Cleaner handling of the various host implementations

Marc Zyngier (32):
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
  arm64: KVM: userspace API documentation
  arm64: KVM: MAINTAINERS update
  arm64: KVM: document kernel object mappings in HYP

 Documentation/arm64/memory.txt         |    7 +
 Documentation/virtual/kvm/api.txt      |   58 +-
 MAINTAINERS                            |    9 +
 arch/arm64/Kconfig                     |    2 +
 arch/arm64/Makefile                    |    2 +-
 arch/arm64/include/asm/kvm_arm.h       |  245 ++++++++
 arch/arm64/include/asm/kvm_asm.h       |  104 ++++
 arch/arm64/include/asm/kvm_coproc.h    |   56 ++
 arch/arm64/include/asm/kvm_emulate.h   |  180 ++++++
 arch/arm64/include/asm/kvm_host.h      |  202 ++++++
 arch/arm64/include/asm/kvm_mmio.h      |   59 ++
 arch/arm64/include/asm/kvm_mmu.h       |  135 ++++
 arch/arm64/include/asm/kvm_psci.h      |   23 +
 arch/arm64/include/asm/memory.h        |    5 +
 arch/arm64/include/asm/pgtable-hwdef.h |   19 +
 arch/arm64/include/asm/pgtable.h       |   11 +
 arch/arm64/include/uapi/asm/kvm.h      |  168 +++++
 arch/arm64/kernel/asm-offsets.c        |   34 ++
 arch/arm64/kernel/vmlinux.lds.S        |   20 +
 arch/arm64/kvm/Kconfig                 |   59 ++
 arch/arm64/kvm/Makefile                |   23 +
 arch/arm64/kvm/emulate.c               |  158 +++++
 arch/arm64/kvm/guest.c                 |  259 ++++++++
 arch/arm64/kvm/handle_exit.c           |  124 ++++
 arch/arm64/kvm/hyp-init.S              |  112 ++++
 arch/arm64/kvm/hyp.S                   |  817 +++++++++++++++++++++++++
 arch/arm64/kvm/inject_fault.c          |  203 ++++++
 arch/arm64/kvm/regmap.c                |  168 +++++
 arch/arm64/kvm/reset.c                 |  100 +++
 arch/arm64/kvm/sys_regs.c              | 1050 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.h              |  138 +++++
 arch/arm64/kvm/sys_regs_generic_v8.c   |   95 +++
 include/uapi/linux/kvm.h               |    2 +
 virt/kvm/arm/arch_timer.c              |    1 +
 34 files changed, 4628 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_arm.h
 create mode 100644 arch/arm64/include/asm/kvm_asm.h
 create mode 100644 arch/arm64/include/asm/kvm_coproc.h
 create mode 100644 arch/arm64/include/asm/kvm_emulate.h
 create mode 100644 arch/arm64/include/asm/kvm_host.h
 create mode 100644 arch/arm64/include/asm/kvm_mmio.h
 create mode 100644 arch/arm64/include/asm/kvm_mmu.h
 create mode 100644 arch/arm64/include/asm/kvm_psci.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm.h
 create mode 100644 arch/arm64/kvm/Kconfig
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
1.8.2.3
