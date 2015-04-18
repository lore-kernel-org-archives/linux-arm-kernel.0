From: broonie@kernel.org (Mark Brown)
Date: Sat, 18 Apr 2015 18:51:39 +0100
Subject: [RESEND RFC PATCH 3/3] ASoC: mediatek: Add AFE platform driver
In-Reply-To: <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
Message-ID: <20150418175139.GG26185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 04:14:09PM +0800, Koro Chen wrote:

> +	if (memif->use_sram) {
> +		struct snd_dma_buffer *dma_buf = &substream->dma_buffer;
> +		int size = params_buffer_bytes(params);
> +
> +		memif->buffer_size = size;
> +		memif->phys_buf_addr = afe->sram_phy_address;
> +
> +		dma_buf->bytes = size;
> +		dma_buf->area = (unsigned char *)afe->sram_address;
> +		dma_buf->addr = afe->sram_phy_address;
> +		dma_buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +		dma_buf->dev.dev = substream->pcm->card->dev;
> +		snd_pcm_set_runtime_buffer(substream, dma_buf);
> +	} else {
> +		ret = snd_pcm_lib_malloc_pages(substream,
> +					       params_buffer_bytes(params));
> +		if (ret < 0)
> +			return ret;
> +
> +		memif->phys_buf_addr = substream->runtime->dma_addr;
> +		memif->buffer_size = substream->runtime->dma_bytes;
> +	}

Ah, so the SRAM is directly memory mappable.  Nice.  But we have a
limited amount of it so need to allocate it to a device somehow based on
some factor I guess?

> +static int mtk_afe_set_adda_dac_out(struct mtk_afe *afe, uint32_t rate)
> +{
> +	u32 audio_i2s_dac = 0;
> +	u32 con0, con1;
> +
> +	/* set dl src2 */
> +	con0 = (mtk_afe_adda_fs(rate) << 28) | (0x03 << 24) | (0x03 << 11);
> +
> +	/* 8k or 16k voice mode */
> +	if (con0 == 0 || con0 == 3)
> +		con0 |= 0x01 << 5;

This all looks a bit magic, some defines would not go amiss here.

> +	/* SA suggests to apply -0.3db to audio/speech path */
> +	con0 = con0 | (0x01 << 1);
> +	con1 = 0xf74f0000;

More magic numbers!  This also suggests that there is a volume control
lurking in here which could usefully be exposed to applications?

> +static void mtk_afe_pmic_shutdown(struct mtk_afe *afe,
> +				  struct snd_pcm_substream *substream)
> +{
> +	/* output */
> +	regmap_update_bits(afe->regmap, AFE_ADDA_DL_SRC2_CON0, 1, 0);
> +	regmap_update_bits(afe->regmap, AFE_I2S_CON1, 1, 0);
> +
> +	/* input */
> +	regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0, 1, 0);
> +	/* disable ADDA */
> +	regmap_update_bits(afe->regmap, AFE_ADDA_UL_DL_CON0, 1, false);
> +}

This is looking like exposing the routing and using DAPM might save a
bunch of code?  Overall my main thought looking at the code here and
what the hardware was described as doing is that it'd all be simpler if
it were a DPCM based thing using DAPM for power.  I think I'd like to
see a strong reason for not using at least DPCM.

> +		if (rate == MTK_AFE_I2S_RATE_8K)
> +			voice_mode = 0;
> +		else if (rate == MTK_AFE_I2S_RATE_16K)
> +			voice_mode = 1;
> +		else if (rate == MTK_AFE_I2S_RATE_32K)
> +			voice_mode = 2;
> +		else if (rate == MTK_AFE_I2S_RATE_48K)
> +			voice_mode = 3;

This should be a switch statement.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150418/ca74b09e/attachment.sig>
