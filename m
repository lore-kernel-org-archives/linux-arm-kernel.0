From: b35083@freescale.com (Jingchang Lu)
Date: Tue, 18 Jun 2013 16:48:47 +0800
Subject: [PATCH v2 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
Message-ID: <1371545327-12481-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Add Freescale Vybrid VF610 I2C controller support to
imx I2C driver framework.
  Some operation is different from imx I2C controller.
The register offset, the i2c clock divider value table,
the module enabling(I2CR_IEN) which is just invert with imx,
and the interrupt flag(I2SR) clearing opcode is w1c on VF610
but w0c on imx.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
Signed-off-by: Xiaochun Li <b41219@freescale.com>
Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
Changes in v2:
  Fix building section mismatch(es) warning.

 drivers/i2c/busses/i2c-imx.c | 144 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 125 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 6406aa9..7892d6b 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -30,6 +30,8 @@
  *	Copyright (C) 2007 RightHand Technologies, Inc.
  *	Copyright (C) 2008 Darius Augulis <darius.augulis@teltonika.lt>
  *
+ *	Copyright 2013 Freescale Semiconductor, Inc.
+ *
  */
 
 /** Includes *******************************************************************
@@ -62,13 +64,6 @@
 /* Default value */
 #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
 
-/* IMX I2C registers */
-#define IMX_I2C_IADR	0x00	/* i2c slave address */
-#define IMX_I2C_IFDR	0x04	/* i2c frequency divider */
-#define IMX_I2C_I2CR	0x08	/* i2c control */
-#define IMX_I2C_I2SR	0x0C	/* i2c status */
-#define IMX_I2C_I2DR	0x10	/* i2c transfer data */
-
 /* Bits of IMX I2C registers */
 #define I2SR_RXAK	0x01
 #define I2SR_IIF	0x02
@@ -96,7 +91,7 @@
  * Duplicated divider values removed from list
  */
 
-static u16 __initdata i2c_clk_div[50][2] = {
+static u16 imx_i2c_clk_div[50][2] = {
 	{ 22,	0x20 }, { 24,	0x21 }, { 26,	0x22 }, { 28,	0x23 },
 	{ 30,	0x00 },	{ 32,	0x24 }, { 36,	0x25 }, { 40,	0x26 },
 	{ 42,	0x03 }, { 44,	0x27 },	{ 48,	0x28 }, { 52,	0x05 },
@@ -112,11 +107,67 @@ static u16 __initdata i2c_clk_div[50][2] = {
 	{ 3072,	0x1E }, { 3840,	0x1F }
 };
 
+/* Vybrid VF610 clock divider, register value pairs */
+static u16 vf610_i2c_clk_div[60][2] = {
+	{ 20,   0x00 }, { 22,   0x01 }, { 24,   0x02 }, { 26,   0x03 },
+	{ 28,   0x04 }, { 30,   0x05 }, { 32,   0x09 }, { 34,   0x06 },
+	{ 36,   0x0A }, { 40,   0x07 }, { 44,   0x0C }, { 48,   0x0D },
+	{ 52,   0x43 }, { 56,   0x0E }, { 60,   0x45 }, { 64,   0x12 },
+	{ 68,   0x0F }, { 72,   0x13 }, { 80,   0x14 }, { 88,   0x15 },
+	{ 96,   0x19 }, { 104,  0x16 }, { 112,  0x1A }, { 128,  0x17 },
+	{ 136,  0x4F }, { 144,  0x1C }, { 160,  0x1D }, { 176,  0x55 },
+	{ 192,  0x1E }, { 208,  0x56 }, { 224,  0x22 }, { 228,  0x24 },
+	{ 240,  0x1F }, { 256,  0x23 }, { 288,  0x5C }, { 320,  0x25 },
+	{ 384,  0x26 }, { 448,  0x2A }, { 480,  0x27 }, { 512,  0x2B },
+	{ 576,  0x2C }, { 640,  0x2D }, { 768,  0x31 }, { 896,  0x32 },
+	{ 960,  0x2F }, { 1024, 0x33 }, { 1152, 0x34 }, { 1280, 0x35 },
+	{ 1536, 0x36 }, { 1792, 0x3A }, { 1920, 0x37 }, { 2048, 0x3B },
+	{ 2304, 0x3C }, { 2560, 0x3D }, { 3072, 0x3E }, { 3584, 0x7A },
+	{ 3840, 0x3F }, { 4096, 0x7B }, { 5120, 0x7D }, { 6144, 0x7E },
+};
+
 enum imx_i2c_type {
 	IMX1_I2C,
 	IMX21_I2C,
+	VF610_I2C,
+};
+
+struct imx_i2c_hwdata {
+	unsigned	addr_reg;
+	unsigned	freq_reg;
+	unsigned	ctrl_reg;
+	unsigned	status_reg;
+	unsigned	data_reg;
+	u16		(*clk_div)[2];
+	unsigned	ndivs;
+	unsigned	i2sr_clr_opcode;
+	unsigned	i2cr_ien_opcode;
+};
+
+struct imx_i2c_drvdata {
+	enum imx_i2c_type	devtype;
+	struct imx_i2c_hwdata	*hwdata;
 };
 
+#define IMX_I2C_IADR	(i2c_imx->i2c_hwdata->addr_reg)
+#define IMX_I2C_IFDR	(i2c_imx->i2c_hwdata->freq_reg)
+#define IMX_I2C_I2CR	(i2c_imx->i2c_hwdata->ctrl_reg)
+#define IMX_I2C_I2SR	(i2c_imx->i2c_hwdata->status_reg)
+#define IMX_I2C_I2DR	(i2c_imx->i2c_hwdata->data_reg)
+
+/*
+ * Interrupt flags clear operation differ between SoCs:
+ * - write zero to clear(w0c) INT flag on I.MX,
+ * - but write one to clear(w1c) INT flag on Vybrid.
+ * I2C module enable operation also differ bteween SoCs:
+ * - set I2CR_IEN bit enable the module on I.MX,
+ * - but clear I2CR_IEN bit enable the module on Vybrid.
+ */
+#define I2SR_CLR_OPCODE_W0C		0x0
+#define I2SR_CLR_OPCODE_W1C		(I2SR_IAL | I2SR_IIF)
+#define I2CR_IEN_OPCODE_0		0x0
+#define I2CR_IEN_OPCODE_1		I2CR_IEN
+
 struct imx_i2c_struct {
 	struct i2c_adapter	adapter;
 	struct clk		*clk;
@@ -127,15 +178,60 @@ struct imx_i2c_struct {
 	int			stopped;
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
 	enum imx_i2c_type	devtype;
+	struct imx_i2c_hwdata	*i2c_hwdata;
+};
+
+static struct imx_i2c_hwdata imx_i2c_hwdata = {
+	.addr_reg		= 0x00,
+	.freq_reg		= 0x04,
+	.ctrl_reg		= 0x08,
+	.status_reg		= 0x0c,
+	.data_reg		= 0x10,
+	.clk_div		= imx_i2c_clk_div,
+	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
+	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
+	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
+
+};
+
+static struct imx_i2c_hwdata vf610_i2c_hwdata = {
+	.addr_reg		= 0x00,
+	.freq_reg		= 0x01,
+	.ctrl_reg		= 0x02,
+	.status_reg		= 0x03,
+	.data_reg		= 0x04,
+	.clk_div		= vf610_i2c_clk_div,
+	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
+	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
+	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
+
+};
+
+static struct imx_i2c_drvdata imx_i2c_drvdata[] = {
+	[IMX1_I2C] = {
+		.devtype = IMX1_I2C,
+		.hwdata = &imx_i2c_hwdata
+	},
+	[IMX21_I2C] = {
+		.devtype = IMX21_I2C,
+		.hwdata = &imx_i2c_hwdata
+	},
+	[VF610_I2C] = {
+		.devtype = VF610_I2C,
+		.hwdata = &vf610_i2c_hwdata
+	},
 };
 
 static struct platform_device_id imx_i2c_devtype[] = {
 	{
 		.name = "imx1-i2c",
-		.driver_data = IMX1_I2C,
+		.driver_data = (kernel_ulong_t)&imx_i2c_drvdata[IMX1_I2C],
 	}, {
 		.name = "imx21-i2c",
-		.driver_data = IMX21_I2C,
+		.driver_data = (kernel_ulong_t)&imx_i2c_drvdata[IMX21_I2C],
+	}, {
+		.name = "vf610-i2c",
+		.driver_data = (kernel_ulong_t)&imx_i2c_drvdata[VF610_I2C],
 	}, {
 		/* sentinel */
 	}
@@ -145,6 +241,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
 static const struct of_device_id i2c_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx1-i2c", .data = &imx_i2c_devtype[IMX1_I2C], },
 	{ .compatible = "fsl,imx21-i2c", .data = &imx_i2c_devtype[IMX21_I2C], },
+	{ .compatible = "fsl,vf610-i2c", .data = &imx_i2c_devtype[VF610_I2C], },
 	{ /* sentinel */ }
 };
 
@@ -214,9 +311,8 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	clk_prepare_enable(i2c_imx->clk);
 	writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
 	/* Enable I2C controller */
-	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
-	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
-
+	writeb(i2c_imx->i2c_hwdata->i2sr_clr_opcode, i2c_imx->base + IMX_I2C_I2SR);
+	writeb(i2c_imx->i2c_hwdata->i2cr_ien_opcode, i2c_imx->base + IMX_I2C_I2CR);
 	/* Wait controller to be stable */
 	udelay(50);
 
@@ -259,7 +355,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 	}
 
 	/* Disable I2C controller */
-	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
+	writeb(i2c_imx->i2c_hwdata->i2cr_ien_opcode ^ I2CR_IEN,
+						i2c_imx->base + IMX_I2C_I2CR);
 	clk_disable_unprepare(i2c_imx->clk);
 }
 
@@ -269,14 +366,15 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 	unsigned int i2c_clk_rate;
 	unsigned int div;
 	int i;
+	u16 (*i2c_clk_div)[2] = i2c_imx->i2c_hwdata->clk_div;
 
 	/* Divider value calculation */
 	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
 	div = (i2c_clk_rate + rate - 1) / rate;
 	if (div < i2c_clk_div[0][0])
 		i = 0;
-	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1][0])
-		i = ARRAY_SIZE(i2c_clk_div) - 1;
+	else if (div > i2c_clk_div[i2c_imx->i2c_hwdata->ndivs - 1][0])
+		i = i2c_imx->i2c_hwdata->ndivs - 1;
 	else
 		for (i = 0; i2c_clk_div[i][0] < div; i++);
 
