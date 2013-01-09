From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Jan 2013 16:07:09 +0000
Subject: [PATCHv3 00/11] Unify arm_generic and arch_timer drivers
Message-ID: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the rebase to an -rc I promised back in December [1].

Changes since v2:
* Rebase to v3.8-rc2
Changes since v1:
* Rename arch_counter_{enable=>set}_user_access.
* * Explicitly disable access to counters from userspace on arm.
* * Add device_node refcounting fix.
* * Fix conflict with Will Deacon's AArch64 vdso changes.
* * Simplify the cpu notifier.
* * Fix a couple of style issues.

Currently we have two drivers for the ARM generic / architected timer,
arch_timer in arch/arm, and arm_generic in drivers/clocksource. This is
an unnecessary duplication of code, and will only lead to maintenance
headaches later.

This patch series splits the generic portion of the arch_timer out to
drivers/clocksource, and ports the arm64 code to use it. The now unused
arm_generic driver is removed in the process.

Separating the arch_timer driver from the arm-specific local_timer api
currently loses us broadcast timer support. I've posted another series
[2] which remedies this by decoupling the timer broadcast mechanism from
drivers.

The series applies to v3.8-rc2, and has been tested on a TC2 test chip.
It also applies to Catalin's soc-armv8-model branch [3], the result of
which has been tested on an AArch64 model.

Christoffer, this will conflict with one of your KVM/ARM architected
timers support patches ([PATCH v5 1/4] ARM: arch_timers: switch to
physical timers if HYP mode is available). I'm happy to fold that into
this series if you're ok with that?

Thanks,
Mark

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138130.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140528.html
[3] git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-model

Mark Rutland (11):
  arm: arch_timer: balance device_node refcounting
  arm: arch_timer: remove redundant available check
  arm: arch_timer: use u64/u32 for register data
  arm: arch_timer: standardise counter reading
  arm: arch_timer: split cntfrq accessor
  arm: arch_timer: factor out register accessors
  arm: arch_timer: divorce from local_timer api
  arm: arch_timer: add arch_counter_set_user_access
  arm: arch_timer: move core to drivers/clocksource
  arm64: move from arm_generic to arm_arch_timer
  Documentation: Add ARMv8 to arch_timer devicetree

 .../devicetree/bindings/arm/arch_timer.txt         |    7 +-
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/include/asm/arch_timer.h                  |  111 ++++-
 arch/arm/kernel/arch_timer.c                       |  504 +-------------------
 arch/arm/mach-omap2/Kconfig                        |    2 +-
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/include/asm/arch_timer.h                |  133 +++++
 arch/arm64/include/asm/arm_generic.h               |  100 ----
 arch/arm64/kernel/time.c                           |   29 +-
 drivers/clocksource/Kconfig                        |    6 +-
 drivers/clocksource/Makefile                       |    2 +-
 drivers/clocksource/arm_arch_timer.c               |  375 +++++++++++++++
 drivers/clocksource/arm_generic.c                  |  232 ---------
 include/clocksource/arm_arch_timer.h               |   63 +++
 include/clocksource/arm_generic.h                  |   21 -
 15 files changed, 734 insertions(+), 855 deletions(-)
 create mode 100644 arch/arm64/include/asm/arch_timer.h
 delete mode 100644 arch/arm64/include/asm/arm_generic.h
 create mode 100644 drivers/clocksource/arm_arch_timer.c
 delete mode 100644 drivers/clocksource/arm_generic.c
 create mode 100644 include/clocksource/arm_arch_timer.h
 delete mode 100644 include/clocksource/arm_generic.h
