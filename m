From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 19 May 2014 15:31:52 +0300
Subject: [PATCH] ARM: AM43xx: clk: Change the wdt1 func clk src to per_32k
 clk
In-Reply-To: <53563F2D.20906@ti.com>
References: <1397621648-15691-1-git-send-email-lokeshvutla@ti.com>
 <53563F2D.20906@ti.com>
Message-ID: <5379F9B8.6070402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 01:06 PM, Tero Kristo wrote:
> On 04/16/2014 07:14 AM, Lokesh Vutla wrote:
>> WDT1 module can take one of the below clocks as input functional
>> clock -
>>     - On-Chip 32K RC Osc [default/reset]
>>     - 32K from PRCM
>>
>> The On-Chip 32K RC Osc clock is not an accurate clock-source as per
>> the design/spec, so as a result, for example, timer which supposed
>> to get expired @60Sec, but will expire somewhere ~@40Sec, which is
>> not expected by any use-case.
>>
>> The solution here is to switch the input clock-source to PRCM
>> generated 32K clock-source during boot-time itself.
>> This is derived from AM33xx clock file.
>
> I guess this patch should wait until we have a proper solution upstream
> for selecting parents based on DT data, unless you have pressing need to
> merge this as a temporary hack.

I've decided to take this patch in its current form as the DT parenting 
is still WIP.

Queued for 3.16/ti-clk-drv.

-Tero

>
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>   drivers/clk/ti/clk-43xx.c |   13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
>> index 67c8de5..ae2524e 100644
>> --- a/drivers/clk/ti/clk-43xx.c
>> +++ b/drivers/clk/ti/clk-43xx.c
>> @@ -110,9 +110,22 @@ static struct ti_dt_clk am43xx_clks[] = {
>>
>>   int __init am43xx_dt_clk_init(void)
>>   {
>> +    struct clk *clk1, *clk2;
>> +
>>       ti_dt_clocks_register(am43xx_clks);
>>
>>       omap2_clk_disable_autoidle_all();
>>
>> +    /*
>> +     * The On-Chip 32K RC Osc clock is not an accurate clock-source
>> as per
>> +     * the design/spec, so as a result, for example, timer which
>> supposed
>> +     * to get expired @60Sec, but will expire somewhere ~@40Sec,
>> which is
>> +     * not expected by any use-case, so change WDT1 clock source to PRCM
>> +     * 32KHz clock.
>> +     */
>> +    clk1 = clk_get_sys(NULL, "wdt1_fck");
>> +    clk2 = clk_get_sys(NULL, "clkdiv32k_ick");
>> +    clk_set_parent(clk1, clk2);
>> +
>>       return 0;
>>   }
>>
>
