From: s-anna@ti.com (Suman Anna)
Date: Thu, 1 Oct 2015 14:32:36 -0500
Subject: [PATCH 0/4] DRA7 Timer12 Support
Message-ID: <1443727960-32232-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The DRA7 Timer12 is completely missing from the kernel. This series
adds the support for it, so that all the Timers on DRA7 are represented
in the kernel. Timer12 is a special Timer, and is not available for
kernel on HS devices, very much similar to the equivalent timer on OMAP3. 

Patch 1 is a bit debatable, as I am not entirely sure if the clk API used
are acceptable outside the drivers/clk folders. It keeps intact the
omap_dm_timer_set_source() API though, and allows it to handle the
non-configurability of Timer12 parent within that API. The need for
this API is questionable, I am not a big fan as the dmtimer code blindly
tries to set the source of every requested API to OMAP_TIMER_SRC_32_KHZ,
and then the requestors would have to reset the proper parent source again.
It also supports configuring only one of 3 parents (which are valid when
added originally for the then SoCs), requiring specific clock aliases to
work across different SoCs, but the DRA7 SoC does have more than 3
configurable clock parents, and the indexes may not necessarily match
for different timers on different SoCs. Patch 1 won't be needed if we
can kill the omap_dm_timer_set_source() API.

Patches baselined on 4.3-rc3, but should apply just fine on -rc1 as well.

regards
Suman

Suman Anna (4):
  ARM: OMAP: dmtimer: check for fixed timers during config
  ARM: OMAP2+: timer: Remove secure timer for DRA7xx devices
  ARM: dts: DRA7: Add timer12 node
  ARM: DRA7: hwmod: Add data for GPTimer 12

 arch/arm/boot/dts/dra7.dtsi               | 10 +++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 36 +++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/timer.c               |  6 +++---
 arch/arm/plat-omap/dmtimer.c              |  5 +++++
 4 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.6.0
