From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 2 Nov 2012 09:53:52 -0400
Subject: [PATCH v3 04/11] clk: davinci - add pll divider clock driver
In-Reply-To: <5093AF8A.8000707@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-5-git-send-email-m-karicheri2@ti.com>
 <5093AF8A.8000707@ti.com>
Message-ID: <5093D070.7060900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2012 07:33 AM, Sekhar Nori wrote:
> On 10/25/2012 9:41 PM, Murali Karicheri wrote:
>
>> pll dividers are present in the pll controller of DaVinci and Other
>> SoCs that re-uses the same hardware IP. This has a enable bit for
>> bypass the divider or enable the driver. This is a sub class of the
>> clk-divider clock checks the enable bit to calculare the rate and
>> invoke the recalculate() function of the clk-divider if enabled.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>   drivers/clk/davinci/clk-div.c |  124 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/davinci/clk-div.h |   42 ++++++++++++++
>>   2 files changed, 166 insertions(+)
>>   create mode 100644 drivers/clk/davinci/clk-div.c
>>   create mode 100644 drivers/clk/davinci/clk-div.h
>>
>> diff --git a/drivers/clk/davinci/clk-div.c b/drivers/clk/davinci/clk-div.c
>> new file mode 100644
>> index 0000000..8147d99
>> --- /dev/null
>> +++ b/drivers/clk/davinci/clk-div.c
>> @@ -0,0 +1,124 @@
>> +/*
>> + * Copyright 2012 Freescale Semiconductor, Inc.
>> + * Copyright 2012 Texas instuments
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
> incomplete sentence.
Will fix
>
>> +/**
>> + * clk_register_davinci_plldiv - register function for DaVinci PLL divider clk
>> + *
>> + * @dev: device ptr
>> + * @name: name of the clock
>> + * @parent_name: name of parent clock
>> + * @plldiv_data: ptr to pll divider data
>> + * @lock: ptr to spinlock passed to divider clock
>> + */
>> +struct clk *clk_register_davinci_plldiv(struct device *dev,
> Why do you need a dev pointer here and which device does it point to? In
> the only usage of this API in the series, you pass a NULL here. I should
> have probably asked this question on one of the earlier patches itself.
>
I did a grep in the drivers/clk directory. All of the platform drivers 
are having the device ptr and all of them are called with NULL. I am not 
sure what is the intent of this arg in the API.  As per documentation of 
the clk_register() API, the device ptr points to the device that is 
registering this clk. So if a specific device driver ever has to 
register a PLL div clk, this will be non NULL. In  the normal use case, 
clk is registered in a platform specific code and is always passed NULL.

The platform/SoC specific clock initialization code will be using 
davinci_plldiv_clk() that doesn't have a device ptr arg.
So this can be changed in future in sync with other drivers (assuming 
this will get removed if unused), and changes
doesn't impact the platform code that initialize the clock. So IMO, we 
should keep this arg so that it is in sync with other driver APIs.

+			const char *name, const char *parent_name,
+			struct clk_plldiv_data *plldiv_data,
+			spinlock_t *lock)
+{
+	struct clk_div *div;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_div_ops;
+	init.flags = plldiv_data->flags;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	div->reg = plldiv_data->reg;
+	div->en_id = plldiv_data->en_id;
+
+	div->divider.reg = plldiv_data->reg;
+	div->divider.shift = plldiv_data->shift;
+	div->divider.width = plldiv_data->width;
+	div->divider.flags = plldiv_data->divider_flags;
+	div->divider.lock = lock;
+	div->divider.hw.init = &init;
+	div->ops = &clk_divider_ops;
+
+	clk = clk_register(NULL, &div->divider.hw);

> Shouldn't you be calling clk_register_divider() here which in turn will
> do clk_register()?
As stated in the top of the file, this is a subclass driver of clk-div 
similar in line with mxs/clk-div.c. The
driver registers the clock instead of calling clk_register_divider() so 
that it's ops function has a chance to do whatever it wants to do and 
call the divider ops function after that.

Murali
> Thanks,
> Sekhar
>
>
