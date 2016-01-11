From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 13:09:55 +0100
Subject: [PATCH] ASoC: hdac_hdmi: remove unused hdac_hdmi_query_pin_connlist
Message-ID: <4242434.H1qiCWaR2p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent rework removed the only user of the hdac_hdmi_query_pin_connlist
function, so we now get a warning when building the hdac_hdmi driver:

hdac_hdmi.c:313:12: warning: 'hdac_hdmi_query_pin_connlist' defined but not used [-Wunused-function]

This removes the function, which makes the file build cleanly again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 15b914476bf2 ("ASoC: hdac_hdmi: Use list to add pins and converters")
---
I saw this warning the first time on today's linux-next with ARM randconfig builds

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f5df7232405b..5a1ec0f7a1a6 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -310,28 +310,6 @@ hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 	return err;
 }
 
-static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
-					struct hdac_hdmi_pin *pin)
-{
-	if (!(get_wcaps(&hdac->hdac, pin->nid) & AC_WCAP_CONN_LIST)) {
-		dev_warn(&hdac->hdac.dev,
-			"HDMI: pin %d wcaps %#x does not support connection list\n",
-			pin->nid, get_wcaps(&hdac->hdac, pin->nid));
-		return -EINVAL;
-	}
-
-	pin->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
-			pin->mux_nids, HDA_MAX_CONNECTIONS);
-	if (pin->num_mux_nids == 0)
-		dev_warn(&hdac->hdac.dev, "No connections found for pin: %d\n",
-								pin->nid);
-
-	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin: %d\n",
-			pin->num_mux_nids, pin->nid);
-
-	return pin->num_mux_nids;
-}
-
 static void hdac_hdmi_fill_widget_info(struct snd_soc_dapm_widget *w,
 				enum snd_soc_dapm_type id,
 				const char *wname, const char *stream)
