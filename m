From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  5 Apr 2010 06:13:36 +0200
Subject: [PATCH 1/3] WM8750: Convert to new API
In-Reply-To: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1270440818-25790-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
around. Hugely inspired by WM8753 which was already converted.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 sound/soc/codecs/wm8750.c |  295 +++++++++++++++++++++------------------------
 1 files changed, 139 insertions(+), 156 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 3e440c0..eea7ba6 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -30,11 +30,6 @@
 
 #include "wm8750.h"
 
-/* codec private data */
-struct wm8750_priv {
-	unsigned int sysclk;
-};
-
 /*
  * wm8750 register cache
  * We can't read the WM8750 register space when we
@@ -54,6 +49,13 @@ static const u16 wm8750_reg[] = {
 	0x0079, 0x0079, 0x0079,          /* 40 */
 };
 
+/* codec private data */
+struct wm8750_priv {
+	unsigned int sysclk;
+	struct snd_soc_codec codec;
+	u16 reg_cache[ARRAY_SIZE(wm8750_reg)];
+};
+
 #define wm8750_reset(c)	snd_soc_write(c, WM8750_RESET, 0)
 
 /*
@@ -696,25 +698,90 @@ static int wm8750_resume(struct platform_device *pdev)
 	return 0;
 }
 
+static struct snd_soc_codec *wm8750_codec;
+
+static int wm8750_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	if (!wm8750_codec) {
+		dev_err(&pdev->dev, "WM8750 codec not yet registered\n");
+		return -EINVAL;
+	}
+
+	socdev->card->codec = wm8750_codec;
+	codec = wm8750_codec;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8750: failed to create pcms\n");
+		goto err;
+	}
+
+	snd_soc_add_controls(codec, wm8750_snd_controls,
+				ARRAY_SIZE(wm8750_snd_controls));
+	wm8750_add_widgets(codec);
+
+	return 0;
+
+err:
+	return ret;
+}
+
+/* power down chip */
+static int wm8750_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8750 = {
+	.probe		= wm8750_probe,
+	.remove		= wm8750_remove,
+	.suspend	= wm8750_suspend,
+	.resume		= wm8750_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
+
 /*
  * initialise the WM8750 driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int wm8750_init(struct snd_soc_device *socdev,
-		       enum snd_soc_control_type control)
+static int wm8750_register(struct wm8750_priv *wm8750,
+			enum snd_soc_control_type control)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = &wm8750->codec;
 	int reg, ret = 0;
 
+	if (wm8750_codec) {
+		dev_err(codec->dev, "Multiple WM8750 devices not supported\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
 	codec->name = "WM8750";
 	codec->owner = THIS_MODULE;
+	codec->bias_level = SND_SOC_BIAS_STANDBY;
 	codec->set_bias_level = wm8750_set_bias_level;
 	codec->dai = &wm8750_dai;
 	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8750_reg);
-	codec->reg_cache = kmemdup(wm8750_reg, sizeof(wm8750_reg), GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	codec->private_data = wm8750;
+	codec->reg_cache_size = ARRAY_SIZE(wm8750->reg_cache) + 1;
+	codec->reg_cache = &wm8750->reg_cache;
+	codec->private_data = wm8750;
+
+	memcpy(codec->reg_cache, wm8750_reg, sizeof(wm8750->reg_cache));
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
@@ -728,13 +795,6 @@ static int wm8750_init(struct snd_soc_device *socdev,
 		goto err;
 	}
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8750: failed to create pcms\n");
-		goto err;
-	}
-
 	/* charge output caps */
 	wm8750_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -756,19 +816,37 @@ static int wm8750_init(struct snd_soc_device *socdev,
 	reg = snd_soc_read(codec, WM8750_RINVOL);
 	snd_soc_write(codec, WM8750_RINVOL, reg | 0x0100);
 
-	snd_soc_add_controls(codec, wm8750_snd_controls,
-				ARRAY_SIZE(wm8750_snd_controls));
-	wm8750_add_widgets(codec);
-	return ret;
+	wm8750_codec = codec;
 
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_dais(&wm8750_dai, 1);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
+		goto err_codec;
+	}
+
+	return 0;
+
+err_codec:
+	snd_soc_unregister_codec(codec);
 err:
-	kfree(codec->reg_cache);
+	kfree(wm8750);
 	return ret;
 }
 
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-static struct snd_soc_device *wm8750_socdev;
+static void wm8750_unregister(struct wm8750_priv *wm8750)
+{
+	wm8750_set_bias_level(&wm8750->codec, SND_SOC_BIAS_OFF);
+	snd_soc_unregister_dais(&wm8750_dai, 1);
+	snd_soc_unregister_codec(&wm8750->codec);
+	kfree(wm8750);
+	wm8750_codec = NULL;
+}
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
@@ -782,24 +860,26 @@ static struct snd_soc_device *wm8750_socdev;
 static int wm8750_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = wm8750_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct snd_soc_codec *codec;
