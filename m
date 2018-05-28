From: david@lechnology.com (David Lechner)
Date: Mon, 28 May 2018 11:54:04 -0500
Subject: [PATCH 9/9] clk: davinci: Fix link errors when not all SoCs are
 enabled
In-Reply-To: <a1b62396-534c-bc68-63a4-ac493690a3e7@ti.com>
References: <20180525181150.17873-1-david@lechnology.com>
 <20180525181150.17873-10-david@lechnology.com>
 <a1b62396-534c-bc68-63a4-ac493690a3e7@ti.com>
Message-ID: <679a6a16-213c-c766-5d82-0c4ce2bdcf75@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2018 08:43 AM, Sekhar Nori wrote:
> On Friday 25 May 2018 11:41 PM, David Lechner wrote:
>> This fixes linker errors due to undefined symbols when one or more of
>> the TI DaVinci SoCs is not enabled in the kernel config.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/clk/davinci/pll.c   | 16 ++++++++++++++++
>>   drivers/clk/davinci/pll.h   | 11 ++++++++---
>>   drivers/clk/davinci/psc.c   | 14 ++++++++++++++
>>   drivers/clk/davinci/psc.h   | 12 ++++++++++++
>>   include/linux/clk/davinci.h | 19 +++++++++++++++----
>>   5 files changed, 65 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
>> index 84a343060bc8..65abd371692d 100644
>> --- a/drivers/clk/davinci/pll.c
>> +++ b/drivers/clk/davinci/pll.c
>> @@ -860,25 +860,41 @@ static struct davinci_pll_platform_data *davinci_pll_get_pdata(struct device *de
>>   }
>>   
>>   /* needed in early boot for clocksource/clockevent */
>> +#ifdef CONFIG_ARCH_DAVINCI_DA850
>>   CLK_OF_DECLARE(da850_pll0, "ti,da850-pll0", of_da850_pll0_init);
>> +#endif
>>   
>>   static const struct of_device_id davinci_pll_of_match[] = {
>> +#ifdef CONFIG_ARCH_DAVINCI_DA850
>>   	{ .compatible = "ti,da850-pll1", .data = of_da850_pll1_init },
>> +#endif
>>   	{ }
>>   };
>>   
>>   static const struct platform_device_id davinci_pll_id_table[] = {
>> +#ifdef CONFIG_ARCH_DAVINCI_DA830
>>   	{ .name = "da830-pll",   .driver_data = (kernel_ulong_t)da830_pll_init   },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DA850
>>   	{ .name = "da850-pll0",  .driver_data = (kernel_ulong_t)da850_pll0_init  },
>>   	{ .name = "da850-pll1",  .driver_data = (kernel_ulong_t)da850_pll1_init  },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM355
>>   	{ .name = "dm355-pll1",  .driver_data = (kernel_ulong_t)dm355_pll1_init  },
>>   	{ .name = "dm355-pll2",  .driver_data = (kernel_ulong_t)dm355_pll2_init  },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM365
>>   	{ .name = "dm365-pll1",  .driver_data = (kernel_ulong_t)dm365_pll1_init  },
>>   	{ .name = "dm365-pll2",  .driver_data = (kernel_ulong_t)dm365_pll2_init  },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM644x
>>   	{ .name = "dm644x-pll1", .driver_data = (kernel_ulong_t)dm644x_pll1_init },
>>   	{ .name = "dm644x-pll2", .driver_data = (kernel_ulong_t)dm644x_pll2_init },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM646x
>>   	{ .name = "dm646x-pll1", .driver_data = (kernel_ulong_t)dm646x_pll1_init },
>>   	{ .name = "dm646x-pll2", .driver_data = (kernel_ulong_t)dm646x_pll2_init },
>> +#endif
>>   	{ }
>>   };
>>   
>> diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
>> index b2e5c4496645..7cc354dd29e2 100644
>> --- a/drivers/clk/davinci/pll.h
>> +++ b/drivers/clk/davinci/pll.h
>> @@ -122,14 +122,19 @@ int of_davinci_pll_init(struct device *dev, struct device_node *node,
>>   
>>   /* Platform-specific callbacks */
>>   
>> +#ifdef CONFIG_ARCH_DAVINCI_DA850
>>   int da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
>>   void of_da850_pll0_init(struct device_node *node);
>>   int of_da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
>> -
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM355
>>   int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
>> -
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM644x
>>   int dm644x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
>> -
>> +#endif
> 
> The traditional way of dealing with this for functions is to provide a
> static inline stub when CONFIG_ARCH_DAVINCI_DM644x is not defined. Can
> we use that? That helps in avoiding ifdefs elsewhere.

I suppose we could. But then we would be taking function pointers to
static inline functions, which seems kind of weird to me.

> 
>> +#ifdef CONFIG_ARCH_DAVINCI_DM646x
>>   int dm646x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
>> +#endif
>>   
>>   #endif /* __CLK_DAVINCI_PLL_H___ */
>> diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
>> index 6326ba1fe3cc..fffbed5e263b 100644
>> --- a/drivers/clk/davinci/psc.c
>> +++ b/drivers/clk/davinci/psc.c
>> @@ -513,20 +513,34 @@ int of_davinci_psc_clk_init(struct device *dev,
>>   }
>>   
>>   static const struct of_device_id davinci_psc_of_match[] = {
>> +#ifdef CONFIG_ARCH_DAVINCI_DA850
>>   	{ .compatible = "ti,da850-psc0", .data = &of_da850_psc0_init_data },
>>   	{ .compatible = "ti,da850-psc1", .data = &of_da850_psc1_init_data },
>> +#endif
>>   	{ }
>>   };
>>   
>>   static const struct platform_device_id davinci_psc_id_table[] = {
>> +#ifdef CONFIG_ARCH_DAVINCI_DA830
>>   	{ .name = "da830-psc0", .driver_data = (kernel_ulong_t)&da830_psc0_init_data },
>>   	{ .name = "da830-psc1", .driver_data = (kernel_ulong_t)&da830_psc1_init_data },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DA850
>>   	{ .name = "da850-psc0", .driver_data = (kernel_ulong_t)&da850_psc0_init_data },
>>   	{ .name = "da850-psc1", .driver_data = (kernel_ulong_t)&da850_psc1_init_data },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM355
>>   	{ .name = "dm355-psc",  .driver_data = (kernel_ulong_t)&dm355_psc_init_data  },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM365
>>   	{ .name = "dm365-psc",  .driver_data = (kernel_ulong_t)&dm365_psc_init_data  },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM644x
>>   	{ .name = "dm644x-psc", .driver_data = (kernel_ulong_t)&dm644x_psc_init_data },
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM646x
>>   	{ .name = "dm646x-psc", .driver_data = (kernel_ulong_t)&dm646x_psc_init_data },
>> +#endif
>>   	{ }
>>   };
>>   
>> diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
>> index c2a7df6413fe..6a42529d31a9 100644
>> --- a/drivers/clk/davinci/psc.h
>> +++ b/drivers/clk/davinci/psc.h
>> @@ -94,15 +94,27 @@ struct davinci_psc_init_data {
>>   	int (*psc_init)(struct device *dev, void __iomem *base);
>>   };
>>   
>> +#ifdef CONFIG_ARCH_DAVINCI_DA830
>>   extern const struct davinci_psc_init_data da830_psc0_init_data;
>>   extern const struct davinci_psc_init_data da830_psc1_init_data;
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DA850
>>   extern const struct davinci_psc_init_data da850_psc0_init_data;
>>   extern const struct davinci_psc_init_data da850_psc1_init_data;
>>   extern const struct davinci_psc_init_data of_da850_psc0_init_data;
>>   extern const struct davinci_psc_init_data of_da850_psc1_init_data;
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM355
>>   extern const struct davinci_psc_init_data dm355_psc_init_data;
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM356
>>   extern const struct davinci_psc_init_data dm365_psc_init_data;
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM644x
>>   extern const struct davinci_psc_init_data dm644x_psc_init_data;
>> +#endif
>> +#ifdef CONFIG_ARCH_DAVINCI_DM646x
>>   extern const struct davinci_psc_init_data dm646x_psc_init_data;
>> +#endif
> 
> ifdefs around these extern declarations are not needed.

True. I guess I just prefer a compiler error to a linker error.
