From: flatmax@flatmax.org (Matt Flax)
Date: Sat, 25 Feb 2017 16:03:12 +1100
Subject: [PATCH 1/3] ASoC : Add an IC bit and frame master mode (SoC and Codec
 slave).
In-Reply-To: <cover.1487997974.git.flatmax@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
Message-ID: <057bbc69c3dcbb5199782ae6fe44d73862b8a1d1.1487997974.git.flatmax@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new clock mode to the SoC system. The new mode
allows for an IC (between the SoC and the Codec) to be bit and
frame master.

As SoC and codec drivers default to return -EINVAL, this new mode
can not set either as master.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 include/sound/soc-dai.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 200e1f0..22f516f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -77,14 +77,17 @@ struct snd_compr_stream;
 /*
  * DAI hardware clock masters.
  *
- * This is wrt the codec, the inverse is true for the interface
- * i.e. if the codec is clk and FRM master then the interface is
- * clk and frame slave.
+ * SND_SOC_DAIFMT_C* definitions are wrt the codec, the inverse is true
+ * for the interface. i.e. if the codec is clk and FRM master then the
+ * interface is clk and frame slave.
+ * The SND_SOC_DAIFMT_IBM_IFM indicates that an IC inbetween the codec and SoC
+ * is master. In SND_SOC_DAIFMT_IBM_IFM mode both the codec and SoC are slaves.
  */
 #define SND_SOC_DAIFMT_CBM_CFM		(1 << 12) /* codec clk & FRM master */
 #define SND_SOC_DAIFMT_CBS_CFM		(2 << 12) /* codec clk slave & FRM master */
 #define SND_SOC_DAIFMT_CBM_CFS		(3 << 12) /* codec clk master & frame slave */
 #define SND_SOC_DAIFMT_CBS_CFS		(4 << 12) /* codec clk & FRM slave */
+#define SND_SOC_DAIFMT_IBM_IFM		(5 << 12) /* IC clk & FRM master */
 
 #define SND_SOC_DAIFMT_FORMAT_MASK	0x000f
 #define SND_SOC_DAIFMT_CLOCK_MASK	0x00f0
-- 
2.7.4
