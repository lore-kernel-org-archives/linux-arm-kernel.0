From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Nov 2017 18:53:18 +0000
Subject: Applied "ASoC: stm32: sai: simplify sync modes management" to the
 asoc tree
In-Reply-To: <1511362947-14747-3-git-send-email-olivier.moysan@st.com>
Message-ID: <E1eJOWs-0007FC-7e@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: simplify sync modes management

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

>From 7dd0d835582ff72b0b3bd0f4fa074967dff1ce82 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Wed, 22 Nov 2017 16:02:26 +0100
Subject: [PATCH] ASoC: stm32: sai: simplify sync modes management

Use function of_find_device_by_node() to retrieve SAI
synchro provider device and private data.
This allows to remove registration of probed SAI
in a linked list.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c | 105 ++++++++++------------------------------------
 1 file changed, 22 insertions(+), 83 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index d6f71a3406e9..0a1f06418bf4 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -28,16 +28,6 @@
 
 #include "stm32_sai.h"
 
-static LIST_HEAD(sync_providers);
-static DEFINE_MUTEX(sync_mutex);
-
-struct sync_provider {
-	struct list_head link;
-	struct device_node *node;
-	int  (*sync_conf)(void *data, int synco);
-	void *data;
-};
-
 static const struct stm32_sai_conf stm32_sai_conf_f4 = {
 	.version = SAI_STM32F4,
 };
@@ -70,9 +60,8 @@ static int stm32_sai_sync_conf_client(struct stm32_sai_data *sai, int synci)
 	return 0;
 }
 
-static int stm32_sai_sync_conf_provider(void *data, int synco)
+static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 {
-	struct stm32_sai_data *sai = (struct stm32_sai_data *)data;
 	u32 prev_synco;
 	int ret;
 
@@ -103,73 +92,34 @@ static int stm32_sai_sync_conf_provider(void *data, int synco)
 	return 0;
 }
 
-static int stm32_sai_set_sync_provider(struct device_node *np, int synco)
+static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
+			      struct device_node *np_provider,
+			      int synco, int synci)
 {
-	struct sync_provider *provider;
+	struct platform_device *pdev = of_find_device_by_node(np_provider);
+	struct stm32_sai_data *sai_provider;
 	int ret;
 
-	mutex_lock(&sync_mutex);
-	list_for_each_entry(provider, &sync_providers, link) {
-		if (provider->node == np) {
-			ret = provider->sync_conf(provider->data, synco);
-			mutex_unlock(&sync_mutex);
-			return ret;
-		}
+	if (!pdev) {
+		dev_err(&sai_client->pdev->dev,
+			"Device not found for node %s\n", np_provider->name);
+		return -ENODEV;
 	}
-	mutex_unlock(&sync_mutex);
 
-	/* SAI sync provider not found */
-	return -ENODEV;
-}
-
-static int stm32_sai_set_sync(struct stm32_sai_data *sai,
-			      struct device_node *np_provider,
-			      int synco, int synci)
-{
-	int ret;
+	sai_provider = platform_get_drvdata(pdev);
+	if (!sai_provider) {
+		dev_err(&sai_client->pdev->dev,
+			"SAI sync provider data not found\n");
+		return -EINVAL;
+	}
 
 	/* Configure sync client */
-	stm32_sai_sync_conf_client(sai, synci);
+	ret = stm32_sai_sync_conf_client(sai_client, synci);
+	if (ret < 0)
+		return ret;
 
 	/* Configure sync provider */
-	ret = stm32_sai_set_sync_provider(np_provider, synco);
-
-	return ret;
-}
-
-static int stm32_sai_sync_add_provider(struct platform_device *pdev,
-				       void *data)
-{
-	struct sync_provider *sp;
-
-	sp = devm_kzalloc(&pdev->dev, sizeof(*sp), GFP_KERNEL);
-	if (!sp)
-		return -ENOMEM;
-
-	sp->node = of_node_get(pdev->dev.of_node);
-	sp->data = data;
-	sp->sync_conf = &stm32_sai_sync_conf_provider;
-
-	mutex_lock(&sync_mutex);
-	list_add(&sp->link, &sync_providers);
-	mutex_unlock(&sync_mutex);
-
-	return 0;
-}
-
-static void stm32_sai_sync_del_provider(struct device_node *np)
-{
-	struct sync_provider *sp;
-
-	mutex_lock(&sync_mutex);
-	list_for_each_entry(sp, &sync_providers, link) {
-		if (sp->node == np) {
-			list_del(&sp->link);
-			of_node_put(sp->node);
-			break;
-		}
-	}
-	mutex_unlock(&sync_mutex);
+	return stm32_sai_sync_conf_provider(sai_provider, synco);
 }
 
 static int stm32_sai_probe(struct platform_device *pdev)
@@ -179,7 +129,6 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	struct reset_control *rst;
 	struct resource *res;
 	const struct of_device_id *of_id;
-	int ret;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
@@ -231,27 +180,17 @@ static int stm32_sai_probe(struct platform_device *pdev)
 		reset_control_deassert(rst);
 	}
 
-	ret = stm32_sai_sync_add_provider(pdev, sai);
-	if (ret < 0)
-		return ret;
-	sai->set_sync = &stm32_sai_set_sync;
-
 	sai->pdev = pdev;
+	sai->set_sync = &stm32_sai_set_sync;
 	platform_set_drvdata(pdev, sai);
 
-	ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
-	if (ret < 0)
-		stm32_sai_sync_del_provider(np);
-
-	return ret;
+	return of_platform_populate(np, NULL, NULL, &pdev->dev);
 }
 
 static int stm32_sai_remove(struct platform_device *pdev)
 {
 	of_platform_depopulate(&pdev->dev);
 
-	stm32_sai_sync_del_provider(pdev->dev.of_node);
-
 	return 0;
 }
 
-- 
2.15.0
