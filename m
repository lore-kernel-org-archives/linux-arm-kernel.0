From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  4 Nov 2018 19:26:47 +0100
Subject: [PATCH v3 10/28] drm/sun4i: Fix DE2 mixer size
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
Message-ID: <20181104182705.18047-11-jernej.skrabec@siol.net>
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
index 6129c350f7bd..6769ec08c0d3 100644
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
index 025550a1f539..09e0f4428c1e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -29,6 +29,8 @@
 
 #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
 
+#define DE2_MIXER_UNIT_SIZE			0x6000
+
 #define DE2_BLD_BASE				0x1000
 #define DE2_CH_BASE				0x2000
 #define DE2_CH_SIZE				0x1000
-- 
2.19.1
