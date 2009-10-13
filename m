From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:48:54 +0900
Subject: [PATCH 02/16] i2c-designware: Don't use the IC_CLR_INTR register
	to clear interrupts
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EA96.9060704@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're strongly discouraged from using the IC_CLR_INTR register because
it clears all software-clearable interrupts asserted at the moment.

stat = read(IC_INTR_STAT);
  :
  :  <=== Interrupts asserted during this period will be lost
  :
read(IC_CLR_INTR);

Use the separately-prepared IC_CLR_* registers, instead.

At the same time, this patch adds all remaining interrupt definitions
available in the DesignWare I2C hardware.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   77 +++++++++++++++++++++++++++++++++--
 1 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index a4f928e..efddae1 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -49,7 +49,18 @@
 #define DW_IC_FS_SCL_LCNT	0x20
 #define DW_IC_INTR_STAT		0x2c
 #define DW_IC_INTR_MASK		0x30
+#define DW_IC_RAW_INTR_STAT	0x34
 #define DW_IC_CLR_INTR		0x40
+#define DW_IC_CLR_RX_UNDER	0x44
+#define DW_IC_CLR_RX_OVER	0x48
+#define DW_IC_CLR_TX_OVER	0x4c
+#define DW_IC_CLR_RD_REQ	0x50
+#define DW_IC_CLR_TX_ABRT	0x54
+#define DW_IC_CLR_RX_DONE	0x58
+#define DW_IC_CLR_ACTIVITY	0x5c
+#define DW_IC_CLR_STOP_DET	0x60
+#define DW_IC_CLR_START_DET	0x64
+#define DW_IC_CLR_GEN_CALL	0x68
 #define DW_IC_ENABLE		0x6c
 #define DW_IC_STATUS		0x70
 #define DW_IC_TXFLR		0x74
@@ -64,9 +75,18 @@
 #define DW_IC_CON_RESTART_EN		0x20
 #define DW_IC_CON_SLAVE_DISABLE		0x40
 
-#define DW_IC_INTR_TX_EMPTY	0x10
-#define DW_IC_INTR_TX_ABRT	0x40
+#define DW_IC_INTR_RX_UNDER	0x001
+#define DW_IC_INTR_RX_OVER	0x002
+#define DW_IC_INTR_RX_FULL	0x004
+#define DW_IC_INTR_TX_OVER	0x008
+#define DW_IC_INTR_TX_EMPTY	0x010
+#define DW_IC_INTR_RD_REQ	0x020
+#define DW_IC_INTR_TX_ABRT	0x040
+#define DW_IC_INTR_RX_DONE	0x080
+#define DW_IC_INTR_ACTIVITY	0x100
 #define DW_IC_INTR_STOP_DET	0x200
+#define DW_IC_INTR_START_DET	0x400
+#define DW_IC_INTR_GEN_CALL	0x800
 
 #define DW_IC_STATUS_ACTIVITY	0x1
 
@@ -439,6 +459,55 @@ static void dw_i2c_pump_msg(unsigned long data)
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
 }
 
+static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
+{
+	u32 stat;
+
+	/*
+	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
+	 * Ths unmasked raw version of interrupt status bits are available
+	 * in the IC_RAW_INTR_STAT register.
+	 *
+	 * That is,
+	 *   stat = readl(IC_INTR_STAT);
+	 * equals to,
+	 *   stat = readl(IC_RAW_INTR_STAT) & readl(IC_INTR_MASK);
+	 *
+	 * The raw version might be useful for debugging purposes.
+	 */
+	stat = readl(dev->base + DW_IC_INTR_STAT);
+
+	/*
+	 * Do not use the IC_CLR_INTR register to clear interrupts, or
+	 * you'll miss some interrupts, triggered during the period from
+	 * reading IC_INTR_STAT to reading IC_CLR_INTR.
+	 *
+	 * Use the separately-prepared IC_CLR_* registers instead.
+	 */
+	if (stat & DW_IC_INTR_RX_UNDER)
+		readl(dev->base + DW_IC_CLR_RX_UNDER);
+	if (stat & DW_IC_INTR_RX_OVER)
+		readl(dev->base + DW_IC_CLR_RX_OVER);
+	if (stat & DW_IC_INTR_TX_OVER)
+		readl(dev->base + DW_IC_CLR_TX_OVER);
+	if (stat & DW_IC_INTR_RD_REQ)
+		readl(dev->base + DW_IC_CLR_RD_REQ);
+	if (stat & DW_IC_INTR_TX_ABRT)
+		readl(dev->base + DW_IC_CLR_TX_ABRT);
+	if (stat & DW_IC_INTR_RX_DONE)
+		readl(dev->base + DW_IC_CLR_RX_DONE);
+	if (stat & DW_IC_INTR_ACTIVITY)
+		readl(dev->base + DW_IC_CLR_ACTIVITY);
+	if (stat & DW_IC_INTR_STOP_DET)
+		readl(dev->base + DW_IC_CLR_STOP_DET);
+	if (stat & DW_IC_INTR_START_DET)
+		readl(dev->base + DW_IC_CLR_START_DET);
+	if (stat & DW_IC_INTR_GEN_CALL)
+		readl(dev->base + DW_IC_CLR_GEN_CALL);
+
+	return stat;
+}
+
 /*
  * Interrupt service routine. This gets called whenever an I2C interrupt
  * occurs.
@@ -448,8 +517,9 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	struct dw_i2c_dev *dev = dev_id;
 	u32 stat;
 
-	stat = readl(dev->base + DW_IC_INTR_STAT);
+	stat = i2c_dw_read_clear_intrbits(dev);
 	dev_dbg(dev->dev, "%s: stat=0x%x\n", __func__, stat);
+
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->abort_source = readl(dev->base + DW_IC_TX_ABRT_SOURCE);
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
@@ -457,7 +527,6 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	} else if (stat & DW_IC_INTR_TX_EMPTY)
 		tasklet_schedule(&dev->pump_msg);
 
-	readl(dev->base + DW_IC_CLR_INTR);	/* clear interrupts */
 	writel(0, dev->base + DW_IC_INTR_MASK);	/* disable interrupts */
 	if (stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
 		complete(&dev->cmd_complete);
-- 
1.6.5
