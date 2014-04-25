From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:13 +0100
Subject: [PATCH 150/222] imx-drm: ipu-common: add helpers to check for a busy
 IDMAC channel and to busywait for an interrupt
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeY9-0007NI-N2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-common.c | 22 ++++++++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h    |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index 058551795677..8fb4c207f3f1 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -697,6 +697,12 @@ int ipu_idmac_enable_channel(struct ipuv3_channel *channel)
 }
 EXPORT_SYMBOL_GPL(ipu_idmac_enable_channel);
 
+bool ipu_idmac_channel_busy(struct ipu_soc *ipu, unsigned int chno)
+{
+	return (ipu_idmac_read(ipu, IDMAC_CHA_BUSY(chno)) & idma_mask(chno));
+}
+EXPORT_SYMBOL_GPL(ipu_idmac_channel_busy);
+
 int ipu_idmac_wait_busy(struct ipuv3_channel *channel, int ms)
 {
 	struct ipu_soc *ipu = channel->ipu;
@@ -714,6 +720,22 @@ int ipu_idmac_wait_busy(struct ipuv3_channel *channel, int ms)
 }
 EXPORT_SYMBOL_GPL(ipu_idmac_wait_busy);
 
+int ipu_wait_interrupt(struct ipu_soc *ipu, int irq, int ms)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(ms);
+	ipu_cm_write(ipu, BIT(irq % 32), IPU_INT_STAT(irq / 32));
+	while (!(ipu_cm_read(ipu, IPU_INT_STAT(irq / 32) & BIT(irq % 32)))) {
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipu_wait_interrupt);
+
 int ipu_idmac_disable_channel(struct ipuv3_channel *channel)
 {
 	struct ipu_soc *ipu = channel->ipu;
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
index 4df00501adc2..bfc1b3366488 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
@@ -185,6 +185,9 @@ void ipu_srm_dp_sync_update(struct ipu_soc *ipu);
 int ipu_module_enable(struct ipu_soc *ipu, u32 mask);
 int ipu_module_disable(struct ipu_soc *ipu, u32 mask);
 
+bool ipu_idmac_channel_busy(struct ipu_soc *ipu, unsigned int chno);
+int ipu_wait_interrupt(struct ipu_soc *ipu, int irq, int ms);
+
 int ipu_di_init(struct ipu_soc *ipu, struct device *dev, int id,
 		unsigned long base, u32 module, struct clk *ipu_clk);
 void ipu_di_exit(struct ipu_soc *ipu, int id);
-- 
1.8.3.1
