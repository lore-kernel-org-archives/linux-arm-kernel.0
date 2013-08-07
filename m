From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 11:10:24 +0100
Subject: [PATCH V3 6/7] ASoC: Samsung: wm8994: Register the osc clock.
In-Reply-To: <1375866616-5541-7-git-send-email-padma.v@samsung.com>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
 <1375866616-5541-7-git-send-email-padma.v@samsung.com>
Message-ID: <20130807101024.GX6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 02:40:15PM +0530, Padmavathi Venna wrote:
> This patch registers the 16MHz oscillator clock as fixed clk.

> +/* 16.9MHz fixed oscillator clock */
> +static void init_osc_clock(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "osc3_clk16mhz");
> +	of_fixed_clk_setup(np);
> +}
> +
>  static int smdk_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_pcm_hw_params *params)
>  {
> @@ -173,6 +183,8 @@ static int smdk_audio_probe(struct platform_device *pdev)
>  		smdk_dai[0].platform_of_node = smdk_dai[0].cpu_of_node;
>  	}
>  
> +	init_osc_clock();
> +

This doesn't seem great - it means that this machine driver needs to
know about a specifically named fixed clock which makes it hard to reuse
on other similar boards.  For example I'm intending to reuse this on
Arndale.  Mike?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/7eb0e38f/attachment.sig>
