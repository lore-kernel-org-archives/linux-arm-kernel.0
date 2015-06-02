From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 2 Jun 2015 09:57:11 +0300
Subject: [PATCHv4 02/10] CLK: TI: always enable DESHDCP clock
In-Reply-To: <20150601214908.GG30984@atomide.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-3-git-send-email-tomi.valkeinen@ti.com>
 <20150601214908.GG30984@atomide.com>
Message-ID: <556D53C7.5060502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2015 12:49 AM, Tony Lindgren wrote:
> Hi Mike, Stephen & Tero,
>
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150531 23:25]:
>> DESHDCP clock is needed on DRA7 based SoCs to enable the DSS IP. That
>> clock is an odd one, as it is not supposed to be any kind of core clock
>> for DSS, and we don't even support HDCP, but the clock is still needed
>> even for the HWMOD framework to be able to reset the DSS IP.
>>
>> As there's no support for multiple core clocks in the HWMOD framework,
>> we don't have any obvious place to enable this clock when DSS IP is
>> being enabled.
>>
>> Furthermore, the HDMI on OMAP5 DSS is the same as on DRA7, and OMAP5
>> does not have any such clock configuration bit. This suggests that on
>> OMAP5 the DESHDCP clock is always enabled, and for DRA7 we have the
>> possibility to gate it.
>>
>> So, as we don't have any clean way to enable and disable the clock
>> based on the need, this patch enables the clock at boot time, making it
>> work similarly to OMAP5.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
> This series seems like I should take it as a whole series..
> Care to ack/nack on this one?
>
> Regards,

Acked-by: Tero Kristo <t-kristo@ti.com>

>
> Tony
>
>
>> ---
>>   drivers/clk/ti/clk-7xx.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
>> index 2dd956b9affa..63b8323df918 100644
>> --- a/drivers/clk/ti/clk-7xx.c
>> +++ b/drivers/clk/ti/clk-7xx.c
>> @@ -312,7 +312,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
>>   int __init dra7xx_dt_clk_init(void)
>>   {
>>   	int rc;
>> -	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
>> +	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *hdcp_ck;
>>
>>   	ti_dt_clocks_register(dra7xx_clks);
>>
>> @@ -348,5 +348,10 @@ int __init dra7xx_dt_clk_init(void)
>>   	if (rc)
>>   		pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
>>
>> +	hdcp_ck = clk_get_sys(NULL, "dss_deshdcp_clk");
>> +	rc = clk_prepare_enable(hdcp_ck);
>> +	if (rc)
>> +		pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
>> +
>>   	return rc;
>>   }
>> --
>> 2.1.4
>>
