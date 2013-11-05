From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 5 Nov 2013 10:22:51 +0200
Subject: [PATCHv9 38/43] ARM: OMAP2+: PRM: add support for initializing
 PRCM clock modules from DT
In-Reply-To: <52741818.2000507@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <1382716658-6964-39-git-send-email-t-kristo@ti.com> <52741818.2000507@ti.com>
Message-ID: <5278AADB.6010201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2013 11:07 PM, Nishanth Menon wrote:
> On 10/25/2013 10:57 AM, Tero Kristo wrote:
> [...]
>> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
>> index 228b850..6fa74c6 100644
>> --- a/arch/arm/mach-omap2/prm_common.c
>> +++ b/arch/arm/mach-omap2/prm_common.c
>
> [...]
>> +/*
>> + * XXX: implementation for the regmap read/write should be moved to
>> + * individual PRCM IP drivers, once those are available.
>> + */
>> +static int ti_clk_regmap_read(void *context, unsigned int reg,
>> +			      unsigned int *val)
>> +{
>> +	void __iomem *mem = context;
>> +	*val = __raw_readl(mem + reg);
>> +	return 0;
>> +}
>> +
>> +static int ti_clk_regmap_write(void *context, unsigned int reg,
>> +			       unsigned int val)
>> +{
>> +	void __iomem *mem = context;
>> +	__raw_writel(val, mem + reg);
>> +	return 0;
>> +}
>> +
>> +static struct regmap_config ti_clk_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.reg_read = ti_clk_regmap_read,
>> +	.reg_write = ti_clk_regmap_write,
>> +	.fast_io = true,
>> +	.cache_type = REGCACHE_NONE,
>> +	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
>> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
>> +};
>
> why not use regmap_mmio?

I was thinking about using it, however this will allow us to route 
everything to their individual driver APIs. Anyway, I guess that is 
rather moot point so I will look at this again.

-Tero

>
>
> [...]
>
