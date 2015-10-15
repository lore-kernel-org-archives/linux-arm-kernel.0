From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:36:38 +0800
Subject: [PATCH v6 09/10] snd: dmaengine-pcm: add snd_dmaengine_pcm_get_caps
 interface
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1444872998-2548-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add snd_dmaengine_pcm_get_caps for I2S devices to query
dma controller's caps if they need it to make special limitation
due to specific dma controller design

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6:
- remove get quirks and add get slave caps

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 sound/soc/soc-generic-dmaengine-pcm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6fd1906..225c933 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -466,4 +466,28 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
 
+
+/**
+ * snd_dmaengine_pcm_get_caps - Get slave dma caps based PCM device
+ * @dev: Parent device the PCM was register with
+ */
+int snd_dmaengine_pcm_get_caps(struct device *dev, struct dma_slave_caps *caps)
+{
+	struct snd_soc_platform *platform;
+	struct dmaengine_pcm *pcm;
+	int ret = -ENODEV;
+
+	platform = snd_soc_lookup_platform(dev);
+	if (!platform)
+		return ret;
+
+	pcm = soc_platform_to_pcm(platform);
+
+	if (pcm->chan)
+		ret = dma_get_slave_caps(pcm->chan[0], caps);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_caps);
+
 MODULE_LICENSE("GPL");
-- 
2.3.7
