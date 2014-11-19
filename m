From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 19 Nov 2014 19:11:04 +0100
Subject: [PATCH] ASoC: samsung: Fix IISMOD setting in i2s_set_sysclk()
Message-ID: <1416420664-20952-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the i2s_set_sysclk() callback we are currently clearing all bits
of the IISMOD register when clk_id is SAMSUNG_I2S_CDCLK and dir
is SND_SOC_CLOCK_OUT. It's due to an incorrect mask used for the AND
operation and breaks the I2S interface operation when we attempt to
use the CDCLK output clock.

It fixes commit a5a56871f804edac93a53b5e871c0e9818fb9033
("ASoC: samsung: add support for exynos7 I2S controller") and restores
sound support for Odroid X2/U3.

Cc: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 947352d..8db8c66 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -494,7 +494,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 		if (dir == SND_SOC_CLOCK_IN)
 			mod |= 1 << i2s_regs->cdclkcon_off;
 		else
-			mod &= 0 << i2s_regs->cdclkcon_off;
+			mod &= ~(1 << i2s_regs->cdclkcon_off);
 
 		i2s->rfs = rfs;
 		break;
-- 
1.7.9.5
