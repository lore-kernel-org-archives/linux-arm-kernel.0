From: xjq@rock-chips.com (Jianqun)
Date: Thu, 02 Oct 2014 16:06:37 +0800
Subject: [PATCH] ASoC: rockchip-max98090: add driver for rockchip board
 using a max98090
In-Reply-To: <20140912135247.GU7960@sirena.org.uk>
References: <1410506806-15327-1-git-send-email-jay.xu@rock-chips.com>
 <1410507588-15719-1-git-send-email-jay.xu@rock-chips.com>
 <20140912135247.GU7960@sirena.org.uk>
Message-ID: <542D078D.2000103@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark:

I'm still try to use simple-card driver but it hasn't do work from now on,
could I to update rockchip-max98090.c at the same time ?

? 09/12/2014 09:52 PM, Mark Brown ??:
> On Fri, Sep 12, 2014 at 03:39:48PM +0800, Jianqun wrote:
>
>> +#define RK_PLAT_CLK_12M      12000000
> I'm not sure a define is adding anything here...  it's just a define
> saying 12MHz that has the value 12MHz.
>
Okay
>> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>> +
>> +/* Set max98090 as master, i2s clock output 12MHz for max98090 */
>> +	ret = snd_soc_dai_set_sysclk(cpu_dai, 0,
> Coding style, comments aren't aligned with the code.
Okay
>
>> +	ret = snd_soc_add_card_controls(card, rk_mc_controls,
>> +					ARRAY_SIZE(rk_mc_controls));
>> +	if (ret) {
>> +		pr_err("unable to add card controls\n");
>> +		return ret;
>> +	}
> Use card->controls.
Okay
>
>> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
>> +	snd_soc_dapm_enable_pin(dapm, "Headphone");
>> +	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
>> +	snd_soc_dapm_enable_pin(dapm, "Int Mic");
>> +
>> +	snd_soc_dapm_sync(dapm);
> All pins are enabled by default and sync doesn't do anything during
> init.
okay, will to remove sync in next version
>> +#ifdef CONFIG_PM_SLEEP
>> +static int snd_rk_prepare(struct device *dev)
>> +{
>> +	struct snd_soc_card *card = dev_get_drvdata(dev);
>> +	struct rk_mc_private *drv = snd_soc_card_get_drvdata(card);
>> +
>> +	snd_soc_jack_free_gpios(&drv->hp_jack, 1, &hp_jack_gpio);
>> +	snd_soc_jack_free_gpios(&drv->mic_jack, 1, &mic_jack_gpio);
>> +
>> +	return snd_soc_suspend(dev);
>> +}
> Why are you freeing the GPIOs over suspend, that doesn't seem good?
Okay , will to remove them in next version
>
>> +	hp_jack_gpio.gpio = of_get_named_gpio(np, "rockchip,hp-det-gpios", 0);
>> +	if (hp_jack_gpio.gpio == -EPROBE_DEFER)
>> +		return -EPROBE_DEFER;
>> +
>> +	mic_jack_gpio.gpio = of_get_named_gpio(np, "rockchip,mic-det-gpios", 0);
>> +	if (mic_jack_gpio.gpio == -EPROBE_DEFER)
>> +		return -EPROBE_DEFER;
> This ignores errors other than probe deferral but the init code assumed
> that these would've succeeded.  Either the init code should handle
> failure or all errors should be treated as fatal.
dev_warn will be ok ?
>> +	platform_set_drvdata(pdev, &card);
>> +
>> +	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
>> +	if (ret)
>> +		return ret;
> These need to happen before we register the card since they could be
> used as soon as we probe.
okay
>> +	snd_soc_card_set_drvdata(soc_card, NULL);
> No need to clear driver data, the core will do it anyway and anything
> relying on pre-set driver data is broken.

okay

-- 
Jianqun Xu

****************************************************************************
*IMPORTANT NOTICE:*This email is from Fuzhou Rockchip Electronics Co.,
Ltd .The contents of this email and any attachments may contain
information that is privileged, confidential and/or exempt from
disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution, or use of the information is STRICTLY PROHIBITED.
Please immediately contact the sender as soon as possible and destroy
the material in its entirety in any format. Thank you.
****************************************************************************
