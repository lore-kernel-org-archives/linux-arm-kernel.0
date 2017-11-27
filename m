From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Nov 2017 18:53:14 +0000
Subject: Applied "ASoC: stm32: sai: use devm_of_platform_populate()" to the
 asoc tree
In-Reply-To: <1511362947-14747-4-git-send-email-olivier.moysan@st.com>
Message-ID: <E1eJOWo-0007Dq-Qf@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: use devm_of_platform_populate()

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

>From 512d1bb4e86bd0fd4d665d4e454a3486236a419f Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Wed, 22 Nov 2017 16:02:27 +0100
Subject: [PATCH] ASoC: stm32: sai: use devm_of_platform_populate()

Use devm_of_platform_populate() instead of of_platform_depopulate()
to simplify driver code.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 0a1f06418bf4..d743b7dd52fb 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -124,7 +124,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 
 static int stm32_sai_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_sai_data *sai;
 	struct reset_control *rst;
 	struct resource *res;
@@ -184,14 +183,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	sai->set_sync = &stm32_sai_set_sync;
 	platform_set_drvdata(pdev, sai);
 
-	return of_platform_populate(np, NULL, NULL, &pdev->dev);
-}
-
-static int stm32_sai_remove(struct platform_device *pdev)
-{
-	of_platform_depopulate(&pdev->dev);
-
-	return 0;
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 MODULE_DEVICE_TABLE(of, stm32_sai_ids);
@@ -202,7 +194,6 @@ static struct platform_driver stm32_sai_driver = {
 		.of_match_table = stm32_sai_ids,
 	},
 	.probe = stm32_sai_probe,
-	.remove = stm32_sai_remove,
 };
 
 module_platform_driver(stm32_sai_driver);
-- 
2.15.0
