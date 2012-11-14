From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 14 Nov 2012 17:39:19 +0530
Subject: [RFC PATCH] ASoC: Samsung: Register the audio dma platform device
Message-ID: <1352894960-17434-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio dma device is not a hardware peripherial.
So this device can't be added in the dt devices list.
So expanded the module_platform_driver and registered
this device using "platform_device_register_simple".

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/dma.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 359708c..17ae9c0 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -444,6 +444,8 @@ static int __devexit samsung_asoc_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_device *asoc_dma_device;
+
 static struct platform_driver asoc_dma_driver = {
 	.driver = {
 		.name = "samsung-audio",
@@ -454,7 +456,33 @@ static struct platform_driver asoc_dma_driver = {
 	.remove = __devexit_p(samsung_asoc_platform_remove),
 };
 
-module_platform_driver(asoc_dma_driver);
+static int __init asoc_dma_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&asoc_dma_driver);
+	if (ret) {
+		pr_err("unable to register driver\n");
+		return ret;
+	}
+
+	asoc_dma_device = platform_device_register_simple("samsung-audio", -1, NULL, 0);
+	if (IS_ERR(asoc_dma_device)) {
+		platform_driver_unregister(&asoc_dma_driver);
+		return PTR_ERR(asoc_dma_device);
+	}
+
+	return 0;
+}
+
+static void __exit asoc_dma_exit(void)
+{
+	platform_device_unregister(asoc_dma_device);
+	platform_driver_unregister(&asoc_dma_driver);
+}
+
+module_init(asoc_dma_init);
+module_exit(asoc_dma_exit);
 
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung ASoC DMA Driver");
-- 
1.7.4.4
