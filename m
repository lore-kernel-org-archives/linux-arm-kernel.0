From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Thu, 21 Jun 2018 11:56:28 +0900
Subject: [PATCH v2] ASoC: uniphier: remove redundant check of PLL ID
Message-ID: <20180621025628.4046-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes redudant check of PLL ID. struct uniphier_aio_pll
enable member has already been checked at is_valid_pll().

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v1:

  - Remove unused variable 'dev'
---
 sound/soc/uniphier/aio-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 2d9b7dde2ffa..ee90e6c3937c 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -219,15 +219,10 @@ static int uniphier_aio_set_pll(struct snd_soc_dai *dai, int pll_id,
 				unsigned int freq_out)
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
-	struct device *dev = &aio->chip->pdev->dev;
 	int ret;
 
 	if (!is_valid_pll(aio->chip, pll_id))
 		return -EINVAL;
-	if (!aio->chip->plls[pll_id].enable) {
-		dev_err(dev, "PLL(%d) is not implemented\n", pll_id);
-		return -ENOTSUPP;
-	}
 
 	ret = aio_chip_set_pll(aio->chip, pll_id, freq_out);
 	if (ret < 0)
-- 
2.17.1
