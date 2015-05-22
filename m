From: wangbintian@gmail.com (Brent Wang)
Date: Sat, 23 May 2015 02:30:34 +0800
Subject: [PATCH v7 6/7] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <555EBCA4.9030303@huawei.com>
References: <1432117752-7074-1-git-send-email-bintian.wang@huawei.com>
 <1432117752-7074-2-git-send-email-bintian.wang@huawei.com>
 <555D09F3.7020506@codeaurora.org> <555D57BB.8080702@huawei.com>
 <555E1D55.1050907@codeaurora.org> <555EBCA4.9030303@huawei.com>
Message-ID: <CAAS=xmgHJVThR2hVeMYZjKgJdodEG_hrs09BBA01gOXMSc8Rdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

2015-05-22 13:20 GMT+08:00 Bintian <bintian.wang@huawei.com>:
> Hello Stephen,
>
>
> On 2015/5/22 2:00, Stephen Boyd wrote:
>>
>> On 05/20/15 20:57, Bintian wrote:
>>>
>>>
>>>>
>>>>>
>>>>> +
>>>>> +static void __init hi6220_clk_sys_init(struct device_node *np)
>>>>> +{
>>>>> +    struct hisi_clock_data *clk_data;
>>>>> +
>>>>> +    clk_data = hisi_clk_init(np, HI6220_SYS_NR_CLKS);
>>>>> +    if (!clk_data)
>>>>> +        return;
>>>>> +
>>>>> +    hisi_clk_register_gate_sep(hi6220_separated_gate_clks_sys,
>>>>> +            ARRAY_SIZE(hi6220_separated_gate_clks_sys), clk_data);
>>>>> +
>>>>> +    hisi_clk_register_mux(hi6220_mux_clks_sys,
>>>>> +            ARRAY_SIZE(hi6220_mux_clks_sys), clk_data);
>>>>> +
>>>>> +    hi6220_clk_register_divider(hi6220_div_clks_sys,
>>>>> +            ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
>>>>> +
>>>>> +    if (!clk_data_ao)
>>>>> +        return;
>>>>> +
>>>>> +    /* enable high speed clock on UART1 mux */
>>>>> +    clk_set_parent(clk_data->clk_data.clks[HI6220_UART1_SRC],
>>>>> +            clk_data_ao->clk_data.clks[HI6220_150M]);
>>>>
>>>>
>>>> Sorry I missed this one earlier. Can we do this clk_set_parent() through
>>>> assigned-parents instead?
>>>
>>> Uart1 has two clock parents in hi6220, and use "clk_tcxo" by default,
>>> we use uart1 to connect BT in HiKey, and switch to "clk_150m" for high
>>> speed mode of BT, but pl011 has no code to set clock rate or set clock
>>> parents operation, so it's a easy way to do that here.
>>
>>
>> Is pl011 the uart device? Does it have a node in DT somewhere? If it
>> does, then we could put the assigned-parents properties in that node so
>> that when the pl011 probes the uart1 clock has its parent set to
>> clk_150m. See the "Assigned clock parents and rates" section of
>> Documentation/devicetree/bindings/clock/clock-bindings.txt.
>>
> I will verify this.
Currently the "assigned-clock*" doesn't work for pl011 UART device
node, maybe we will
do some fix for its driver later or other modules.

How about keep the "clk_set_parent" in this patch now?

Thanks,

Bintian
>
> If it is OK, I will remove "clk_set_parent" from this patch.
>
> Thanks,
>
> Bintian
>
