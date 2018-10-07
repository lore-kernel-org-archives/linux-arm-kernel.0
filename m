From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  7 Oct 2018 11:38:48 +0200
Subject: [PATCH v2 12/29] drm/sun4i: Disable unused DE2 sub-engines
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
Message-ID: <20181007093905.11253-13-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some sub-engines are unused. Disable them explicitly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 8 ++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 7beb3065a522..2cb24d987005 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -462,6 +462,14 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	/* Reset the registers */
 	for (i = 0; i < DE2_MIXER_UNIT_SIZE; i += 4)
 		regmap_write(mixer->engine.regs, i, 0);
+	/* Disable unused sub-engines */
+	regmap_write(mixer->engine.regs, DE2_MIXER_FCE_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_BWS_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_LTI_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_PEAK_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_ASE_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_FCC_EN, 0);
+	regmap_write(mixer->engine.regs, DE2_MIXER_DCSC_EN, 0);
 
 	/* Enable the mixer */
 	regmap_write(mixer->engine.regs, DE2_MIXER_GLOBAL_CTL,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index e2aa42e8f715..f26ee6af6cba 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -101,8 +101,8 @@
 #define DE2_MIXER_FBFMT_YUV411		14
 
 /*
- * These sub-engines are still unknown now, the EN registers are here only to
- * be used to disable these sub-engines.
+ * Sub-engines listed bellow are unused for now. The EN registers are here only
+ * to be used to disable these sub-engines.
  */
 #define DE2_MIXER_FCE_EN			0xa0000
 #define DE2_MIXER_BWS_EN			0xa2000
-- 
2.19.0
