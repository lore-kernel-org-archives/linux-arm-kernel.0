From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 08 Sep 2014 06:31:40 -0700
Subject: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
In-Reply-To: <20140908123246.GB26284@lee--X1>
References: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
 <1409841592-18890-6-git-send-email-lee.jones@linaro.org>
 <20140905155811.GA12374@roeck-us.net> <20140908123246.GB26284@lee--X1>
Message-ID: <540DAFBC.1010502@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2014 05:32 AM, Lee Jones wrote:
> On Fri, 05 Sep 2014, Guenter Roeck wrote:
...
>>> +
>>> +static struct st_wdog_syscfg stid127_syscfg = {
>>> +	.type_mask	= BIT(2),
>>> +	.enable_mask	= BIT(2),
>>> +};
>>> +
>>> +static struct st_wdog_syscfg stih415_syscfg = {
>>> +	.type_mask	= BIT(6),
>>> +	.enable_mask	= BIT(7),
>>> +};
>>> +
>>> +static struct st_wdog_syscfg stih416_syscfg = {
>>> +	.type_mask	= BIT(6),
>>> +	.enable_mask	= BIT(7),
>>> +};
>>> +
>>> +static struct st_wdog_syscfg stih407_syscfg = {
>>> +	.enable_mask	= BIT(19),
>>> +};
>>> +
...

>>> +	/* Mask/unmask watchdog reset */
>>> +	regmap_update_bits(st_wdog->syscfg->regmap,
>>> +			   st_wdog->syscfg->enable_reg,
>>> +			   st_wdog->syscfg->enable_mask,
>>> +			   !enable);
>>
>> enable is a bool, but is supposed to provide the value to be put into the
>> register, masked with enable_mask. Unless I am missing something, the value
>> is not shifted in regmap_update_bits. So I don't think this can work, but
>> effectively always writes zero into the mask unless the mask happens to be
>> at bit position 0 - which never happens.
>>
>> Same is true for warm_reset above, which also has values 0 or 1.
>>
>> I know it does not really matter in C (at least when it comes to handling
>> 0 and 1), but I would suggest to avoid mixing booleans with bit masks.
>
> You're right of course, great spot.
>
> How about?
>
>    !enable << ffs(st_wdog->syscfg->enable_mask).
>
Seems to add a lot of complexity (as in 'makes it difficult to understand')
to avoid a conditional, and assumes that enable_mask will never have more
than one bit set. I would go with
	enable ? st_wdog->syscfg->enable_mask : 0
to avoid confusion, but your call.

Guenter
