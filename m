From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Sun, 18 Oct 2015 22:13:28 +0200
Subject: [PATCH] bus: imx-weim: Fix deferred probing
Message-ID: <5623FD68.4070801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_DELAY_DEVICE_PROBES being set the weim driver
isn't loadad because module_platform_driver_probe is
incompatible with deferred probing.

Fix this by using builtin_platform_driver instead.
Going with deferred probing also means we have to drop
the __init annotations.

Successfully tested on a I.MX6-based system.

I send the patch to linux-arm-kernel as the kernel MAINTAINERS
file doesn't list a dedicated maintainer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/bus/imx-weim.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index e98d15e..7c425d3 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -59,7 +59,7 @@ static const struct of_device_id weim_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, weim_id_table);
 
-static int __init imx_weim_gpr_setup(struct platform_device *pdev)
+static int imx_weim_gpr_setup(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct property *prop;
@@ -109,7 +109,7 @@ err:
 }
 
 /* Parse and set the timing for this device. */
-static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
+static int weim_timing_setup(struct device_node *np, void __iomem *base,
 				    const struct imx_weim_devtype *devtype)
 {
 	u32 cs_idx, value[devtype->cs_regs_count];
@@ -135,7 +135,7 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 	return 0;
 }
 
-static int __init weim_parse_dt(struct platform_device *pdev,
+static int weim_parse_dt(struct platform_device *pdev,
 				void __iomem *base)
 {
 	const struct of_device_id *of_id = of_match_device(weim_id_table,
@@ -172,7 +172,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	return ret;
 }
 
-static int __init weim_probe(struct platform_device *pdev)
+static int weim_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct clk *clk;
@@ -209,8 +209,9 @@ static struct platform_driver weim_driver = {
 		.name		= "imx-weim",
 		.of_match_table	= weim_id_table,
 	},
+	.probe = weim_probe,
 };
-module_platform_driver_probe(weim_driver, weim_probe);
+builtin_platform_driver(weim_driver);
 
 MODULE_AUTHOR("Freescale Semiconductor Inc.");
 MODULE_DESCRIPTION("i.MX EIM Controller Driver");
-- 
2.6.1
