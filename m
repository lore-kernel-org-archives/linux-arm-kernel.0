From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 22 Jan 2013 13:54:42 +0800
Subject: [PATCH v7 14/15] pinctrl: single: support generic pinconf
In-Reply-To: <20130121171436.GI15361@atomide.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-15-git-send-email-haojian.zhuang@linaro.org>
 <20130121171436.GI15361@atomide.com>
Message-ID: <CAD6h2NTgw4xvaDJfZrw4U3Q=37W5EgqcXaYKTHbzKb-HqbQvgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2013 01:14, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Haojian Zhuang <haojian.zhuang@linaro.org> [130117 23:35]:
>> +static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
>> +                          struct pcs_function *func,
>> +                          struct pinctrl_map **map)
>> +
>> +{
>> +     struct pinctrl_map *m = *map;
>> +     int i = 0, nconfs = 0;
>> +     unsigned long *settings = NULL, *s = NULL;
>> +     struct pcs_conf_vals *conf = NULL;
>> +     struct pcs_conf_type prop2[] = {
>> +             { "pinctrl-single,power-source", PIN_CONFIG_POWER_SOURCE, },
>> +             { "pinctrl-single,slew-rate", PIN_CONFIG_SLEW_RATE, },
>> +             { "pinctrl-single,input-schmitt", PIN_CONFIG_INPUT_SCHMITT, },
>> +     };
>
> The PIN_CONFIG_POWER_SOURCE should be split to PIN_CONFIG_POWER_ENABLE
> and PIN_CONFIG_POWER_SOURCE. If you only have one bit for it, I guess then
> you can just use PIN_CONFIG_POWER_ENABLE and make PIN_CONFIG_POWER_SOURCE
> a NOP.
>

In Hisilicon Hi3620 SoC, 4bits are used for power source. b0000 is
2mA, b0001 is 4mA, .... b1111 is 8mA.
There's no power enable bit. In Marvell silicon, it's also same.

> I also suggest we standardize on PIN_CONFIG_*_ENABLE on the naming instead
> of PIN_CONFIG_*_DISABLE. Many of these features enable some input logic,
> and by default they should be off to save power.
>

In Hisilicon Hi3620 SoC, there's no bias enable or disable bit. They
could only configure pull up or
pull down. We can think that no-pullup and no-pulldown is bias
disable. If we define BIAS_ENABLE,
both pullup & pulldown meet the definition. It's a problem.

>> +     struct pcs_conf_type prop3[] = {
>> +             { "pinctrl-single,bias-disable", PIN_CONFIG_BIAS_DISABLE, },
>> +             { "pinctrl-single,bias-pullup", PIN_CONFIG_BIAS_PULL_UP, },
>> +             { "pinctrl-single,bias-pulldown", PIN_CONFIG_BIAS_PULL_DOWN, },
>> +             { "pinctrl-single,input-schmitt-disable",
>> +                     PIN_CONFIG_INPUT_SCHMITT_DISABLE, },
>> +     };
>
> I'm not aware of cases where we need both INPUT_SCHMITT and INPUT_SCHMITT_DISABLE,
> so we may just want to have INPUT_SCHMITT_ENABLE if that works for you.
>
Because marvell silicon coul configure two input schmitt type (rise
edge or fall edge).

Could we always use DISABLE as our standard? It seems that this
defintion could be compatible
with most silicons.

> Other than that, looks good to me. I'll update my patches here and do
> some tests against my pinctrl-single,bits testcase.
>
> Regards,
>
> Tony

Thanks
Haojian
