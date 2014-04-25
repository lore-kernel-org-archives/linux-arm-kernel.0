From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:23 +0100
Subject: [PATCH 152/222] imx-drm: ipu-dc: wait for DC_FC_1 / DP_SF_END
 interrupt
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeYJ-0007NQ-Tc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Wait for the DC Frame Complete or DP Sync Flow End interrupts
before disabling DC channels.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c | 71 +++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index 6f9abe8a4575..7f5734aef9f7 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 
 #include "../imx-drm.h"
@@ -111,6 +112,9 @@ struct ipu_dc_priv {
 	struct device		*dev;
 	struct ipu_dc		channels[IPU_DC_NUM_CHANNELS];
 	struct mutex		mutex;
+	struct completion	comp;
+	int			dc_irq;
+	int			dp_irq;
 };
 
 static void dc_link_event(struct ipu_dc *dc, int event, int addr, int priority)
@@ -242,38 +246,46 @@ void ipu_dc_enable_channel(struct ipu_dc *dc)
 }
 EXPORT_SYMBOL_GPL(ipu_dc_enable_channel);
 
+static irqreturn_t dc_irq_handler(int irq, void *dev_id)
+{
+	struct ipu_dc *dc = dev_id;
+	u32 reg;
+
+	reg = readl(dc->base + DC_WR_CH_CONF);
+	reg &= ~DC_WR_CH_CONF_PROG_TYPE_MASK;
+	writel(reg, dc->base + DC_WR_CH_CONF);
+
+	/* The Freescale BSP kernel clears DIx_COUNTER_RELEASE here */
+
+	complete(&dc->priv->comp);
+	return IRQ_HANDLED;
+}
+
 void ipu_dc_disable_channel(struct ipu_dc *dc)
 {
 	struct ipu_dc_priv *priv = dc->priv;
+	int irq, ret;
 	u32 val;
-	int irq = 0, timeout = 50;
 
+	/* TODO: Handle MEM_FG_SYNC differently from MEM_BG_SYNC */
 	if (dc->chno == 1)
-		irq = IPU_IRQ_DC_FC_1;
+		irq = priv->dc_irq;
 	else if (dc->chno == 5)
-		irq = IPU_IRQ_DP_SF_END;
+		irq = priv->dp_irq;
 	else
 		return;
 
-	/* should wait for the interrupt here */
-	mdelay(50);
+	init_completion(&priv->comp);
+	enable_irq(irq);
+	ret = wait_for_completion_timeout(&priv->comp, msecs_to_jiffies(50));
+	disable_irq(irq);
+	if (ret <= 0) {
+		dev_warn(priv->dev, "DC stop timeout after 50 ms\n");
 
-	if (dc->di == 0)
-		val = 0x00000002;
-	else
-		val = 0x00000020;
-
-	/* Wait for DC triple buffer to empty */
-	while ((readl(priv->dc_reg + DC_STAT) & val) != val) {
-		usleep_range(2000, 20000);
-		timeout -= 2;
-		if (timeout <= 0)
-			break;
+		val = readl(dc->base + DC_WR_CH_CONF);
+		val &= ~DC_WR_CH_CONF_PROG_TYPE_MASK;
+		writel(val, dc->base + DC_WR_CH_CONF);
 	}
-
-	val = readl(dc->base + DC_WR_CH_CONF);
-	val &= ~DC_WR_CH_CONF_PROG_TYPE_MASK;
-	writel(val, dc->base + DC_WR_CH_CONF);
 }
 EXPORT_SYMBOL_GPL(ipu_dc_disable_channel);
 
@@ -343,7 +355,7 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 	struct ipu_dc_priv *priv;
 	static int channel_offsets[] = { 0, 0x1c, 0x38, 0x54, 0x58, 0x5c,
 		0x78, 0, 0x94, 0xb4};
-	int i;
+	int i, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -364,6 +376,23 @@ int ipu_dc_init(struct ipu_soc *ipu, struct device *dev,
 		priv->channels[i].base = priv->dc_reg + channel_offsets[i];
 	}
 
+	priv->dc_irq = ipu_map_irq(ipu, IPU_IRQ_DC_FC_1);
+	if (!priv->dc_irq)
+		return -EINVAL;
+	ret = devm_request_irq(dev, priv->dc_irq, dc_irq_handler, 0, NULL,
+			       &priv->channels[1]);
+	if (ret < 0)
+		return ret;
+	disable_irq(priv->dc_irq);
+	priv->dp_irq = ipu_map_irq(ipu, IPU_IRQ_DP_SF_END);
+	if (!priv->dp_irq)
+		return -EINVAL;
+	ret = devm_request_irq(dev, priv->dp_irq, dc_irq_handler, 0, NULL,
+			       &priv->channels[5]);
+	if (ret < 0)
+		return ret;
+	disable_irq(priv->dp_irq);
+
 	writel(DC_WR_CH_CONF_WORD_SIZE_24 | DC_WR_CH_CONF_DISP_ID_PARALLEL(1) |
 			DC_WR_CH_CONF_PROG_DI_ID,
 			priv->channels[1].base + DC_WR_CH_CONF);
-- 
1.8.3.1
