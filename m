From: will.deacon@arm.com (Will Deacon)
Date: Mon,  4 Feb 2013 13:55:28 +0000
Subject: [GIT PULL 1/4] core ARM kvm implementation for 3.9
Message-ID: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Arnd, Olof,

Here is the first (and most significant) pull request introducing KVM
support for ARM. I'm sending this later than I would have liked due to
various indirect dependencies on other branches that didn't stabilise
until the end of last week (then I was at FOSDEM over the weekend), but
this branch has been stable since -rc3.

The only direct dependency is on my for-rmk/perf branch, which you have
already pulled.

Cheers,

Will

--->8

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/virt/kvm/core

for you to fetch changes up to da141b67d29a05267a9a0d56bd7856b7f3f58d44:

  Merge branch 'for-will/kvm/core' of git://github.com/virtualopensystems/linux-kvm-arm into for-rmk/virt/kvm/core (2013-01-24 10:37:49 +0000)

----------------------------------------------------------------

Christoffer Dall (15):
      ARM: Define CPU part numbers and implementors
      ARM: Use implementor and part defines from cputype.h
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

Mark Rutland (3):
      ARM: perf: handle armpmu_register failing
      ARM: perf: remove unnecessary checks for idx < 0
      ARM: perf: simplify __hw_perf_event_init err handling

Rusty Russell (1):
      KVM: ARM: VFP userspace interface

Will Deacon (4):
      ARM: perf: remove redundant NULL check on cpu_pmu
      ARM: perf: don't pretend to support counting of L1I writes
      Merge branch 'for-rmk/perf' into for-rmk/virt/kvm/core
      Merge branch 'for-will/kvm/core' of git://github.com/virtualopensystems/linux-kvm-arm into for-rmk/virt/kvm/core

 Documentation/virtual/kvm/api.txt           |   99 ++-
 MAINTAINERS                                 |    9 +
 arch/arm/Kconfig                            |    2 +
 arch/arm/Makefile                           |    1 +
 arch/arm/include/asm/cputype.h              |   33 +
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
 arch/arm/kernel/perf_event.c                |   16 +-
 arch/arm/kernel/perf_event_cpu.c            |   51 +-
 arch/arm/kernel/perf_event_v6.c             |    4 +-
 arch/arm/kernel/perf_event_v7.c             |   18 +-
 arch/arm/kernel/perf_event_xscale.c         |    2 +-
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
 44 files changed, 6621 insertions(+), 69 deletions(-)
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
