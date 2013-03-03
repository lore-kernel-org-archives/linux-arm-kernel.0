From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun, 03 Mar 2013 13:48:12 +0100
Subject: [PATCH v6 01/16] clk: samsung: add common clock framework helper
 functions for Samsung platforms
In-Reply-To: <201303031309.01118.heiko@sntech.de>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <51333149.1060105@gmail.com> <2984153.Xctncej7hL@flatron>
 <201303031309.01118.heiko@sntech.de>
Message-ID: <5133468C.4010001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2013 01:08 PM, Heiko St?bner wrote:
> Am Sonntag, 3. M?rz 2013, 12:45:01 schrieb Tomasz Figa:
>> On Sunday 03 of March 2013 12:17:29 Sylwester Nawrocki wrote:
>>> On 03/03/2013 02:08 AM, Heiko St?bner wrote:
>>>> But is there an easy way to define more than one alias? On the s3c2416
>>>> for example the hsmmc hclk is the "hsmmc" io-clock, as well as the
>>>> source for the "mmc_busclk.0". Same for the "uart" pclk, that is also
>>>> a baud clock source.
>>>
>>> This driver currently provides for only one additional clkdev lookup
>>> entry per a platform clock. I pointed out this desing issue in the
>>> early version of the patch set. It's because a machine clock definition
>>> is coupled with a clock consumer definition. And IMO various
>>> samsung_clock_register_* functions should not have
>>> clk_register_clkdev() inside them. I.e. first step could be registering
>>> all machine clocks and in the second one clkdev lookup entries could be
>>> created. This is how most (all?) existing SoC clock drivers are
>>> working.
>>>
>>> But those multiple aliases are important only for machines with device
>>> tree support, aren't they ?
>>
>> I suppose you meant _without_ device tree support, right?

Yes, my mistake, sorry for the confusion.

> The aliases are only needed for the non-dt case. But as I think common clk
> support will be a requirement for dt support in the future, similar to
> pinctrl, without the correct handling of the aliases it will be hard to
> incrementally convert the other platforms (i.e. s3c24xx before s3c2443, etc).

Yes, indeed. That's a very valid point to have the handling of the aliases
implemented correctly, not assuming it will be needed temporarily only.

> For the time being I've added my own register_alias function to Thomas' core
> code, hijacking the clk_table for this - attached for reference below.

The patch looks good to me. It would make sense to handle all clkdev
entries like this.

>>> I hope this patch series gets merged early to linux-next in the 3.10
>>> cycle so the multiple accumulated fixup patches for this clock driver
>>> can be merged as well and issues like that you pointed out can be
>>> resolved with incremental patches.
>>
>> Yes, I hope so too.
>
> me too. Following all this still out-of-tree stuff makes me dizzy :-)

Yeah, especially that it is not always clear what tag the patch series
are based of off. For a long patch series like these, touching the core
subsystems, it would be nice to have a corresponding git tree so it is
possible to actually use and test the patches without much trouble.

> Heiko
>
>
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index d36cdd5..7f1b5bc 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -57,14 +57,15 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
>   		unsigned long nr_rdump)
>   {
>   	reg_base = base;
> -	if (!np)
> -		return;
>
> -#ifdef CONFIG_OF
>   	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
>   	if (!clk_table)
>   		panic("could not allocate clock lookup table\n");
>
> +	if (!np)
> +		return;
> +
> +#ifdef CONFIG_OF
>   	clk_data.clks = clk_table;
>   	clk_data.clk_num = nr_clks;
>   	of_clk_add_provider(np, of_clk_src_onecell_get,&clk_data);
> @@ -96,6 +97,46 @@ void samsung_clk_add_lookup(struct clk *clk, unsigned int id)
>   		clk_table[id] = clk;
>   }
>
> +/* register a list of aliases */
> +void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
> +					unsigned int nr_clk)
> +{
> +	struct clk *clk;
> +	unsigned int idx, ret;
> +
> +	if (!clk_table) {
> +		pr_err("%s: clock table missing\n", __func__);
> +		return;
> +	}
> +
> +	for (idx = 0; idx<  nr_clk; idx++, list++) {
> +		if (!list->id) {
> +			pr_err("%s: clock id missing for index %d\n", __func__,
> +				idx);
> +			continue;
> +		}
> +
> +		clk = clk_table[list->id];
> +		if (!clk) {
> +			pr_err("%s: failed to find clock %d\n", __func__,
> +				list->id);
> +			continue;
> +		}
> +
> +		/* register a clock lookup only if a clock alias is specified */
> +		if (!list->alias) {
> +			pr_err("%s: no alias defined for clock %d\n", __func__,
> +			       list->id);

I wouldn't print that error in general. It might be a clock with NULL 
conn_id.
It's not an error condition.

> +			continue;
> +		}
> +
> +		ret = clk_register_clkdev(clk, list->alias, list->dev_name);
> +		if (ret)
> +			pr_err("%s: failed to register lookup %s\n",
> +					__func__, list->alias);
> +	}
> +}
> +
>   /* register a list of fixed clocks */
>   void __init samsung_clk_register_fixed_rate(
>   		struct samsung_fixed_rate_clock *list, unsigned int nr_clk)
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index 175a9d0..8be9248 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -23,6 +23,25 @@
>   #include<mach/map.h>
>
>   /**
> + * struct samsung_clock_alias: information about mux clock
> + * @id: platform specific id of the clock.
> + * @dev_name: name of the device to which this clock belongs.
> + * @alias: optional clock alias name to be assigned to this clock.
> + */
> +struct samsung_clock_alias {
> +	unsigned int		id;
> +	const char		*dev_name;
> +	const char		*alias;
> +};
> +
> +#define ALIAS(_id, dname, a)	\
> +	{							\
> +		.id		= _id,				\
> +		.dev_name	= dname,			\
> +		.alias		= a,				\
> +	}
> +
> +/**
>    * struct samsung_fixed_rate_clock: information about fixed-rate clock
>    * @id: platform specific id of the clock.
>    * @name: name of this fixed-rate clock.
> @@ -260,6 +282,8 @@ extern void __init samsung_clk_of_register_fixed_ext(
>
>   extern void samsung_clk_add_lookup(struct clk *clk, unsigned int id);
>
> +extern void samsung_clk_register_alias(struct samsung_clock_alias *list,
> +		unsigned int nr_clk);
>   extern void __init samsung_clk_register_fixed_rate(
>   		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk);
>   extern void __init samsung_clk_register_fixed_factor(
