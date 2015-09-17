From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Sep 2015 12:00:06 +0200
Subject: [PATCH 3/3] ALSA: hda: Do not rely on explicit module loading
In-Reply-To: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
References: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1442484006-9614-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

With MODALIAS information being properly exported to userspace helpers,
there is no need to explicitly request modules. Upon registration of new
codec devices, userspace will know which kernel module to load.

This removes request_module() from the HDA controller's ->probe() path.
Recursively loading a module this way causes a deadlock in the driver
core because the HDA controller is locked as part of its own probe but
probing its children (the HDA codec devices) will attempt to lock them
again. In the past this has been worked around by splitting the probe
into synchronous and asynchronous parts, where the request_module() is
executed from a workqueue to avoid the deadlock.

Since all the information necessary to let userspace load the proper
kernel modules is now exported, there is no need for such workarounds
anymore.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/pci/hda/hda_bind.c | 80 ------------------------------------------------
 1 file changed, 80 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index d5ac25cc7fee..bbc7e2081b0d 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -146,72 +146,6 @@ void hda_codec_driver_unregister(struct hda_codec_driver *drv)
 }
 EXPORT_SYMBOL_GPL(hda_codec_driver_unregister);
 
-static inline bool codec_probed(struct hda_codec *codec)
-{
-	return device_attach(hda_codec_dev(codec)) > 0 && codec->preset;
-}
-
-/* try to auto-load and bind the codec module */
-static void codec_bind_module(struct hda_codec *codec)
-{
-#ifdef MODULE
-	request_module("snd-hda-codec-id:%08x", codec->core.vendor_id);
-	if (codec_probed(codec))
-		return;
-	request_module("snd-hda-codec-id:%04x*",
-		       (codec->core.vendor_id >> 16) & 0xffff);
-	if (codec_probed(codec))
-		return;
-#endif
-}
-
-#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
-/* if all audio out widgets are digital, let's assume the codec as a HDMI/DP */
-static bool is_likely_hdmi_codec(struct hda_codec *codec)
-{
-	hda_nid_t nid;
-
-	for_each_hda_codec_node(nid, codec) {
-		unsigned int wcaps = get_wcaps(codec, nid);
-		switch (get_wcaps_type(wcaps)) {
-		case AC_WID_AUD_IN:
-			return false; /* HDMI parser supports only HDMI out */
-		case AC_WID_AUD_OUT:
-			if (!(wcaps & AC_WCAP_DIGITAL))
-				return false;
-			break;
-		}
-	}
-	return true;
-}
-#else
-/* no HDMI codec parser support */
-#define is_likely_hdmi_codec(codec)	false
-#endif /* CONFIG_SND_HDA_CODEC_HDMI */
-
-static int codec_bind_generic(struct hda_codec *codec)
-{
-	if (codec->probe_id)
-		return -ENODEV;
-
-	if (is_likely_hdmi_codec(codec)) {
-		codec->probe_id = HDA_CODEC_ID_GENERIC_HDMI;
-#if IS_MODULE(CONFIG_SND_HDA_CODEC_HDMI)
-		request_module("snd-hda-codec-hdmi");
-#endif
-		if (codec_probed(codec))
-			return 0;
-	}
-
-	codec->probe_id = HDA_CODEC_ID_GENERIC;
-#if IS_MODULE(CONFIG_SND_HDA_GENERIC)
-	request_module("snd-hda-codec-generic");
-#endif
-	if (codec_probed(codec))
-		return 0;
-	return -ENODEV;
-}
-
 #if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
 #define is_generic_config(codec) \
 	(codec->modelname && !strcmp(codec->modelname, "generic"))
@@ -241,25 +175,11 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	if (!codec->preset)
-		codec_bind_module(codec);
-	if (!codec->preset) {
-		err = codec_bind_generic(codec);
-		if (err < 0) {
-			codec_err(codec, "Unable to bind the codec\n");
-			goto error;
-		}
-	}
-
 	/* audio codec should override the mixer name */
 	if (codec->core.afg || !*codec->card->mixername)
 		snprintf(codec->card->mixername,
 			 sizeof(codec->card->mixername), "%s %s",
 			 codec->core.vendor_name, codec->core.chip_name);
 	return 0;
-
- error:
-	snd_hdac_device_unregister(&codec->core);
-	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_configure);
-- 
2.5.0
