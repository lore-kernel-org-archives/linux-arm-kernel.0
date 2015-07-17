From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Jul 2015 19:04:02 +0100
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150717180402.GS11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 11:15:42AM +0800, Xing Zheng wrote:

This looks pretty good, a couple of minor points below which should be
quick to fix.

> +static int rk_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	struct snd_soc_card *card = runtime->card;
> +
> +	card->dapm.idle_bias_off = true;

You shouldn't need to do this?  If you do need to do it we should make
it possible to do it from the card struct.

> +	ret = snd_soc_register_card(card);
> +	if (ret) {
> +		pr_err("snd_soc_register_card failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
> +	if (ret)
> +		return ret;

This should be devm_snd_soc_register_card() and you need to parse the
card name before registering it, otherwise the card might instantiate
before the name is set.

> +static int snd_rk_mc_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
> +
> +	snd_soc_card_set_drvdata(soc_card, NULL);
> +	snd_soc_unregister_card(soc_card);
> +	platform_set_drvdata(pdev, NULL);

No need for any of the _set_drvdata() calls, the core does them and they
shouldn't make any difference anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/26fee2c8/attachment.sig>
