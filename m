From: will.deacon@arm.com (Will Deacon)
Date: Mon,  4 Feb 2013 13:55:30 +0000
Subject: [GIT PULL 3/4] Move arch-timer into drivers/clocksource for 3.9
In-Reply-To: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
Message-ID: <1359986131-13034-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This set of changes moves the arch-timer driver out from arch/arm/ and
into drivers/clocksource and unifies the new driver with the arm64 copy.

This depends on for-rmk/broadcast, which is the second pull request in
this series.

Cheers,

Will

--->8

The following changes since commit 04c2eee5b9dfcb13f3cd07a5537fb8c785f2751a:

  Merge branch 'x86-efi-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-01-31 17:10:36 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-arm-soc/arch-timers

for you to fetch changes up to 9e02e394c7d7fdc2570a73fb7fc6da3c79f6db2a:

  Merge branch 'for-will/arch-timer-unification' of git://linux-arm.org/linux-mr into for-arm-soc/arch-timers (2013-02-01 10:28:36 +0000)

----------------------------------------------------------------

Marc Zyngier (1):
      ARM: arch_timers: switch to physical timers if HYP mode is available

Mark Rutland (17):
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
      clockevents: Add generic timer broadcast receiver
      clockevents: Add generic timer broadcast function
      arm: Use generic timer broadcast receiver
      arm: Add generic timer broadcast support

Will Deacon (3):
      Merge branch 'timers/for-arm' of git://git.kernel.org/.../tip/tip into for-rmk/broadcast
      Merge branch 'clocks/broadcast-arm' of git://linux-arm.org/linux-mr into for-rmk/broadcast
      Merge branch 'for-will/arch-timer-unification' of git://linux-arm.org/linux-mr into for-arm-soc/arch-timers

 .../devicetree/bindings/arm/arch_timer.txt         |   7 +-
 arch/arm/Kconfig                                   |   4 +-
 arch/arm/include/asm/arch_timer.h                  | 109 ++++-
 arch/arm/kernel/arch_timer.c                       | 504 +--------------------
 arch/arm/kernel/smp.c                              |  13 +-
 arch/arm/mach-omap2/Kconfig                        |   2 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/arch_timer.h                | 133 ++++++
 arch/arm64/include/asm/arm_generic.h               | 100 ----
 arch/arm64/kernel/time.c                           |  29 +-
 drivers/clocksource/Kconfig                        |   6 +-
 drivers/clocksource/Makefile                       |   2 +-
 drivers/clocksource/arm_arch_timer.c               | 391 ++++++++++++++++
 drivers/clocksource/arm_generic.c                  | 232 ----------
 include/clocksource/arm_arch_timer.h               |  63 +++
 include/clocksource/arm_generic.h                  |  21 -
 include/linux/clockchips.h                         |   9 +
 kernel/time/Kconfig                                |   4 +
 kernel/time/tick-broadcast.c                       |  30 ++
 19 files changed, 796 insertions(+), 864 deletions(-)
 create mode 100644 arch/arm64/include/asm/arch_timer.h
 delete mode 100644 arch/arm64/include/asm/arm_generic.h
 create mode 100644 drivers/clocksource/arm_arch_timer.c
 delete mode 100644 drivers/clocksource/arm_generic.c
 create mode 100644 include/clocksource/arm_arch_timer.h
 delete mode 100644 include/clocksource/arm_generic.h
