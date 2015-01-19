From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 19 Jan 2015 15:23:38 +0300
Subject: [PATCH 2/3] ASoC: sh: fsi: Fix clock inversion
In-Reply-To: <1421661297-19654-2-git-send-email-lars@metafoo.de>
References: <1421661297-19654-1-git-send-email-lars@metafoo.de>
 <1421661297-19654-2-git-send-email-lars@metafoo.de>
Message-ID: <54BCF74A.10106@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/19/2015 12:54 PM, Lars-Peter Clausen wrote:

> According to the sh7724 hardware user manual (Rev.2.00 Jan 2013) page 1851
> to 1856 the FSI bit-clock is inverted to the bit-clock as specified by the
> I2S standard. This means the bit clock inversion bit should be set for a
> normal I2S clock and should not be set for an inverted I2S clock.

> Similarly when operating in left-justified mode both the frame-clock and the
> bit-clock need to be inverted to be standards compliant.

> This means also that the extra clock inversion setting in the
> armadillo800eva machine driver for CPU component should now be removed.

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

[...]

> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index b87b22e..dfb17f6 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1594,6 +1594,12 @@ static int fsi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>
>   static int fsi_set_fmt_dai(struct fsi_priv *fsi, unsigned int fmt)
>   {
> +	/*
> +	 * FSI bit clock is inverted to the I2S specification, so we invert it
> +	 * when a non-inverted I2S clock was requested and vice versa.
> +	 */
> +	 fsi->bit_clk_inv = !fsi->bit_clk_inv;

    One space too many here. :-)

[...]

WBR, Sergei
