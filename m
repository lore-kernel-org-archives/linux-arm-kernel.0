From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 20 Apr 2015 14:22:24 +0800
Subject: [RESEND RFC PATCH 3/3] ASoC: mediatek: Add AFE platform driver
In-Reply-To: <20150418175139.GG26185@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
 <20150418175139.GG26185@sirena.org.uk>
Message-ID: <1429510944.30743.36.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-04-18 at 18:51 +0100, Mark Brown wrote:
> On Fri, Apr 10, 2015 at 04:14:09PM +0800, Koro Chen wrote:
> 
> > +	if (memif->use_sram) {
> > +		struct snd_dma_buffer *dma_buf = &substream->dma_buffer;
> > +		int size = params_buffer_bytes(params);
> > +
> > +		memif->buffer_size = size;
> > +		memif->phys_buf_addr = afe->sram_phy_address;
> > +
> > +		dma_buf->bytes = size;
> > +		dma_buf->area = (unsigned char *)afe->sram_address;
> > +		dma_buf->addr = afe->sram_phy_address;
> > +		dma_buf->dev.type = SNDRV_DMA_TYPE_DEV;
> > +		dma_buf->dev.dev = substream->pcm->card->dev;
> > +		snd_pcm_set_runtime_buffer(substream, dma_buf);
> > +	} else {
> > +		ret = snd_pcm_lib_malloc_pages(substream,
> > +					       params_buffer_bytes(params));
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		memif->phys_buf_addr = substream->runtime->dma_addr;
> > +		memif->buffer_size = substream->runtime->dma_bytes;
> > +	}
> 
> Ah, so the SRAM is directly memory mappable.  Nice.  But we have a
> limited amount of it so need to allocate it to a device somehow based on
> some factor I guess?
Yes, actually SRAM is only used for the main playback path (which is
memif "DL1") to achieve low power in real use case. Maybe you think it's
better to not describe this in the device tree, but to choose SRAM
automatically if memif "DL1" is chosen?
> 
> > +static int mtk_afe_set_adda_dac_out(struct mtk_afe *afe, uint32_t rate)
> > +{
> > +	u32 audio_i2s_dac = 0;
> > +	u32 con0, con1;
> > +
> > +	/* set dl src2 */
> > +	con0 = (mtk_afe_adda_fs(rate) << 28) | (0x03 << 24) | (0x03 << 11);
> > +
> > +	/* 8k or 16k voice mode */
> > +	if (con0 == 0 || con0 == 3)
> > +		con0 |= 0x01 << 5;
> 
> This all looks a bit magic, some defines would not go amiss here.
> 
> > +	/* SA suggests to apply -0.3db to audio/speech path */
> > +	con0 = con0 | (0x01 << 1);
> > +	con1 = 0xf74f0000;
> 
> More magic numbers!  This also suggests that there is a volume control
> lurking in here which could usefully be exposed to applications?
> 
Sorry, I will fix these magic numbers.
It is actually not a real volume control and not that suitable for
application control because it cannot be changed in runtime; its value
is fixed and was decided off-lined by experiment that can have best
audio quality when using with our proprietary codec (not for I2S)

> > +static void mtk_afe_pmic_shutdown(struct mtk_afe *afe,
> > +				  struct snd_pcm_substream *substream)
> > +{
> > +	/* output */
> > +	regmap_update_bits(afe->regmap, AFE_ADDA_DL_SRC2_CON0, 1, 0);
> > +	regmap_update_bits(afe->regmap, AFE_I2S_CON1, 1, 0);
> > +
> > +	/* input */
> > +	regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0, 1, 0);
> > +	/* disable ADDA */
> > +	regmap_update_bits(afe->regmap, AFE_ADDA_UL_DL_CON0, 1, false);
> > +}
> 
> This is looking like exposing the routing and using DAPM might save a
> bunch of code?  Overall my main thought looking at the code here and
> what the hardware was described as doing is that it'd all be simpler if
> it were a DPCM based thing using DAPM for power.  I think I'd like to
> see a strong reason for not using at least DPCM.
Thank you very much for mentioning the DPCM. I didn't know much about
DPCM and I will definitely study and check if it is suitable for our HW.
> 
> > +		if (rate == MTK_AFE_I2S_RATE_8K)
> > +			voice_mode = 0;
> > +		else if (rate == MTK_AFE_I2S_RATE_16K)
> > +			voice_mode = 1;
> > +		else if (rate == MTK_AFE_I2S_RATE_32K)
> > +			voice_mode = 2;
> > +		else if (rate == MTK_AFE_I2S_RATE_48K)
> > +			voice_mode = 3;
> 
> This should be a switch statement.
