From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 19 Mar 2013 12:38:19 -0500
Subject: [PATCH 5/5] ARM: OMAP2+: Populate DMTIMER errata when using
 device-tree
In-Reply-To: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
References: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1363714699-29622-6-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the DMTIMER errata flags are not being populated when using
device-tree. Add static platform data to populate errata flags when
using device-tree.

Please note that DMTIMER erratum i767 is applicable to OMAP3-5 devices
as well as AM335x devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   45 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index b50d478..5d0af13 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -783,6 +783,8 @@ int omap_dm_timers_active(void)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
+static const struct of_device_id omap_timer_match[];
+
 /**
  * omap_dm_timer_probe - probe function called for every registered device
  * @pdev:	pointer to current timer platform device
@@ -796,7 +798,11 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	struct omap_dm_timer *timer;
 	struct resource *mem, *irq;
 	struct device *dev = &pdev->dev;
-	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+	const struct of_device_id *match;
+	const struct dmtimer_platform_data *pdata;
+
+	match = of_match_device(of_match_ptr(omap_timer_match), dev);
+	pdata = match ? match->data : dev->platform_data;
 
 	if (!pdata && !dev->of_node) {
 		dev_err(dev, "%s: no platform data.\n", __func__);
@@ -836,12 +842,14 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 			timer->capability |= OMAP_TIMER_SECURE;
 	} else {
 		timer->id = pdev->id;
-		timer->errata = pdata->timer_errata;
 		timer->capability = pdata->timer_capability;
 		timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 		timer->get_context_loss_count = pdata->get_context_loss_count;
 	}
 
+	if (pdata)
+		timer->errata = pdata->timer_errata;
+
 	timer->irq = irq->start;
 	timer->pdev = pdev;
 
@@ -894,13 +902,34 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct dmtimer_platform_data omap3plus_pdata = {
+	.timer_errata = OMAP_TIMER_ERRATA_I103_I767,
+};
+
 static const struct of_device_id omap_timer_match[] = {
-	{ .compatible = "ti,omap2420-timer", },
-	{ .compatible = "ti,omap3430-timer", },
-	{ .compatible = "ti,omap4430-timer", },
-	{ .compatible = "ti,omap5430-timer", },
-	{ .compatible = "ti,am335x-timer", },
-	{ .compatible = "ti,am335x-timer-1ms", },
+	{
+		.compatible = "ti,omap2420-timer",
+	},
+	{
+		.compatible = "ti,omap3430-timer",
+		.data = &omap3plus_pdata,
+	},
+	{
+		.compatible = "ti,omap4430-timer",
+		.data = &omap3plus_pdata,
+	},
+	{
+		.compatible = "ti,omap5430-timer",
+		.data = &omap3plus_pdata,
+	},
+	{
+		.compatible = "ti,am335x-timer",
+		.data = &omap3plus_pdata,
+	},
+	{
+		.compatible = "ti,am335x-timer-1ms",
+		.data = &omap3plus_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_timer_match);
-- 
1.7.10.4
