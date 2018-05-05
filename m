From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 5 May 2018 09:05:13 +0200
Subject: [PATCH v14 2/8] ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2
 Boost Volume
In-Reply-To: <20180503143319.4vyh2y5sluatssnv@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-3-dannym@scratchpost.org>
 <20180503143319.4vyh2y5sluatssnv@flea>
Message-ID: <20180505090513.7e3f02c2@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, 3 May 2018 16:33:19 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> > +struct sun4i_codec_quirks {
> > +	const struct regmap_config *regmap_config;
> > +	const struct snd_soc_component_driver *codec;
> > +	struct snd_soc_card * (*create_card)(struct device *dev);
> > +	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
> > +	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> > +	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
> > +	bool has_reset;
> > +	const struct snd_kcontrol_new *controls;
> > +	unsigned int num_controls;
> > +};
> > +
> > +static int sun4i_codec_component_driver_probe(struct snd_soc_component *codec)
> > +{
> > +	const struct sun4i_codec_quirks *quirks;
> > +
> > +	quirks = of_device_get_match_data(codec->dev);
> > +	return snd_soc_add_component_controls(codec,
> > +					      quirks->controls,
> > +					      quirks->num_controls);  
> 
> Why not just extending the sun4i_codec_controls to add it, and create
> a duplicate one for the A20?

Because sun4i_codec_controls has five controls shared between A10 and A20,
and only two not shared.

And if we extended sun4i_codec_controls, we'd also have to duplicate
sun4i_codec_codec in order to use sun4i_codec_controls vs. sun7i_codec_controls,
which really contains exactly the same data otherwise.

The quirks here are just for two controls, Mic1 Boost Volume and Mic2 Boost Volume,
and there not even for the names or anything - just for some reason the register
moved away.

The simplest way was to add it to the quirks - which already have a variant
selection etc.
