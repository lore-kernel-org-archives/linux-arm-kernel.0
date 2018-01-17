From: david@lechnology.com (David Lechner)
Date: Wed, 17 Jan 2018 11:33:09 -0600
Subject: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
In-Reply-To: <bb1f446e-5900-7e73-c1b7-955662a9541b@ti.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com>
 <8d09dba6-9b1d-e06e-8730-256b8a4320db@ti.com>
 <b6baa17e-1239-c209-9eca-52e5da73e921@lechnology.com>
 <bb1f446e-5900-7e73-c1b7-955662a9541b@ti.com>
Message-ID: <b85f7b4a-7b4c-11d8-6ea5-db4717e11658@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 05:57 AM, Sekhar Nori wrote:
> On Tuesday 16 January 2018 10:51 PM, David Lechner wrote:
>> On 01/16/2018 08:00 AM, Sekhar Nori wrote:
>>> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
>>>> +void __init da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1)
>>>> +{
>>>> +??? struct clk_onecell_data *clk_data;
>>>> +
>>>> +??? clk_data = davinci_psc_register_clocks(psc0, da850_psc0_info, 16);
>>>> +??? if (!clk_data)
>>>> +??????? return;
>>>> +
>>>> +??? clk_register_clkdev(clk_data->clks[3], NULL, "ti-aemif");
>>>> +??? clk_register_clkdev(clk_data->clks[3], "aemif", "davinci-nand.0");
>>>> +??? clk_register_clkdev(clk_data->clks[4], NULL, "spi_davinci.0");
>>>> +??? clk_register_clkdev(clk_data->clks[5], NULL, "da830-mmc.0");
>>>> +??? clk_register_clkdev(clk_data->clks[9], NULL, "serial8250.0");
>>>> +??? clk_register_clkdev(clk_data->clks[14], "arm", NULL);
>>>> +??? clk_register_clkdev(clk_data->clks[15], NULL, "davinci-rproc.0");
>>>> +
>>>> +??? clk_free_onecell_data(clk_data);
>>>> +
>>>> +??? clk_data = davinci_psc_register_clocks(psc1, da850_psc1_info, 32);
>>>> +??? if (!clk_data)
>>>> +??????? return;
>>>> +
>>>> +??? clk_register_clkdev(clk_data->clks[1], "usb20_psc_clk", NULL);
>>>
>>> Is this con_id really needed now? Searching for "usb20_psc_clk" in your
>>> tree results in only this one hit.
>>
>> Yes, this is left over from previous attempts.
>>
>>>
>>>> +??? clk_register_clkdev(clk_data->clks[1], NULL, "musb-da8xx");
>>>> +??? clk_register_clkdev(clk_data->clks[1], NULL, "cppi41-dmaengine");
>>>
>>> I guess multiple dev_id matches like these are another hurdle in moving
>>> them to davinci_psc_clk_info[] table? If its too cumbersome to keep
>>> multiple entries in the table, they can be handled as an exception at
>>> the end of processing the table? Still they are not the norm so I hope
>>> the normal case will still benefit.
>>
>> Right, as I mentioned in the reply to the previous patch, instead of
>> assigning a con_id and dev_id to each clock, we would need to assign
>> an array with a list of clocks. I think that would work better than
>> trying to handle the extras as an exception since there, on average,
>> about 5 per SoC.
> 
> Okay, are you going to try this to see how it looks? It looks like
> samsung (clk-s3c2410.c) and tegra (clk-tegra20.c) use such tables
> (although both use separate tables mapping just the gate number to
> con_id/dev_id).
> 
> Others like u8540_clk.c and clk-mmp2.c have multiple calls in code to
> clk_register_clkdev() like you have, but they keep them right after the
> gate clock registration which makes it easy to see the mapping.
> 
> clk-imx35.c has multiple clk_register_clkdev() calls, but uses an enum
> for the gates so its easy to see the mapping. This approach looks fine
> to me as well.
> 
> So looks like there is a whole gamut of ways people have approached
> this. But I do think we need to change the scheme you have currently
> since it is difficult to review and audit (believe me on this one :))
> 

OK, I'll figure out something here.
