From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Sep 2012 12:27:31 -0300
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20ASoC=3A=20eukrea-tlv320=3A=20Convert=20it=20to=20platform=20driver?=
Message-ID: <1348327652-21567-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Convert eukrea-tlv320 to platform driver.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- No changes, only CC'ed ARM kernel list as requested by Mark Brown

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c |    1 +
 sound/soc/fsl/eukrea-tlv320.c                  |   37 ++++++++++++------------
 5 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index fd3177f..98aef57 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -348,4 +348,5 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	imx27_add_imx_keypad(&eukrea_mbimx27_keymap_data);
 
 	gpio_led_register_device(-1, &eukrea_mbimx27_gpio_led_info);
+	imx_add_platform_device("eukrea_tlv320", 0, NULL, 0, NULL, 0);
 }
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index dfd2da8..0b84666 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -306,4 +306,5 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 	gpio_led_register_device(-1, &eukrea_mbimxsd_led_info);
 	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
+	imx_add_platform_device("eukrea_tlv320", 0, NULL, 0, NULL, 0);
 }
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 6e9dd12..c6532a0 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -315,4 +315,5 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 	gpio_led_register_device(-1, &eukrea_mbimxsd_led_info);
 	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
+	imx_add_platform_device("eukrea_tlv320", 0, NULL, 0, NULL, 0);
 }
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
index 96a24b7..8b0de30 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
@@ -228,4 +228,5 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 
 	gpio_led_register_device(-1, &eukrea_mbimxsd51_led_info);
 	imx_add_gpio_keys(&eukrea_mbimxsd51_button_data);
+	imx_add_platform_device("eukrea_tlv320", 0, NULL, 0, NULL, 0);
 }
diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index efb9ede..267d5b4 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -93,9 +93,7 @@ static struct snd_soc_card eukrea_tlv320 = {
 	.num_links	= 1,
 };
 
-static struct platform_device *eukrea_tlv320_snd_device;
-
-static int __init eukrea_tlv320_init(void)
+static int __devinit eukrea_tlv320_probe(struct platform_device *pdev)
 {
 	int ret;
 	int int_port = 0, ext_port;
@@ -136,29 +134,32 @@ static int __init eukrea_tlv320_init(void)
 		return 0;
 	}
 
-	eukrea_tlv320_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!eukrea_tlv320_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(eukrea_tlv320_snd_device, &eukrea_tlv320);
-	ret = platform_device_add(eukrea_tlv320_snd_device);
-
-	if (ret) {
-		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
-		platform_device_put(eukrea_tlv320_snd_device);
-	}
+	eukrea_tlv320.dev = &pdev->dev;
+	ret = snd_soc_register_card(&eukrea_tlv320);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 
 	return ret;
 }
 
-static void __exit eukrea_tlv320_exit(void)
+static int __devexit eukrea_tlv320_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(eukrea_tlv320_snd_device);
+	snd_soc_unregister_card(&eukrea_tlv320);
+
+	return 0;
 }
 
-module_init(eukrea_tlv320_init);
-module_exit(eukrea_tlv320_exit);
+static struct platform_driver eukrea_tlv320_driver = {
+	.driver = {
+		.name = "eukrea_tlv320",
+		.owner = THIS_MODULE,
+	},
+	.probe = eukrea_tlv320_probe,
+	.remove = __devexit_p(eukrea_tlv320_remove),};
+
+module_platform_driver(eukrea_tlv320_driver);
 
 MODULE_AUTHOR("Eric B?nard <eric@eukrea.com>");
 MODULE_DESCRIPTION("CPUIMX ALSA SoC driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:eukrea_tlv320");
-- 
1.7.9.5
