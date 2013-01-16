From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:03:11 -0500
Subject: [PATCH v6 0/4] KVM/ARM Architected Timers support
Message-ID: <20130116180307.29693.84098.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements support for the architected generic
timers for KVM/ARM.

This patch series can also be pulled from:
    git://github.com/virtualopensystems/linux-kvm-arm.git
            branch: kvm-arm-v16-vgic-timers

Changes since v5:
 - Renamed sync_{to,from} to {flush,sync}_hwstate
 - Removed ISB's in world-switch code
 - Avoid add/sub on vcpu pointer in world-switch

Changes since v1-v4:
 - Get virtual IRQ number from DT
 - Simplify access to cntvoff and cntv_cval
 - Remove extraneous bit clearing
 - Abstract timer arming/disarming to improve code readability
 - Context switch CNTKCTL across world-switches
 - Add CPU hotplug notifier

---

Marc Zyngier (4):
      ARM: arch_timers: switch to physical timers if HYP mode is available
      ARM: KVM: arch_timers: Add guest timer core support
      ARM: KVM: arch_timers: Add timer world switch
      ARM: KVM: arch_timers: Wire the init code and config option


 arch/arm/include/asm/kvm_arch_timer.h |   85 ++++++++++
 arch/arm/include/asm/kvm_asm.h        |    3 
 arch/arm/include/asm/kvm_host.h       |    5 +
 arch/arm/kernel/arch_timer.c          |    7 +
 arch/arm/kernel/asm-offsets.c         |    6 +
 arch/arm/kvm/Kconfig                  |    8 +
 arch/arm/kvm/Makefile                 |    1 
 arch/arm/kvm/arch_timer.c             |  271 +++++++++++++++++++++++++++++++++
 arch/arm/kvm/arm.c                    |   14 ++
 arch/arm/kvm/coproc.c                 |    4 
 arch/arm/kvm/interrupts.S             |    2 
 arch/arm/kvm/interrupts_head.S        |   90 +++++++++++
 arch/arm/kvm/vgic.c                   |    1 
 13 files changed, 495 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_arch_timer.h
 create mode 100644 arch/arm/kvm/arch_timer.c

-- 
