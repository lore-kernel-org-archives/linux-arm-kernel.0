From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Sep 2015 15:31:35 +0200
Subject: [PATCH 2/2] ASoC: sunxi: add support for the on-chip codec on
 early Allwinner SoCs
In-Reply-To: <20150916191612.GM12027@sirena.org.uk>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442064384-23379-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150916191612.GM12027@sirena.org.uk>
Message-ID: <20150917133135.GE4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Sep 16, 2015 at 08:16:12PM +0100, Mark Brown wrote:
> On Sat, Sep 12, 2015 at 03:26:24PM +0200, Maxime Ripard wrote:
> 
> This looks pretty good, there's a few minor things below but I'll apply
> anyway - please send followup patches fixing these.

Sure, I will. Thanks!

> 
> > +	if (clk_set_rate(scodec->clk_module, clk_freq))
> > +		return -EINVAL;
> 
> Better to pass back the error code here rather than silently discard it
> (it might have more information).

Yep.

> 
> > +static struct snd_soc_dai_driver sun4i_codec_dai = {
> > +	.name	= "Codec",
> > +	.ops	= &sun4i_codec_dai_ops,
> > +	.playback = {
> > +		.stream_name	= "Codec Playback",
> > +		.channels_min	= 1,
> > +		.channels_max	= 2,
> > +		.rate_min	= 8000,
> > +		.rate_max	= 192000,
> > +		.rates		= SNDRV_PCM_RATE_8000_48000 |
> > +				  SNDRV_PCM_RATE_96000 |
> > +				  SNDRV_PCM_RATE_192000 |
> > +				  SNDRV_PCM_RATE_KNOT,
> 
> No need to specify both explicit rates and _KNOT, _KNOT covers
> everything.

Ack.

> > +		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
> > +				  SNDRV_PCM_FMTBIT_S32_LE,
> > +		.sig_bits	= 24,
> 
> So presumably also S24_LE (ie, 24 bits packed into a 32 bit word)?

Hmm, probably yes, I'll test that.

> > +	/* Enable the bus clock */
> > +	if (clk_prepare_enable(scodec->clk_apb)) {
> > +		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
> > +		return -EINVAL;
> > +	}
> 
> Ideally we'd have runtime power management to disable the clocks when
> idle.

We don't really have any kind of power management support currently,
but adding runtime pm everywhere is definitely on the todo list. It
might not happen before a while though.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/67f312a7/attachment.sig>
