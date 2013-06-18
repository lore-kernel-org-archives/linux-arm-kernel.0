From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 18 Jun 2013 19:46:50 +0400
Subject: [PATCH 4/4] drivers: bus: imx-weim: Preparation driver to support
 different CPUs
In-Reply-To: <1371570410-12773-1-git-send-email-shc_work@mail.ru>
References: <1371570410-12773-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371570410-12773-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/bus/imx-weim.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index f872924..5c78ce5 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -12,19 +12,29 @@
 #include <linux/io.h>
 #include <linux/of_device.h>
 
+struct imx_weim_devtype {
+	unsigned int	cs_max_num;
+	unsigned int	cs_regs_count;
+	unsigned int	cs_stride;
+};
+
+static const struct imx_weim_devtype imx6q_weim_devtype = {
+      .cs_max_num	= 3,
+      .cs_regs_count	= 6,
+      .cs_stride	= 0x18,
+};
+
 static const struct of_device_id weim_id_table[] = {
-	{ .compatible = "fsl,imx6q-weim", },
-	{}
+	{ .compatible = "fsl,imx6q-weim", .data = &imx6q_weim_devtype, },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, weim_id_table);
 
-#define CS_TIMING_LEN 6
-#define CS_REG_RANGE  0x18
-
 /* Parse and set the timing for this device. */
-static int __init weim_timing_setup(struct device_node *np, void __iomem *base)
+static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
+				    const struct imx_weim_devtype *devtype)
 {
-	u32 value[CS_TIMING_LEN];
+	u32 value[devtype->cs_regs_count];
 	u32 cs_idx;
 	int ret;
 	int i;
@@ -35,23 +45,26 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base)
 		return ret;
 
 	/* The weim has four chip selects. */
-	if (cs_idx > 3)
+	if (cs_idx > devtype->cs_max_num)
 		return -EINVAL;
 
 	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
-					value, CS_TIMING_LEN);
+					 value, devtype->cs_regs_count);
 	if (ret)
 		return ret;
 
 	/* set the timing for WEIM */
-	for (i = 0; i < CS_TIMING_LEN; i++)
-		writel(value[i], base + cs_idx * CS_REG_RANGE + i * 4);
+	for (i = 0; i < devtype->cs_regs_count; i++)
+		writel(value[i], base + cs_idx * devtype->cs_stride + i * 4);
+
 	return 0;
 }
 
 static int __init weim_parse_dt(struct platform_device *pdev,
 				void __iomem *base)
 {
+	const struct of_device_id *of_id = of_match_device(weim_id_table, &pdev->dev);
+	const struct imx_weim_devtype *devtype = of_id->data;
 	struct device_node *child;
 	int ret;
 
@@ -59,7 +72,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 		if (!child->name)
 			continue;
 
-		ret = weim_timing_setup(child, base);
+		ret = weim_timing_setup(child, base, devtype);
 		if (ret) {
 			dev_err(&pdev->dev, "%s set timing failed.\n",
 				child->full_name);
-- 
1.8.1.5
