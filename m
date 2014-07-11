From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Jul 2014 15:45:08 +0200
Subject: [PATCH 4/4] ASoC: samsung: remove unused DMA data
In-Reply-To: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
Message-ID: <1405086308-1461192-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c_dma_client structures and the 'ch' and 'ops' members in
s3c_dma_params were only used by the legacy DMA driver and serve
no function any more. This removes any reference to them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
---
 sound/soc/samsung/ac97.c        | 15 ---------------
 sound/soc/samsung/dma.h         |  7 -------
 sound/soc/samsung/i2s.c         |  6 ------
 sound/soc/samsung/pcm.c         | 12 ------------
 sound/soc/samsung/s3c-i2s-v2.c  |  2 --
 sound/soc/samsung/s3c2412-i2s.c |  4 ----
 sound/soc/samsung/s3c24xx-i2s.c |  4 ----
 sound/soc/samsung/spdif.c       |  5 -----
 8 files changed, 55 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 2aa24d052a4a..e1615113fd84 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -38,30 +38,15 @@ struct s3c_ac97_info {
 };
 static struct s3c_ac97_info s3c_ac97;
 
-static struct s3c_dma_client s3c_dma_client_out = {
-	.name = "AC97 PCMOut"
-};
-
-static struct s3c_dma_client s3c_dma_client_in = {
-	.name = "AC97 PCMIn"
-};
-
-static struct s3c_dma_client s3c_dma_client_micin = {
-	.name = "AC97 MicIn"
-};
-
 static struct s3c_dma_params s3c_ac97_pcm_out = {
-	.client		= &s3c_dma_client_out,
 	.dma_size	= 4,
 };
 
 static struct s3c_dma_params s3c_ac97_pcm_in = {
-	.client		= &s3c_dma_client_in,
 	.dma_size	= 4,
 };
 
 static struct s3c_dma_params s3c_ac97_mic_in = {
-	.client		= &s3c_dma_client_micin,
 	.dma_size	= 4,
 };
 
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 070ab0f09609..0e85dcfec023 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -14,17 +14,10 @@
 
 #include <sound/dmaengine_pcm.h>
 
-struct s3c_dma_client {
-	char *name;
-};
-
 struct s3c_dma_params {
-	struct s3c_dma_client *client;	/* stream identifier */
 	int channel;				/* Channel ID */
 	dma_addr_t dma_addr;
 	int dma_size;			/* Size of the DMA transfer */
-	unsigned ch;
-	struct samsung_dma_ops *ops;
 	char *ch_name;
 	struct snd_dmaengine_dai_dma_data dma_data;
 };
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 5f9b255a8b38..db8b29a0d106 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1212,11 +1212,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	pri_dai->dma_playback.dma_addr = regs_base + I2STXD;
 	pri_dai->dma_capture.dma_addr = regs_base + I2SRXD;
-	pri_dai->dma_playback.client =
-		(struct s3c_dma_client *)&pri_dai->dma_playback;
 	pri_dai->dma_playback.ch_name = "tx";
-	pri_dai->dma_capture.client =
-		(struct s3c_dma_client *)&pri_dai->dma_capture;
 	pri_dai->dma_capture.ch_name = "rx";
 	pri_dai->dma_playback.dma_size = 4;
 	pri_dai->dma_capture.dma_size = 4;
@@ -1234,8 +1230,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			goto err;
 		}
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
-		sec_dai->dma_playback.client =
-			(struct s3c_dma_client *)&sec_dai->dma_playback;
 		sec_dai->dma_playback.ch_name = "tx-sec";
 
 		if (!np) {
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 4c5f97fe45c8..bac034b15a27 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -131,32 +131,20 @@ struct s3c_pcm_info {
 	struct s3c_dma_params	*dma_capture;
 };
 
-static struct s3c_dma_client s3c_pcm_dma_client_out = {
-	.name		= "PCM Stereo out"
-};
-
-static struct s3c_dma_client s3c_pcm_dma_client_in = {
-	.name		= "PCM Stereo in"
-};
-
 static struct s3c_dma_params s3c_pcm_stereo_out[] = {
 	[0] = {
-		.client		= &s3c_pcm_dma_client_out,
 		.dma_size	= 4,
 	},
 	[1] = {
-		.client		= &s3c_pcm_dma_client_out,
 		.dma_size	= 4,
 	},
 };
 
 static struct s3c_dma_params s3c_pcm_stereo_in[] = {
 	[0] = {
-		.client		= &s3c_pcm_dma_client_in,
 		.dma_size	= 4,
 	},
 	[1] = {
-		.client		= &s3c_pcm_dma_client_in,
 		.dma_size	= 4,
 	},
 };
diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index de6c321b8b68..df65c5b494b1 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -22,8 +22,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/dma.h>
-
 #include "regs-i2s-v2.h"
 #include "s3c-i2s-v2.h"
 #include "dma.h"
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index d6bc6dc0aafb..9180310e862a 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -34,16 +34,12 @@
 #include "s3c2412-i2s.h"
 
 static struct s3c_dma_params s3c2412_i2s_pcm_stereo_out = {
-	.client		=
-		(struct s3c_dma_client *)&s3c2412_i2s_pcm_stereo_out,
 	.channel	= DMACH_I2S_OUT,
 	.ch_name	= "tx",
 	.dma_size	= 4,
 };
 
 static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
-	.client		=
-		(struct s3c_dma_client *)&s3c2412_i2s_pcm_stereo_in,
 	.channel	= DMACH_I2S_IN,
 	.ch_name	= "rx",
 	.dma_size	= 4,
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index e8b98528e356..e87d9a2053b8 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -32,16 +32,12 @@
 #include "s3c24xx-i2s.h"
 
 static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_out = {
-	.client		=
-		(struct s3c_dma_client *)&s3c24xx_i2s_pcm_stereo_out,
 	.channel	= DMACH_I2S_OUT,
 	.ch_name	= "tx",
 	.dma_size	= 2,
 };
 
 static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_in = {
-	.client		=
-		(struct s3c_dma_client *)&s3c24xx_i2s_pcm_stereo_in,
 	.channel	= DMACH_I2S_IN,
 	.ch_name	= "rx",
 	.dma_size	= 2,
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index d9ffc48fce5e..d7d2e208f486 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -93,10 +93,6 @@ struct samsung_spdif_info {
 	struct s3c_dma_params	*dma_playback;
 };
 
-static struct s3c_dma_client spdif_dma_client_out = {
-	.name		= "S/PDIF Stereo out",
-};
-
 static struct s3c_dma_params spdif_stereo_out;
 static struct samsung_spdif_info spdif_info;
 
@@ -435,7 +431,6 @@ static int spdif_probe(struct platform_device *pdev)
 	}
 
 	spdif_stereo_out.dma_size = 2;
-	spdif_stereo_out.client = &spdif_dma_client_out;
 	spdif_stereo_out.dma_addr = mem_res->start + DATA_OUTBUF;
 	spdif_stereo_out.channel = dma_res->start;
 
-- 
1.8.3.2
