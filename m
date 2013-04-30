From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 07:49:21 -0700
Subject: [GIT PULL v2] KVM/ARM Changes for 3.10
Message-ID: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcelo and Gleb,

These are the changes for KVM/ARM for 3.10.

The patches depend on the cleanup branch, which you've already merged.

Main thing is the reworking of Hyp idmaps, which is now handled by KVM
instead of arm/mm and includes several nasty bug fixes from Marc in
the progress.

 [v2] No changes since v1, except sending patch series with this one.

Thanks!

Andre Przywara (1):
  ARM: KVM: iterate over all CPUs for CPU compatibility check

Arnd Bergmann (1):
  ARM: KVM: define KVM_ARM_MAX_VCPUS unconditionally

Christoffer Dall (2):
  KVM: ARM: Fix API documentation for ONE_REG encoding
  KVM: ARM: Fix spelling in error message

Marc Zyngier (10):
  ARM: KVM: add support for minimal host vs guest profiling
  ARM: KVM: simplify HYP mapping population
  ARM: KVM: fix HYP mapping limitations around zero
  ARM: KVM: move to a KVM provided HYP idmap
  ARM: KVM: enforce maximum size for identity mapped code
  ARM: KVM: rework HYP page table freeing
  ARM: KVM: switch to a dual-step HYP init code
  ARM: KVM: perform HYP initilization for hotplugged CPUs
  ARM: KVM: add architecture specific hook for capabilities
  ARM: KVM: promote vfp_host pointer to generic host cpu context

Mark Rutland (1):
  ARM: KVM: arch_timer: use symbolic constants

 Documentation/virtual/kvm/api.txt |   12 +-
 arch/arm/include/asm/idmap.h      |    1 -
 arch/arm/include/asm/kvm_host.h   |   47 ++--
 arch/arm/include/asm/kvm_mmu.h    |   28 ++-
 arch/arm/kernel/asm-offsets.c     |    2 +-
 arch/arm/kernel/vmlinux.lds.S     |    7 +-
 arch/arm/kvm/Kconfig              |    6 +-
 arch/arm/kvm/Makefile             |    2 +-
 arch/arm/kvm/arch_timer.c         |    7 +-
 arch/arm/kvm/arm.c                |  111 +++++----
 arch/arm/kvm/handle_exit.c        |    2 +-
 arch/arm/kvm/init.S               |   78 +++++--
 arch/arm/kvm/mmu.c                |  455 +++++++++++++++++++++----------------
 arch/arm/kvm/perf.c               |   68 ++++++
 arch/arm/mm/idmap.c               |   32 +--
 15 files changed, 532 insertions(+), 326 deletions(-)
 create mode 100644 arch/arm/kvm/perf.c

-- 
1.7.9.5
