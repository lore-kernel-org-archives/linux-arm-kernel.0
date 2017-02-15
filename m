From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed, 15 Feb 2017 18:55:10 +0800
Subject: [PATCH v1 3/3] ASoC: zx-96p22: add zte's aud96p22 controller driver
In-Reply-To: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds aud96p22 controller driver for zte's SoC family.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 sound/soc/codecs/Kconfig       |   4 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/zx_aud96p22.c | 588 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 594 insertions(+)
 create mode 100644 sound/soc/codecs/zx_aud96p22.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cfc108e..120af32 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1116,4 +1116,8 @@ config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
 
+config SND_SOC_ZX96P22
+	tristate "ZTE Inner AUD96P22 CODEC"
+	depends on I2C
+
 endmenu
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2624c73..dbc3818 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -219,6 +219,7 @@ snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
+snd-soc-zx96p22-objs := zx_aud96p22.o
 # Amp
 snd-soc-max9877-objs := max9877.o
 snd-soc-max98504-objs := max98504.o
@@ -444,6 +445,7 @@ obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
+obj-$(CONFIG_SND_SOC_ZX96P22)	+= snd-soc-zx96p22.o
 
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
new file mode 100644
index 0000000..f2979df
--- /dev/null
+++ b/sound/soc/codecs/zx_aud96p22.c
@@ -0,0 +1,588 @@
+/*
+ * ZTE's audio 96p22 driver
+ *
+ * Copyright (C) 2017 ZTE Ltd
+ *
+ * Author: Baoyou Xie <baoyou.xie@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/pcm.h>
+
+#define BGPIO64				(64)
+#define snd_kcontrol_dev(kcontrol)	\
+		((struct device *)((kcontrol)->private_value))
+
+struct i2c_reg {
+	unsigned char addr;
+	unsigned char high_data;
+	unsigned char low_data;
+};
+
+struct zx_aud96p22_info {
+	struct device   *dev;
+	int gpio;
+	bool capture;
+};
+
+static struct i2c_reg i2c_dac_master_volume_table[] = {
+	{ 0x34, 0xe7, 0xe7 },
+};
+
+static struct i2c_reg i2c_adc_master_volume_table[] = {
+	{ 0x24, 0xbf, 0xbf },
+};
+
+static struct i2c_reg i2c_dac_headset_volume_table[] = {
+	{ 0x38, 0x0d, 0x0d },
+};
+
+static struct i2c_reg i2c_dac_sleep_table[] = {
+	{ 0x18, 0x00, 0x00 }, //play power down
+};
+
+static struct i2c_reg i2c_dac_wakeup_table[] = {
+	{ 0x18, 0x00, 0xff }, //play power up
+};
+
+static struct i2c_reg i2c_adc_sleep_table[] = {
+	{ 0x16, 0x00, 0x00 }, //record power down
+};
+
+static struct i2c_reg i2c_adc_wakeup_table[] = {
+	{ 0x16, 0x00, 0x0f }, //record power up
+};
+
+static struct i2c_reg i2c_codec_start_table[] = {
+	{ 0x15, 0x00, 0x00 }, //power down control
+	{ 0x47, 0x00, 0x00 }, //record path slect
+	{ 0x24, 0xbf, 0xbf }, //record volume control
+	{ 0x26, 0x30, 0x30 }, //record pga volume control
+	{ 0xc8, 0x00, 0x00 }, //ALC control
+	{ 0xce, 0x00, 0xf5 }, //record noise gate
+	{ 0xf3, 0x00, 0xc0 }, //dac noise dithe
+	{ 0xcd, 0x00, 0x20 }, //max record volume
+	{ 0x15, 0x00, 0x01 }, //power down control
+	{ 0x18, 0x00, 0xff }, //play power  control
+	{ 0x16, 0x00, 0x0f }, //record power up
+	{ 0x19, 0x00, 0x04 }, //power down control
+	{ 0x02, 0x00, 0x05 }, //ext clock slect
+	{ 0x01, 0x00, 0x05 }, //ext clock slect
+	{ 0x00, 0x00, 0x00 }, //adc dpz reset
+	{ 0x00, 0x00, 0x03 }, //dac dpz reset
+	{ 0x04, 0x00, 0x40 }, //clk div
+	{ 0x05, 0x00, 0x04 }, //clk div0x4
+	{ 0x06, 0x00, 0x40 }, //clk div
+	{ 0x07, 0x00, 0x04 }, //clk div 0x4
+	{ 0x03, 0x00, 0x01 }, //slave 16bit i2s
+	{ 0x00, 0x00, 0x00 }, //adc dpz reset
+	{ 0x00, 0x00, 0x03 }, //dac dpz reset
+};
+
+static int zx_aud96p22_i2c_write(struct i2c_client *i2c_client,
+				 const void *data, size_t count)
+{
+	int xfer;
+
+	xfer = i2c_master_send(i2c_client, data, count);
+	if (xfer == count)
+		return 0;
+	else if (xfer < 0)
+		return xfer;
+	else
+		return -EIO;
+}
+
+static int zx_aud96p22_i2c_read(struct i2c_client *i2c_client,
+				unsigned char addr)
+{
+	int xfer;
+
+	xfer = i2c_smbus_read_word_data(i2c_client, addr);
+	if (xfer < 0)
+		dev_warn(&i2c_client->dev, "transfer error %d\n", xfer);
+
+	return xfer;
+}
+
+static int zx_aud96p22_i2c_update(struct i2c_client *i2c_client,
+			const struct i2c_reg *tbl, unsigned int tbl_size)
+{
+	int xfer;
+	unsigned int i = 0;
+	unsigned char buf[3];
+
+	for (i = 0; i < tbl_size; i++) {
+		buf[0] = tbl[i].addr;
+		buf[1] = tbl[i].low_data;
+		buf[2] = tbl[i].high_data;
+
+		xfer = zx_aud96p22_i2c_write(i2c_client, buf, ARRAY_SIZE(buf));
+		if (xfer < 0) {
+			dev_err(&i2c_client->dev, "write error %d\n", xfer);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static void
+zx_aud96p22_i2c_dac_amp_run_enable(struct i2c_client *i2c_client, bool on)
+{
+	int ret = 0;
+
+	ret = gpio_request(BGPIO64, "dac");
+	if (ret) {
+		dev_err(&i2c_client->dev, "request gpio BGPIO64 failed %d\n",
+			ret);
+		return;
+	}
+
+	/*
+	 * write 1 to gpio 64 to set MUTE_CTL for enable play.
+	 * otherwise disable it.
+	 */
+	if (on)
+		gpiod_direction_output(gpio_to_desc(BGPIO64), 1);
+	else
+		gpiod_direction_output(gpio_to_desc(BGPIO64), 0);
+
+	gpio_free(BGPIO64);
+}
+
+static void
+zx_aud96p22_i2c_dac_sleep_enable(struct i2c_client *i2c_client, bool on)
+{
+	if (on)
+		zx_aud96p22_i2c_update(i2c_client, i2c_dac_sleep_table,
+			ARRAY_SIZE(i2c_dac_sleep_table));
+	else
+		zx_aud96p22_i2c_update(i2c_client, i2c_dac_wakeup_table,
+			ARRAY_SIZE(i2c_dac_wakeup_table));
+}
+
+static void
+zx_aud96p22_i2c_adc_sleep_enable(struct i2c_client *i2c_client, bool on)
+{
+	if (on)
+		zx_aud96p22_i2c_update(i2c_client, i2c_adc_sleep_table,
+			ARRAY_SIZE(i2c_adc_sleep_table));
+	else
+		zx_aud96p22_i2c_update(i2c_client, i2c_adc_wakeup_table,
+			ARRAY_SIZE(i2c_adc_wakeup_table));
+}
+
+static void
+zx_aud96p22_i2c_codec_run_enable(struct i2c_client *i2c_client)
+{
+	zx_aud96p22_i2c_update(i2c_client, i2c_codec_start_table,
+			ARRAY_SIZE(i2c_codec_start_table));
+}
+
+static int zx_aud96p22_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *socdai)
+{
+	struct device *dev = socdai->dev;
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	struct zx_aud96p22_info *zx_aud96p22 = dev_get_drvdata(socdai->dev);
+	bool capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
+
+	zx_aud96p22->capture = capture;
+	snd_soc_dai_set_drvdata(socdai, zx_aud96p22);
+
+	zx_aud96p22_i2c_adc_sleep_enable(i2c_client, false);
+	if (!capture)
+		zx_aud96p22_i2c_dac_amp_run_enable(i2c_client, true);
+
+	return 0;
+}
+
+static int zx_aud96p22_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->dev;
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	bool capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
+
+	zx_aud96p22_i2c_dac_sleep_enable(i2c_client, false);
+	if (!capture)
+		zx_aud96p22_i2c_dac_amp_run_enable(i2c_client, true);
+
+	return 0;
+}
+
+static void zx_aud96p22_shutdown(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->dev;
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	bool capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
+
+	zx_aud96p22_i2c_dac_sleep_enable(i2c_client, true);
+	if (!capture)
+		zx_aud96p22_i2c_dac_amp_run_enable(i2c_client, false);
+}
+
+static int
+zx_aud96p22_i2c_read_regs(struct i2c_client *i2c_client,
+			struct i2c_reg *tbl, unsigned int tbl_size)
+{
+	int xfer = 0;
+	unsigned int i;
+
+	for (i = 0; i < tbl_size; i++) {
+		xfer = zx_aud96p22_i2c_read(i2c_client, tbl[i].addr);
+		if (xfer < 0) {
+			dev_err(&i2c_client->dev,
+				"read 0x%x, error is %d\n", tbl[i].addr, xfer);
+			return -EIO;
+		}
+		tbl[i].low_data = xfer & 0xff;
+		tbl[i].high_data = (xfer >> 8) & 0xff;
+	}
+
+	return 0;
+}
+
+static int
+zx_aud96p22_headset_playback_info_volsw(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xf;
+
+	return 0;
+}
+
+static int
+zx_aud96p22_headset_playback_get_volsw(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct device *dev = snd_kcontrol_dev(kcontrol);
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	int ret;
+	int l;
+	int r;
+
+	ret = zx_aud96p22_i2c_read_regs(i2c_client,
+			i2c_dac_headset_volume_table,
+			ARRAY_SIZE(i2c_dac_headset_volume_table));
+	if (ret)
+		return ret;
+
+	l = i2c_dac_headset_volume_table[0].low_data;
+	r = i2c_dac_headset_volume_table[0].high_data;
+
+	/* make sure value fall in (0x0,0xf) */
+	l = clamp(l, 0, 0xf);
+	r = clamp(r, 0, 0xf);
+
+	ucontrol->value.integer.value[0] = l;
+	ucontrol->value.integer.value[1] = r;
+
+	return 0;
+}
+
+static int
+zx_aud96p22_headset_playback_put_volsw(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct device *dev = snd_kcontrol_dev(kcontrol);
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	int l;
+	int r;
+
+	l = r = ucontrol->value.integer.value[0];
+
+	/* make sure value fall in (0x0,0xf) */
+	l = clamp(l, 0, 0xf);
+	r = clamp(r, 0, 0xf);
+
+	i2c_dac_headset_volume_table[0].low_data = l;
+	i2c_dac_headset_volume_table[0].high_data = r;
+
+	zx_aud96p22_i2c_update(i2c_client, i2c_dac_headset_volume_table,
+			ARRAY_SIZE(i2c_dac_headset_volume_table));
+	return 0;
+}
+
+
+static int
+zx_aud96p22_master_playback_info_volsw(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xff;
+
+	return 0;
+}
+
+static int
+zx_aud96p22_master_playback_get_volsw(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct device *dev = snd_kcontrol_dev(kcontrol);
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	int l;
+	int r;
+
+	zx_aud96p22_i2c_read_regs(i2c_client,
+			i2c_dac_master_volume_table,
+			ARRAY_SIZE(i2c_dac_master_volume_table));
+
+	l = i2c_dac_master_volume_table[0].low_data;
+	r = i2c_dac_master_volume_table[0].high_data;
+
+	/* make sure value fall in (0x0,0xf) */
+	l = clamp(l, 0, 0xff);
+	r = clamp(r, 0, 0xff);
+
+	ucontrol->value.integer.value[0] = l;
+	ucontrol->value.integer.value[1] = r;
+
+	return 0;
+}
+
+static int
+zx_aud96p22_master_playback_put_volsw(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct device *dev = snd_kcontrol_dev(kcontrol);
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	int l;
+	int r;
+
+	l = r = ucontrol->value.integer.value[0];
+
+	/* make sure value fall in (0x0,0xf) */
+	l = clamp(l, 0, 0xff);
+	r = clamp(r, 0, 0xff);
+
+	i2c_dac_master_volume_table[0].low_data = l;
+	i2c_dac_master_volume_table[0].high_data = r;
+
+	zx_aud96p22_i2c_update(i2c_client,
+			i2c_dac_master_volume_table,
+			ARRAY_SIZE(i2c_dac_master_volume_table));
+	return 0;
+}
+
+static int zx_aud96p22_master_record_info_volsw(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xff;
+
+	return 0;
+}
+
+static int zx_aud96p22_master_record_get_volsw(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct device *dev = snd_kcontrol_dev(kcontrol);
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	int l;
+	int r;
+
+	zx_aud96p22_i2c_read_regs(i2c_client,
+				i2c_adc_master_volume_table,
+				ARRAY_SIZE(i2c_adc_master_volume_table));
+
+	l = i2c_adc_master_volume_table[0].low_data;
+	r = i2c_adc_master_volume_table[0].high_data;
+
+	/* make sure value fall in (0x0,0xf) */
+	l = clamp(l, 0, 0xff);
+	r = clamp(r, 0, 0xff);
+
+	ucontrol->value.integer.value[0] = l;
+	ucontrol->value.integer.value[1] = r;
+
+	return 0;
+}
+
+
+static int zx_aud96p22_master_record_put_volsw(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct device *dev = snd_kcontrol_dev(kcontrol);
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	int l;
+	int r;
+
+	l = r = ucontrol->value.integer.value[0];
+
+	/* make sure value fall in (0x0,0xf) */
+	l = clamp(l, 0, 0xff);
+	r = clamp(r, 0, 0xff);
+
+	i2c_adc_master_volume_table[0].low_data = l;
+	i2c_adc_master_volume_table[0].high_data = r;
+
+	return zx_aud96p22_i2c_update(i2c_client, i2c_adc_master_volume_table,
+			ARRAY_SIZE(i2c_adc_master_volume_table));
+}
+static struct snd_kcontrol_new zx_playback_controls[] = {
+	/* Headset volume */
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Headset Playback Volume",
+		.info = zx_aud96p22_headset_playback_info_volsw,
+		.get = zx_aud96p22_headset_playback_get_volsw,
+		.put = zx_aud96p22_headset_playback_put_volsw,
+	},
+	/* Master volume */
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Volume",
+		.info = zx_aud96p22_master_playback_info_volsw,
+		.get = zx_aud96p22_master_playback_get_volsw,
+		.put = zx_aud96p22_master_playback_put_volsw,
+	},
+};
+
+static struct snd_kcontrol_new zx_record_controls[] = {
+	/* Master record volume */
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Capture Volume",
+		.info = zx_aud96p22_master_record_info_volsw,
+		.get = zx_aud96p22_master_record_get_volsw,
+		.put = zx_aud96p22_master_record_put_volsw,
+	},
+};
+
+static int zx_aud96p22_probe(struct snd_soc_codec *codec)
+{
+	struct device *dev = codec->dev;
+	struct i2c_client *i2c_client = to_i2c_client(dev);
+	int ret = 0;
+	struct zx_aud96p22_info *zx_aud96p22;
+	int i;
+
+	zx_aud96p22 = devm_kzalloc(dev, sizeof(*zx_aud96p22), GFP_KERNEL);
+	if (!zx_aud96p22)
+		return -ENOMEM;
+
+	zx_aud96p22->dev = dev;
+	dev_set_drvdata(dev, zx_aud96p22);
+	zx_aud96p22_i2c_dac_amp_run_enable(i2c_client, false);
+	zx_aud96p22_i2c_codec_run_enable(i2c_client);
+
+	for (i = 0; i < ARRAY_SIZE(zx_playback_controls); i++)
+		zx_playback_controls[i].private_value =	(unsigned long)dev;
+	snd_soc_add_codec_controls(codec, zx_playback_controls,
+			ARRAY_SIZE(zx_playback_controls));
+
+	for (i = 0; i < ARRAY_SIZE(zx_record_controls); i++)
+		zx_record_controls[i].private_value = (unsigned long)dev;
+	snd_soc_add_codec_controls(codec, zx_record_controls,
+			ARRAY_SIZE(zx_record_controls));
+
+	return ret;
+}
+
+static struct snd_soc_codec_driver zx_aud96p22_driver = {
+	.probe = zx_aud96p22_probe,
+};
+
+static int zx_aud96p22_dai_probe(struct snd_soc_dai *dai)
+{
+	struct zx_aud96p22_info *zx_aud96p22 = dev_get_drvdata(dai->dev);
+
+	snd_soc_dai_set_drvdata(dai, zx_aud96p22);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops zx_aud96p22_dai_ops = {
+	.hw_params = zx_aud96p22_hw_params,
+	.startup = zx_aud96p22_startup,
+	.shutdown = zx_aud96p22_shutdown,
+};
+
+#define ZX_I2S_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000| \
+	SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
+
+#define ZX_I2S_FMTBIT \
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver zx_aud96p22_dai = {
+	.name = "zx-aud96p22-dai",
+	.probe = zx_aud96p22_dai_probe,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = ZX_I2S_RATES,
+		.formats = ZX_I2S_FMTBIT,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = ZX_I2S_RATES,
+		.formats = ZX_I2S_FMTBIT,
+	},
+	.ops = &zx_aud96p22_dai_ops,
+};
+
+static int zx_aud96p22_i2c_probe(struct i2c_client *i2c_client,
+				const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct device *pdev = &i2c_client->dev;
+
+	if (!i2c_client)
+		return -ENODEV;
+
+	ret = snd_soc_register_codec(pdev, &zx_aud96p22_driver,
+				&zx_aud96p22_dai, 1);
+
+	return ret;
+}
+
+static int zx_aud96p22_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct device *pdev = &i2c_client->dev;
+
+	snd_soc_unregister_codec(pdev);
+
+	return 0;
+}
+
+const struct of_device_id zx_aud96p22_of_dt_ids[] = {
+	{ .compatible = "zte,zx-aud96p22", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, zx_aud96p22_of_dt_ids);
+
+static struct i2c_driver aud96p22_i2c_driver = {
+	.driver = {
+		.name = "zx-aud96p22",
+		.of_match_table = zx_aud96p22_of_dt_ids,
+	},
+	.probe = zx_aud96p22_i2c_probe,
+	.remove = zx_aud96p22_i2c_remove,
+};
+module_i2c_driver(aud96p22_i2c_driver);
+
+MODULE_DESCRIPTION("ZTE ASoC AUD96P22 driver");
+MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
