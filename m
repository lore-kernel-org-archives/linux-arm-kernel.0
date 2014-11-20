From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 20 Nov 2014 15:33:17 +0530
Subject: [PATCH] ASoC: samsung: ASoC: samsung: Fix IISMOD setting in
 i2s_set_sysclk()
Message-ID: <1416477797-27332-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the i2s_set_sysclk() callback we are currently clearing all bits
of the IISMOD register in i2s_set_sysclk. It's due to an incorrect
mask used for the AND operation which is introduced in commit
a5a56871f804edac93a53b5e871c0e9818fb9033 (ASoC: samsung:
add support for exynos7 I2S controller) and also adds the missing
break statement.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/i2s.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 0df6547..e1ace52 100644
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
@@ -551,10 +551,11 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 		}
 
 		if (clk_id == 0)
-			mod &= 0 << i2s_regs->rclksrc_off;
+			mod &= ~(1 << i2s_regs->rclksrc_off);
 		else
 			mod |= 1 << i2s_regs->rclksrc_off;
 
+		break;
 	default:
 		dev_err(&i2s->pdev->dev, "We don't serve that!\n");
 		return -EINVAL;
-- 
1.7.4.4
