From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Tue, 5 Jul 2016 09:52:13 +0800
Subject: [alsa-devel] [PATCH 3/4] ASoC: mediatek: add BT implementation
In-Reply-To: <20160704144406.GH6247@sirena.org.uk>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
 <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
 <20160704144406.GH6247@sirena.org.uk>
Message-ID: <1467683533.4212.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-07-04 at 16:44 +0200, Mark Brown wrote:
> On Mon, Jul 04, 2016 at 06:56:27PM +0800, Garlic Tseng wrote:
> 
> > +static int mt2701_btmrg_startup(struct snd_pcm_substream *substream,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
> > +	struct mt2701_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
> > +			   AUDIO_TOP_CON4_PDN_MRGIF, 0);
> 
> We really shouldn't be writing the registers or other internal data of
> the device.  Instead we should be getting the driver for the relevant
> hardware component to do it.  If we just write to registers that makes
> the interoperation with the real driver for the device more fragile than
> it should be, people might update the main driver without noticing the
> external driver.

The AUDIO_TOP_CON4 is a reg of the ASoC hw module. All the registers
which are set in the btmrg operator belong to ASoC hardware. The reg
writing you mention above is to power up the MRG interface in the ASoC
module.

When we start BT link, we need to start some hardware component belongs
to ASoC module. Of course we also need to start up the BT module
(including start up the MRG interface hw in BT chip), but it is not in
the ASoC driver.
