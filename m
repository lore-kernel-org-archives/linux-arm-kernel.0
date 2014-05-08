From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 8 May 2014 10:59:28 +0200
Subject: [PATCH 134/222] ARM: imx: keep PLLs in bypass while they're
 locking
In-Reply-To: <5360D5FB.2080209@de.bosch.com>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
 <E1WdeWp-0007MD-Vr@rmk-PC.arm.linux.org.uk> <5360D5FB.2080209@de.bosch.com>
Message-ID: <536B4770.4020605@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Besides the question below regarding 'val & BM_PLL_POWER', three 
additional questions:

On 30.04.2014 12:52, Dirk Behme wrote:
> On 25.04.2014 13:42, Russell King wrote:
>> Keep the PLL bypassed while we prepare a clock by powering up the PLL,
>> otherwise we can end up with improper output/gitches which prevents
>> further operation.

Have you seen a real world case to show this patch fixes an issue in 
real? Have you been seeing anything like "improper output/gitches"?

>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>   arch/arm/mach-imx/clk-pllv3.c | 27 +++++++++++++++++++++------
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-pllv3.c
>> b/arch/arm/mach-imx/clk-pllv3.c
>> index 61364050fccd..3776f974d1dc 100644
>> --- a/arch/arm/mach-imx/clk-pllv3.c
>> +++ b/arch/arm/mach-imx/clk-pllv3.c
>> @@ -273,9 +273,10 @@ static int clk_pllv3_av_set_rate(struct clk_hw

We touch here pllv3/av only, while the commit message generically says 
"keep PLLs in bypass while they're locking" nothing specific to 
audio/video PLL clock. So isn't similar modification needed for the 
other set_rate() functions as well?

>> *hw, unsigned long rate,
>>       struct clk_pllv3 *pll = to_clk_pllv3(hw);
>>       unsigned long min_rate = parent_rate * 27;
>>       unsigned long max_rate = parent_rate * 54;
>> -    u32 val, div;
>> +    u32 val, newval, div;
>>       u32 mfn, mfd = 1000000;
>>       s64 temp64;
>> +    int ret;
>>
>>       if (rate < min_rate || rate > max_rate)
>>           return -EINVAL;
>> @@ -287,13 +288,27 @@ static int clk_pllv3_av_set_rate(struct clk_hw
>> *hw, unsigned long rate,
>>       mfn = temp64;
>>
>>       val = readl_relaxed(pll->base);
>> -    val &= ~pll->div_mask;
>> -    val |= div;
>> -    writel_relaxed(val, pll->base);
>> +
>> +    /* set the PLL into bypass mode */
>> +    newval = val | BM_PLL_BYPASS;
>> +    writel_relaxed(newval, pll->base);
>> +
>> +    /* configure the new frequency */

Reading the i.MX6 reference manual section '18.5.1.5.3 PLL clock 
change': 'Before changing the PLL setting, power it down. Power up the 
PLL after the change.' So we need to power down/up the PLL rather than 
just bypass for a rate change?

>> +    newval &= ~pll->div_mask;
>> +    newval |= div;
>> +    writel_relaxed(newval, pll->base);
>>       writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
>> -    writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
>> +    writel(mfd, pll->base + PLL_DENOM_OFFSET);
>>
>> -    return clk_pllv3_wait_lock(pll);
>> +    ret = clk_pllv3_wait_lock(pll);
>> +    if (ret == 0 && val & BM_PLL_POWER) {
>
> I'm no expert on this, so sorry if I'm wrong ;)
>
> But regarding the check 'val & BM_PLL_POWER' here:
>
> Reading the manual, it seems that both PLL4_AUDIO & PLL5_VIDEO don't
> have a POWER bit, instead they have a POWERDOWN at bit 12. So for
> PLL4_AUDIO & PLL5_VIDEO 'val & BM_PLL_POWER' would mean not powered up?
>
> Maybe the check should be done anywhere else, e.g. in clk_pllv3_set_rate()?

Best regards

Dirk
