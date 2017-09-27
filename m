From: joel@jms.id.au (Joel Stanley)
Date: Wed, 27 Sep 2017 16:13:07 +1000
Subject: [PATCH v2 2/5] clk: aspeed: Register core clocks
In-Reply-To: <1506340924.30138.26.camel@aj.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-3-joel@jms.id.au>
 <1506340924.30138.26.camel@aj.id.au>
Message-ID: <CACPK8XcmwypP9HfjKKKYk55589Z0GGSa8mc=Uswzu6Dg01KwLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 10:02 PM, Andrew Jeffery <andrew@aj.id.au> wrote:

>> +static const struct clk_div_table ast2400_div_table[] = {
>> +     { 0x0, 2 },
>> +     { 0x1, 4 },
>> +     { 0x2, 6 },
>> +     { 0x3, 8 },
>> +     { 0x4, 10 },
>> +     { 0x5, 12 },
>> +     { 0x6, 14 },
>> +     { 0x7, 16 },
>> +     { 0 }
>> +};
>> +
>> +static const struct clk_div_table ast2500_div_table[] = {
>> +     { 0x0, 4 },
>> +     { 0x1, 8 },
>> +     { 0x2, 12 },
>> +     { 0x3, 16 },
>> +     { 0x4, 20 },
>> +     { 0x5, 24 },
>> +     { 0x6, 28 },
>> +     { 0x7, 32 },
>> +     { 0 }
>> +};
>
> ast2500_div_table is unused?

In this patch, yeah. It gets used in the next one. I defined it next
to the ast2400_div_table so that it is clear why we need the separate
ones.

>> +static void __init aspeed_ast2400_cc(struct regmap *map)
>> +{
>> +     struct clk_hw *hw;
>> +     u32 val, div, mult;
>> +
>> +     /*
>> +      * High-speed PLL clock derived from the crystal. This the CPU clock,
>> +      * and we assume that it is enabled
>> +      */
>> +     regmap_read(map, ASPEED_HPLL_PARAM, &val);
>> +     WARN(val & BIT(18), "clock is strapped not configured");
>
> I don't quite understand the intent of the warning - are we just trying to say
> that the defaults have been assumed and they may not match reality? It's
> probably not a great idea to not strap the board properly, but you could get
> away with it for a given configuration (Numerator = 20, H-PLL Output Divider
> set, H-PLL denominator = 1)

The vlaue of the PLL can be configured in two different ways; one is
via the strapping registers and the other is configured via the
ASPEED_HPLL_PARAM.

I added this warning as the driver does not support reading the value
of hpll from the strapping.

>
>> +     if (val & BIT(17)) {
>> +             /* Pass through mode */
>> +             mult = div = 1;
>> +     } else {
>> +             /* F = 24Mhz * (2-OD) * [(N + 2) / (D + 1)] */
>> +             u32 n = (val >> 5) & 0x3f;
>> +             u32 od = (val >> 4) & 0x1;
>> +             u32 d = val & 0xf;
>> +
>> +             mult = (2 - od) * (n + 2);
>> +             div = d + 1;
>> +     }
>> +     hw = clk_hw_register_fixed_factor(NULL, "hpll", "clkin", 0, mult, div);
>> +     aspeed_clk_data->hws[ASPEED_CLK_HPLL] = hw;
>> +
>> +     /*
>> +      * Strap bits 11:10 define the CPU/AHB clock frequency ratio (aka HCLK)
>> +      *   00: Select CPU:AHB = 1:1
>> +      *   01: Select CPU:AHB = 2:1
>> +      *   10: Select CPU:AHB = 4:1
>> +      *   11: Select CPU:AHB = 3:1
>> +      */
>> +     regmap_read(map, ASPEED_STRAP, &val);
>> +     val = (val >> 10) & 0x3;
>
> How do the calculations below line up with the comment above? I can't see the
> connection and I feel like I've missed something.
>

The code should read like this:

if (div == 3)
  div = 4;
else if (div == 3)
  div = 4;

Fixed in v3.

>
>> +     hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, div);
>> +     aspeed_clk_data->hws[ASPEED_CLK_AHB] = hw;
>> +
>> +     /* APB clock clock selection register SCU08 (aka PCLK) */
>> +     hw = clk_hw_register_divider_table(NULL, "apb", "hpll", 0,
>> +                     scu_base + ASPEED_CLK_SELECTION, 23, 3, 0,
>> +                     ast2400_div_table,
>> +                     &aspeed_clk_lock);
>> +     aspeed_clk_data->hws[ASPEED_CLK_APB] = hw;
>> +}
>> +
>> +static void __init aspeed_ast2500_cc(struct regmap *map)
>> +{
>> +     struct clk_hw *hw;
>> +     u32 val, div;
>> +
>> +     /*
>> +      * High-speed PLL clock derived from the crystal. This the CPU clock,
>> +      * and we assume that it is enabled
>> +      */
>> +     regmap_read(map, ASPEED_HPLL_PARAM, &val);
>> +     aspeed_clk_data->hws[ASPEED_CLK_HPLL] = aspeed_calc_pll("hpll", val);
>
> Why did you extract the aspeed_calc_pll() implementation for the ast2500 but
> not the ast2400?

It was used more than once for the ast2500, but only once for the
ast2400. That's changed it v3 so I broke it out again.

>> +
>> +     /* Strap bits 11:9 define the AXI/AHB clock frequency ratio (aka HCLK)*/
>> +     regmap_read(map, ASPEED_STRAP, &val);
>> +     val = (val >> 9) & 0x7;
>> +     WARN_ON(val == 0);
>
> Maybe WARN() would be better here to explain what's going wrong (zero is an
> undefined value)?

