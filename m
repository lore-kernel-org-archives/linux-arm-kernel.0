From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Jul 2018 12:03:21 +0100 (BST)
Subject: Applied "ASoC: sirf: Fix potential NULL pointer dereference" to the
 asoc tree
In-Reply-To: <20180726204910.GA1635@embeddedor.com>
Message-ID: <20180730110321.388881124216@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sirf: Fix potential NULL pointer dereference

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ae1c696a480c67c45fb23b35162183f72c6be0e1 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 26 Jul 2018 15:49:10 -0500
Subject: [PATCH] ASoC: sirf: Fix potential NULL pointer dereference

There is a potential execution path in which function
platform_get_resource() returns NULL. If this happens,
we will end up having a NULL pointer dereference.

Fix this by replacing devm_ioremap with devm_ioremap_resource,
which has the NULL check and the memory region request.

This code was detected with the help of Coccinelle.

Cc: stable at vger.kernel.org
Fixes: 2bd8d1d5cf89 ("ASoC: sirf: Add audio usp interface driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sirf/sirf-usp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
index 77e7dcf969d0..d70fcd4a1adf 100644
--- a/sound/soc/sirf/sirf-usp.c
+++ b/sound/soc/sirf/sirf-usp.c
@@ -370,10 +370,9 @@ static int sirf_usp_pcm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, usp);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap(&pdev->dev, mem_res->start,
-		resource_size(mem_res));
-	if (base == NULL)
-		return -ENOMEM;
+	base = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	usp->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					    &sirf_usp_regmap_config);
 	if (IS_ERR(usp->regmap))
-- 
2.18.0
