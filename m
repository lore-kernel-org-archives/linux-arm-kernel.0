From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 15:27:54 -0400
Subject: [PATCH 3/8] clk: keystone: common clk driver initialization
In-Reply-To: <51FFF4D1.9060300@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
 <1375719147-7578-4-git-send-email-santosh.shilimkar@ti.com>
 <51FFF4D1.9060300@ti.com>
Message-ID: <51FFFCBA.4070909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013 02:54 PM, Nishanth Menon wrote:
> On 08/05/2013 11:12 AM, Santosh Shilimkar wrote:
>> Initialise common clock drivers for Keystone 2 devices.
>>
>> Cc: Mike Turquette <mturquette@linaro.org>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   drivers/clk/keystone/clk.c   |   34 ++++++++++++++++++++++++++++++++++
>>   include/linux/clk/keystone.h |    1 +
>>   2 files changed, 35 insertions(+)
>>   create mode 100644 drivers/clk/keystone/clk.c
>>
>> diff --git a/drivers/clk/keystone/clk.c b/drivers/clk/keystone/clk.c
>> new file mode 100644
>> index 0000000..9001380
>> --- /dev/null
>> +++ b/drivers/clk/keystone/clk.c
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Common Clock initialization code for Keystone SOCs
>> + *
>> + * Copyright (C) 2013 Texas Instruments Inc.
>> + *    Murali Karicheri <m-karicheri2@ti.com>
>> + *    Santosh Shilimkar <santosh.shilimkar@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +#include <linux/init.h>
>> +#include <linux/types.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/of.h>
>> +#include <linux/clk/keystone.h>
>> +
>> +static const __initconst struct of_device_id clk_match[] = {
>> +    { .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
>> +    { .compatible = "fixed-factor-clock", .data =
>> +                     of_fixed_factor_clk_setup, },
>> +    { .compatible = "keystone,pll-clk", .data = of_keystone_pll_clk_init, },
>> +    { .compatible = "mux-clk", .data = of_mux_clk_setup, },
>> +    { .compatible = "divider-clock", .data = of_divider_clk_setup, },
>> +    { .compatible = "keystone,psc-clk", .data = of_keystone_psc_clk_init, },
>> +    {}
>> +};
>> +
>> +void __init of_keystone_clk_init()
>> +{
>> +    /* initialize clk providers from device tree */
>> +    of_clk_init(clk_match);
>> +}
>> diff --git a/include/linux/clk/keystone.h b/include/linux/clk/keystone.h
>> index 7b3e154..282e88f 100644
>> --- a/include/linux/clk/keystone.h
>> +++ b/include/linux/clk/keystone.h
>> @@ -15,5 +15,6 @@
>>
>>   extern void of_keystone_pll_clk_init(struct device_node *node);
>>   extern void of_keystone_psc_clk_init(struct device_node *node);
>> +extern void of_keystone_clk_init(void);
>>
>>   #endif /* __LINUX_CLK_KEYSTONE_H_ */
>>
> 
> You can dump the entire file - with of_clk_init(NULL);
> 
> every driver which is registered with CLK_OF_DECLARE() will work, and further, you can even get rid of all the nasty export code, extra headers etc..
> 
of_clk_init(NULL) is indeed good idea and will have a look at it. This should
be actually applicable to many clock drivers as well which I see have the
custom init.

Regarding the nasty export code, this series doesn't rely on any exports except
the dt init functions and if of_clk_init(NULL) takes care of it, I will
drop it.

> See how it was done in the OMAP support[1] - this should simplify much of the code, as well as allow you to share drivers/clk/ti.
> 
Will have a look. Regarding the sharing code, the series actually uses all what
common clock framework support. Only PLL and gate related code is specific and
that is not common with OMAP anyways because IPs are completely different.
When we find a any commonalities, we can actually put them under ti
directory to allow sharing.

Thanks for review.

regards,
Santosh
