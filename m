From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 13 Sep 2017 20:41:55 +0900
Subject: [PATCH v4 4/4] [media] exynos-gsc: Add hardware rotation limits
In-Reply-To: <1505302915-15699-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1505302915-15699-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170913114215epcas2p346dd3987cf25481bc780e0eef8b91ed8@epcas2p3.samsung.com>
Message-ID: <1505302915-15699-5-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware rotation limits of gsc depends on SOC (Exynos
5250/5420/5433). Distinguish them and add them to the driver data.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 127 +++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 4380150..173a238 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -958,6 +958,51 @@ static irqreturn_t gsc_irq_handler(int irq, void *priv)
 	.target_rot_en_h	= 2016,
 };
 
+static struct gsc_pix_max gsc_v_5250_max = {
+	.org_scaler_bypass_w	= 8192,
+	.org_scaler_bypass_h	= 8192,
+	.org_scaler_input_w	= 4800,
+	.org_scaler_input_h	= 3344,
+	.real_rot_dis_w		= 4800,
+	.real_rot_dis_h		= 3344,
+	.real_rot_en_w		= 2016,
+	.real_rot_en_h		= 2016,
+	.target_rot_dis_w	= 4800,
+	.target_rot_dis_h	= 3344,
+	.target_rot_en_w	= 2016,
+	.target_rot_en_h	= 2016,
+};
+
+static struct gsc_pix_max gsc_v_5420_max = {
+	.org_scaler_bypass_w	= 8192,
+	.org_scaler_bypass_h	= 8192,
+	.org_scaler_input_w	= 4800,
+	.org_scaler_input_h	= 3344,
+	.real_rot_dis_w		= 4800,
+	.real_rot_dis_h		= 3344,
+	.real_rot_en_w		= 2048,
+	.real_rot_en_h		= 2048,
+	.target_rot_dis_w	= 4800,
+	.target_rot_dis_h	= 3344,
+	.target_rot_en_w	= 2016,
+	.target_rot_en_h	= 2016,
+};
+
+static struct gsc_pix_max gsc_v_5433_max = {
+	.org_scaler_bypass_w	= 8192,
+	.org_scaler_bypass_h	= 8192,
+	.org_scaler_input_w	= 4800,
+	.org_scaler_input_h	= 3344,
+	.real_rot_dis_w		= 4800,
+	.real_rot_dis_h		= 3344,
+	.real_rot_en_w		= 2047,
+	.real_rot_en_h		= 2047,
+	.target_rot_dis_w	= 4800,
+	.target_rot_dis_h	= 3344,
+	.target_rot_en_w	= 2016,
+	.target_rot_en_h	= 2016,
+};
+
 static struct gsc_pix_min gsc_v_100_min = {
 	.org_w			= 64,
 	.org_h			= 32,
@@ -992,6 +1037,45 @@ static irqreturn_t gsc_irq_handler(int irq, void *priv)
 	.local_sc_down		= 2,
 };
 
+static struct gsc_variant gsc_v_5250_variant = {
+	.pix_max		= &gsc_v_5250_max,
+	.pix_min		= &gsc_v_100_min,
+	.pix_align		= &gsc_v_100_align,
+	.in_buf_cnt		= 32,
+	.out_buf_cnt		= 32,
+	.sc_up_max		= 8,
+	.sc_down_max		= 16,
+	.poly_sc_down_max	= 4,
+	.pre_sc_down_max	= 4,
+	.local_sc_down		= 2,
+};
+
+static struct gsc_variant gsc_v_5420_variant = {
+	.pix_max		= &gsc_v_5420_max,
+	.pix_min		= &gsc_v_100_min,
+	.pix_align		= &gsc_v_100_align,
+	.in_buf_cnt		= 32,
+	.out_buf_cnt		= 32,
+	.sc_up_max		= 8,
+	.sc_down_max		= 16,
+	.poly_sc_down_max	= 4,
+	.pre_sc_down_max	= 4,
+	.local_sc_down		= 2,
+};
+
+static struct gsc_variant gsc_v_5433_variant = {
+	.pix_max		= &gsc_v_5433_max,
+	.pix_min		= &gsc_v_100_min,
+	.pix_align		= &gsc_v_100_align,
+	.in_buf_cnt		= 32,
+	.out_buf_cnt		= 32,
+	.sc_up_max		= 8,
+	.sc_down_max		= 16,
+	.poly_sc_down_max	= 4,
+	.pre_sc_down_max	= 4,
+	.local_sc_down		= 2,
+};
+
 static struct gsc_driverdata gsc_v_100_drvdata = {
 	.variant = {
 		[0] = &gsc_v_100_variant,
@@ -1004,11 +1088,33 @@ static irqreturn_t gsc_irq_handler(int irq, void *priv)
 	.num_clocks = 1,
 };
 
+static struct gsc_driverdata gsc_v_5250_drvdata = {
+	.variant = {
+		[0] = &gsc_v_5250_variant,
+		[1] = &gsc_v_5250_variant,
+		[2] = &gsc_v_5250_variant,
+		[3] = &gsc_v_5250_variant,
+	},
+	.num_entities = 4,
+	.clk_names = { "gscl" },
+	.num_clocks = 1,
+};
+
+static struct gsc_driverdata gsc_v_5420_drvdata = {
+	.variant = {
+		[0] = &gsc_v_5420_variant,
+		[1] = &gsc_v_5420_variant,
+	},
+	.num_entities = 4,
+	.clk_names = { "gscl" },
+	.num_clocks = 1,
+};
+
 static struct gsc_driverdata gsc_5433_drvdata = {
 	.variant = {
-		[0] = &gsc_v_100_variant,
-		[1] = &gsc_v_100_variant,
-		[2] = &gsc_v_100_variant,
+		[0] = &gsc_v_5433_variant,
+		[1] = &gsc_v_5433_variant,
+		[2] = &gsc_v_5433_variant,
 	},
 	.num_entities = 3,
 	.clk_names = { "pclk", "aclk", "aclk_xiu", "aclk_gsclbend" },
@@ -1017,13 +1123,21 @@ static irqreturn_t gsc_irq_handler(int irq, void *priv)
 
 static const struct of_device_id exynos_gsc_match[] = {
 	{
-		.compatible = "samsung,exynos5-gsc",
-		.data = &gsc_v_100_drvdata,
+		.compatible = "samsung,exynos5250-gsc",
+		.data = &gsc_v_5250_drvdata,
+	},
+	{
+		.compatible = "samsung,exynos5420-gsc",
+		.data = &gsc_v_5420_drvdata,
 	},
 	{
 		.compatible = "samsung,exynos5433-gsc",
 		.data = &gsc_5433_drvdata,
 	},
+	{
+		.compatible = "samsung,exynos5-gsc",
+		.data = &gsc_v_100_drvdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_gsc_match);
@@ -1045,6 +1159,9 @@ static int gsc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (drv_data == &gsc_v_100_drvdata)
+		dev_info(dev, "compatible 'exynos5-gsc' is deprecated\n");
+
 	gsc->id = ret;
 	if (gsc->id >= drv_data->num_entities) {
 		dev_err(dev, "Invalid platform device id: %d\n", gsc->id);
-- 
1.9.1
