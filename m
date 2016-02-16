From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 17:44:15 +0100
Subject: [PATCH v2] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
Message-ID: <1455641066-4014858-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_SND_JACK is disabled, the hdmi driver tries to create
a new output jack structure and dereferences it even though
the pointer is never assigned:

sound/pci/hda/patch_hdmi.c: In function 'generic_hdmi_build_jack':
sound/pci/hda/patch_hdmi.c:2534:30: error: 'jack' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/pci/hda/patch_hdmi.c:2526:19: note: 'jack' was declared here

This makes snd_jack_new() return an error when SND_JACK is disabled,
forcing all users to handle errors gracefully and avoiding the
problem in all callers that correctly check the return code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 788d441a164c ("ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling")
---
 include/sound/jack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 23bede121c78..1e84a2e413f8 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -99,7 +99,7 @@ void snd_jack_report(struct snd_jack *jack, int status);
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
 			       struct snd_jack **jack, bool initial_kctl, bool phantom_jack)
 {
-	return 0;
+	return -ENXIO;
 }
 
 static inline int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask)
-- 
2.7.0
