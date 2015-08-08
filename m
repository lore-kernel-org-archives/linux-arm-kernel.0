From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:10:11 +0100
Subject: [PATCH 2/9] drm: bridge/dw_hdmi-ahb-audio: parse ELD from HDMI driver
In-Reply-To: <20150808160936.GN7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6hH-0003N1-IM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse the ELD (EDID like data) stored from the HDMI driver to restrict
the sample rates and channels which are available to ALSA.  This causes
the ALSA device to reflect the capabilities of the overall audio path,
not just what is supported at the HDMI source interface level.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/Kconfig             | 1 +
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 6 ++++++
 drivers/gpu/drm/bridge/dw_hdmi-audio.h     | 1 +
 drivers/gpu/drm/bridge/dw_hdmi.c           | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 56ed35fe0734..204861bfb867 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -7,6 +7,7 @@ config DRM_DW_HDMI_AHB_AUDIO
 	tristate "Synopsis Designware AHB Audio interface"
 	depends on DRM_DW_HDMI && SND
 	select SND_PCM
+	select SND_PCM_ELD
 	select SND_PCM_IEC958
 	help
 	  Support the AHB Audio interface which is part of the Synopsis
diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
index 22bbbc5c2393..125b81306254 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
@@ -12,11 +12,13 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/drm_edid.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/pcm_drm_eld.h>
 #include <sound/pcm_iec958.h>
 
 #include "dw_hdmi-audio.h"
@@ -284,6 +286,10 @@ static int dw_hdmi_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = dw_hdmi_hw;
 
+	ret = snd_pcm_hw_constraint_eld(runtime, dw->data.eld);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_pcm_limit_hw_rates(runtime);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/bridge/dw_hdmi-audio.h b/drivers/gpu/drm/bridge/dw_hdmi-audio.h
index 1e840118d90a..91f631beecc7 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi-audio.h
+++ b/drivers/gpu/drm/bridge/dw_hdmi-audio.h
@@ -8,6 +8,7 @@ struct dw_hdmi_audio_data {
 	void __iomem *base;
 	int irq;
 	struct dw_hdmi *hdmi;
+	u8 *eld;
 };
 
 #endif
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index b65464789fbd..a8b243278774 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1533,6 +1533,8 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
 		drm_mode_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
+		/* Store the ELD */
+		drm_edid_to_eld(connector, edid);
 		kfree(edid);
 	} else {
 		dev_dbg(hdmi->dev, "failed to get edid\n");
@@ -1873,6 +1875,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 		audio.base = hdmi->regs;
 		audio.irq = irq;
 		audio.hdmi = hdmi;
+		audio.eld = hdmi->connector.eld;
 
 		pdevinfo.name = "dw-hdmi-ahb-audio";
 		pdevinfo.data = &audio;
-- 
2.1.0
