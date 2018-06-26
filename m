From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 16:11:09 +0100 (BST)
Subject: Applied "ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()"
 to the asoc tree
In-Reply-To: <20180626092016.9296-6-srinivas.kandagatla@linaro.org>
Message-ID: <20180626151109.43C44440070@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()

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

>From 4aac7e2773030d667491fbb6d97c9f467fdcbc05 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:09 +0100
Subject: [PATCH] ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()

Now that the child nodes have there own compatible strings,
Use of_platform_populate/depopulate() instead of less common
of_platform_device_create()/destroy().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 530852385cad..c4fd28f168d5 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -177,7 +177,6 @@ struct q6asm {
 	struct platform_device *pcmdev;
 	spinlock_t slock;
 	struct audio_client *session[MAX_SESSIONS + 1];
-	struct platform_device *pdev_dais;
 };
 
 struct audio_client {
@@ -1344,7 +1343,6 @@ EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
 static int q6asm_probe(struct apr_device *adev)
 {
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 	struct q6asm *q6asm;
 
 	q6asm = devm_kzalloc(dev, sizeof(*q6asm), GFP_KERNEL);
@@ -1359,22 +1357,12 @@ static int q6asm_probe(struct apr_device *adev)
 	spin_lock_init(&q6asm->slock);
 	dev_set_drvdata(dev, q6asm);
 
-	dais_np = of_get_child_by_name(dev->of_node, "dais");
-	if (dais_np) {
-		q6asm->pdev_dais = of_platform_device_create(dais_np,
-							   "q6asm-dai", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6asm_remove(struct apr_device *adev)
 {
-	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
-
-	if (q6asm->pdev_dais)
-		of_platform_device_destroy(&q6asm->pdev_dais->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.17.1
