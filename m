From: nm@ti.com (Nishanth Menon)
Date: Thu,  6 Jan 2011 13:54:38 -0600
Subject: [PATCH v3 2/3] omap3: beaglexm: fix DVI reset GPIO
In-Reply-To: <1294343679-10605-1-git-send-email-nm@ti.com>
References: <1294343679-10605-1-git-send-email-nm@ti.com>
Message-ID: <1294343679-10605-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koen Kooi <koen@beagleboard.org>

GPIO reset line for Beagle XM is different from vanilla beagle
so we populate it as part of gpio update routine.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 1b5aa7a..d628f5e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -199,7 +199,7 @@ static struct omap_dss_device beagle_dvi_device = {
 	.name = "dvi",
 	.driver_name = "generic_panel",
 	.phy.dpi.data_lines = 24,
-	.reset_gpio = 170,
+	.reset_gpio = -EINVAL,
 	.platform_enable = beagle_enable_dvi,
 	.platform_disable = beagle_disable_dvi,
 };
@@ -308,6 +308,12 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	else
 		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
+	/* DVI reset GPIO is different between beagle revisions */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		beagle_dvi_device.reset_gpio = 129;
+	else
+		beagle_dvi_device.reset_gpio = 170;
+
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
-- 
1.6.3.3
