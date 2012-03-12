From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Mar 2012 13:51:35 +0100
Subject: [PATCH 3/4] pinctrl: support pinconfig on the U300
In-Reply-To: <4F57E3D2.40405@wwwdotorg.org>
References: <1331071533-24789-1-git-send-email-linus.walleij@stericsson.com>
 <4F57E3D2.40405@wwwdotorg.org>
Message-ID: <CACRpkdbSzU-eXCfzFVmynO_D44PYA4g7dRSvRj+0s6uZxYD+tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 11:40 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/06/2012 03:05 PM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This adds pin configuration support for the U300 driver pair,
>> we can now read out the biasing and drive mode in debugfs and
>> configure it using the new configuration API.
>
>> +int u300_pin_config_set(struct pinctrl_dev *pctldev,
>> + ? ? ? ? ? ? ? ? ? ? unsigned pin,
>> + ? ? ? ? ? ? ? ? ? ? unsigned long config)
>> +{
>> + ? ? struct pinctrl_gpio_range *range = u300_match_gpio_range(pin);
>> + ? ? int ret;
>> +
>> + ? ? if (!range)
>> + ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? /* Note: none of these configurations take any argument */
>> + ? ? ret = u300_gpio_config_set(range->gc,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(pin - range->pin_base + range->base),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?to_config_param(config));
>
> I'm a little confused here; the documentation for most of the
> PIN_CONFIG_* parameters that this function is passed does explicitly
> document that there is an associated argument value. For example,
> IN_CONFIG_BIAS_PULL_UP is coupled with the pull up resistance in Ohms.
> Shouldn't this code extract the argument and validate that it's a
> supported value for the HW?

It says:

 * @PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with high
 *      impedance to VDD), if the controller supports specifying a certain
 *      pull-up resistance, this is given as an argument (in Ohms) when
 *      setting this parameter.

Notice "if controller supports specifying ..." clause.

The reverse holds: if the pin controller doesn't support specifying that,
the pull-up will just be enabled, no matter what the argument was.

But maybe I should try to dig out which exact value it is, since it's
anyway a 1-1 copuling between board data and this one driver it
could be clearer (though the argument will just be checked to be
the one value the chip supports, and then discarded).

Yours,
Linus Walleij
