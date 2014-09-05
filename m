From: xjq@rock-chips.com (Jianqun)
Date: Fri, 05 Sep 2014 15:38:30 +0800
Subject: [PATCH] Rockchip: RK3288: CRU: swap value of bit for CORE clock
 pll source selection
In-Reply-To: <1726751.YXExQQBGOk@diego>
References: <1409896166-32732-1-git-send-email-xjq@rock-chips.com>
 <1726751.YXExQQBGOk@diego>
Message-ID: <54096876.9070604@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK  thanks

? 09/05/2014 03:32 PM, Heiko St?bner ??:
> Hi Jianqun,
> 
> Am Freitag, 5. September 2014, 13:49:26 schrieb jianqun:
>> From: xujianqun <xjq@rock-chips.com>
>>
>> For RK3288, core clock pll source select APLL when bit value is 1, select
>> GPLL when bit value is 0;
>>
>> CRU_CLKSEL0_CON [15]
>> - core_clk_pll_sel
>> - CORE clock pll source selection
>> -- 1'b1: select ARM PLL
>> -- 1'b0: select GENERAL PLL
> 
> your patch changes code, I haven't even submitted yet ... so I guess there is 
> no need to spam maintainers and mailinglists with changes like these :-) .
> 
> 
>>
>> BUG=none
>> TEST= "cat /sys/kernel/debug/clk/clk_summary |grep apll" check parent of
>> core clock
>>
>> Change-Id: I44a528af256da1fad573b4ccf9d0a20ad4cf6d68
> 
> and to remember for the future, the ChromeOS, BUG, TEST and Change-Id 
> shouldn't appear in commits sent upstream.
> 
> 
> Heiko
> 
> 
>> Signed-off-by: xujianqun <xjq@rock-chips.com>
>> ---
>>  drivers/clk/rockchip/clk-cpu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
>> index c5b14e9..1725ac7 100644
>> --- a/drivers/clk/rockchip/clk-cpu.c
>> +++ b/drivers/clk/rockchip/clk-cpu.c
>> @@ -136,7 +136,7 @@ static int rockchip_cpuclk_pre_rate_change(struct
>> rockchip_cpuclk *cpuclk, }
>>
>>  	/* select alternate parent */
>> -	writel(HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
>> +	writel(HIWORD_UPDATE(0, 1, reg_data->mux_core_shift),
>>  	       cpuclk->reg_base + reg_data->core_reg);
>>
>>  	/* alternate parent is active now. set the dividers */
>> @@ -163,7 +163,7 @@ static int rockchip_cpuclk_post_rate_change(struct
>> rockchip_cpuclk *cpuclk, spin_lock(cpuclk->lock);
>>
>>  	/* post-rate change event, re-mux back to primary parent */
>> -	writel(HIWORD_UPDATE(0, 1, reg_data->mux_core_shift),
>> +	writel(HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
>>  	       cpuclk->reg_base + RK2928_CLKSEL_CON(0));
>>
>>  	/* remove any core dividers */
> 
> 
> 
> 
