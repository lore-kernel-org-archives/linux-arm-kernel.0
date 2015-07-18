From: zhengxing@rock-chips.com (zhengxing)
Date: Sat, 18 Jul 2015 11:51:24 +0800
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <20150717180402.GS11162@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <20150717180402.GS11162@sirena.org.uk>
Message-ID: <55A9CD3C.10300@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?07?18? 02:04, Mark Brown wrote:
> On Wed, Jul 15, 2015 at 11:15:42AM +0800, Xing Zheng wrote:
>
> This looks pretty good, a couple of minor points below which should be
> quick to fix.
>
>> +static int rk_init(struct snd_soc_pcm_runtime *runtime)
>> +{
>> +	struct snd_soc_card *card = runtime->card;
>> +
>> +	card->dapm.idle_bias_off = true;
> You shouldn't need to do this?  If you do need to do it we should make
> it possible to do it from the card struct.
Done, we don't need it in the machine driver.
>> +	ret = snd_soc_register_card(card);
>> +	if (ret) {
>> +		pr_err("snd_soc_register_card failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
>> +	if (ret)
>> +		return ret;
> This should be devm_snd_soc_register_card() and you need to parse the
> card name before registering it, otherwise the card might instantiate
> before the name is set.
Done.
>> +static int snd_rk_mc_remove(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
>> +
>> +	snd_soc_card_set_drvdata(soc_card, NULL);
>> +	snd_soc_unregister_card(soc_card);
>> +	platform_set_drvdata(pdev, NULL);
> No need for any of the _set_drvdata() calls, the core does them and they
> shouldn't make any difference anyway.
Done. I will remove *_set_drvdata and *get_drvdata because we don't need 
them any more.

Thanks.
