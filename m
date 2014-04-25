From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:18 +0100
Subject: [PATCH 151/222] imx-drm: ipu-dmfc: wait for FIFOs to run empty before
 disabling
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeYE-0007NM-QI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Disabling the DMFC module while there is still data in the FIFOs could
cause the "new frame before end of frame" error state when the DMFC is
enabled again.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
index 45213017fa4b..59f182b28fc1 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
@@ -28,7 +28,12 @@
 #define DMFC_GENERAL1		0x0014
 #define DMFC_GENERAL2		0x0018
 #define DMFC_IC_CTRL		0x001c
-#define DMFC_STAT		0x0020
+#define DMFC_WR_CHAN_ALT	0x0020
+#define DMFC_WR_CHAN_DEF_ALT	0x0024
+#define DMFC_DP_CHAN_ALT	0x0028
+#define DMFC_DP_CHAN_DEF_ALT	0x002c
+#define DMFC_GENERAL1_ALT	0x0030
+#define DMFC_STAT		0x0034
 
 #define DMFC_WR_CHAN_1_28		0
 #define DMFC_WR_CHAN_2_41		8
@@ -133,6 +138,20 @@ int ipu_dmfc_enable_channel(struct dmfc_channel *dmfc)
 }
 EXPORT_SYMBOL_GPL(ipu_dmfc_enable_channel);
 
+static void ipu_dmfc_wait_fifos(struct ipu_dmfc_priv *priv)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+
+	while ((readl(priv->base + DMFC_STAT) & 0x02fff000) != 0x02fff000) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(priv->dev,
+				 "Timeout waiting for DMFC FIFOs to clear\n");
+			break;
+		}
+		cpu_relax();
+	}
+}
+
 void ipu_dmfc_disable_channel(struct dmfc_channel *dmfc)
 {
 	struct ipu_dmfc_priv *priv = dmfc->priv;
@@ -141,8 +160,10 @@ void ipu_dmfc_disable_channel(struct dmfc_channel *dmfc)
 
 	priv->use_count--;
 
-	if (!priv->use_count)
+	if (!priv->use_count) {
+		ipu_dmfc_wait_fifos(priv);
 		ipu_module_disable(priv->ipu, IPU_CONF_DMFC_EN);
+	}
 
 	if (priv->use_count < 0)
 		priv->use_count = 0;
-- 
1.8.3.1
