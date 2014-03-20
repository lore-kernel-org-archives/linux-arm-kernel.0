From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 20 Mar 2014 16:17:12 +0100
Subject: [RFC PATCH] staging: imx-drm: add suspend / resume
Message-ID: <20140320151712.22089.59230.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently i.MX53 boards with the imx-drm display driver active
fail an intensive suspend to ram / resume test.

After around 5 - 50 cycles it is no longer possible to resume
the board.

The culprit is the imx-drm driver which does not stop DMA
before suspending. Removing the driver "fixes" the problem.

This patch provides a minimal suspend / resume implementation
enabling the intensive test to work (500 cycles ok).

I am only sending this as RFC for the moment since I don't
really know the hardware or driver code well enough to be
sure this is the "right" way of doing it.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/staging/imx-drm/ipu-v3/ipu-common.c |   47 +++++++++++++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h    |    1 +
 2 files changed, 48 insertions(+)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index 97ca692..484a90a 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -692,6 +692,8 @@ int ipu_idmac_enable_channel(struct ipuv3_channel *channel)
 	val |= idma_mask(channel->num);
 	ipu_idmac_write(ipu, val, IDMAC_CHA_EN(channel->num));
 
+	channel->enabled = true;
+
 	spin_unlock_irqrestore(&ipu->lock, flags);
 
 	return 0;
@@ -750,6 +752,8 @@ int ipu_idmac_disable_channel(struct ipuv3_channel *channel)
 	val &= ~idma_mask(channel->num);
 	ipu_cm_write(ipu, val, IPU_CHA_DB_MODE_SEL(channel->num));
 
+	channel->enabled = false;
+
 	spin_unlock_irqrestore(&ipu->lock, flags);
 
 	return 0;
@@ -1245,10 +1249,53 @@ static int ipu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static int ipu_suspend(struct device *dev)
+{
+	struct ipu_soc *ipu = dev_get_drvdata(dev);
+	struct ipuv3_channel *channel;
+	int i;
+
+	channel = ipu->channel;
+	for (i = 0; i < ARRAY_SIZE(ipu->channel); i++, channel++) {
+		channel->suspended = false;
+		if (channel->enabled) {
+			if (ipu_idmac_wait_busy(channel, 50))
+				dev_warn(dev,
+					"%s: Timeout channel %d idle\n",
+					__func__, i);
+			ipu_idmac_disable_channel(channel);
+			channel->suspended = true;
+		}
+	}
+	return 0;
+}
+
+static int ipu_resume(struct device *dev)
+{
+	struct ipu_soc *ipu = dev_get_drvdata(dev);
+	struct ipuv3_channel *channel;
+	int i;
+
+	channel = ipu->channel;
+	for (i = 0; i < ARRAY_SIZE(ipu->channel); i++, channel++) {
+		if (channel->suspended) {
+			ipu_idmac_enable_channel(channel);
+			channel->suspended = false;
+		}
+	}
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ipu_pm_ops, ipu_suspend, ipu_resume);
+
 static struct platform_driver imx_ipu_driver = {
 	.driver = {
 		.name = "imx-ipuv3",
 		.of_match_table = imx_ipu_dt_ids,
+		.pm = &ipu_pm_ops,
 	},
 	.probe = ipu_probe,
 	.remove = ipu_remove,
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
index 4df0050..233749a 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
@@ -144,6 +144,7 @@ struct ipuv3_channel {
 
 	bool enabled;
 	bool busy;
+	bool suspended;
 
 	struct ipu_soc *ipu;
 };
