From: r.sh.open@gmail.com (Rahul Sharma)
Date: Mon, 6 Jan 2014 17:05:26 +0530
Subject: [PATCH 4/7] clk/samsung: add support for multuple clock providers
In-Reply-To: <11276764.MQ2Wg9nEER@amdc1227>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-5-git-send-email-rahul.sharma@samsung.com>
 <11276764.MQ2Wg9nEER@amdc1227>
Message-ID: <CAPdUM4M9XkB14y=c29WzX93VysWhZTzFkCKXpkmXtFv1CB2OvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 11 December 2013 16:45, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Rahul,
>
> Please see my comments inline.
>
> On Friday 06 of December 2013 21:26:28 Rahul Sharma wrote:
>> Samsung CCF helper functions do not provide support to
>> register multiple Clock Providers for a given SoC. Due to
>> this limitation SoC platforms are not able to use these
>> helpers for registering mulitple clock providers and are
>> forced to bypass this layer.
>>
>> This layer is modified acordingly to enable the support.
>>
>> Clockfile for exynos4, exynos5250, exynos5420, exynos5440
>> and S3c64xx are also modified as per changed helper functions.
> [snip]
>> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
>> index 91bec3e..20de446 100644
>> --- a/drivers/clk/samsung/clk.c
>> +++ b/drivers/clk/samsung/clk.c
>> @@ -15,11 +15,6 @@
>>  #include "clk.h"
>>
>>  static DEFINE_SPINLOCK(lock);
>
> IMHO you can also move the spinlock into samsung_clk_provider struct, to
> have more fine grained locking, as you shouldn't need to lock between
> particular providers, just multiple requests for one.
>
Done.

>> -static struct clk **clk_table;
>> -static void __iomem *reg_base;
>> -#ifdef CONFIG_OF
>> -static struct clk_onecell_data clk_data;
>> -#endif
>>
>>  void samsung_clk_save(void __iomem *base,
>>                                   struct samsung_clk_reg_dump *rd,
>> @@ -55,40 +50,53 @@ struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
>>  }
>>
>>  /* setup the essentials required to support clock lookup using ccf */
>> -void __init samsung_clk_init(struct device_node *np, void __iomem *base,
>> -                          unsigned long nr_clks)
>> +struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
>> +                     void __iomem *base, unsigned long nr_clks)
>>  {
>> -     reg_base = base;
>> +     struct samsung_clk_provider *ctx;
>> +     struct clk **clk_table;
>> +     int ret;
>> +
>> +     if (!np)
>> +             return NULL;
>
> This check is incorrect. It's completely correct to call this function
> with NULL np, when booted without DT and this was handled correctly
> before this patch. Please keep the same behavior.
>

Done.

>> +
>> +     ctx = kzalloc(sizeof(struct samsung_clk_provider), GFP_KERNEL);
>> +     if (!ctx)
>> +             panic("could not allocate clock provider context.\n");
>>
>>       clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
>>       if (!clk_table)
>>               panic("could not allocate clock lookup table\n");
>>
>> -     if (!np)
>> -             return;
>> +     ctx->reg_base = base;
>> +     ctx->clk_data.clks = clk_table;
>> +     ctx->clk_data.clk_num = nr_clks;
>>
>> -#ifdef CONFIG_OF
>> -     clk_data.clks = clk_table;
>> -     clk_data.clk_num = nr_clks;
>> -     of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>> -#endif
>> +     ret = of_clk_add_provider(np, of_clk_src_onecell_get,
>> +                     &ctx->clk_data);
>> +     if (ret)
>> +             panic("could not register clock provide\n");
>> +
>> +     return ctx;
>>  }
> [snip]
>> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
>> index c7141ba..433bab3 100644
>> --- a/drivers/clk/samsung/clk.h
>> +++ b/drivers/clk/samsung/clk.h
>> @@ -21,6 +21,17 @@
>>  #include <linux/of_address.h>
>>  #include "clk-pll.h"
>>
>> +/* Context node which holds information about the clock provider. */
>> +/**
>> + * struct samsung_clk_provider: information about clock plovider
>
> typo: s/plovider/provider/

Ok.
>
>> + * @reg_base: virtual address for the register base.
>> + * @clk_data: holds clock related data like clk* and number of clocks.
>> + */
>
> Why two comments? The kerneldoc one should be enough.
>
>> +struct samsung_clk_provider {
>> +     void __iomem *reg_base;
>> +     struct clk_onecell_data clk_data;
>> +};
>> +
>>  /**
>>   * struct samsung_clock_alias: information about mux clock
>>   * @id: platform specific id of the clock.
>> @@ -312,29 +323,40 @@ struct samsung_pll_clock {
>>       __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,     \
>>               _lock, _con, _rtable, _alias)
>>
>> -extern void __init samsung_clk_init(struct device_node *np, void __iomem *base,
>> -                                 unsigned long nr_clks);
>> +extern struct samsung_clk_provider *__init samsung_clk_init(
>> +                     struct device_node *np, void __iomem *base,
>> +                     unsigned long nr_clks);
>>  extern void __init samsung_clk_of_register_fixed_ext(
>> +             struct samsung_clk_provider *ctx,
>>               struct samsung_fixed_rate_clock *fixed_rate_clk,
>>               unsigned int nr_fixed_rate_clk,
>>               struct of_device_id *clk_matches);
>>
>> -extern void samsung_clk_add_lookup(struct clk *clk, unsigned int id);
>> +extern void samsung_clk_add_lookup(struct samsung_clk_provider *ctx,
>> +                     struct clk *clk, unsigned int id);
>>
>> -extern void samsung_clk_register_alias(struct samsung_clock_alias *list,
>> -             unsigned int nr_clk);
>> +extern void samsung_clk_register_alias(struct samsung_clk_provider *ctx,
>> +                     struct samsung_clock_alias *list,
>> +                     unsigned int nr_clk);
>>  extern void __init samsung_clk_register_fixed_rate(
>> -             struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk);
>> +                     struct samsung_clk_provider *ctx,
>> +                     struct samsung_fixed_rate_clock *clk_list,
>> +                     unsigned int nr_clk);
>>  extern void __init samsung_clk_register_fixed_factor(
>> -             struct samsung_fixed_factor_clock *list, unsigned int nr_clk);
>> -extern void __init samsung_clk_register_mux(struct samsung_mux_clock *clk_list,
>> +                     struct samsung_clk_provider *ctx,
>> +                     struct samsung_fixed_factor_clock *list,
>> +                     unsigned int nr_clk);
>> +extern void __init samsung_clk_register_mux(struct samsung_clk_provider *ctx,
>> +             struct samsung_mux_clock *clk_list,
>>               unsigned int nr_clk);
>> -extern void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
>> +extern void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
>> +             struct samsung_div_clock *clk_list,
>>               unsigned int nr_clk);
>> -extern void __init samsung_clk_register_gate(
>> +extern void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
>>               struct samsung_gate_clock *clk_list, unsigned int nr_clk);
>> -extern void __init samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
>> -             unsigned int nr_clk, void __iomem *base);
>> +extern void __init samsung_clk_register_pll(struct samsung_clk_provider *ctx,
>> +                     struct samsung_pll_clock *pll_list,
>> +                     unsigned int nr_clk, void __iomem *base);
>>
>>  extern unsigned long _get_rate(const char *clk_name);
>>
>
> nit: Please keep the indentation consistent in all the function prototypes
> above.

ok.

regards,
Rahul Sharma.

>
> Best regards,
> Tomasz
>
