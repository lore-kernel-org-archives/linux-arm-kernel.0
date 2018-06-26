From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 16:11:31 +0100 (BST)
Subject: Applied "ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()"
 to the asoc tree
In-Reply-To: <20180626092016.9296-5-srinivas.kandagatla@linaro.org>
Message-ID: <20180626151131.337B6440070@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()

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

>From f614c9b070ed149bbaac4edefb2b5fcb7755c4b0 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:08 +0100
Subject: [PATCH] ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()

Now that the child nodes have there own compatible strings,
Use of_platform_populate/depopulate() instead of less common
of_platform_device_create()/destroy().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 9983c665a941..932c3ebfd252 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -64,7 +64,6 @@ struct q6adm {
 	struct aprv2_ibasic_rsp_result_t result;
 	struct mutex lock;
 	wait_queue_head_t matrix_map_wait;
-	struct platform_device *pdev_routing;
 };
 
 struct q6adm_cmd_device_open_v5 {
@@ -588,7 +587,6 @@ EXPORT_SYMBOL_GPL(q6adm_close);
 static int q6adm_probe(struct apr_device *adev)
 {
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 	struct q6adm *adm;
 
 	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
@@ -605,22 +603,12 @@ static int q6adm_probe(struct apr_device *adev)
 	INIT_LIST_HEAD(&adm->copps_list);
 	spin_lock_init(&adm->copps_list_lock);
 
-	dais_np = of_get_child_by_name(dev->of_node, "routing");
-	if (dais_np) {
-		adm->pdev_routing = of_platform_device_create(dais_np,
-							   "q6routing", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6adm_remove(struct apr_device *adev)
 {
-	struct q6adm *adm = dev_get_drvdata(&adev->dev);
-
-	if (adm->pdev_routing)
-		of_platform_device_destroy(&adm->pdev_routing->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.17.1
