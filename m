From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 May 2013 12:36:05 +0100
Subject: [PATCHv3 0/5] arm: arch_timer cleanups and niceties
Message-ID: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches clean up some (harmless) fallout from the changes
in 3.9, and make the driver always use the virtual counter, eliminating
problems relating to choosing which counters to use (racy
initialisation, branches in hot paths).

The patches can also be found in my public git tree:
git://linux-arm.org/git/linux-mr.git clocks/arch-timer-cleanups

Russell, are you happy to take these for 3.11 if I send a pull request or drop
these in your patch system?

Since v1 [1]:
* Rebased to v3.10-rc1
* Fix up mach-shmobile's selection of ARCH_ARM_TIMER
Since v2: [2]:
* Added Simon Horman's ack for shmobile
* Clarified virtual timer CNTVOFF requirement per Christopher Covington's
  comments.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/158604.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168536.html

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
 arch/arm/mach-shmobile/Kconfig       |  4 ++--
 arch/arm/mach-tegra/Kconfig          |  2 +-
 arch/arm/mach-virt/Kconfig           |  2 +-
 arch/arm64/include/asm/arch_timer.h  | 10 ----------
 drivers/clocksource/arm_arch_timer.c | 23 +++++------------------
 include/clocksource/arm_arch_timer.h |  2 +-
 10 files changed, 22 insertions(+), 43 deletions(-)

-- 
1.8.1.1