@@ -311,6 +409,7 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
 		/* save status register */
 		i2c_imx->i2csr = temp;
 		temp &= ~I2SR_IIF;
+		temp |= (i2c_imx->i2c_hwdata->i2sr_clr_opcode & I2SR_IIF);
 		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
 		wake_up(&i2c_imx->queue);
 		return IRQ_HANDLED;
@@ -492,6 +591,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imx_i2c_struct *i2c_imx;
 	struct resource *res;
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
+	struct imx_i2c_drvdata *drvdata;
 	void __iomem *base;
 	int irq, ret;
 	u32 bitrate;
@@ -518,7 +618,9 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 
 	if (of_id)
 		pdev->id_entry = of_id->data;
-	i2c_imx->devtype = pdev->id_entry->driver_data;
+	drvdata = (struct imx_i2c_drvdata *)pdev->id_entry->driver_data;
+	i2c_imx->devtype = drvdata->devtype;
+	i2c_imx->i2c_hwdata = drvdata->hwdata;
 
 	/* Setup i2c_imx driver structure */
 	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.name));
@@ -559,8 +661,12 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx_set_clk(i2c_imx, bitrate);
 
 	/* Set up chip registers to defaults */
-	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
-	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
+	clk_prepare_enable(i2c_imx->clk);
+	writeb(i2c_imx->i2c_hwdata->i2cr_ien_opcode ^ I2CR_IEN,
+						i2c_imx->base + IMX_I2C_I2CR);
+	writeb(i2c_imx->i2c_hwdata->i2sr_clr_opcode,
+						i2c_imx->base + IMX_I2C_I2SR);
+	clk_disable_unprepare(i2c_imx->clk);
 
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
-- 
1.8.0
