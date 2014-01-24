From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 24 Jan 2014 17:54:31 +0100
Subject: [alsa-devel] [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
In-Reply-To: <52E26325.4040203@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk> <52D67099.1040904@ti.com>
 <20140115165100.3bfab96f@armhf> <52DF8D60.9020505@ti.com>
 <20140122111953.238349a5@armhf> <20140122114647.20f75d0d@armhf>
 <52E26325.4040203@ti.com>
Message-ID: <20140124175431.47a82d57@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Jan 2014 14:57:09 +0200
Jyri Sarha <jsarha@ti.com> wrote:

> Could you give me a link to a git repo with your tda998x codec code so I 
> could prepare to use that too?

I have no git repo. Instead, here is the source.

It goes into sound/soc/codecs and is selected with CONFIG_OF and
CONFIG_DRM_I2C_NXP_TDA998X.

It needs 2 exported functions of the tda998x driver: the first one to
select the audio port (tda998x_audio_update)  and the other one to get
the ELD (tda998x_audio_get_eld).

For these functions to receive the correct i2c_client, the codec
searches the tda998x driver in the DT by its compatible "nxp,tda998x".
If the tda998x is loaded by drm_i2c_encoder_init(), it should not be
declared in the DT, so, this raises a problem. I don't know what must
be done in this case.

The codec is used with the simple card as the sound card. For you, the
DT could be:

	hdmi_codec: hdmi-codec {
		compatible = "nxp,tda998x-codec";
		#sound-dai-cells = <1>;
		audio-ports = <0x03>, <0x04>;	/* i2s - s/pdif */
	};

	sound {
		compatible = "simple-audio-card";
		simple-audio-card,cpu {
			sound-dai = <&audio1 1>;
			format = "i2s";
		};
		simple-audio-card,codec {
			sound-dai = <&hdmi_codec 0>;	/* i2s */
		};
	};

('audio1' is the audio controller)

-------------------8<---------------- source sound/soc/codecs/tda998x.c
/*
 * ALSA SoC TDA998X driver
 *
 * This driver is used by the NXP TDA998x HDMI transmitter.
 *
 * Copyright (C) 2014 Jean-Francois Moine
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/module.h>
#include <sound/soc.h>
#include <sound/pcm.h>
#include <linux/of.h>
#include <linux/i2c.h>
#include <drm/drm_encoder_slave.h>
#include <drm/i2c/tda998x.h>

#define TDA998X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
			SNDRV_PCM_FMTBIT_S20_3LE | \
			SNDRV_PCM_FMTBIT_S24_LE | \
			SNDRV_PCM_FMTBIT_S32_LE)

struct tda_priv {
	struct i2c_client *i2c_client;
	struct snd_soc_codec *codec;
	u32 ports[2];
	int dai_id;
	u8 *eld;
};

static void tda_get_encoder(struct tda_priv *priv)
{
	struct snd_soc_codec *codec = priv->codec;
	struct device_node *np;
	struct i2c_client *i2c_client;
	static const struct of_device_id tda_dt[] = {
		{ .compatible = "nxp,tda998x" },
		{ },
	};

	/* search the tda998x device (only one!) */
	np = of_find_matching_node_and_match(NULL, tda_dt, NULL);
	if (!np || !of_device_is_available(np)) {
		dev_err(codec->dev, "No tda998x in DT\n");
		return;
	}
	i2c_client = of_find_i2c_device_by_node(np);
	of_node_put(np);
	if (!i2c_client) {
		dev_err(codec->dev, "no tda998x i2c client\n");
		return;
	}
	if (!i2c_get_clientdata(i2c_client)) {
		dev_err(codec->dev, "tda998x not initialized\n");
		return;
	}

	priv->i2c_client = i2c_client;
}

static int tda_start_stop(struct tda_priv *priv,
			int start)
{
	int format;
	u32 port;

	if (!priv->i2c_client) {
		tda_get_encoder(priv);
		if (!priv->i2c_client)
			return -EINVAL;
	}

	/* give the audio input type and ports to the HDMI encoder */
	format = start ? priv->dai_id : 0;
	switch (format) {
	case AFMT_I2S:
		port = priv->ports[0];
		break;
	default:
	case AFMT_SPDIF:
		port = priv->ports[1];
		break;
	}
	tda998x_audio_update(priv->i2c_client, format, port);
	return 0;
}

static int tda_startup(struct snd_pcm_substream *substream,
			struct snd_soc_dai *dai)
{
	struct tda_priv *priv = snd_soc_codec_get_drvdata(dai->codec);
	u8 *eld = NULL;
	static unsigned rates_mask[] = {
		SNDRV_PCM_RATE_32000,
		SNDRV_PCM_RATE_44100,
		SNDRV_PCM_RATE_48000,
		SNDRV_PCM_RATE_88200,
		SNDRV_PCM_RATE_96000,
		SNDRV_PCM_RATE_176400,
		SNDRV_PCM_RATE_192000,
	};

	/* memorize the used DAI */
	priv->dai_id = dai->id;

	/* get the ELD from the tda998x driver */
	if (!priv->i2c_client)
		tda_get_encoder(priv);
	if (priv->i2c_client)
		eld = tda998x_audio_get_eld(priv->i2c_client);

