From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  7 Oct 2018 11:38:47 +0200
Subject: [PATCH v2 11/29] drm/sun4i: Fix DE2 mixer size
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
Message-ID: <20181007093905.11253-12-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DE2 mixer is always 0x6000 bytes in size on all known SoCs.

While at it, introduce a macro for that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 71c0f6dc8a49..7beb3065a522 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -460,7 +460,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	base = sun8i_blender_base(mixer);
 
 	/* Reset the registers */
-	for (i = 0x0; i < 0x20000; i += 4)
+	for (i = 0; i < DE2_MIXER_UNIT_SIZE; i += 4)
 		regmap_write(mixer->engine.regs, i, 0);
 
 	/* Enable the mixer */
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 208e8219d2be..e2aa42e8f715 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -29,6 +29,8 @@
 
 #define DE2_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
 
+#define DE2_MIXER_UNIT_SIZE			0x6000
+
 #define DE2_BLD_BASE				0x1000
 #define DE2_CH_BASE				0x2000
 #define DE2_CH_SIZE				0x1000
-- 
2.19.0
