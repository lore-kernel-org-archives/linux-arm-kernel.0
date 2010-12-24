From: bgamari.foss@gmail.com (Ben Gamari)
Date: Thu, 23 Dec 2010 21:48:09 -0500
Subject: [PATCH] omap2: Make OMAP2PLUS select OMAP_DM_TIMER
Message-ID: <1293158889-9708-1-git-send-email-bgamari.foss@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that arch/arm/mach-omap2/timer-gp.o is needed by OMAP2PLUS.
Since timer-gp.o has direct dependencies on omap_dm_timer_*, it seems
correct for the architecture to depend upon OMAP_DM_TIMER, otherwise
unsuspecting integrators will be faced with a whole bunch of linker
errors at the end of their kernel build:

arch/arm/mach-omap2/built-in.o: In function `omap2_gp_timer_set_mode':
/home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:84: undefined reference to `omap_dm_timer_stop'
/home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:88: undefined reference to `omap_dm_timer_get_fclk'
/home/bgamari/trees/linux-2.6/arch/arm/mach-omap2/timer-gp.c:90: undefined reference to `omap_dm_timer_set_load_start'
...
---
 arch/arm/plat-omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 92c5bb7..784c06c 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP1
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4"
 	select COMMON_CLKDEV
+	select OMAP_DM_TIMER
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
-- 
1.7.1
