From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue, 17 Dec 2013 22:06:03 -0600
Subject: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property
 to the "altr, socfpga-gate-clk"
In-Reply-To: <20131217235557.23538.22672@quantum>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
 <1387213476-22122-2-git-send-email-dinguyen@altera.com>
 <52B00167.4010903@linaro.org> <52B0554F.1080509@gmail.com>
 <20131217235557.23538.22672@quantum>
Message-ID: <52B11F2B.5000507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 12/17/13 5:55 PM, Mike Turquette wrote:
> Quoting Dinh Nguyen (2013-12-17 05:44:47)
>> Hi Zhangfei,
>>
>> On 12/17/13 1:46 AM, zhangfei wrote:
>>>
>>> On 12/17/2013 01:04 AM, dinguyen at altera.com wrote:
>>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
>>>> +{
>>>> +    struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
>>>> +    struct regmap *sys_mgr_base_addr;
>>>> +    u32 hs_timing;
>>>> +
>>>> +    if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
>>>> +        sys_mgr_base_addr =
>>>> syscon_regmap_lookup_by_compatible("altr,sys-mgr");
>>>> +        if (IS_ERR(sys_mgr_base_addr)) {
>>>> +            pr_err("%s: failed to find altr,sys-mgr regmap!\n",
>>>> __func__);
>>>> +            return -EINVAL;
>>>> +        }
>>>> +        hs_timing = SYSMGR_SDMMC_CTRL_SET(socfpgaclk->clk_phase[0],
>>>> +                        socfpgaclk->clk_phase[1]);
>>>> +        regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
>>>> +                        hs_timing);
>>>> +    }
>>>> +    return 0;
>>>> +}
>>> So reusing gate-clk here and check the node of "altr,sys-mgr".
>>> I think it is good and simple.
>>> Also can define new clock combined with node "altr,sys-mgr" with
>>> parent of sdmmc_clk.
>>>
>>> Thanks for the update, it is fine to me.
>> Thanks, can I get an Ack from you for this version?
> Dinh,
>
> Will you be spinning another version of this patch? If not I can go
> ahead and take this into clk-next.
If you are OK with the patch, then yes, can you please apply it to clk-next?

Thanks,
Dinh
>
> Regards,
> Mike
>
>> Thanks,
>> Dinh
>>>> +
>>>>   static struct clk_ops gateclk_ops = {
>>>> +    .prepare = socfpga_clk_prepare,
>>>>       .recalc_rate = socfpga_clk_recalc_rate,
>>>>       .get_parent = socfpga_clk_get_parent,
>>>>       .set_parent = socfpga_clk_set_parent,
>>>> @@ -254,6 +283,7 @@ static void __init socfpga_gate_clk_init(struct
>>>> device_node *node,
>>>>   {
>>>>       u32 clk_gate[2];
>>>>       u32 div_reg[3];
>>>> +    u32 clk_phase[2];
>>>>       u32 fixed_div;
>>>>       struct clk *clk;
>>>>       struct socfpga_clk *socfpga_clk;
>>>> @@ -294,6 +324,12 @@ static void __init socfpga_gate_clk_init(struct
>>>> device_node *node,
>>>>           socfpga_clk->div_reg = 0;
>>>>       }
>>>>
>>>> +    rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
>>>> +    if (!rc) {
>>>> +        socfpga_clk->clk_phase[0] = clk_phase[0];
>>>> +        socfpga_clk->clk_phase[1] = clk_phase[1];
>>>> +    }
>>>> +
>>>>       of_property_read_string(node, "clock-output-names", &clk_name);
>>>>
>>>>       init.name = clk_name;
>>>>
