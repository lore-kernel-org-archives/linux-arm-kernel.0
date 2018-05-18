From: david@lechnology.com (David Lechner)
Date: Fri, 18 May 2018 10:35:54 -0500
Subject: [PATCH v10 25/27] ARM: davinci: add device tree support to timer
In-Reply-To: <c7064bee-d385-4496-c19e-1b72853b01f1@ti.com>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-26-david@lechnology.com>
 <8fa98514-7651-58cb-595e-6c7f713540b8@ti.com>
 <1162de58-00bc-fdfa-eef1-48a094834ac3@lechnology.com>
 <c7064bee-d385-4496-c19e-1b72853b01f1@ti.com>
Message-ID: <9bc3fb8f-ca03-9cfd-1e9d-51f8c9347da7@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2018 01:05 AM, Sekhar Nori wrote:
> On Thursday 17 May 2018 08:39 PM, David Lechner wrote:
>> On 05/17/2018 09:35 AM, Sekhar Nori wrote:
>>> Hi David,
>>>
>>> On Wednesday 09 May 2018 10:56 PM, David Lechner wrote:
>>>> This adds device tree support to the davinci timer so that when clocks
>>>> are moved to device tree, the timer will still work.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>> ---
>>>
>>>> +static int __init of_davinci_timer_init(struct device_node *np)
>>>> +{
>>>> +??? struct clk *clk;
>>>> +
>>>> +??? clk = of_clk_get(np, 0);
>>>> +??? if (IS_ERR(clk)) {
>>>> +??????? struct of_phandle_args clkspec;
>>>> +
>>>> +??????? /*
>>>> +???????? * Fall back to using ref_clk if the actual clock is not
>>>> +???????? * available. There will be problems later if the real clock
>>>> +???????? * source is disabled.
>>>> +???????? */
>>>> +
>>>> +??????? pr_warn("%s: falling back to ref_clk\n", __func__);
>>>> +
>>>> +??????? clkspec.np = of_find_node_by_name(NULL, "ref_clk");
>>>> +??????? if (IS_ERR(clkspec.np)) {
>>>> +??????????? pr_err("%s: No clock available for timer!\n", __func__);
>>>> +??????????? return PTR_ERR(clkspec.np);
>>>> +??????? }
>>>> +??????? clk = of_clk_get_from_provider(&clkspec);
>>>> +??????? of_node_put(clkspec.np);
>>>> +??? }
>>>
>>> Do we need this error path now?
>>>
>>> Thanks,
>>> Sekhar
>>>
>>
>> No, not really.
> 
> Then lets just print an error and return the error number.
> 

OK. FYI, timer_probe() prints the error if we return and error, so
I will just return the error.