Done.

>
>> +     div = 2 * (val + 1);
>> +     hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, div);
>> +     aspeed_clk_data->hws[ASPEED_CLK_AHB] = hw;
>> +
>> +     /* APB clock clock selection register SCU08 (aka PCLK) */
>> +     /* TODO: this is wrong! */
>
> Why is this wrong?

I think I must have been looking at the ast2400 data sheet and gotten
confused. It looks good to me. I removed the comment in v3.

>
>> +     regmap_read(map, ASPEED_CLK_SELECTION, &val);
>> +     val = (val >> 23) & 0x7;
>> +     div = 4 * (val + 1);
>> +     hw = clk_hw_register_fixed_factor(NULL, "apb", "hpll", 0, 1, div);
>> +     aspeed_clk_data->hws[ASPEED_CLK_APB] = hw;
>> +};
>> +
>> +
>>  static void __init aspeed_cc_init(struct device_node *np)
>>  {
>>       struct regmap *map;
>> +     unsigned long freq;
>> +     struct clk_hw *hw;
>>       u32 val;
>>       int ret;
>>       int i;
>> @@ -153,6 +284,21 @@ static void __init aspeed_cc_init(struct device_node *np)
>>               return;
>>       }
>>
>> +     /* CLKIN is the crystal oscillator, 24 or 25MHz selected by strapping */
>> +     if (val & BIT(23))
>> +             freq = 25000000;
>> +     else
>> +             freq = 24000000;
>
> This isn't true on the AST2400, where CLKIN could be 24 OR 48MHz when BIT(23) is
> clear. You need to test BIT(18) as well on the AST2400 to disambiguate.

Fixed. I moved the clkin calcs into the soc specific functions.

>
>> +     hw = clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, freq);
>> +     pr_debug("clkin @%lu MHz\n", freq / 1000000);
>> +
>> +     if (of_device_is_compatible(np, "aspeed,ast2400-scu"))
>> +             aspeed_ast2400_cc(map);
>> +     else if (of_device_is_compatible(np, "aspeed,ast2500-scu"))
>> +             aspeed_ast2500_cc(map);
>> +     else
>> +             pr_err("unknown platform, failed to add clocks\n");
>
> I'm not confident that "borrowing" the SCU compatible like this is entirely in
> the spirit of its MFD nature, but maybe others can chime in.
