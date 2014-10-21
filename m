From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Oct 2014 14:49:26 +0800
Subject: [RFC 2/3] mfd: sun6i-prcm: Add support for PRCM found on Allwinner
 A80 SoC
In-Reply-To: <1413874167-6479-1-git-send-email-wens@csie.org>
References: <1413874167-6479-1-git-send-email-wens@csie.org>
Message-ID: <1413874167-6479-3-git-send-email-wens@csie.org>
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
 drivers/mfd/sun6i-prcm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 283ab8d..4589acb 100644
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
@@ -97,6 +113,33 @@ static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
 	},
 };
 
+static const struct mfd_cell sun9i_a80_prcm_subdevs[] = {
+	{
+		.name = "sun6i-a31-ar100-clk",
+		.of_compatible = "allwinner,sun6i-a31-ar100-clk",
+		.num_resources = ARRAY_SIZE(sun9i_a80_cpus_clk_res),
+		.resources = sun9i_a80_cpus_clk_res,
+	},
+	{
+		.name = "sun8i-a23-apb0-clk",
+		.of_compatible = "allwinner,sun8i-a23-apb0-clk",
+		.num_resources = ARRAY_SIZE(sun9i_a80_apbs_clk_res),
+		.resources = sun9i_a80_apbs_clk_res,
+	},
+	{
+		.name = "sun6i-a31-apb0-gates-clk",
+		.of_compatible = "allwinner,sun9i-a80-apbs-gates-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_gates_clk_res),
+		.resources = sun6i_a31_apb0_gates_clk_res,
+	},
+	{
+		.name = "sun6i-a31-apb0-clock-reset",
+		.of_compatible = "allwinner,sun6i-a31-clock-reset",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
+		.resources = sun6i_a31_apb0_rstc_res,
+	},
+};
+
 static const struct prcm_data sun6i_a31_prcm_data = {
 	.nsubdevs = ARRAY_SIZE(sun6i_a31_prcm_subdevs),
 	.subdevs = sun6i_a31_prcm_subdevs,
@@ -107,6 +150,11 @@ static const struct prcm_data sun8i_a23_prcm_data = {
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
@@ -116,6 +164,10 @@ static const struct of_device_id sun6i_prcm_dt_ids[] = {
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
2.1.1
