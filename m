From: andrea.bondavalli74@gmail.com (Andrea Bondavalli)
Date: Mon, 30 Oct 2017 13:16:03 +0100
Subject: [PATCH] ASoC: sun4i-codec: fixed 32bit audio capture support for
 H3/H2+
In-Reply-To: <20171030085542.udrw2s7pcznb75rl@flea>
References: <20171029094048.GA5295@ubuntu>
 <20171030085542.udrw2s7pcznb75rl@flea>
Message-ID: <20171030121603.GB12678@andrea-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime, everyone,

see comments inline.

On Mon, Oct 30, 2017 at 09:55:42AM +0100, Maxime Ripard wrote:
> On Sun, Oct 29, 2017 at 02:41:01AM -0700, Andrea Bondavalli wrote:
> > Fixed support for 32bit audio capture for Allwinner H3/H2+ SoC
> > 
> > Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
> 
> A more detailed commit log would be welcome.
> 
> What are the issues involved would be the more valuable information,
> and then how you'ring fixing it and why would be great.
> 

H3 audio codec supports 16 and 24 bits capture formats (same for the playback).
Switching between these two modes can be achieved by using the RX_SAMPLE_BITS (bit 6)
of the AC_ADC_FIFOC register (offset 0x10) of the audio codec. 
The RX_FIFO_MODE (bit 24) register must also be set accordingly to have
the desired RX FIFO output mode.

The current implementation declares support for 16bit and 32bit (with a 
resolution of 24bit) capture formats but the 32bit implementation is broken 
because the RX_SAMPLE_BITS and the RX_FIFO_MODE bits are not set correctly and 
in addition to this the DMA bus transfer width is left to 2 bytes instead of 
4 bytes causing invalid captures whose durating is double than the expected period.

The following patch sets the H3 audio codec registers properly when a
24/32bit capture is requested.
Similar approach was already implemented for the audio playback part.

> > ---
> >  sound/soc/sunxi/sun4i-codec.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> > index baa9007..f40fa34 100644
> > --- a/sound/soc/sunxi/sun4i-codec.c
> > +++ b/sound/soc/sunxi/sun4i-codec.c
> > @@ -346,11 +346,6 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
> >  				   0x3 << 8,
> >  				   0x1 << 8);
> > 
> > -	/* Fill most significant bits with valid data MSB */
> > -	regmap_field_update_bits(scodec->reg_adc_fifoc,
> > -				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
> > -				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
> > -
> >  	return 0;
> >  }
> > 
> > @@ -490,6 +485,30 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
> >  					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
> >  					 0);
> > 
> > +	/* Set the number of sample bits to either 16 or 24 bits */
> > +	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min == 32) {
> > +		regmap_field_update_bits(scodec->reg_adc_fifoc,
> > +				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
> > +				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS));
> > +
> > +		regmap_field_update_bits(scodec->reg_adc_fifoc,
> > +				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
> > +				   0);
> > +
> > +		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +	} else {
> > +		regmap_field_update_bits(scodec->reg_adc_fifoc,
> > +				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
> > +				   0);
> > +
> > +		/* Fill most significant bits with valid data MSB */
> > +		regmap_field_update_bits(scodec->reg_adc_fifoc,
> > +				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
> > +				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
> > +
> > +		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> 
> Doesn't that break 24 bits?

No. I did tests with 16/24/32bit captures and all seem to work properly now:

arecord -vv -r 48000 -c 2 -f S32_LE /home/root/s32_le.wav  -d 10
arecord -vv -r 48000 -c 2 -f S24_LE /home/root/s24_le.wav  -d 10
arecord -vv -r 48000 -c 2 -f S16_LE /home/root/s16_le.wav  -d 10

For the reasons explained above 24bit and 32bit captures were previously
broken.

> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Kind regards,
Andrea Bondavalli
