From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  1 May 2015 00:10:04 +0800
Subject: [PATCH v2 3/5] mfd: sun6i-prcm: Add support for PRCM found on
 Allwinner A80 SoC
In-Reply-To: <1430410206-4410-1-git-send-email-wens@csie.org>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
Message-ID: <1430410206-4410-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the PRCM on the A80 SoC. There is little
to no document for this at the moment. Only register offsets are
available. However with some testing, the clock and reset controls
seem to be the similar to the ones on the A31.

One thing that needs verifying is whether the apbs divider is the same
as the A31 or the A23. The lowest divider is different between those
2 implementations.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  3 +-
 drivers/mfd/sun6i-prcm.c                           | 58 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
index 03c5a551da55..c100abfcb2a4 100644
--- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
+++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
@@ -4,7 +4,8 @@ PRCM is an MFD device exposing several Power Management related devices
 (like clks and reset controllers).
 
 Required properties:
- - compatible: "allwinner,sun6i-a31-prcm" or "allwinner,sun8i-a23-prcm"
+ - compatible: "allwinner,sun6i-a31-prcm", "allwinner,sun8i-a23-prcm",
+	       "allwinner,sun9i-a80-prcm"
  - reg: The PRCM registers range
 
 The prcm node may contain several subdevices definitions:
diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 191173166d65..e56344f04066 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -33,6 +33,22 @@ static const struct resource sun6i_a31_apb0_clk_res[] = {
 	},
 };
 
+static const struct resource sun9i_a80_cpus_clk_res[] = {
+	{
+		.start = 0x10,
+		.end = 0x13,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static const struct resource sun9i_a80_apbs_clk_res[] = {
+	{
+		.start = 0x1c,
+		.end = 0x1f,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 static const struct resource sun6i_a31_apb0_gates_clk_res[] = {
 	{
 		.start = 0x28,
@@ -111,6 +127,39 @@ static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
 	},
 };
 
+static const struct mfd_cell sun9i_a80_prcm_subdevs[] = {
+	{
+		.name = "sun9i-a80-cpus-clk",
+		.of_compatible = "allwinner,sun9i-a80-cpus-clk",
+		.num_resources = ARRAY_SIZE(sun9i_a80_cpus_clk_res),
+		.resources = sun9i_a80_cpus_clk_res,
+	},
+	{
+		.name = "sun9i-a80-apbs-clk",
+		.of_compatible = "allwinner,sun8i-a23-apb0-clk",
+		.num_resources = ARRAY_SIZE(sun9i_a80_apbs_clk_res),
+		.resources = sun9i_a80_apbs_clk_res,
+	},
+	{
+		.name = "sun9i-a80-apbs-gates-clk",
+		.of_compatible = "allwinner,sun9i-a80-apbs-gates-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_gates_clk_res),
+		.resources = sun6i_a31_apb0_gates_clk_res,
+	},
+	{
+		.name = "sun9i-a80-r-ir-clk",
+		.of_compatible = "allwinner,sun4i-a10-mod0-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_ir_clk_res),
+		.resources = sun6i_a31_ir_clk_res,
+	},
+	{
+		.name = "sun9i-a80-apbs-clock-reset",
+		.of_compatible = "allwinner,sun6i-a31-clock-reset",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
+		.resources = sun6i_a31_apb0_rstc_res,
+	},
+};
+
 static const struct prcm_data sun6i_a31_prcm_data = {
 	.nsubdevs = ARRAY_SIZE(sun6i_a31_prcm_subdevs),
 	.subdevs = sun6i_a31_prcm_subdevs,
@@ -121,6 +170,11 @@ static const struct prcm_data sun8i_a23_prcm_data = {
 	.subdevs = sun8i_a23_prcm_subdevs,
 };
 
+static const struct prcm_data sun9i_a80_prcm_data = {
+	.nsubdevs = ARRAY_SIZE(sun9i_a80_prcm_subdevs),
+	.subdevs = sun9i_a80_prcm_subdevs,
+};
+
 static const struct of_device_id sun6i_prcm_dt_ids[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-prcm",
@@ -130,6 +184,10 @@ static const struct of_device_id sun6i_prcm_dt_ids[] = {
 		.compatible = "allwinner,sun8i-a23-prcm",
 		.data = &sun8i_a23_prcm_data,
 	},
+	{
+		.compatible = "allwinner,sun9i-a80-prcm",
+		.data = &sun9i_a80_prcm_data,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.1.4
