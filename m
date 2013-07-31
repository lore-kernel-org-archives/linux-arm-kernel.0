From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 31 Jul 2013 17:56:44 +0300
Subject: [PATCHv4 15/33] CLK: OMAP: DPLL: add support for DT property
 ti,dpll-no-gate
In-Reply-To: <51F8118F.3000104@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-16-git-send-email-t-kristo@ti.com>
 <51F8118F.3000104@ti.com>
Message-ID: <51F925AC.7010806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 10:18 PM, Nishanth Menon wrote:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>> AM335x has DPLL clocks that should never be attempted to be gated. Adding
>> ti,dpll-no-gate property for them handles this situation.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/omap/dpll.c |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
>> index 66e82be..1d24feada 100644
>> --- a/drivers/clk/omap/dpll.c
>> +++ b/drivers/clk/omap/dpll.c
>> @@ -54,6 +54,13 @@ static const struct clk_ops dpll_x2_ck_ops = {
>>       .recalc_rate    = &omap3_clkoutx2_recalc,
>>   };
>>
>> +static const struct clk_ops dpll_no_gate_ck_ops = {
>> +    .recalc_rate    = &omap3_dpll_recalc,
>> +    .get_parent    = &omap2_init_dpll_parent,
>> +    .round_rate    = &omap2_dpll_round_rate,
>> +    .set_rate    = &omap3_noncore_dpll_set_rate,
>> +};
>> +
>>   struct clk *omap_clk_register_dpll(struct device *dev, const char
>> *name,
>>           const char **parent_names, int num_parents, unsigned long
>> flags,
>>           struct dpll_data *dpll_data, const char *clkdm_name,
>> @@ -288,6 +295,9 @@ __init void of_omap4_dpll_setup(struct device_node
>> *node)
>>           return;
>>       }
>>
>> +    if (of_property_read_bool(node, "ti,dpll-no-gate"))
>> +        ops = &dpll_no_gate_ck_ops;
>> +
>>       of_omap_dpll_setup(node, ops);
>>   }
>>   EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
>>
> squash this to dpll patch?
>

Can do it. Was kept separate just to avoid confusion with previous rev 
of the code.

-Tero
