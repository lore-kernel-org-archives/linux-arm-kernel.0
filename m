From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:23 +0000
Subject: [PATCHv5 00/16] Unify arm_generic and arch_timer drivers
Message-ID: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an updated version of v4 of the series I posted 2 weeks ago [1].

The only change is the last two patches, moving over to always using the
virtual counters. I've left these as separate patches rather than
folding them in to allow them to be reviewed more easily.

I've tested the series on a TC2 and an AArch64 model, and I'm happy that
it all works.

Stephen, Thomas:

I've not folded the CLOCKSOURCE_OF_DECLARE patch as it's unclear what
path everything is going to take, and I don't a have a tree with
Stephen's patch that I can base on.

There's already a dependency on the timer broadcast rework, and adding
more branches to the mix is going to get messy. I can take the version
with ifdefs under the assumption we remove them in a later patch once
Stephen's patch is in. Does that sound ok?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/142070.html

Marc Zyngier (2):
  ARM: arch_timers: switch to physical timers if HYP mode is available
  ARM: hyp: initialize CNTVOFF to zero

Mark Rutland (14):
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
  clocksource: arch_timer: use virtual counters

 .../devicetree/bindings/arm/arch_timer.txt         |   7 +-
 arch/arm/Kconfig                                   |   3 +-
 arch/arm/include/asm/arch_timer.h                  | 109 ++++-
 arch/arm/kernel/arch_timer.c                       | 504 +--------------------
 arch/arm/kernel/hyp-stub.S                         |   3 +
 arch/arm/mach-omap2/Kconfig                        |   2 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/arch_timer.h                | 133 ++++++
 arch/arm64/include/asm/arm_generic.h               | 100 ----
 arch/arm64/kernel/time.c                           |  29 +-
 drivers/clocksource/Kconfig                        |   6 +-
 drivers/clocksource/Makefile                       |   2 +-
 drivers/clocksource/arm_arch_timer.c               | 378 ++++++++++++++++
 drivers/clocksource/arm_generic.c                  | 232 ----------
 include/clocksource/arm_arch_timer.h               |  63 +++
 include/clocksource/arm_generic.h                  |  21 -
 16 files changed, 738 insertions(+), 855 deletions(-)
 create mode 100644 arch/arm64/include/asm/arch_timer.h
 delete mode 100644 arch/arm64/include/asm/arm_generic.h
 create mode 100644 drivers/clocksource/arm_arch_timer.c
 delete mode 100644 drivers/clocksource/arm_generic.c
 create mode 100644 include/clocksource/arm_arch_timer.h
 delete mode 100644 include/clocksource/arm_generic.h

-- 
1.8.1.1
