From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jun 2014 15:22:55 +0100
Subject: [PATCH 2/7] ASoC: kirkwood-i2s: provide helper
 KIRKWOOD_RECCTL_ENABLE_MASK definition
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1X0AZj-0003iB-4N@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a KIRKWOOD_RECCTL_ENABLE_MASK definition to complement the existing
PLAYCTL definition, and make use of it where we wish to clear both
enable bits.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 7 +++----
 sound/soc/kirkwood/kirkwood.h     | 3 +++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 9f842222e798..55af6c8e4603 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -322,8 +322,7 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 		else
 			ctl &= ~KIRKWOOD_RECCTL_I2S_EN;		/* spdif */
 
-		value = ctl & ~(KIRKWOOD_RECCTL_I2S_EN |
-				KIRKWOOD_RECCTL_SPDIF_EN);
+		value = ctl & ~KIRKWOOD_RECCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 
 		/* enable interrupts */
@@ -347,7 +346,7 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 
 		/* disable all records */
 		value = readl(priv->io + KIRKWOOD_RECCTL);
-		value &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
+		value &= ~KIRKWOOD_RECCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 		break;
 
@@ -411,7 +410,7 @@ static int kirkwood_i2s_init(struct kirkwood_dma_data *priv)
 	writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
 	value = readl(priv->io + KIRKWOOD_RECCTL);
-	value &= ~(KIRKWOOD_RECCTL_I2S_EN | KIRKWOOD_RECCTL_SPDIF_EN);
+	value &= ~KIRKWOOD_RECCTL_ENABLE_MASK;
 	writel(value, priv->io + KIRKWOOD_RECCTL);
 
 	return 0;
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index bf23afbba1d7..ab21de090938 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -38,6 +38,9 @@
 #define KIRKWOOD_RECCTL_SIZE_24		(1<<0)
 #define KIRKWOOD_RECCTL_SIZE_32		(0<<0)
 
+#define KIRKWOOD_RECCTL_ENABLE_MASK		(KIRKWOOD_RECCTL_SPDIF_EN | \
+						 KIRKWOOD_RECCTL_I2S_EN)
+
 #define KIRKWOOD_REC_BUF_ADDR			0x1004
 #define KIRKWOOD_REC_BUF_SIZE			0x1008
 #define KIRKWOOD_REC_BYTE_COUNT			0x100C
-- 
1.8.3.1
