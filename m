From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Jun 2017 11:19:55 +0800
Subject: [PATCH 2/2] ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver
In-Reply-To: <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
 <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
Message-ID: <20170620031953.GC4818@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for the reviewing.

On Mon, Jun 19, 2017 at 05:19:10PM +0100, Mark Brown wrote:
> On Sat, Jun 17, 2017 at 10:09:34PM +0800, Shawn Guo wrote:
> 
> > +	/* Mute control */
> > +	SOC_DOUBLE("Playback Master Mute", AUD96P22_MUTE_2, 0, 1, 1, 0),
> > +	SOC_DOUBLE("Headset Mute", AUD96P22_MUTE_2, 4, 5, 1, 0),
> 
> As covered in ControlNames.txt mute and other on/off controls should be
> named ending in Switch so UIs know what to do with them.

Oh, thanks for the info.  I did not know that before.

> 
> > +static int aud96p22_startup(struct snd_pcm_substream *substream,
> > +			    struct snd_soc_dai *dai)
> > +{
> > +	struct aud96p22_priv *priv = snd_soc_codec_get_drvdata(dai->codec);
> > +	struct regmap *regmap = priv->regmap;
> > +
> > +	/* Overall power-up */
> > +	regmap_update_bits(regmap, AUD96P22_PD_0, PD_0_PDZ, PD_0_PDZ);
> 
> Why is this not done with DAPM?

As this is a overall power bit, which is not for any specific component.
I'm not sure which DAPM widget should be used for it, and how it should
be arranged in the widget route.  Any suggestion or example will be
appreciated.

> 
> > +	/* Reset ADC and DAC path */
> > +	regmap_write(regmap, AUD96P22_RESET, 0x0);
> > +	regmap_write(regmap, AUD96P22_RESET, 0x3);
> 
> What does this mean?

It's a de-assert/assert of ADC and DAC reset.  I will add proper
defines for the bits to make this clear.

Shawn
