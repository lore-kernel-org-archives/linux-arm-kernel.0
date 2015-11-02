From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 2 Nov 2015 12:14:26 +0100
Subject: [PATCH 3/3] arm: plat-omap: Add PWM dmtimer platform data quirks
Message-ID: <56374592.4060201@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to set the currently platform dependent dmtimer
functions pointers as platform data for the pwm-omap-dmtimer
platform driver, add it to plat-omap auxdata_lookup table.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index ea56397..647dec5 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -23,6 +23,8 @@
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/wkup_m3.h>
+#include <linux/platform_data/pwm_omap_dmtimer.h>
+#include <plat/dmtimer.h>

 #include <asm/siginfo.h>
 #include <asm/signal.h>
@@ -453,6 +455,24 @@ void omap_auxdata_legacy_init(struct device *dev)
 	dev->platform_data = &twl_gpio_auxdata;
 }

+/* Dual mode timer PWM callbacks platdata */
+#if IS_ENABLED(CONFIG_OMAP_DM_TIMER)
+struct pwm_omap_dmtimer_pdata pwm_dmtimer_pdata = {
+	.request_by_node = omap_dm_timer_request_by_node,
+	.free = omap_dm_timer_free,
+	.enable = omap_dm_timer_enable,
+	.disable = omap_dm_timer_disable,
+	.get_fclk = omap_dm_timer_get_fclk,
+	.start = omap_dm_timer_start,
+	.stop = omap_dm_timer_stop,
+	.set_load = omap_dm_timer_set_load,
+	.set_match = omap_dm_timer_set_match,
+	.set_pwm = omap_dm_timer_set_pwm,
+	.set_prescaler = omap_dm_timer_set_prescaler,
+	.write_counter = omap_dm_timer_write_counter,
+};
+#endif
+
 /*
  * Few boards still need auxdata populated before we populate
  * the dev entries in of_platform_populate().
@@ -506,6 +526,9 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
 		       &wkup_m3_data),
 #endif
+#if IS_ENABLED(CONFIG_OMAP_DM_TIMER)
+	OF_DEV_AUXDATA("ti,omap-dmtimer-pwm", 0, NULL, &pwm_dmtimer_pdata),
+#endif
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
 		       &omap4_iommu_pdata),
-- 
1.9.1
