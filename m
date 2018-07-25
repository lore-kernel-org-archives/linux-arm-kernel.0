From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 25 Jul 2018 10:21:26 +0100
Subject: [PATCH v3 0/2] kvm: arm/arm64: Fix emulated physical timer IRQ
 injection
Message-ID: <20180725092128.11534-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

those two patches fix the (physical EL1) arch timer emulation in KVM,
which missed to inject the timer IRQ if the vCPU was asleep when the
timer expired. This can be checked by a new kvm-unit-tests test [1].

I am now taking Christoffer's approach, which keeps phys_timer_emulate()
mostly as it is, and adds the explicit IRQ injection check in the caller.
This turned out to fit better into the upcoming arch timer rework.

Cheers,
Andre.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032220.html

Christoffer Dall (2):
  KVM: arm/arm64: Fix potential loss of ptimer interrupts
  KVM: arm/arm64: Fix lost IRQs from emulated physcial timer when
    blocked

 virt/kvm/arm/arch_timer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.14.4
