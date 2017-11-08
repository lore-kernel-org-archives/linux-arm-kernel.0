From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  8 Nov 2017 16:47:08 +0100
Subject: [PATCH 1/3] ASoC: sun8i-codec: Invert Master / Slave condition
In-Reply-To: <20171108154710.16407-1-maxime.ripard@free-electrons.com>
References: <20171108154710.16407-1-maxime.ripard@free-electrons.com>
Message-ID: <20171108154710.16407-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code had the condition backward when checking if the codec
should be running in slave or master mode.

Fix it, and make the comment a bit more readable.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Cc: <stable@vger.kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index abfb710df7cb..038107baf414 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -170,11 +170,11 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	/* clock masters */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS: /* DAI Slave */
-		value = 0x0; /* Codec Master */
+	case SND_SOC_DAIFMT_CBS_CFS: /* Codec slave, DAI master */
+		value = 0x1;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFM: /* DAI Master */
-		value = 0x1; /* Codec Slave */
+	case SND_SOC_DAIFMT_CBM_CFM: /* Codec Master, DAI slave */
+		value = 0x0;
 		break;
 	default:
 		return -EINVAL;
-- 
2.14.3
