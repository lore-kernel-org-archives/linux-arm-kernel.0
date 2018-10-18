From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 18 Oct 2018 13:26:14 +0200
Subject: [PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and later.
In-Reply-To: <20181018112615.29362-1-o.rempel@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
Message-ID: <20181018112615.29362-3-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA support for I2C was introduced on i.MX50. So,
avoid of DMA probing on not supported versions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 53 ++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index c406700789e1..df013b1b6fa4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -169,6 +169,7 @@ struct imx_i2c_hwdata {
 	unsigned		ndivs;
 	unsigned		i2sr_clr_opcode;
 	unsigned		i2cr_ien_opcode;
+	bool			has_dmamode;
 };
 
 struct imx_i2c_dma {
@@ -211,7 +212,7 @@ static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
 	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
 	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
 	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
-
+	.has_dmamode		= false,
 };
 
 static const struct imx_i2c_hwdata imx21_i2c_hwdata = {
@@ -221,7 +222,17 @@ static const struct imx_i2c_hwdata imx21_i2c_hwdata = {
 	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
 	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
 	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
+	.has_dmamode		= false,
+};
 
+static const struct imx_i2c_hwdata imx50_i2c_hwdata = {
+	.devtype		= IMX21_I2C,
+	.regshift		= IMX_I2C_REGSHIFT,
+	.clk_div		= imx_i2c_clk_div,
+	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
+	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
+	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
+	.has_dmamode		= true,
 };
 
 static struct imx_i2c_hwdata vf610_i2c_hwdata = {
@@ -231,7 +242,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata = {
 	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
 	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
 	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
-
+	.has_dmamode		= true,
 };
 
 static const struct platform_device_id imx_i2c_devtype[] = {
@@ -241,6 +252,33 @@ static const struct platform_device_id imx_i2c_devtype[] = {
 	}, {
 		.name = "imx21-i2c",
 		.driver_data = (kernel_ulong_t)&imx21_i2c_hwdata,
+	}, {
+		.name = "imx50-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx51-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx53-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx6q-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx6sl-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx6sll-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx6sx-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx6ul-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
+	}, {
+		.name = "imx7d-i2c",
+		.driver_data = (kernel_ulong_t)&imx50_i2c_hwdata,
 	}, {
 		/* sentinel */
 	}
@@ -250,6 +288,14 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
 static const struct of_device_id i2c_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx1-i2c", .data = &imx1_i2c_hwdata, },
 	{ .compatible = "fsl,imx21-i2c", .data = &imx21_i2c_hwdata, },
+	{ .compatible = "fsl,imx50-i2c", .data = &imx50_i2c_hwdata, },
+	{ .compatible = "fsl,imx51-i2c", .data = &imx50_i2c_hwdata, },
+	{ .compatible = "fsl,imx53-i2c", .data = &imx50_i2c_hwdata, },
+	{ .compatible = "fsl,imx6q-i2c", .data = &imx50_i2c_hwdata, },
+	{ .compatible = "fsl,imx6sl-i2c", .data = &imx50_i2c_hwdata, },
+	{ .compatible = "fsl,imx6sll-i2c", .data = &imx50_i2c_hwdata, },
+	{ .compatible = "fsl,imx6sx-i2c", .data = &imx50_i2c_hwdata, },
+	{ .compatible = "fsl,imx6ul-i2c", .data = &imx50_i2c_hwdata, },
 	{ .compatible = "fsl,vf610-i2c", .data = &vf610_i2c_hwdata, },
 	{ /* sentinel */ }
 };
@@ -281,6 +327,9 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	struct device *dev = &i2c_imx->adapter.dev;
 	int ret;
 
+	if (!i2c_imx->hwdata->has_dmamode)
+		return;
+
 	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
 	if (!dma)
 		return;
-- 
2.19.0
