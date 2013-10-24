From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Oct 2013 12:08:33 +0100
Subject: [PATCH v4] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20131021122422.4cde72c0@armhf>
References: <20131021122422.4cde72c0@armhf>
Message-ID: <20131024110833.GC18506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 12:24:22PM +0200, Jean-Francois Moine wrote:

> +static struct snd_soc_dai_driver kirkwood_i2s_dai[3] = {
> +	DAI_DEF("i2s", 0,
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +					SNDRV_PCM_RATE_96000),
> +	DAI_DEF("spdif", 1,
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +					SNDRV_PCM_RATE_96000),
> +	DAI_DEF("i2s/spdif", 2,
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +					SNDRV_PCM_RATE_96000),

I didn't take this version because this third DAI reintroduces the
problem with having both S/PDIF and I2S in the single DAI.  The problem
there is that you end up with one traditional DAI linked to two
different CODECs which the framework doesn't understand - it's
introducing a DAI which does what v1 does.  

This is what DPCM addresses for this platform, it allows the single DMA
controller to be used in conjunction with the two external DAIs by
splitting the DMA from the DAI in the model the subsystem has.
Hopefully someone will have the time and enthusiasm to update to use
this and support systems that want to use I2S and S/PDIF simultaneously.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/8253f89d/attachment-0001.sig>
