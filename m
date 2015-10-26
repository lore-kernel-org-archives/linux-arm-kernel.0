From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 26 Oct 2015 10:59:56 +0800
Subject: [PATCH] clk: atlas7: merge lots of discrete clocks into arrays
In-Reply-To: <20151022121700.20687.9552@quantum>
References: <1444377931-5178-1-git-send-email-21cnbao@gmail.com>
 <20151022121700.20687.9552@quantum>
Message-ID: <CAGsJ_4yHQmhJZb5Y2g=9VHtYGzRV5jx7FsLo_ApOXRRPSGpC5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-22 20:17 GMT+08:00 Michael Turquette <mturquette@baylibre.com>:
> Hello Barry,
>
> Quoting Barry Song (2015-10-09 01:05:31)
>> From: Guo Zeng <Guo.Zeng@csr.com>
>>
>> this patch merges lots of discrete dividers, divider tables and dto
>> into arrays, then drops lots of codes.
>>
>> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/clk/sirf/clk-atlas7.c | 211 ++++++++++--------------------------------
>>  1 file changed, 47 insertions(+), 164 deletions(-)
>
> Seems like a nice change with a nice diffstat.
>
>> @@ -719,6 +727,24 @@ static struct atlas7_div_init_data divider_list[] __initdata = {
>>         { "sys2pll_qa20", "sys2pll_fixdiv", "sys2pll_a20", 0, 0, 0, SIRFSOC_CLKC_SHARED_DIVIDER_CFG0, 0, 6, SIRFSOC_CLKC_SHARED_DIVIDER_ENA, 0, &share_div_lock },
>>         { "sys1pll_qa17", "sys1pll_fixdiv", "sys1pll_a17", 0, 0, CLK_IGNORE_UNUSED, SIRFSOC_CLKC_SHARED_DIVIDER_CFG1, 8, 6, SIRFSOC_CLKC_SHARED_DIVIDER_ENA, 20, &share_div_lock },
>>         { "sys0pll_qa20", "sys0pll_fixdiv", "sys0pll_a20", 0, 0, 0, SIRFSOC_CLKC_SHARED_DIVIDER_CFG1, 0, 6, SIRFSOC_CLKC_SHARED_DIVIDER_ENA, 16, &share_div_lock },
>> +       { "sys0pll_div1", "sys0pll_vco", "sys0pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 12, &sys0pll_ctrl1_lock },
>> +       { "sys0pll_div2", "sys0pll_vco", "sys0pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 13, &sys0pll_ctrl1_lock },
>> +       { "sys0pll_div3", "sys0pll_vco", "sys0pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS0PLL_AB_CTRL1, 14, &sys0pll_ctrl1_lock },
>> +       { "sys1pll_div1", "sys1pll_vco", "sys1pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 12, &sys1pll_ctrl1_lock },
>> +       { "sys1pll_div2", "sys1pll_vco", "sys1pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 13, &sys1pll_ctrl1_lock },
>> +       { "sys1pll_div3", "sys1pll_vco", "sys1pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS1PLL_AB_CTRL1, 14, &sys1pll_ctrl1_lock },
>> +       { "sys2pll_div1", "sys2pll_vco", "sys2pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 12, &sys2pll_ctrl1_lock },
>> +       { "sys2pll_div2", "sys2pll_vco", "sys2pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 13, &sys2pll_ctrl1_lock },
>> +       { "sys2pll_div3", "sys2pll_vco", "sys2pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS2PLL_AB_CTRL1, 14, &sys2pll_ctrl1_lock },
>> +       { "sys3pll_div1", "sys3pll_vco", "sys3pll_clk1", 1, 0, 0, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 12, &sys3pll_ctrl1_lock },
>> +       { "sys3pll_div2", "sys3pll_vco", "sys3pll_clk2", 1, 0, 0, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 13, &sys3pll_ctrl1_lock },
>> +       { "sys3pll_div3", "sys3pll_vco", "sys3pll_clk3", 1, 0, 0, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_SYS3PLL_AB_CTRL1, 14, &sys3pll_ctrl1_lock },
>> +       { "cpupll_div1", "cpupll_vco", "cpupll_clk1", 1, 0, 0, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 12, &cpupll_ctrl1_lock },
>> +       { "cpupll_div2", "cpupll_vco", "cpupll_clk2", 1, 0, 0, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 13, &cpupll_ctrl1_lock },
>> +       { "cpupll_div3", "cpupll_vco", "cpupll_clk3", 1, 0, 0, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_CPUPLL_AB_CTRL1, 14, &cpupll_ctrl1_lock },
>> +       { "mempll_div1", "mempll_vco", "mempll_clk1", 1, 0, 0, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 0, 3, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 12, &mempll_ctrl1_lock },
>> +       { "mempll_div2", "mempll_vco", "mempll_clk2", 1, 0, 0, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 4, 3, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 13, &mempll_ctrl1_lock },
>> +       { "mempll_div3", "mempll_vco", "mempll_clk3", 1, 0, 0, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 8, 3, SIRFSOC_CLKC_MEMPLL_AB_CTRL1, 14, &mempll_ctrl1_lock },
>
> Checkpatch warns on 23 lines that are over 80 character, including some
> of the code below in atlas7_clk_init.

Mike, what if we fix the below "atlas7_clk_init" in this patch because
it seems "atlas7_div_init_data divider_list" needs another patch since
the original table has lots of "lines that are over 80 character".
or do we need to fix  "atlas7_div_init_data divider_list", it seems
breaking the line makes the codes uglier?

-barry
