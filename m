From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Jan 2013 17:45:17 +0000
Subject: [PATCHv4 00/14] Unify arm_generic and arch_timer drivers
Message-ID: <1358271931-7761-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an update to v3 of the series I posted earlier this month [1].

Changes since v3:
* Rebase to v3.8-rc3 (fixing arm64 Kconfig conflict).
* Use physical timers if hyp mode is available.
* Separate the addition of isbs into separate patches.
* Change arch_timer_read_counter into a function pointer.
* Style fixups.
* Kconfig: s/USE_ARM_ARCH_TIMER/HAVE_ARM_ARCH_TIMER/
Changes since v2:
* Rebase to v3.8-rc2
Changes since v1:
* Rename arch_counter_{enable=>set}_user_access.
* Explicitly disable access to counters from userspace on arm.
* Add device_node refcounting fix.
* Fix conflict with Will Deacon's AArch64 vdso changes.
* Simplify the cpu notifier.
* Fix a couple of style issues.

Currently we have two drivers for the ARM generic / architected timer,
arch_timer in arch/arm, and arm_generic in drivers/clocksource. This is
an unnecessary duplication of code, and will only lead to maintenance
headaches later.

This patch series splits the generic portion of the arch_timer out to
drivers/clocksource, and ports the arm/arm64 code to use it. The now
unused arm_generic driver is removed in the process.

Separating the arch_timer driver from the arm-specific local_timer api
currently loses us broadcast timer support. I've posted another series
[2] which remedies this by decoupling the timer broadcast mechanism from
drivers.

The series applies to v3.8-rc3, and has been tested on a TC2 test chip.
It also applies to Catalin's soc-armv8-model branch [3], the result of
which has been tested on an AArch64 model (with additional interrupts
listed in the dt).

Christoffer, I've folded in a patch from Marc to use physical timers if
hyp mode is available. This should solve the conflict with your KVM/ARM
architected timers support patches.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140560.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/141706.html
[3] git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-model

Marc Zyngier (1):
  ARM: arch_timers: switch to physical timers if HYP mode is available

Mark Rutland (13):
  arm: arch_timer: balance device_node refcounting
  arm: arch_timer: remove redundant available check
  arm: arch_timer: use u64/u32 for register data
  arm: arch_timer: standardise counter reading
  arm: arch_timer: split cntfrq accessor
  arm: arch_timer: factor out register accessors
  arm: arch_timer: add isbs to register accessors
  arm: arch_timer: divorce from local_timer api
  arm: arch_timer: add arch_counter_set_user_access
  arm: arch_timer: move core to drivers/clocksource
  arm64: arm_generic: prevent reading stale time
  arm64: move from arm_generic to arm_arch_timer
  Documentation: Add ARMv8 to arch_timer devicetree

 .../devicetree/bindings/arm/arch_timer.txt         |    7 +-
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/include/asm/arch_timer.h                  |  109 ++++-
 arch/arm/kernel/arch_timer.c                       |  504 +-------------------
 arch/arm/mach-omap2/Kconfig                        |    2 +-
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/include/asm/arch_timer.h                |  133 +++++
 arch/arm64/include/asm/arm_generic.h               |  100 ----
 arch/arm64/kernel/time.c                           |   29 +-
 drivers/clocksource/Kconfig                        |    6 +-
 drivers/clocksource/Makefile                       |    2 +-
 drivers/clocksource/arm_arch_timer.c               |  391 +++++++++++++++
 drivers/clocksource/arm_generic.c                  |  232 ---------
 include/clocksource/arm_arch_timer.h               |   63 +++
 include/clocksource/arm_generic.h                  |   21 -
 15 files changed, 748 insertions(+), 855 deletions(-)
 create mode 100644 arch/arm64/include/asm/arch_timer.h
 delete mode 100644 arch/arm64/include/asm/arm_generic.h
 create mode 100644 drivers/clocksource/arm_arch_timer.c
 delete mode 100644 drivers/clocksource/arm_generic.c
 create mode 100644 include/clocksource/arm_arch_timer.h
 delete mode 100644 include/clocksource/arm_generic.h