+	struct wm8750_priv *wm8750;
 
-	i2c_set_clientdata(i2c, codec);
+	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
+	if (wm8750 == NULL)
+		return -ENOMEM;
+
+	codec = &wm8750->codec;
 	codec->control_data = i2c;
+	i2c_set_clientdata(i2c, wm8750);
 
-	ret = wm8750_init(socdev, SND_SOC_I2C);
-	if (ret < 0)
-		pr_err("failed to initialise WM8750\n");
+	codec->dev = &i2c->dev;
 
-	return ret;
+	return wm8750_register(wm8750, SND_SOC_I2C);
 }
 
 static int wm8750_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	struct wm8750_priv *wm8750 = i2c_get_clientdata(client);
+	wm8750_unregister(wm8750);
 	return 0;
 }
 
@@ -818,66 +898,31 @@ static struct i2c_driver wm8750_i2c_driver = {
 	.remove =   wm8750_i2c_remove,
 	.id_table = wm8750_i2c_id,
 };
-
-static int wm8750_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8750_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8750_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8750", I2C_NAME_SIZE);
-
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
-	}
-
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
-
-	return 0;
-
-err_driver:
-	i2c_del_driver(&wm8750_i2c_driver);
-	return -ENODEV;
-}
 #endif
 
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8750_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_device *socdev = wm8750_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct snd_soc_codec *codec;
+	struct wm8750_priv *wm8750;
 
+	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
+	if (wm8750 == NULL)
+		return -ENOMEM;
+
+	codec = &wm8750->codec;
 	codec->control_data = spi;
+	codec->dev = &spi->dev;
 
-	ret = wm8750_init(socdev, SND_SOC_SPI);
-	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8750\n");
+	dev_set_drvdata(&spi->dev, wm8750);
 
-	return ret;
+	return wm8750_register(wm8750, SND_SOC_SPI);
 }
 
 static int __devexit wm8750_spi_remove(struct spi_device *spi)
 {
+	struct wm8750_priv *wm8750 = dev_get_drvdata(&spi->dev);
+	wm8750_unregister(wm8750);
 	return 0;
 }
 
@@ -892,93 +937,31 @@ static struct spi_driver wm8750_spi_driver = {
 };
 #endif
 
-static int wm8750_probe(struct platform_device *pdev)
+static int __init wm8750_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8750_setup_data *setup = socdev->codec_data;
-	struct snd_soc_codec *codec;
-	struct wm8750_priv *wm8750;
 	int ret;
-
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
-	if (wm8750 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	codec->private_data = wm8750;
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-	wm8750_socdev = socdev;
-
-	ret = -ENODEV;
-
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		ret = wm8750_add_i2c_device(pdev, setup);
-	}
+	ret = i2c_add_driver(&wm8750_i2c_driver);
+	if (ret != 0)
+		pr_err("Failed to register WM8750 I2C driver: %d\n", ret);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-	if (setup->spi) {
-		ret = spi_register_driver(&wm8750_spi_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add spi driver");
-	}
+	ret = spi_register_driver(&wm8750_spi_driver);
+	if (ret != 0)
+		pr_err("Failed to register WM8750 SPI driver: %d\n", ret);
 #endif
-
-	if (ret != 0) {
-		kfree(codec->private_data);
-		kfree(codec);
-	}
-	return ret;
+	return 0;
 }
+module_init(wm8750_modinit);
 
-/* power down chip */
-static int wm8750_remove(struct platform_device *pdev)
+static void __exit wm8750_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8750_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8750_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	spi_unregister_driver(&wm8750_spi_driver);
 #endif
-	kfree(codec->private_data);
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8750 = {
-	.probe = 	wm8750_probe,
-	.remove = 	wm8750_remove,
-	.suspend = 	wm8750_suspend,
-	.resume =	wm8750_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
-
-static int __init wm8750_modinit(void)
-{
-	return snd_soc_register_dai(&wm8750_dai);
-}
-module_init(wm8750_modinit);
-
-static void __exit wm8750_exit(void)
-{
-	snd_soc_unregister_dai(&wm8750_dai);
 }
 module_exit(wm8750_exit);
 
-- 
1.7.0
