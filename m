From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 23 Jun 2013 11:48:16 +0400
Subject: [PATCH v3 3/5] drivers: bus: imx-weim: use
 module_platform_driver_probe()
In-Reply-To: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
References: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371973698-16150-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver should be called only once at startup, so code converted
to using module_platform_driver_probe().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/bus/imx-weim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 0f4b081..f872924 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -22,7 +22,7 @@ MODULE_DEVICE_TABLE(of, weim_id_table);
 #define CS_REG_RANGE  0x18
 
 /* Parse and set the timing for this device. */
-static int weim_timing_setup(struct device_node *np, void __iomem *base)
+static int __init weim_timing_setup(struct device_node *np, void __iomem *base)
 {
 	u32 value[CS_TIMING_LEN];
 	u32 cs_idx;
@@ -49,7 +49,8 @@ static int weim_timing_setup(struct device_node *np, void __iomem *base)
 	return 0;
 }
 
-static int weim_parse_dt(struct platform_device *pdev, void __iomem *base)
+static int __init weim_parse_dt(struct platform_device *pdev,
+				void __iomem *base)
 {
 	struct device_node *child;
 	int ret;
@@ -73,7 +74,7 @@ static int weim_parse_dt(struct platform_device *pdev, void __iomem *base)
 	return ret;
 }
 
-static int weim_probe(struct platform_device *pdev)
+static int __init weim_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct clk *clk;
@@ -110,10 +111,9 @@ static struct platform_driver weim_driver = {
 		.name = "imx-weim",
 		.of_match_table = weim_id_table,
 	},
-	.probe   = weim_probe,
 };
+module_platform_driver_probe(weim_driver, weim_probe);
 
-module_platform_driver(weim_driver);
 MODULE_AUTHOR("Freescale Semiconductor Inc.");
 MODULE_DESCRIPTION("i.MX EIM Controller Driver");
 MODULE_LICENSE("GPL");
-- 
1.8.1.5
