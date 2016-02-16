From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 15:47:28 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack' pointer
Message-ID: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_SND_JACK is disabled, the hdmi driver tries to create
a new output jack structure and dereferences it even though
the pointer is never assigned:

sound/pci/hda/patch_hdmi.c: In function 'generic_hdmi_build_jack':
sound/pci/hda/patch_hdmi.c:2534:30: error: 'jack' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/pci/hda/patch_hdmi.c:2526:19: note: 'jack' was declared here

This uses a compile-time check to avoid calling a nonworking
snd_jack_new() function, and sets an explicit NULL pointer instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 788d441a164c ("ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling")
---
 sound/pci/hda/patch_hdmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f4443b5fbf6e..c0872ad80aa0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2526,6 +2526,11 @@ static int add_hdmi_jack_kctl(struct hda_codec *codec,
 	struct snd_jack *jack;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_SND_JACK)) {
+		spec->pcm_rec[pcm_idx].jack = NULL;
+		return 0;
+	}
+
 	err = snd_jack_new(codec->card, name, SND_JACK_AVOUT, &jack,
 			   true, false);
 	if (err < 0)
-- 
2.7.0
