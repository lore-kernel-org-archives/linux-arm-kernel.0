From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:00 +0000
Subject: [PATCH RFC 01/12] drm/i2c: tda998x: avoid race in
 tda998x_encoder_mode_set()
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45SW-0005jL-52@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As priv->audio_params can now be changed at run time, we need to be more
careful about how we deal with a mode set.  We must take the audio lock
while checking if there's a valid audio configuration.

However, it's slightly worse than that - during mode set, we mute the
audio, and it must not be unmuted until we have finished the mode set.
It is possible that the audio side may start while a mode set is in
progress, so take the audio_mutex lock around the whole mode setting
procedure.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 088900d78ceb..1cc0433ce9d5 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1074,13 +1074,12 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
-		if (priv->audio_params.format != AFMT_UNUSED) {
-			mutex_lock(&priv->audio_mutex);
+		mutex_lock(&priv->audio_mutex);
+		if (priv->audio_params.format != AFMT_UNUSED)
 			tda998x_configure_audio(priv,
 						&priv->audio_params,
 						adjusted_mode->clock);
-			mutex_unlock(&priv->audio_mutex);
-		}
+		mutex_unlock(&priv->audio_mutex);
 	}
 }
 
-- 
2.7.4
