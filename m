From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Mon, 01 Sep 2014 00:42:47 -0700 (PDT)
Subject: [alsa-devel] [PATCHv1 1/7] ASoC: simple-card: Merge single and
 muti	DAI link code.
In-Reply-To: <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <87tx4rzszx.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Xiubo

Thank you for your patch.
This clean-up is very nice for me.
But, I have 1 small comment

>  asoc_simple_card_sub_parse_of(struct device_node *np,
>  			      struct asoc_simple_dai *dai,
>  			      struct device_node **p_node,
> -			      const char **name)
> +			      const char **name,
> +			      unsigned int *daifmt)
>  {
>  	struct device_node *node;
>  	struct clk *clk;
>  	u32 val;
>  	int ret;
>  
> +	if (!daifmt)
> +		return -EINVAL;
> +
> +	/*
> +	 * Parse format, bitclock-inversion and frame-inversion
> +	 * for DAI each device.
> +	 */
> +	*daifmt = snd_soc_of_parse_daifmt(np, NULL, NULL, NULL);
> +	*daifmt &= ~(SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK);
(snip)
>  	ret = asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai,
>  					    &dai_link->cpu_of_node,
> -					    &dai_link->cpu_dai_name);
> +					    &dai_link->cpu_dai_name,
> +					    &daifmt);
(snip)
> +	dai_props->cpu_dai.fmt |= daifmt;
(snip)
>  	ret = asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai,
>  					    &dai_link->codec_of_node,
> -					    &dai_link->codec_dai_name);
> +					    &dai_link->codec_dai_name,
> +					    &daifmt);
(snip)
> +	dai_props->codec_dai.fmt |= daifmt;

These are using

      asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai, xxx)
      asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai, xxx)

I guess, asoc_simple_card_sub_parse_of() can update
below inside function

	dai_props->cpu_dai.fmt |= daifmt;
	dai_props->codec_dai.fmt |= daifmt;


Best regards
---
Kuninori Morimoto
