From: zonque@gmail.com (Daniel Mack)
Date: Tue,  8 Nov 2011 11:16:09 +0100
Subject: [PATCH v2] ARM: pxa: add support for Raumfeld DDX
Message-ID: <1320747369-12141-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new product features a STA32x codec. To support it, some rework
of the regulator initialization for the Raumfeld platform is necessary.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Johannes Stezenbach <js@sig21.net>
---

 v2 of this patch has clocking fixes and superseeds the older version.

 As there are more changes in sound/soc than in arch/arm, I think it
 should best go through Mark's AsoC tree.

 arch/arm/mach-pxa/raumfeld.c |  119 +++++++++++++++++---
 sound/soc/pxa/Kconfig        |    2 +
 sound/soc/pxa/raumfeld.c     |  247 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 336 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 7856fe4..22366ff 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -850,7 +850,7 @@ struct regulator_init_data audio_va_initdata = {
 	},
 };
 
-static struct fixed_voltage_config audio_va_config = {
+static struct fixed_voltage_config cs4270_va_config = {
 	.supply_name		= "audio_va",
 	.microvolts		= 5000000,
 	.gpio			= GPIO_AUDIO_VA_ENABLE,
@@ -859,47 +859,114 @@ static struct fixed_voltage_config audio_va_config = {
 	.init_data		= &audio_va_initdata,
 };
 
-static struct platform_device audio_va_device = {
+static struct platform_device cs4270_va_device = {
 	.name	= "reg-fixed-voltage",
 	.id	= 0,
 	.dev	= {
-		.platform_data = &audio_va_config,
+		.platform_data = &cs4270_va_config,
 	},
 };
 
 /* Dummy supplies for Codec's VD/VLC */
 
-static struct regulator_consumer_supply audio_dummy_supplies[] = {
+static struct regulator_consumer_supply cs4270_dummy_supplies[] = {
 	REGULATOR_SUPPLY("vd", "0-0048"),
 	REGULATOR_SUPPLY("vlc", "0-0048"),
 };
 
-struct regulator_init_data audio_dummy_initdata = {
-	.consumer_supplies = audio_dummy_supplies,
-	.num_consumer_supplies = ARRAY_SIZE(audio_dummy_supplies),
+struct regulator_init_data cs4270_dummy_initdata = {
+	.consumer_supplies = cs4270_dummy_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(cs4270_dummy_supplies),
 	.constraints = {
 		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 	},
 };
 
-static struct fixed_voltage_config audio_dummy_config = {
-	.supply_name		= "audio_vd",
+static struct fixed_voltage_config cs4270_dummy_config = {
+	.supply_name		= "cs4270_vd",
 	.microvolts		= 3300000,
 	.gpio			= -1,
-	.init_data		= &audio_dummy_initdata,
+	.init_data		= &cs4270_dummy_initdata,
 };
 
-static struct platform_device audio_supply_dummy_device = {
+static struct platform_device cs4270_supply_dummy_device = {
 	.name	= "reg-fixed-voltage",
 	.id	= 1,
 	.dev	= {
-		.platform_data = &audio_dummy_config,
+		.platform_data = &cs4270_dummy_config,
 	},
 };
 
-static struct platform_device *audio_regulator_devices[] = {
-	&audio_va_device,
-	&audio_supply_dummy_device,
+static struct platform_device *cs4270_regulator_devices[] = {
+	&cs4270_va_device,
+	&cs4270_supply_dummy_device,
+};
+
+/* Fixed regulator for sta32x Vdda supply
+ * 0-001a maps to the sta32x codec devname (derived from i2c bus num + addr)
+ */
+
+static struct regulator_consumer_supply sta32x_va_consumer_supply =
+	REGULATOR_SUPPLY("Vdda", "0-001a");
+
+struct regulator_init_data sta32x_va_initdata = {
+	.consumer_supplies = &sta32x_va_consumer_supply,
+	.num_consumer_supplies = 1,
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config sta32x_va_config = {
+	.supply_name		= "audio_va",
+	.microvolts		= 3300000,
+	.gpio			= GPIO_AUDIO_VA_ENABLE,
+	.enable_high		= 1,
+	.enabled_at_boot	= 0,
+	.init_data		= &sta32x_va_initdata,
+};
+
+static struct platform_device sta32x_va_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &sta32x_va_config,
+	},
+};
+
+/* Dummy supplies for sta32x codec's Vdd3/Vcc */
+
+static struct regulator_consumer_supply sta32x_dummy_supplies[] = {
+	REGULATOR_SUPPLY("Vdd3", "0-001a"),
+	REGULATOR_SUPPLY("Vcc", "0-001a"),
+};
+
+struct regulator_init_data sta32x_dummy_initdata = {
+	.consumer_supplies = sta32x_dummy_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(sta32x_dummy_supplies),
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config sta32x_dummy_config = {
+	.supply_name	    = "audio_vd",
+	.microvolts	     = 3300000,
+	.gpio		   = -1,
+	.init_data	      = &sta32x_dummy_initdata,
+};
+
+static struct platform_device sta32x_supply_dummy_device = {
+	.name   = "reg-fixed-voltage",
+	.id     = 1,
+	.dev    = {
+		.platform_data = &sta32x_dummy_config,
+	},
+};
+
+static struct platform_device *sta32x_regulator_devices[] = {
+	&sta32x_va_device,
+	&sta32x_supply_dummy_device,
 };
 
 /**
@@ -948,6 +1015,11 @@ static struct i2c_board_info raumfeld_connector_i2c_board_info __initdata = {
 	.addr	= 0x48,
 };
 
+static struct i2c_board_info raumfeld_ddx_i2c_board_info __initdata = {
+	.type   = "sta326",
+	.addr   = 0x1a,
+};
+
 static struct eeti_ts_platform_data eeti_ts_pdata = {
 	.irq_active_high = 1,
 };
@@ -987,7 +1059,10 @@ static void __init raumfeld_audio_init(void)
 	else
 		gpio_direction_output(GPIO_MCLK_RESET, 1);
 
-	platform_add_devices(ARRAY_AND_SIZE(audio_regulator_devices));
+	if ((system_rev & 0xff00) == 0x0400)
+		platform_add_devices(ARRAY_AND_SIZE(sta32x_regulator_devices));
+	else
+		platform_add_devices(ARRAY_AND_SIZE(cs4270_regulator_devices));
 }
 
 static void __init raumfeld_common_init(void)
@@ -1060,7 +1135,11 @@ static void __init raumfeld_connector_init(void)
 {
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_connector_pin_config));
 	spi_register_board_info(ARRAY_AND_SIZE(connector_spi_devices));
-	i2c_register_board_info(0, &raumfeld_connector_i2c_board_info, 1);
+
+	if ((system_rev & 0xff00) == 0x0400)
+		i2c_register_board_info(0, &raumfeld_ddx_i2c_board_info, 1);
+	else
+		i2c_register_board_info(0, &raumfeld_connector_i2c_board_info, 1);
 
 	platform_device_register(&smc91x_device);
 
@@ -1072,7 +1151,11 @@ static void __init raumfeld_speaker_init(void)
 {
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_speaker_pin_config));
 	spi_register_board_info(ARRAY_AND_SIZE(speaker_spi_devices));
-	i2c_register_board_info(0, &raumfeld_connector_i2c_board_info, 1);
+
+	if ((system_rev & 0xff00) == 0x0400)
+		i2c_register_board_info(0, &raumfeld_ddx_i2c_board_info, 1);
+	else
+		i2c_register_board_info(0, &raumfeld_connector_i2c_board_info, 1);
 
 	platform_device_register(&smc91x_device);
 	platform_device_register(&rotary_encoder_device);
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 33ebc46..e6db56a 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -152,6 +152,8 @@ config SND_SOC_RAUMFELD
 	select SND_PXA_SOC_SSP
 	select SND_SOC_CS4270
 	select SND_SOC_AK4104
+	select SND_SOC_STA32X
+	select SND_SOC_WM8782
 	help
 	  Say Y if you want to add support for SoC audio on Raumfeld devices
 
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 1a591f1..7d4f1bf 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 
 #include <asm/mach-types.h>
@@ -225,6 +226,175 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.hw_params = raumfeld_ak4104_hw_params,
 };
 
+/* STA32X */
+static int raumfeld_sta32x_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	/* fixed MCLK of 11.2896MHz */
+	snd_pcm_hw_constraint_mask64(substream->runtime,
+				    SNDRV_PCM_HW_PARAM_RATE,
+				    SNDRV_PCM_RATE_44100 |
+				    SNDRV_PCM_RATE_88200 |
+				    SNDRV_PCM_RATE_176400);
+
+	/* PXA DMA cannot do zero extend for 24bit samples,
+	 * thus only 16bit (two samples packet into 32bit word)
+	 * or 32bit samples are possible
+	 */
+	snd_pcm_hw_constraint_mask64(substream->runtime,
+				    SNDRV_PCM_HW_PARAM_FORMAT,
+				    SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE |
+				    SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_S32_BE);
+
+	/* we have a fixed MCLK, set it here so ALSA knows
+	 * the supported sample rates and can resample if necessary
+	 */
+	return snd_soc_dai_set_sysclk(codec_dai, 0, 11289600, 0);
+}
+
+static void raumfeld_sta32x_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	/* set freq to 0 to enable all possible codec sample rates */
+	snd_soc_dai_set_sysclk(codec_dai, 0, 0, 0);
+}
+
+static int raumfeld_sta32x_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int fmt, clk = 0;
+	int ret = 0;
+
+	// fixed MCLK of 11.2896MHz
+	switch (params_rate(params)) {
+	case 44100:
+	case 88200:
+	case 176400:
+		clk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S32_LE:
+	case SNDRV_PCM_FORMAT_S32_BE:
+		/* this enables network mode for 2 * 32bit samples */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 3, 0, 2, 32);
+		if (ret < 0)
+			return ret;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S16_BE:
+		/* this disables network mode */
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0, 0, 16);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fmt = SND_SOC_DAIFMT_I2S |
+	      SND_SOC_DAIFMT_NB_NF |
+	      SND_SOC_DAIFMT_CBS_CFS;
+
+	/* setup the CODEC DAI */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk, 0);
+	if (ret < 0)
+		return ret;
+
+	/* setup the CPU DAI */
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, 0, clk);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, clk, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops raumfeld_sta32x_ops = {
+	.startup = raumfeld_sta32x_startup,
+	.shutdown = raumfeld_sta32x_shutdown,
+	.hw_params = raumfeld_sta32x_hw_params,
+};
+
+/* WM8782 */
+static int raumfeld_wm8782_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int fmt, clk = 0;
+	int ret = 0;
+
+	// fixed MCLK of 11.2896MHz
+	switch (params_rate(params)) {
+	case 44100:
+		clk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S16_BE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fmt = SND_SOC_DAIFMT_I2S |
+	      SND_SOC_DAIFMT_NB_NF |
+	      SND_SOC_DAIFMT_CBS_CFS;
+
+	/* setup the CPU DAI */
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, 0, clk);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_DIV_SCR, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, clk, 1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops raumfeld_wm8782_ops = {
+	.hw_params = raumfeld_wm8782_hw_params,
+};
+
 #define DAI_LINK_CS4270		\
 {							\
 	.name		= "CS4270",			\
@@ -247,6 +417,28 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.codec_name	= "spi0.0",			\
 }
 
+#define DAI_LINK_STA32X		\
+{							\
+	.name 		= "STA32X",			\
+	.stream_name	= "Playback",			\
+	.cpu_dai_name	= "pxa-ssp-dai.0",		\
+	.platform_name	= "pxa-pcm-audio",		\
+	.codec_dai_name	= "STA32X",			\
+	.ops		= &raumfeld_sta32x_ops,		\
+	.codec_name	= "sta32x.0-001a",	\
+}
+
+#define DAI_LINK_WM8782		\
+{							\
+	.name		= "wm8782",			\
+	.stream_name	= "wm8782",			\
+	.cpu_dai_name	= "pxa-ssp-dai.0",		\
+	.platform_name	= "pxa-pcm-audio",		\
+	.codec_dai_name	= "wm8782",			\
+	.codec_name	= "wm8782.0",		\
+	.ops		= &raumfeld_wm8782_ops,		\
+}
+
 static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] =
 {
 	DAI_LINK_CS4270,
@@ -258,6 +450,12 @@ static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] =
 	DAI_LINK_CS4270,
 };
 
+static struct snd_soc_dai_link snd_soc_raumfeld_ddx_dai[] =
+{
+	DAI_LINK_STA32X,
+	DAI_LINK_WM8782,
+};
+
 static struct snd_soc_card snd_soc_raumfeld_connector = {
 	.name		= "Raumfeld Connector",
 	.dai_link	= snd_soc_raumfeld_connector_dai,
@@ -274,7 +472,15 @@ static struct snd_soc_card snd_soc_raumfeld_speaker = {
 	.resume_pre	= raumfeld_analog_resume,
 };
 
-static struct platform_device *raumfeld_audio_device;
+static struct snd_soc_card snd_soc_raumfeld_ddx = {
+	.name		= "Raumfeld DDX",
+	.dai_link	= snd_soc_raumfeld_ddx_dai,
+	.num_links	= ARRAY_SIZE(snd_soc_raumfeld_ddx_dai),
+	.suspend_post	= raumfeld_analog_suspend,
+	.resume_pre	= raumfeld_analog_resume,
+};
+
+static struct platform_device *raumfeld_audio_device, *wm8782_device;
 
 static int __init raumfeld_audio_init(void)
 {
@@ -284,26 +490,39 @@ static int __init raumfeld_audio_init(void)
 	    !machine_is_raumfeld_connector())
 		return 0;
 
-	max9486_client = i2c_new_device(i2c_get_adapter(0),
-					&max9486_hwmon_info);
+	if ((system_rev & 0xff00) == 0x0400) {
+		wm8782_device = platform_device_alloc("wm8782", 0);
+		if (!wm8782_device)
+			return -ENOMEM;
 
-	if (!max9486_client)
-		return -ENOMEM;
+		platform_device_add(wm8782_device);
+	} else {
+		max9486_client = i2c_new_device(i2c_get_adapter(0),
+						&max9486_hwmon_info);
+
+		if (!max9486_client)
+			return -ENOMEM;
 
-	set_max9485_clk(MAX9485_MCLK_FREQ_122880);
+		set_max9485_clk(MAX9485_MCLK_FREQ_122880);
+	}
 
-	/* Register analog device */
+	/* Register audio device */
 	raumfeld_audio_device = platform_device_alloc("soc-audio", 0);
 	if (!raumfeld_audio_device)
 		return -ENOMEM;
 
-	if (machine_is_raumfeld_speaker())
+	if ((system_rev & 0xff00) == 0x0400)
 		platform_set_drvdata(raumfeld_audio_device,
-				     &snd_soc_raumfeld_speaker);
-
-	if (machine_is_raumfeld_connector())
-		platform_set_drvdata(raumfeld_audio_device,
-				     &snd_soc_raumfeld_connector);
+				     &snd_soc_raumfeld_ddx);
+	else {
+		if (machine_is_raumfeld_speaker())
+			platform_set_drvdata(raumfeld_audio_device,
+					     &snd_soc_raumfeld_speaker);
+
+		if (machine_is_raumfeld_connector())
+			platform_set_drvdata(raumfeld_audio_device,
+					     &snd_soc_raumfeld_connector);
+	}
 
 	ret = platform_device_add(raumfeld_audio_device);
 	if (ret < 0)
@@ -317,8 +536,8 @@ static void __exit raumfeld_audio_exit(void)
 {
 	raumfeld_enable_audio(false);
 
+	platform_device_unregister(wm8782_device);
 	platform_device_unregister(raumfeld_audio_device);
-
 	i2c_unregister_device(max9486_client);
 
 	gpio_free(GPIO_MCLK_RESET);
-- 
1.7.6.4
