From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Oct 2017 10:51:44 -0700
Subject: [PATCH 4/7] bus: ti-sysc: Add minimal TI sysc interconnect
 target driver
In-Reply-To: <20170929223411.9691-5-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-5-tony@atomide.com>
Message-ID: <20171013175144.GQ4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170929 15:35]:
> +static struct platform_driver sysc_driver = {
> +	.probe		= sysc_probe,
> +	.driver         = {
> +		.name   = "ti-sysc",
> +		.of_match_table	= sysc_match,
> +		.pm = &sysc_pm_ops,
> +	},
> +};
> +module_platform_driver(sysc_driver);

We also need add remove() to have unbind and bind work
properly, here's an incremental patch to add that.

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 13 Oct 2017 10:48:40 -0700
Subject: [PATCH] bus: ti-sysc: Fix unbalanced pm_runtime_enable by adding
 remove

Looks like we're missing remove() that's needed if a driver instance
rebound. Otherwise we will get "Unbalanced pm_runtime_enable!".

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -529,6 +529,30 @@ static int sysc_probe(struct platform_device *pdev)
 	return error;
 }
 
+static int sysc_remove(struct platform_device *pdev)
+{
+	struct sysc *ddata = platform_get_drvdata(pdev);
+	int error;
+
+	error = pm_runtime_get_sync(ddata->dev);
+	if (error < 0) {
+		pm_runtime_put_noidle(ddata->dev);
+		pm_runtime_disable(ddata->dev);
+		goto unprepare;
+	}
+
+	of_platform_depopulate(&pdev->dev);
+
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+unprepare:
+	sysc_unprepare(ddata);
+
+	return 0;
+}
+
 static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-omap2" },
 	{ .compatible = "ti,sysc-omap4" },
@@ -546,6 +570,7 @@ MODULE_DEVICE_TABLE(of, sysc_match);
 
 static struct platform_driver sysc_driver = {
 	.probe		= sysc_probe,
+	.remove		= sysc_remove,
 	.driver         = {
 		.name   = "ti-sysc",
 		.of_match_table	= sysc_match,
-- 
2.14.2
