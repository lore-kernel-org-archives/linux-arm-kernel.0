From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed,  5 Jan 2011 17:50:58 +0100
Subject: [PATCH 1/6] i2c/pxa: use dynamic register layout
In-Reply-To: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1294246263-31960-2-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will prepare the driver to handle register layouts where certain
registers are not available at all.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/i2c/busses/i2c-pxa.c |   70 ++++++++++++++++++++++++++++++------------
 1 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4c19a9..a011455 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -38,29 +38,49 @@
 #include <asm/irq.h>
 #include <plat/i2c.h>
 
+struct pxa_reg_layout {
+	u32 ibmr;
+	u32 idbr;
+	u32 icr;
+	u32 isr;
+	u32 isar;
+};
+
+enum pxa_i2c_types {
+	REGS_PXA2XX,
+	REGS_PXA3XX,
+};
+
 /*
- * I2C register offsets will be shifted 0 or 1 bit left, depending on
- * different SoCs
+ * I2C registers definitions
  */
-#define REG_SHIFT_0	(0 << 0)
-#define REG_SHIFT_1	(1 << 0)
-#define REG_SHIFT(d)	((d) & 0x1)
+static struct pxa_reg_layout pxa_reg_layout[] = {
+	[REGS_PXA2XX] = {
+		.ibmr =	0x00,
+		.idbr =	0x10,
+		.icr =	0x20,
+		.isr =	0x30,
+		.isar =	0x40,
+	},
+	[REGS_PXA3XX] = {
+		.ibmr =	0x00,
+		.idbr =	0x08,
+		.icr =	0x10,
+		.isr =	0x18,
+		.isar =	0x20,
+	},
+};
 
 static const struct platform_device_id i2c_pxa_id_table[] = {
-	{ "pxa2xx-i2c",		REG_SHIFT_1 },
-	{ "pxa3xx-pwri2c",	REG_SHIFT_0 },
+	{ "pxa2xx-i2c",		REGS_PXA2XX },
+	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
 
 /*
- * I2C registers and bit definitions
+ * I2C bit definitions
  */
-#define IBMR		(0x00)
-#define IDBR		(0x08)
-#define ICR		(0x10)
-#define ISR		(0x18)
-#define ISAR		(0x20)
 
 #define ICR_START	(1 << 0)	   /* start bit */
 #define ICR_STOP	(1 << 1)	   /* stop bit */
@@ -111,7 +131,11 @@ struct pxa_i2c {
 	u32			icrlog[32];
 
 	void __iomem		*reg_base;
-	unsigned int		reg_shift;
+	void __iomem		*reg_ibmr;
+	void __iomem		*reg_idbr;
+	void __iomem		*reg_icr;
+	void __iomem		*reg_isr;
+	void __iomem		*reg_isar;
 
 	unsigned long		iobase;
 	unsigned long		iosize;
@@ -121,11 +145,11 @@ struct pxa_i2c {
 	unsigned int		fast_mode :1;
 };
 
-#define _IBMR(i2c)	((i2c)->reg_base + (0x0 << (i2c)->reg_shift))
-#define _IDBR(i2c)	((i2c)->reg_base + (0x4 << (i2c)->reg_shift))
-#define _ICR(i2c)	((i2c)->reg_base + (0x8 << (i2c)->reg_shift))
-#define _ISR(i2c)	((i2c)->reg_base + (0xc << (i2c)->reg_shift))
-#define _ISAR(i2c)	((i2c)->reg_base + (0x10 << (i2c)->reg_shift))
+#define _IBMR(i2c)	((i2c)->reg_ibmr)
+#define _IDBR(i2c)	((i2c)->reg_idbr)
+#define _ICR(i2c)	((i2c)->reg_icr)
+#define _ISR(i2c)	((i2c)->reg_isr)
+#define _ISAR(i2c)	((i2c)->reg_isar)
 
 /*
  * I2C Slave mode address
@@ -1001,6 +1025,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct resource *res;
 	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
 	const struct platform_device_id *id = platform_get_device_id(dev);
+	enum pxa_i2c_types i2c_type = id->driver_data;
 	int ret;
 	int irq;
 
@@ -1044,7 +1069,12 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		ret = -EIO;
 		goto eremap;
 	}
-	i2c->reg_shift = REG_SHIFT(id->driver_data);
+
+	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
+	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
+	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
+	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
+	i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
 
 	i2c->iobase = res->start;
 	i2c->iosize = resource_size(res);
-- 
1.7.3.2
