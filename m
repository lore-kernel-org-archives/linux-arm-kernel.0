From: b51503@freescale.com (Bai Ping)
Date: Tue, 10 Nov 2015 17:59:11 +0800
Subject: [PATCH] clk: imx: add 'is_prepared' clk_ops callback for pllv3 clk
In-Reply-To: <1446459007.3156.6.camel@pengutronix.de>
References: <1446487569-20757-1-git-send-email-b51503@freescale.com>
 <1446459007.3156.6.camel@pengutronix.de>
Message-ID: <5641BFEF.9000504@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/2 18:10, Lucas Stach wrote:
> Am Dienstag, den 03.11.2015, 02:06 +0800 schrieb Bai Ping:
>> Add 'is_prepared' callback function for pllv3 type clk to make sure when
>> the system is bootup, the unused clk is in a known state to match the
>> prepare count info.
>>
> What does this commit fix?
> Is it there to ensure clocks are turned off at the disable unused clocks
> phase even if they haven't been prepared even once during bootup?

I am sorry for replay  you so later, it seem I missed this mail before.  
yeah, this commit
just to make sure the PLLs that are not been prepared can be turned off. 
sometimes,
the bootloader may turn on the PLL(take video PLL as example) for use, 
but when the
kernel bootup, the prepare count for the PLL clock is zero, but actually 
the PLL is powered on.
so adding the "is_prepared" ops to turn off the unused PLL to save power.

BR
Jacky Bai
>
> Regards,
> Lucas
>
>> Signed-off-by: Bai Ping <b51503@freescale.com>
>> ---
>>   drivers/clk/imx/clk-pllv3.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
>> index 6addf8f..c05c43d 100644
>> --- a/drivers/clk/imx/clk-pllv3.c
>> +++ b/drivers/clk/imx/clk-pllv3.c
>> @@ -97,6 +97,16 @@ static void clk_pllv3_unprepare(struct clk_hw *hw)
>>   	writel_relaxed(val, pll->base);
>>   }
>>   
>> +static int clk_pllv3_is_prepared(struct clk_hw *hw)
>> +{
>> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>> +
>> +	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>>   static unsigned long clk_pllv3_recalc_rate(struct clk_hw *hw,
>>   					   unsigned long parent_rate)
>>   {
>> @@ -139,6 +149,7 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
>>   static const struct clk_ops clk_pllv3_ops = {
>>   	.prepare	= clk_pllv3_prepare,
>>   	.unprepare	= clk_pllv3_unprepare,
>> +	.is_prepared	= clk_pllv3_is_prepared,
>>   	.recalc_rate	= clk_pllv3_recalc_rate,
>>   	.round_rate	= clk_pllv3_round_rate,
>>   	.set_rate	= clk_pllv3_set_rate,
>> @@ -193,6 +204,7 @@ static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rate,
>>   static const struct clk_ops clk_pllv3_sys_ops = {
>>   	.prepare	= clk_pllv3_prepare,
>>   	.unprepare	= clk_pllv3_unprepare,
>> +	.is_prepared	= clk_pllv3_is_prepared,
>>   	.recalc_rate	= clk_pllv3_sys_recalc_rate,
>>   	.round_rate	= clk_pllv3_sys_round_rate,
>>   	.set_rate	= clk_pllv3_sys_set_rate,
>> @@ -265,6 +277,7 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
>>   static const struct clk_ops clk_pllv3_av_ops = {
>>   	.prepare	= clk_pllv3_prepare,
>>   	.unprepare	= clk_pllv3_unprepare,
>> +	.is_prepared	= clk_pllv3_is_prepared,
>>   	.recalc_rate	= clk_pllv3_av_recalc_rate,
>>   	.round_rate	= clk_pllv3_av_round_rate,
>>   	.set_rate	= clk_pllv3_av_set_rate,
>> @@ -279,6 +292,7 @@ static unsigned long clk_pllv3_enet_recalc_rate(struct clk_hw *hw,
>>   static const struct clk_ops clk_pllv3_enet_ops = {
>>   	.prepare	= clk_pllv3_prepare,
>>   	.unprepare	= clk_pllv3_unprepare,
>> +	.is_prepared	= clk_pllv3_is_prepared,
>>   	.recalc_rate	= clk_pllv3_enet_recalc_rate,
>>   };
>>   
