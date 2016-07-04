From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jul 2016 16:44:06 +0200
Subject: [alsa-devel] [PATCH 3/4] ASoC: mediatek: add BT implementation
In-Reply-To: <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
 <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <20160704144406.GH6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 06:56:27PM +0800, Garlic Tseng wrote:

> +static int mt2701_btmrg_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
> +	struct mt2701_afe_private *afe_priv = afe->platform_priv;
> +
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
> +			   AUDIO_TOP_CON4_PDN_MRGIF, 0);

We really shouldn't be writing the registers or other internal data of
the device.  Instead we should be getting the driver for the relevant
hardware component to do it.  If we just write to registers that makes
the interoperation with the real driver for the device more fragile than
it should be, people might update the main driver without noticing the
external driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160704/37f4746c/attachment.sig>
