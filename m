From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 16 Feb 2014 16:38:44 +0800
Subject: [PATCH v3] bus: imx-weim: support CS GPR config for imx6q-weim
Message-ID: <1392539924-23583-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For imx6q-weim type of device, there might a WEIM CS space configuration
register in General Purpose Register controller, e.g. IOMUXC_GPR1 on
i.MX6Q.

Depending on which configuration of the following 4 is chosen for given
system, IOMUXC_GPR1[11:0] should be set up as 05, 033, 0113 or 01111
correspondingly.

	CS0(128M) CS1(0M)  CS2(0M)  CS3(0M)
	CS0(64M)  CS1(64M) CS2(0M)  CS3(0M)
	CS0(64M)  CS1(32M) CS2(32M) CS3(0M)
	CS0(32M)  CS1(32M) CS2(32M) CS3(32M)

The patch creates a function for imx6q-weim type of device, which scans
'ranges' property of WEIM node and build the GPR value incrementally.
Thus the WEIM CS GPR can be set up automatically at boot time.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v2:
 - Fix a typo of 01111 value
 - Minor code improvements per Philippe's suggestion

 drivers/bus/imx-weim.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 3ef58c8..08b017a 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -11,6 +11,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/regmap.h>
 
 struct imx_weim_devtype {
 	unsigned int	cs_count;
@@ -56,6 +59,55 @@ static const struct of_device_id weim_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, weim_id_table);
 
+static int __init imx6q_weim_gpr_setup(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct property *prop;
+	const __be32 *p;
+	struct regmap *gpr;
+	u32 gprvals[4] = {
+		05,	/* CS0(128M) CS1(0M)  CS2(0M)  CS3(0M) */
+		033,	/* CS0(64M)  CS1(64M) CS2(0M)  CS3(0M) */
+		0113,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
+		01111,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
+	};
+	u32 gprval = 0;
+	u32 val;
+	int cs = 0;
+	int i = 0;
+
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr)) {
+		dev_err(&pdev->dev, "failed to find fsl,imx6q-iomuxc-gpr\n");
+		return -ENOENT;
+	}
+
+	of_property_for_each_u32(np, "ranges", prop, p, val) {
+		if (i % 4 == 0) {
+			cs = val;
+		} else if (i % 4 == 3 && val) {
+			val = (val / SZ_32M) | 1;
+			gprval |= val << cs * 3;
+		}
+		i++;
+	}
+
+	if (i == 0 || i % 4)
+		goto err;
+
+	for (i = 0; i < ARRAY_SIZE(gprvals); i++) {
+		if (gprval == gprvals[i]) {
+			/* Found it. Set up IOMUXC_GPR1[11:0] with it. */
+			regmap_update_bits(gpr, IOMUXC_GPR1, 0xfff, gprval);
+			return 0;
+		}
+	}
+
+err:
+	dev_err(&pdev->dev, "Invalid 'ranges' configuration\n");
+	return -EINVAL;
+}
+
 /* Parse and set the timing for this device. */
 static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 				    const struct imx_weim_devtype *devtype)
@@ -92,6 +144,9 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	struct device_node *child;
 	int ret;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6q-weim"))
+		imx6q_weim_gpr_setup(pdev);
+
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		if (!child->name)
 			continue;
-- 
1.7.9.5
