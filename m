From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 08 Nov 2016 12:25:10 +0000
Subject: [PATCH RFC 03/12] drm/i2c: tda998x: avoid race when programming audio
In-Reply-To: <20161108122420.GP1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
Message-ID: <E1c45Sg-0005jX-DP@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid a race between programming audio and an in-progress mode set.
A mode set is complex, and disables the ability to send infoframes
to the sink, and is disruptive to audio - we have to mute the audio
FIFO while doing a mode set.

If an attempt is made to start up the audio side, we will undo the
audio FIFO mute before the mode set has completed.

Move the lock so that we prevent audio interfering with an in-progress
mode set.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index ab58a13d815e..bafe3c7ad84b 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -971,6 +971,8 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 			div = 3;
 	}
 
+	mutex_lock(&priv->audio_mutex);
+
 	/* mute the audio FIFO: */
 	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
 
@@ -1064,8 +1066,6 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	/* must be last register set: */
 	reg_write(priv, REG_TBG_CNTRL_0, 0);
 
-	mutex_lock(&priv->audio_mutex);
-
 	priv->tmds_clock = adjusted_mode->clock;
 
 	/* Only setup the info frames if the sink is HDMI */
-- 
2.7.4
