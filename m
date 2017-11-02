From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 Nov 2017 12:15:48 +0100
Subject: [PATCH] ASoC: stm32: sai: attempt to fix uninitialized variable
Message-ID: <20171102111620.3688534-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 61fb4ff70377 ("ASoC: stm32: sai: Move static
settings to DAI init"), we get a valid warning about the
use of an uninitialized variable:

sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_hw_params':
sound/soc/stm/stm32_sai_sub.c:485:7: error: 'cr1' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I could not immediately figure out what the code should do
instead, this is the hack I applied locally to shut up the
warning. It may or may not be correct, please take a look.

Fixes: 61fb4ff70377 ("ASoC: stm32: sai: Move static settings to DAI init")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/stm/stm32_sai_sub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 150ad546d8b9..d8a51fce368a 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -480,6 +480,7 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 
 	/* Mode, data format and channel config */
 	cr1_mask = SAI_XCR1_DS_MASK;
+	cr1 = 0;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
-- 
2.9.0
