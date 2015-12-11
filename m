From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 11 Dec 2015 09:45:33 +0100
Subject: [PATCH] ASoC: rockchip: spdif: Set transmit data level to 16 samples
Message-ID: <1449823533-6993-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicitly set the transmit data level on the transceiver to 16 samples
rather then the default 0. This matches both the level set in the vendor
kernel and the (seemingly very similar) i2s engine. This fixes audio
glitches when playing back at 192k rate.

At the same time, fix a trivial typo in the TDL mask definition

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 sound/soc/rockchip/rockchip_spdif.c | 6 ++++--
 sound/soc/rockchip/rockchip_spdif.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index ac72ff5..5a806da 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -152,8 +152,10 @@ static int rk_spdif_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = regmap_update_bits(spdif->regmap, SPDIF_DMACR,
-				   SPDIF_DMACR_TDE_ENABLE,
-				   SPDIF_DMACR_TDE_ENABLE);
+				   SPDIF_DMACR_TDE_ENABLE |
+				   SPDIF_DMACR_TDL_MASK,
+				   SPDIF_DMACR_TDE_ENABLE |
+				   SPDIF_DMACR_TDL(16));
 
 		if (ret != 0)
 			return ret;
diff --git a/sound/soc/rockchip/rockchip_spdif.h b/sound/soc/rockchip/rockchip_spdif.h
index 921b409..3ef1277 100644
--- a/sound/soc/rockchip/rockchip_spdif.h
+++ b/sound/soc/rockchip/rockchip_spdif.h
@@ -42,7 +42,7 @@
 
 #define SPDIF_DMACR_TDL_SHIFT	0
 #define SPDIF_DMACR_TDL(x)	((x) << SPDIF_DMACR_TDL_SHIFT)
-#define SPDIF_DMACR_TDL_MASK	(0x1f << SDPIF_DMACR_TDL_SHIFT)
+#define SPDIF_DMACR_TDL_MASK	(0x1f << SPDIF_DMACR_TDL_SHIFT)
 
 /*
  * XFER
-- 
2.6.2
