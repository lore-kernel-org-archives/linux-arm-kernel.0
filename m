From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 16:11:07 +0100 (BST)
Subject: Applied "ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()"
 to the asoc tree
In-Reply-To: <20180625143115.8346-7-srinivas.kandagatla@linaro.org>
Message-ID: <20180626151107.2C0CB440070@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()

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

>From 01afbd45f78cb0557db18c3ba768eea3e9576cfd Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:10 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()

Now that the child nodes have there own compatible strings,
Use of_platform_populate/depopulate() instead of less common
of_platform_device_create()/destroy().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 01f43218984b..621b67b34db9 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -316,7 +316,6 @@ struct q6afe {
 	struct mutex lock;
 	struct list_head port_list;
 	spinlock_t port_list_lock;
-	struct platform_device *pdev_dais;
 };
 
 struct afe_port_cmd_device_start {
@@ -1438,7 +1437,6 @@ static int q6afe_probe(struct apr_device *adev)
 {
 	struct q6afe *afe;
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 
 	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
@@ -1453,22 +1451,12 @@ static int q6afe_probe(struct apr_device *adev)
 
 	dev_set_drvdata(dev, afe);
 
-	dais_np = of_get_child_by_name(dev->of_node, "dais");
-	if (dais_np) {
-		afe->pdev_dais = of_platform_device_create(dais_np,
-							   "q6afe-dai", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6afe_remove(struct apr_device *adev)
 {
-	struct q6afe *afe = dev_get_drvdata(&adev->dev);
-
-	if (afe->pdev_dais)
-		of_platform_device_destroy(&afe->pdev_dais->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.17.1
