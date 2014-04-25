From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:44:34 +0100
Subject: [PATCH 154/222] imx-drm: imx-dp: when disabling the DP foreground
 channel, wait until the DP background channel is finished before disabling
 the IDMAC channel
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeYU-0007NY-4O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dp.c b/drivers/staging/imx-drm/ipu-v3/ipu-dp.c
index 6980fa125517..d90f82a87d19 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dp.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dp.c
@@ -277,6 +277,9 @@ void ipu_dp_disable_channel(struct ipu_dp *dp)
 	writel(0, flow->base + DP_FG_POS);
 	ipu_srm_dp_sync_update(priv->ipu);
 
+	if (ipu_idmac_channel_busy(priv->ipu, IPUV3_CHANNEL_MEM_BG_SYNC))
+		ipu_wait_interrupt(priv->ipu, IPU_IRQ_DP_SF_END, 50);
+
 	mutex_unlock(&priv->mutex);
 }
 EXPORT_SYMBOL_GPL(ipu_dp_disable_channel);
-- 
1.8.3.1
