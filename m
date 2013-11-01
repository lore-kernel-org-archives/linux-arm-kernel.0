From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 19:48:20 +0800
Subject: [PATCH][RESEND 7/8] ASoC: davinci: use gen_pool_dma_alloc() in
 davinci-pcm.c
In-Reply-To: <cover.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
Message-ID: <8bd26b17552315f0a3ea63c166a97a938c88dcf0.1383306365.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/davinci/davinci-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 84a63c6..fa64cd8 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -267,10 +267,9 @@ static int allocate_sram(struct snd_pcm_substream *substream,
 		return 0;
 
 	ppcm->period_bytes_max = size;
-	iram_virt = (void *)gen_pool_alloc(sram_pool, size);
+	iram_virt = gen_pool_dma_alloc(sram_pool, size, &iram_phys);
 	if (!iram_virt)
 		goto exit1;
-	iram_phys = gen_pool_virt_to_phys(sram_pool, (unsigned)iram_virt);
 	iram_dma = kzalloc(sizeof(*iram_dma), GFP_KERNEL);
 	if (!iram_dma)
 		goto exit2;
-- 
1.8.4
