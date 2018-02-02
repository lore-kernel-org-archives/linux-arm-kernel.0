From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 13:53:04 +0530
Subject: [PATCH v6 04/41] clk: davinci: Add platform information for TI
 DA850 PLL
In-Reply-To: <6f0146e4-72bc-7bc2-2135-44950949cd77@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-5-git-send-email-david@lechnology.com>
 <834cb7ce-9406-a806-3ec1-a59766bd8a9d@ti.com>
 <6f0146e4-72bc-7bc2-2135-44950949cd77@lechnology.com>
Message-ID: <fea42265-9afd-5c85-2c92-a01f5cb77013@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 February 2018 12:34 AM, David Lechner wrote:
> On 02/01/2018 02:58 AM, Sekhar Nori wrote:
>> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>>> This adds platform-specific declarations for the PLL clocks on TI DA850/
>>> OMAP-L138/AM18XX SoCs.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>>> +static const struct davinci_pll_clk_info da850_pll1_info __initconst
>>> = {
>>> +??? .name = "pll1",
>>> +??? .unlock_reg = CFGCHIP(3),
>>> +??? .unlock_mask = CFGCHIP3_PLL1_MASTER_LOCK,
>>
>> I guess this will change with the cfgchip handling discussion last week.
> 
> Actually no, there really weren't any changes to the clock drivers because
> of this change. Only a small change in mach-davinci.
> 
>>
>>> +??? .pllm_mask = GENMASK(4, 0),
>>> +??? .pllm_min = 4,
>>> +??? .pllm_max = 32,
>>> +??? .pllout_min_rate = 300000000,
>>> +??? .pllout_max_rate = 600000000,
>>> +??? .flags = PLL_HAS_POSTDIV,
>>> +};
>>> +
>>
>> [...]
>>
>>> +void __init da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1)
>>> +{
>>> +??? const struct davinci_pll_sysclk_info *info;
>>> +
>>> +??? davinci_pll_clk_register(&da850_pll0_info, "ref_clk", pll0);
>>> +
>>> +??? davinci_pll_auxclk_register("pll0_auxclk", pll0);
>>> +
>>> +??? for (info = da850_pll0_sysclk_info; info->name; info++)
>>> +??????? davinci_pll_sysclk_register(info, pll0);
>>> +
>>> +??? davinci_pll_obsclk_register(&da850_pll0_obsclk_info, pll0);
>>> +
>>> +??? davinci_pll_clk_register(&da850_pll1_info, "oscin", pll1);
>>
>> Both PLL0 and PLL1 use the same reference clock. So this should be
>> "ref_clk". I dont think we ever need to register a clock called oscin
>> along with "ref_clk". There is only one reference clock. It can either
>> be obtained using internal oscillator or external oscillator.
>>
> 
> As per my response to the previous path, this depends on which both
> which SoC and which diagram in the TRM for that SoC you are looking at.
> It works either way.

I see the distinction you are making between clock inputs to the two
PLLs now. A comment somewhere (probably in pll.c) should do it.

Thanks,
Sekhar
