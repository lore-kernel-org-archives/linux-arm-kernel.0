From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 22:41:54 +0800
Subject: [PATCH 5/5] ALSA: AACI: Convert to use devm_ioremap_resource()
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1490539314-9681-6-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to use devm_ioremap_resource() in probe function, otherwise it's
missed to unremap this region if probe failed or rmmod module.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 sound/arm/aaci.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 4140b1b..2078568 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -990,19 +990,13 @@ static int aaci_probe(struct amba_device *dev,
 	struct aaci *aaci;
 	int ret, i;
 
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		return ret;
-
 	aaci = aaci_init_card(dev);
-	if (!aaci) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!aaci)
+		return -ENOMEM;
 
-	aaci->base = ioremap(dev->res.start, resource_size(&dev->res));
-	if (!aaci->base) {
-		ret = -ENOMEM;
+	aaci->base = devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(aaci->base)) {
+		ret = PTR_ERR(aaci->base);
 		goto out;
 	}
 
@@ -1064,9 +1058,7 @@ static int aaci_probe(struct amba_device *dev,
 	}
 
  out:
-	if (aaci)
-		snd_card_free(aaci->card);
-	amba_release_regions(dev);
+	snd_card_free(aaci->card);
 	return ret;
 }
 
@@ -1079,7 +1071,6 @@ static int aaci_remove(struct amba_device *dev)
 		writel(0, aaci->base + AACI_MAINCR);
 
 		snd_card_free(card);
-		amba_release_regions(dev);
 	}
 
 	return 0;
-- 
2.7.4
