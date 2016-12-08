From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 14:09:42 -0800
Subject: [PATCH 2/3] ASoC: simple-card: use devm_get_clk_from_child()
In-Reply-To: <871sxnvtkp.wl%kuninori.morimoto.gx@renesas.com>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
 <871sxnvtkp.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20161208220942.GO5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05, Kuninori Morimoto wrote:
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index cf02625..4924575 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -98,7 +98,8 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
>  }
>  EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
>  
> -int asoc_simple_card_parse_clk(struct device_node *node,
> +int asoc_simple_card_parse_clk(struct device *dev,
> +			       struct device_node *node,
>  			       struct device_node *dai_of_node,
>  			       struct asoc_simple_dai *simple_dai)
>  {
> @@ -111,14 +112,13 @@ int asoc_simple_card_parse_clk(struct device_node *node,
>  	 *  or "system-clock-frequency = <xxx>"
>  	 *  or device's module clock.
>  	 */
> -	clk = of_clk_get(node, 0);
> +	clk = devm_get_clk_from_child(dev, node, NULL);
>  	if (!IS_ERR(clk)) {
>  		simple_dai->sysclk = clk_get_rate(clk);
> -		simple_dai->clk = clk;
>  	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
>  		simple_dai->sysclk = val;
>  	} else {
> -		clk = of_clk_get(dai_of_node, 0);
> +		clk = devm_get_clk_from_child(dev, dai_of_node, NULL);


I was confused for a minute about how the second of_clk_get()
call with the dai_link node could work. Is that documented
anywhere or used by anyone? It seems like it's at least another
child node of the sound node (which is dev here) so it seems ok.


>  		if (!IS_ERR(clk))
>  			simple_dai->sysclk = clk_get_rate(clk);
>  	}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
