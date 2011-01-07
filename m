From: nm@ti.com (Nishanth Menon)
Date: Fri,  7 Jan 2011 17:01:21 -0600
Subject: [PATCH v4 2/3] omap3: beaglexm: fix DVI reset GPIO
In-Reply-To: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
Message-ID: <1294441282-17986-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koen Kooi <koen@beagleboard.org>

GPIO reset line for Beagle XM is different from vanilla beagle
so we populate it as part of gpio update routine.

This in part fixes the issue of display not functioning on beagle XM
platform.

[nm at ti.com: split up, added descriptive changelogs]
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
