From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 23 Jan 2013 14:22:23 -0500
Subject: [GIT PULL] KVM/ARM core implementation
Message-ID: <CANM98qLq5wfuUWHmjn_SHG=f1O9kG_cgwpA2VfOy5y4t0m-52Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I've prepared a stable branch for you, for-will/kvm/core, based on
your stable perf branch.

Since the last patch series, I've addressed the reviewer comments, and
rev'ed KVM_CAP_ARM_PSCI to 87, since 86 is already used by PPC in
kvm/next.

kvmtool should probably be updated acoordingly.

I rebased the VGIC and the Arch. Timers series on the stable branch
and made these available in kvm/vgic and kvm/vgic-timers,
respectively. These branches are, however, not yet stable.


Thanks,
-Christoffer

The following changes since commit 6abc749f635005be78dfcb562c2235511965db6d:

  Merge branch 'for-rmk/perf' into for-rmk/virt/kvm/core (2013-01-23
17:17:52 +0000)

are available in the git repository at:


  git://github.com/virtualopensystems/linux-kvm-arm.git for-will/kvm/core

for you to fetch changes up to a749474de5f0f5902f59acb5c7f4dc6b816ac788:

  KVM: ARM: Add maintainer entry for KVM/ARM (2013-01-23 13:29:19 -0500)

----------------------------------------------------------------
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

Marc Zyngier (1):
      KVM: ARM: Power State Coordination Interface implementation

Rusty Russell (1):
      KVM: ARM: VFP userspace interface

 Documentation/virtual/kvm/api.txt           |   99 ++-
 MAINTAINERS                                 |    9 +
 arch/arm/Kconfig                            |    2 +
 arch/arm/Makefile                           |    1 +
 arch/arm/include/asm/idmap.h                |    1 +
 arch/arm/include/asm/kvm_arm.h              |  214 ++++++
 arch/arm/include/asm/kvm_asm.h              |   82 +++
 arch/arm/include/asm/kvm_coproc.h           |   47 ++
 arch/arm/include/asm/kvm_emulate.h          |   72 ++
 arch/arm/include/asm/kvm_host.h             |  161 +++++
 arch/arm/include/asm/kvm_mmio.h             |   56 ++
 arch/arm/include/asm/kvm_mmu.h              |   50 ++
 arch/arm/include/asm/kvm_psci.h             |   23 +
 arch/arm/include/asm/pgtable-3level-hwdef.h |    5 +
 arch/arm/include/asm/pgtable-3level.h       |   18 +
 arch/arm/include/asm/pgtable.h              |    7 +
 arch/arm/include/uapi/asm/kvm.h             |  164 +++++
 arch/arm/kernel/asm-offsets.c               |   25 +
 arch/arm/kernel/vmlinux.lds.S               |    6 +-
 arch/arm/kvm/Kconfig                        |   56 ++
 arch/arm/kvm/Makefile                       |   21 +
 arch/arm/kvm/arm.c                          | 1015 ++++++++++++++++++++++++++
 arch/arm/kvm/coproc.c                       | 1046 +++++++++++++++++++++++++++
 arch/arm/kvm/coproc.h                       |  153 ++++
 arch/arm/kvm/coproc_a15.c                   |  162 +++++
 arch/arm/kvm/emulate.c                      |  373 ++++++++++
 arch/arm/kvm/guest.c                        |  222 ++++++
 arch/arm/kvm/init.S                         |  114 +++
 arch/arm/kvm/interrupts.S                   |  478 ++++++++++++
 arch/arm/kvm/interrupts_head.S              |  441 +++++++++++
 arch/arm/kvm/mmio.c                         |  153 ++++
 arch/arm/kvm/mmu.c                          |  787 ++++++++++++++++++++
 arch/arm/kvm/psci.c                         |  108 +++
 arch/arm/kvm/reset.c                        |   74 ++
 arch/arm/kvm/trace.h                        |  235 ++++++
 arch/arm/mm/idmap.c                         |   55 +-
 arch/arm/mm/mmu.c                           |   22 +
 include/uapi/linux/kvm.h                    |    9 +
 38 files changed, 6546 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_arm.h
 create mode 100644 arch/arm/include/asm/kvm_asm.h
 create mode 100644 arch/arm/include/asm/kvm_coproc.h
 create mode 100644 arch/arm/include/asm/kvm_emulate.h
 create mode 100644 arch/arm/include/asm/kvm_host.h
 create mode 100644 arch/arm/include/asm/kvm_mmio.h
 create mode 100644 arch/arm/include/asm/kvm_mmu.h
 create mode 100644 arch/arm/include/asm/kvm_psci.h
 create mode 100644 arch/arm/include/uapi/asm/kvm.h
 create mode 100644 arch/arm/kvm/Kconfig
 create mode 100644 arch/arm/kvm/Makefile
 create mode 100644 arch/arm/kvm/arm.c
 create mode 100644 arch/arm/kvm/coproc.c
 create mode 100644 arch/arm/kvm/coproc.h
 create mode 100644 arch/arm/kvm/coproc_a15.c
 create mode 100644 arch/arm/kvm/emulate.c
 create mode 100644 arch/arm/kvm/guest.c
 create mode 100644 arch/arm/kvm/init.S
 create mode 100644 arch/arm/kvm/interrupts.S
 create mode 100644 arch/arm/kvm/interrupts_head.S
 create mode 100644 arch/arm/kvm/mmio.c
 create mode 100644 arch/arm/kvm/mmu.c
 create mode 100644 arch/arm/kvm/psci.c
 create mode 100644 arch/arm/kvm/reset.c
 create mode 100644 arch/arm/kvm/trace.h
