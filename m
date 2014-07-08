From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Tue, 08 Jul 2014 10:17:58 +0100
Subject: [alsa-devel] [PATCH v2] ASoC: tda998x: add a codec to the HDMI
 transmitter
In-Reply-To: <20140704091733.10258cfe@armhf>
References: <20140704091733.10258cfe@armhf>
Message-ID: <53BBB746.1000201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/14 08:17, Jean-Francois Moine wrote:
> This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.
> 
> The CODEC handles both I2S and S/PDIF input and does dynamic input
> switch in the TDA998x I2C driver on start/stop audio streaming.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---

[snip]

> +++ b/drivers/gpu/drm/i2c/tda998x_codec.c

[snip]

> +static int tda_startup(struct snd_pcm_substream *substream,
> +                       struct snd_soc_dai *dai)
> +{
> +       struct tda998x_priv *priv = snd_soc_codec_get_drvdata(dai->codec);
> +       u8 *eld = priv->eld;
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       u8 *sad;
> +       int sad_count;
> +       unsigned eld_ver, mnl, rate_mask;
> +       unsigned max_channels, fmt;
> +       u64 formats;
> +       struct snd_pcm_hw_constraint_list *rate_constraints =
> +                       &priv->rate_constraints;
> +       static const u32 hdmi_rates[] = {
> +               32000, 44100, 48000, 88200, 9600, 176400, 192000
> +       };
> +

Shouldn't this be 96000, not 9600?  Assuming that the table is ordered in terms of increasing frequencies.

    Andrew
