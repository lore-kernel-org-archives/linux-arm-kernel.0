From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 30 Jan 2018 20:22:44 +0000
Subject: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
In-Reply-To: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1517343778-27902-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On R-Car Gen2 and RZ/G1 the rwdt clock needs to be always ON, therefore
when suspending to RAM we need to explicitly disable the counting by
clearing TME from RWTCSRA.
Also, on some systems RWDT is the only piece of HW that allows the SoC
to be restarted, therefore this patch implements the restart callback.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
Wolfram, was the restart callback implementation missing for a reason?
Is its implementation going to break any Gen3 platform?

v1->v3:
* unified Gen2 and Gen3 drivers.

 drivers/watchdog/renesas_wdt.c | 61 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 831ef83..eedb016 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -107,6 +107,24 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
 }
 
+static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
+			void *data)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	pm_runtime_get_sync(wdev->parent);
+
+	rwdt_write(priv, 0x00, RWTCSRB);
+	rwdt_write(priv, 0x00, RWTCSRA);
+	rwdt_write(priv, 0xffff, RWTCNT);
+
+	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
+		cpu_relax();
+
+	rwdt_write(priv, 0x80, RWTCSRA);
+	return 0;
+}
+
 static const struct watchdog_info rwdt_ident = {
 	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
 	.identity = "Renesas WDT Watchdog",
@@ -118,6 +136,7 @@ static const struct watchdog_ops rwdt_ops = {
 	.stop = rwdt_stop,
 	.ping = rwdt_init_timeout,
 	.get_timeleft = rwdt_get_timeleft,
+	.restart = rwdt_restart,
 };
 
 static int rwdt_probe(struct platform_device *pdev)
@@ -203,13 +222,42 @@ static int rwdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
- * to work there, one also needs a RESET (RST) driver which does not exist yet
- * due to HW issues. This needs to be solved before adding compatibles here.
- */
+#ifdef CONFIG_PM
+static int rwdt_suspend(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct rwdt_priv *priv;
+
+	pdev = to_platform_device(dev);
+	priv = platform_get_drvdata(pdev);
+	if (watchdog_active(&priv->wdev)) {
+		rwdt_write(priv, priv->cks, RWTCSRA);
+	}
+	return 0;
+}
+
+static int rwdt_resume(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct rwdt_priv *priv;
+
+	pdev = to_platform_device(dev);
+	priv = platform_get_drvdata(pdev);
+	if (watchdog_active(&priv->wdev)) {
+		rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops rwdt_pm = {
+	.suspend = rwdt_suspend,
+	.resume = rwdt_resume,
+};
+#endif
+
 static const struct of_device_id rwdt_ids[] = {
 	{ .compatible = "renesas,rcar-gen3-wdt", },
+	{ .compatible = "renesas,rcar-gen2-wdt", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rwdt_ids);
@@ -218,6 +266,9 @@ static struct platform_driver rwdt_driver = {
 	.driver = {
 		.name = "renesas_wdt",
 		.of_match_table = rwdt_ids,
+#ifdef CONFIG_PM
+		.pm = &rwdt_pm,
+#endif
 	},
 	.probe = rwdt_probe,
 	.remove = rwdt_remove,
-- 
2.7.4
