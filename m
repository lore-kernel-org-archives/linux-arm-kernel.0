From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:36 +0530
Subject: [PATCH 04/12] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jett.Zhou" <jtzhou@marvell.com>

TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
of standard & fast mode in pxa910/988; so this patch adds these two new
entries to "struct pxa_reg_layout" and "struct pxa_i2c" and also adds two
new DT properties to take configuration value for the same.

Note that, DT binding document is also updated.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Yi Zhang <yizhang@marvell.com>
[vaibhav.hiremath at linaro.org: Updated kernel doc for new DT properties
and updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt |  7 ++++
 drivers/i2c/busses/i2c-pxa.c                      | 44 +++++++++++++++++++++--
 include/linux/i2c/pxa-i2c.h                       |  2 ++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
index 12b78ac..5750bff 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
@@ -18,6 +18,13 @@ Recommended properties :
    status register of i2c controller instead.
  - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
 
+Optional Properties (Applicable to PXA910 family):
+
+ - mrvl,i2c-ilcr : Load Count Register: Allows minor adjustment to SCL clk to
+		   achieve std, normal and fast mode of operation.
+ - mrvl,i2c-iwcr : Wait Count Register - controls the setup and hold time
+		   together with mrvl,i2c-ilcr
+
 Examples:
 	twsi1: i2c at d4011000 {
 		compatible = "mrvl,mmp-twsi";
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index a76c901..8ca5552 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -46,12 +46,15 @@ struct pxa_reg_layout {
 	u32 icr;
 	u32 isr;
 	u32 isar;
+	u32 ilcr;
+	u32 iwcr;
 };
 
 enum pxa_i2c_types {
 	REGS_PXA2XX,
 	REGS_PXA3XX,
 	REGS_CE4100,
+	REGS_PXA910,
 };
 
 /*
@@ -79,12 +82,22 @@ static struct pxa_reg_layout pxa_reg_layout[] = {
 		.isr =	0x04,
 		/* no isar register */
 	},
+	[REGS_PXA910] = {
+		.ibmr = 0x00,
+		.idbr = 0x08,
+		.icr =	0x10,
+		.isr =	0x18,
+		.isar = 0x20,
+		.ilcr = 0x28,
+		.iwcr = 0x30,
+	},
 };
 
 static const struct platform_device_id i2c_pxa_id_table[] = {
 	{ "pxa2xx-i2c",		REGS_PXA2XX },
 	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
 	{ "ce4100-i2c",		REGS_CE4100 },
+	{ "pxa910-i2c",		REGS_PXA910 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
@@ -149,6 +162,8 @@ struct pxa_i2c {
 	void __iomem		*reg_icr;
 	void __iomem		*reg_isr;
 	void __iomem		*reg_isar;
+	void __iomem		*reg_ilcr;
+	void __iomem		*reg_iwcr;
 
 	unsigned long		iobase;
 	unsigned long		iosize;
@@ -160,6 +175,8 @@ struct pxa_i2c {
 	unsigned char		master_code;
 	unsigned long		rate;
 	bool			highmode_enter;
+	unsigned int		ilcr;
+	unsigned int		iwcr;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -167,6 +184,8 @@ struct pxa_i2c {
 #define _ICR(i2c)	((i2c)->reg_icr)
 #define _ISR(i2c)	((i2c)->reg_isr)
 #define _ISAR(i2c)	((i2c)->reg_isar)
+#define _ILCR(i2c)	((i2c)->reg_ilcr)
+#define _IWCR(i2c)	((i2c)->reg_iwcr)
 
 /*
  * I2C Slave mode address
@@ -467,11 +486,16 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	if (i2c->reg_isar)
 		writel(i2c->slave_addr, _ISAR(i2c));
 #endif
-
 	/* set control register values */
 	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
 	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
 
+	if (i2c->ilcr)
+		writel(i2c->ilcr, _ILCR(i2c));
+	if (i2c->iwcr)
+		writel(i2c->iwcr, _IWCR(i2c));
+	udelay(2);
+
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
 	writel(readl(_ICR(i2c)) | ICR_SADIE | ICR_ALDIE | ICR_SSDIE, _ICR(i2c));
@@ -1098,7 +1122,7 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
 static const struct of_device_id i2c_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
 	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
-	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA2XX },
+	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA910 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
@@ -1106,6 +1130,7 @@ MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
 static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 			    enum pxa_i2c_types *i2c_types)
 {
+	int ret;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 			of_match_device(i2c_pxa_dt_ids, &pdev->dev);
@@ -1121,6 +1146,16 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
 		i2c->fast_mode = 1;
 	*i2c_types = (u32)(of_id->data);
+
+	if (of_device_is_compatible(np, "mrvl,mmp-twsi")) {
+		ret = of_property_read_u32(np, "mrvl,i2c-ilcr", &i2c->ilcr);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32(np, "mrvl,i2c-iwcr", &i2c->iwcr);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -1206,6 +1241,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	if (i2c_type != REGS_CE4100)
 		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
 
+	i2c->reg_ilcr = i2c->reg_base + pxa_reg_layout[i2c_type].ilcr;
+	i2c->reg_iwcr = i2c->reg_base + pxa_reg_layout[i2c_type].iwcr;
+
 	i2c->iobase = res->start;
 	i2c->iosize = resource_size(res);
 
@@ -1219,6 +1257,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->slave_addr = plat->slave_addr;
 		i2c->slave = plat->slave;
 #endif
+		i2c->ilcr = plat->ilcr;
+		i2c->iwcr = plat->iwcr;
 		i2c->adap.class = plat->class;
 	}
 
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index 53aab24..d1a44e8 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -70,6 +70,8 @@ struct i2c_pxa_platform_data {
 	unsigned int		high_mode:1;
 	unsigned char		master_code;
 	unsigned long		rate;
+	unsigned int		ilcr;
+	unsigned int		iwcr;
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-- 
1.9.1
