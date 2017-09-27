From: joel@jms.id.au (Joel Stanley)
Date: Wed, 27 Sep 2017 16:13:30 +1000
Subject: [PATCH v2 3/5] clk: aspeed: Add platform driver and register PLLs
In-Reply-To: <1506343255.30138.29.camel@aj.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-4-joel@jms.id.au>
 <1506343255.30138.29.camel@aj.id.au>
Message-ID: <CACPK8Xd8RQ4s1xMsSuxHgQRiHS6vDtxVTAxu8Ba3J3it45MC5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 10:40 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Thu, 2017-09-21 at 13:56 +0930, Joel Stanley wrote:

>> +     /*
>> +      * Memory controller (M-PLL) PLL. This clock is configured by the
>> +      * bootloader, and is exposed to Linux as a read-only clock rate.
>> +      */
>> +     regmap_read(map, ASPEED_MPLL_PARAM, &val);
>> +     aspeed_clk_data->hws[ASPEED_CLK_MPLL] = aspeed_calc_pll("mpll", val);
>
> IIRC the calculation in aspeed_calc_pll() is appropriate for the AST2500, but
> not the AST2400.

Ah ha. I knew there was a reason why I created an ast2400_calc_pll. I
will add it back in in the previous patch so we can use it here.

>> +     /* Video Engine (ECLK) mux and clock divider */
>> +     hw = clk_hw_register_mux(NULL, "eclk_mux",
>> +                     eclk_parents, ARRAY_SIZE(eclk_parents), 0,
>> +                     scu_base + ASPEED_CLK_SELECTION, 2, 2,
>> +                     0, &aspeed_clk_lock);
>> +     aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
>> +     hw = clk_hw_register_divider_table(NULL, "eclk", "eclk_mux", 0,
>> +                     scu_base + ASPEED_CLK_SELECTION, 20, 3, 0,
>
> On the AST2500 it looks like this should start at bit 28 for 3 bits, not bit

Good catch. Fixed in v3.

> 20. Separately, I'm not sure how to interpret the AST2400 datasheet here -
> maybe it's similar but with different wording ("clock slow down" rather than
> "divisor"?).
>
>> +                     div_table,
>
> This doesn't seem to be correct. There's the problem of 0b000 and 0b001 mapping
> the same value of 2 for the AST2500, whose table then increments in steps of 1.
> The AST2400 mapping on the otherhand is multiples of 2 starting at 2, with no
> inconsistency for 0b000 vs 0b001.

Yep, we do use a different table for ast2400 vs ast2500. See
ast2400_div_table vs ast2500_div_table.

>
>> +                     &aspeed_clk_lock);
>> +     aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
>> +
>> +     /* P-Bus (BCLK) clock divider */
>> +     hw = clk_hw_register_divider_table(NULL, "bclk", "hpll", 0,
>> +                     scu_base + ASPEED_CLK_SELECTION, 0, 2, 0,
>
> Bit 0 in SCU08 is a 1-bit field "CPU/AHB clock dynamic slow down enable". BCLK
> is actually in SCU*D*8, but (perhaps confusingly) documented immediately below
> SCU*0*8.

Good catch. Fixed in v3.

Cheers,

Joel
