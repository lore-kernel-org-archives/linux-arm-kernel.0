From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Dec 2013 13:16:17 +0000
Subject: [PATCH RFC v2 REPOST 2/8] ASoC: davinci-evm: Add named clock
 reference to DT bindings
In-Reply-To: <c1ae738c9b6cd9f2e595eed1f4981378ded46925.1387535302.git.jsarha@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <c1ae738c9b6cd9f2e595eed1f4981378ded46925.1387535302.git.jsarha@ti.com>
Message-ID: <20131231131617.GZ31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 12:38:27PM +0200, Jyri Sarha wrote:

> +static int evm_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_card *soc_card = rtd->codec->card;
> +	struct clk *mclk = ((struct snd_soc_card_drvdata_davinci *)
> +			    snd_soc_card_get_drvdata(soc_card))->mclk;

Why do you need to cast away void?  Ths indicates something is going
wrong here though I can't see what.

> +	mclk = of_clk_get_by_name(np, "ti,codec-clock");
> +	if (PTR_ERR(mclk) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(mclk)) {
> +		dev_dbg(&pdev->dev, "Codec clock not found.\n");
> +		mclk = NULL;
> +	}

The driver will unconditionally enable and disable the clock which I'd
not expect to work well if we got an error, I'd expect either NULL checks 
on use or a fixed clock to be registered from code in the case where
we're using the old binding.

I'd also expect to see devm_clk_get() used here, with the standard
clock-names based lookup from DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131231/d02c445d/attachment.sig>
