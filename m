From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:53 +0530
Subject: [PATCH-v3 09/11] i2c: pxa: Add support for pxa910/988 & new
 configuration features
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436210695-19159-10-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
of standard & fast mode in pxa910/988; so this patch adds these two new
entries to "struct pxa_reg_layout" and "struct pxa_i2c".

As discussed in the previous patch-series, the idea here is to add standard
DT properties for ilcr and iwcr configuration fields.
In case of Master ilcr is used for low/high time and in case of slave mode
of operation iwcr is used for setup/hold time.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Yi Zhang <yizhang@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index dfd1dd0..d5cf6f5 100644
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
@@ -124,6 +137,24 @@ MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
 #define ISR_SAD		(1 << 9)	   /* slave address detected */
 #define ISR_BED		(1 << 10)	   /* bus error no ACK/NAK */
 
+/* bit field shift & mask */
+#define ILCR_SLV_SHIFT		0
+#define ILCR_SLV_MASK		(0x1FF << ILCR_SLV_SHIFT)
+#define ILCR_FLV_SHIFT		9
+#define ILCR_FLV_MASK		(0x1FF << ILCR_FLV_SHIFT)
+#define ILCR_HLVL_SHIFT		18
+#define ILCR_HLVL_MASK		(0x1FF << ILCR_HLVL_SHIFT)
+#define ILCR_HLVH_SHIFT		27
+#define ILCR_HLVH_MASK		(0x1F << ILCR_HLVH_SHIFT)
+
+#define IWCR_CNT_SHIFT		0
+#define IWCR_CNT_MASK		(0x1F << IWCR_CNT_SHIFT)
+#define IWCR_HS_CNT1_SHIFT	5
+#define IWCR_HS_CNT1_MASK	(0x1F << IWCR_HS_CNT1_SHIFT)
+#define IWCR_HS_CNT2_SHIFT	10
+#define IWCR_HS_CNT2_MASK	(0x1F << IWCR_HS_CNT2_SHIFT)
+
+
 struct pxa_i2c {
 	spinlock_t		lock;
 	wait_queue_head_t	wait;
@@ -150,6 +181,8 @@ struct pxa_i2c {
 	void __iomem		*reg_icr;
 	void __iomem		*reg_isr;
 	void __iomem		*reg_isar;
+	void __iomem		*reg_ilcr;
+	void __iomem		*reg_iwcr;
 
 	unsigned long		iobase;
 	unsigned long		iosize;
@@ -169,6 +202,8 @@ struct pxa_i2c {
 #define _ICR(i2c)	((i2c)->reg_icr)
 #define _ISR(i2c)	((i2c)->reg_isr)
 #define _ISAR(i2c)	((i2c)->reg_isar)
+#define _ILCR(i2c)	((i2c)->reg_ilcr)
+#define _IWCR(i2c)	((i2c)->reg_iwcr)
 
 /*
  * I2C Slave mode address
@@ -1135,7 +1170,7 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
 static const struct of_device_id i2c_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
 	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
-	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA2XX },
+	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA910 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
@@ -1250,6 +1285,11 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	if (i2c_type != REGS_CE4100)
 		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
 
+	if (i2c_type == REGS_PXA910) {
+		i2c->reg_ilcr = i2c->reg_base + pxa_reg_layout[i2c_type].ilcr;
+		i2c->reg_iwcr = i2c->reg_base + pxa_reg_layout[i2c_type].iwcr;
+	}
+
 	i2c->iobase = res->start;
 	i2c->iosize = resource_size(res);
 
-- 
1.9.1
