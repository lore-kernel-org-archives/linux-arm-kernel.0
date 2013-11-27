From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 27 Nov 2013 11:08:46 +0200
Subject: [PATCHv10 31/41] ARM: OMAP2+: clock: add support for regmap
In-Reply-To: <20131126174045.GE26766@atomide.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-32-git-send-email-t-kristo@ti.com>
 <20131126174045.GE26766@atomide.com>
Message-ID: <5295B69E.3080806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 07:40 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [131126 00:10]:
>> Using regmap is required for isolating the actual memory access from
>> the clock code. Now, the driver providing the support for the clock IP
>> block can provide a regmap for this purpose.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/clock.c |   27 ++++++++++++++++++++++++++-
>>   arch/arm/mach-omap2/clock.h |    3 +++
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
>> index 238be3f..1ef6df8 100644
>> --- a/arch/arm/mach-omap2/clock.c
>> +++ b/arch/arm/mach-omap2/clock.c
>> @@ -25,7 +25,7 @@
>>   #include <linux/bitops.h>
>>   #include <linux/clk-private.h>
>>   #include <asm/cpu.h>
>> -
>> +#include <linux/regmap.h>
>>
>>   #include <trace/events/power.h>
>>
>> @@ -56,6 +56,31 @@ u16 cpu_mask;
>>   static bool clkdm_control = true;
>>
>>   static LIST_HEAD(clk_hw_omap_clocks);
>> +struct regmap *clk_regmaps[CLK_MAX_REGMAPS];
>> +
>> +void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
>> +{
>> +	if (clk->flags & REGMAP_ADDRESSING) {
>> +		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
>> +		regmap_write(clk_regmaps[r->index], r->offset, val);
>> +	} else {
>> +		__raw_writel(val, reg);
>> +	}
>> +}
>> +
>> +u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
>> +{
>> +	u32 val;
>> +
>> +	if (clk->flags & REGMAP_ADDRESSING) {
>> +		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
>> +		regmap_read(clk_regmaps[r->index], r->offset, &val);
>> +	} else {
>> +		val = __raw_readl(reg);
>> +	}
>> +
>> +	return val;
>> +}
>>
>>   /*
>>    * Used for clocks that have the same value as the parent clock,
>
> Maybe use read[lw]_relaxed and write[lw]_relaxed here and elsewhere
> instead of __raw_read/write to help cut down the changes needed for
> the big endian patch set?

Well, this is the only place where we have a call to __raw_readl / 
__raw_writel in this patch set, the next patch actually removes all 
these calls from mach-omap2. But yes, I can change this.

-Tero