	/* limit the hw params from the ELD (EDID) */
	if (eld) {
		struct snd_soc_dai_driver *dai_drv = dai->driver;
		struct snd_soc_pcm_stream *stream = &dai_drv->playback;
		u8 *sad;
		int sad_count;
		unsigned eld_ver, mnl, rates, rate_mask, i;
		unsigned max_channels;

		eld_ver = eld[0] >> 3;
		if (eld_ver != 2 && eld_ver != 31)
			return 0;

		mnl = eld[4] & 0x1f;
		if (mnl > 16)
			return 0;

		sad_count = eld[5] >> 4;
		sad = eld + 20 + mnl;

		/* Start from the basic audio settings */
		max_channels = 2;
		rates = 0;
		while (sad_count--) {
			switch (sad[0] & 0x78) {
			case 0x08: /* PCM */
				max_channels = max(max_channels, (sad[0] & 7) + 1u);
				rates |= sad[1];
				break;
			}
			sad += 3;
		}

		for (rate_mask = i = 0; i < ARRAY_SIZE(rates_mask); i++)
			if (rates & 1 << i)
				rate_mask |= rates_mask[i];

		/* change the snd_soc_pcm_stream values of the driver */
		stream->rates = rate_mask;
		stream->channels_max = max_channels;
	}

	/* start the TDA998x audio */
	return tda_start_stop(priv, 1);
}

static void tda_shutdown(struct snd_pcm_substream *substream,
			struct snd_soc_dai *dai)
{
	struct tda_priv *priv = snd_soc_codec_get_drvdata(dai->codec);

	priv->dai_id = 0;
	tda_start_stop(priv, 0);
}

static const struct snd_soc_dai_ops tda_ops = {
	.startup = tda_startup,
	.shutdown = tda_shutdown,
};

static const struct snd_soc_dai_driver tda998x_dai[] = {
    {
	.name = "i2s-hifi",
	.id = AFMT_I2S,
	.playback = {
		.stream_name	= "HDMI I2S Playback",
		.channels_min	= 1,
		.channels_max	= 8,
		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
		.rate_min	= 5512,
		.rate_max	= 192000,
		.formats	= TDA998X_FORMATS,

	},
	.ops = &tda_ops,
    },
    {
	.name = "spdif-hifi",
	.id = AFMT_SPDIF,
	.playback = {
		.stream_name	= "HDMI SPDIF Playback",
		.channels_min	= 1,
		.channels_max	= 2,
		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
		.rate_min	= 22050,
		.rate_max	= 192000,
		.formats	= TDA998X_FORMATS,
	},
	.ops = &tda_ops,
    },
};

static const struct snd_soc_dapm_widget tda_widgets[] = {
	SND_SOC_DAPM_OUTPUT("hdmi-out"),
};
static const struct snd_soc_dapm_route tda_routes[] = {
	{ "hdmi-out", NULL, "HDMI I2S Playback" },
	{ "hdmi-out", NULL, "HDMI SPDIF Playback" },
};

static int tda_probe(struct snd_soc_codec *codec)
{
	struct tda_priv *priv;
	struct device_node *np;
	int i, ret;

	priv = devm_kzalloc(codec->dev, sizeof(*priv), GFP_KERNEL);
	if (!priv)
		return -ENOMEM;
	snd_soc_codec_set_drvdata(codec, priv);
	priv->codec = codec;

	/* get the audio input ports (I2s and S/PDIF) */
	np = codec->dev->of_node;
	for (i = 0; i < 2; i++) {
		ret = of_property_read_u32_index(np, "audio-ports", i,
						&priv->ports[i]);
		if (ret) {
			if (i == 0)
				dev_err(codec->dev,
					"bad or missing audio-ports\n");
			break;
		}
	}

	return 0;
}

static const struct snd_soc_codec_driver soc_codec_tda998x = {
	.probe = tda_probe,
	.dapm_widgets = tda_widgets,
	.num_dapm_widgets = ARRAY_SIZE(tda_widgets),
	.dapm_routes = tda_routes,
	.num_dapm_routes = ARRAY_SIZE(tda_routes),
};

static int tda998x_dev_probe(struct platform_device *pdev)
{
	struct snd_soc_dai_driver *dai_drv;

	/* copy the DAI driver to a writable area */
	dai_drv = devm_kzalloc(&pdev->dev, sizeof(tda998x_dai), GFP_KERNEL);
	if (!dai_drv)
		return -ENOMEM;
	memcpy(dai_drv, tda998x_dai, sizeof(tda998x_dai));

	return snd_soc_register_codec(&pdev->dev,
				&soc_codec_tda998x,
				dai_drv, ARRAY_SIZE(tda998x_dai));
}

static int tda998x_dev_remove(struct platform_device *pdev)
{
	snd_soc_unregister_codec(&pdev->dev);
	return 0;
}

static const struct of_device_id tda998x_codec_ids[] = {
	{ .compatible = "nxp,tda998x-codec", },
	{ }
};
MODULE_DEVICE_TABLE(of, tda998x_codec_ids);

static struct platform_driver tda998x_driver = {
	.probe		= tda998x_dev_probe,
	.remove		= tda998x_dev_remove,
	.driver		= {
		.name	= "tda998x-codec",
		.owner	= THIS_MODULE,
		.of_match_table = tda998x_codec_ids,
	},
};

module_platform_driver(tda998x_driver);

MODULE_AUTHOR("Jean-Francois Moine");
MODULE_DESCRIPTION("TDA998x codec driver");
MODULE_LICENSE("GPL");
-------------------8<----------------

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
