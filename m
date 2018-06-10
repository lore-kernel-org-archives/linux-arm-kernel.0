From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 10 Jun 2018 23:52:59 +0000
Subject: [PATCH] ASoC: audio-graph-card: add hp and mic detect gpios same
 as simple-card
In-Reply-To: <20180608080843.11097-1-suzuki.katsuhiro@socionext.com>
References: <20180608080843.11097-1-suzuki.katsuhiro@socionext.com>
Message-ID: <87h8makxt7.wl-kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Katsuhiro-san

Thank you for your patch

> This patch adds headphone and microphone jack detection gpios as same
> as simple-card driver. This feature move into simple-card-utils from
> simple-card to avoid the duplicating code.
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---

I think it can be 2 patches ?
 1. move function from simple-card to simple-card-utils
 2. use it from audio-graph-card

> +static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
> +{
> +	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
> +	int ret;
> +
> +	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int asoc_graph_card_probe(struct platform_device *pdev)
>  {
>  	struct graph_card_data *priv;
> @@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
>  	card->num_links	= num;
>  	card->dapm_widgets = asoc_graph_card_dapm_widgets;
>  	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
> +	card->probe	= asoc_graph_soc_card_probe;

Current simple-card is calling init_hp/init_mic from
asoc_simple_card_dai_init(), and audio-graph-card has
asoc_graph_card_dai_init().
simple/audio card are doing samethings in different style.
Thus, I want to synchronized whole simple/audio card.

Best regards
---
Kuninori Morimoto
