From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Mar 2013 17:11:47 +0000
Subject: [PATCH 0/5] arm: arch_timer cleanups and niceties for 3.10
Message-ID: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches clean up some (harmless) fallout from the changes
in 3.9, and make the driver always use the virtual counter, eliminating
problems relating to choosing which counters to use (racy
initialisation, branches in hot paths).

The patches are based on  v3.9-rc4, and have been tested on a TC2 with
KVM.

The patches can also be found in my public git tree:
git://linux-arm.org/git/linux-mr.git clocks/arch-timer-cleanups

Rob, patch 3 "clocksource: arch_timer: use virtual counters" clashes
with your CLKSRC_OF patches, but only by the fact nearby lines are
alterered. The resolution is trivial and I'm happy to rebase this series
as necessary.

Thanks,
Mark.

Marc Zyngier (2):
  ARM: hyp: initialize CNTVOFF to zero
  ARM: arch_timer: stop virtual timer when booted in HYP mode

Mark Rutland (3):
  ARM: KVM: arch_timers: zero CNTVOFF upon return to host
  clocksource: arch_timer: use virtual counters
  arm: fix up ARM_ARCH_TIMER selects

 arch/arm/include/asm/arch_timer.h    |  9 ---------
 arch/arm/kernel/hyp-stub.S           |  7 +++++++
 arch/arm/kvm/interrupts_head.S       |  4 ++++
 arch/arm/mach-exynos/Kconfig         |  2 +-
 arch/arm/mach-tegra/Kconfig          |  2 +-
 arch/arm/mach-virt/Kconfig           |  2 +-
 arch/arm64/include/asm/arch_timer.h  | 10 ----------
 drivers/clocksource/arm_arch_timer.c | 23 +++++------------------
 include/clocksource/arm_arch_timer.h |  2 +-
 9 files changed, 20 insertions(+), 41 deletions(-)

-- 
1.8.1.1
