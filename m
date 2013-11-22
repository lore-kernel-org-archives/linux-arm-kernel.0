From: joelf@ti.com (Joel Fernandes)
Date: Thu, 21 Nov 2013 19:56:46 -0600
Subject: [PATCH 0/8] OMAP: timers: Preparation for migration to clocksource
Message-ID: <1385085414-9034-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is in preparation to make the OMAP dmtimer a clocksource driver
(moving it drivers/clocksource/). As a first step, we introduce a  a generic
.init_time function OMAP DT platforms that can be used across OMAP devices.
Also introduced are a better separation between omap-specific code such as
hwmod and the generic timer code. This will allow us to move the generic
portion to drivers/clocksource/ in the future.

The generic functions with the new DT bindings were tested on OMAP4 and AM33xx.
Although, OMAP4 uses the local timer for clocksource by default.

Lastly, this series also adds a new omap-timer.h header that allows drivers
to use the public dmtimer API in MULTIPLATFORM configurations, and along
with this, ir-rx51 is enabled as well, with some fixes to it.

Joel Fernandes (8):
  ARM: OMAP: Move public portion of dmtimer.h to
    include/linux/omap-timer.h
  rc: ir-rx51: Use clk API to get clock rate
  rc: ir-rx51: Turn ON ir-rx51 as it should work for MULTIPLATFORM
  ARM: OMAP4: timer: Remove non-DT code for TWD timer
  ARM: OMAP2+: timer: Introduce OF-friendly clocksource/clockevent
    system timers
  devicetree: doc: Document ti,timer-parent property
  ARM: DTS: am33xx: Provide the ti,timer-parent property
  ARM: AM33xx: Move to using omap_generic_timer_init for init_time

 .../devicetree/bindings/arm/omap/timer.txt         |  17 ++
 arch/arm/boot/dts/am33xx.dtsi                      |   2 +
 arch/arm/mach-omap2/board-generic.c                |   2 +-
 arch/arm/mach-omap2/common.h                       |   1 +
 arch/arm/mach-omap2/timer.c                        | 257 +++++++++++++++++++--
 arch/arm/plat-omap/include/plat/dmtimer.h          | 121 +---------
 drivers/media/rc/Kconfig                           |   2 +-
 drivers/media/rc/ir-rx51.c                         |   6 +-
 include/linux/omap-timer.h                         | 167 +++++++++++++
 9 files changed, 432 insertions(+), 143 deletions(-)
 create mode 100644 include/linux/omap-timer.h

-- 
1.8.1.2
