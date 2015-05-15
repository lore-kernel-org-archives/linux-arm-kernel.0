From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 15 May 2015 21:36:24 +0800
Subject: [PATCH 1/7] arm: imx: power-off: change to syscon to access register
In-Reply-To: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1431696990-23078-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

snvs is MFP device, which included rtc, ON/OFF key, power off

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/power/reset/imx-snvs-poweroff.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/reset/imx-snvs-poweroff.c
index ad6ce50..b4881d7 100644
--- a/drivers/power/reset/imx-snvs-poweroff.c
+++ b/drivers/power/reset/imx-snvs-poweroff.c
@@ -22,21 +22,30 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
-static void __iomem *snvs_base;
+static struct regmap *snvs;
+
+#define SNVS_LPCR 0x38
 
 static void do_imx_poweroff(void)
 {
-	u32 value = readl(snvs_base);
-
 	/* set TOP and DP_EN bit */
-	writel(value | 0x60, snvs_base);
+	regmap_update_bits(snvs, SNVS_LPCR, 0x60, 0x60);
 }
 
 static int imx_poweroff_probe(struct platform_device *pdev)
 {
-	snvs_base = of_iomap(pdev->dev.of_node, 0);
-	if (!snvs_base) {
+	struct device_node *nd;
+
+	nd = of_get_parent(pdev->dev.of_node);
+	if (!nd)
+		return -ENODEV;
+	snvs = syscon_node_to_regmap (nd);
+	of_node_put(nd);
+
+	if (!snvs) {
 		dev_err(&pdev->dev, "failed to get memory\n");
 		return -ENODEV;
 	}
-- 
1.9.1
