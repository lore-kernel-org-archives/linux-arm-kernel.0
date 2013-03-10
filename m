From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:07 +0100
Subject: [PATCH 06/10] ARM: soc-audio phycore-ac97: fix driver init order
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a soc-audio sound driver internally uses snd_soc_register_device,
which tries to bind it with the codec. The adding of the driver is
deferred because the codec driver is not loaded.

This patch changes the order of registration. The codec driver is there
before the ac97 driver, so the snd_soc_register_device call is
successfull.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/phycore-ac97.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index f8da6dd..d146cec 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -79,35 +79,40 @@ static int __init imx_phycore_init(void)
 		return 0;
 	}
 
-	imx_phycore_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!imx_phycore_snd_ac97_device)
+
+	/*
+	 * First add codec driver, otherwise soc-audio may be deferred and fails
+	 * to load.
+	 */
+	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
+	if (!imx_phycore_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(imx_phycore_snd_ac97_device, &imx_phycore);
-	ret = platform_device_add(imx_phycore_snd_ac97_device);
-	if (ret)
+	ret = platform_device_add(imx_phycore_snd_device);
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
 		goto fail1;
+	}
 
-	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
-	if (!imx_phycore_snd_device) {
+	imx_phycore_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!imx_phycore_snd_ac97_device) {
 		ret = -ENOMEM;
 		goto fail2;
 	}
-	ret = platform_device_add(imx_phycore_snd_device);
 
-	if (ret) {
-		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+	platform_set_drvdata(imx_phycore_snd_ac97_device, &imx_phycore);
+	ret = platform_device_add(imx_phycore_snd_ac97_device);
+	if (ret)
 		goto fail3;
-	}
 
 	return 0;
 
 fail3:
-	platform_device_put(imx_phycore_snd_device);
+	platform_device_put(imx_phycore_snd_ac97_device);
 fail2:
-	platform_device_del(imx_phycore_snd_ac97_device);
+	platform_device_del(imx_phycore_snd_device);
 fail1:
-	platform_device_put(imx_phycore_snd_ac97_device);
+	platform_device_put(imx_phycore_snd_device);
 	return ret;
 }
 
-- 
1.8.1.5
