From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 13 Dec 2016 11:01:53 +0200
Subject: [PATCH 3/3] clk: keystone: Add sci-clk driver support
In-Reply-To: <20161212193800.GL5423@codeaurora.org>
References: <1477053961-27128-1-git-send-email-t-kristo@ti.com>
 <1477053961-27128-4-git-send-email-t-kristo@ti.com>
 <20161208001348.GC5423@codeaurora.org>
 <cb608729-b617-0eab-5ddf-d78ff47b237e@ti.com>
 <20161208211044.GI5423@codeaurora.org>
 <22dacb0c-a3bc-50ce-e4b9-f74a0c706f20@ti.com>
 <20161212193800.GL5423@codeaurora.org>
Message-ID: <53ca4fc2-04a3-5260-e0de-2d2f9abbee2c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/16 21:38, Stephen Boyd wrote:
> On 12/09, Tero Kristo wrote:
>> On 08/12/16 23:10, Stephen Boyd wrote:
>>> On 12/08, Tero Kristo wrote:
>>>> On 08/12/16 02:13, Stephen Boyd wrote:
>>>>> On 10/21, Tero Kristo wrote:
>>>>>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>>>>>> new file mode 100644
>>>>>> index 0000000..f6af5bd
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/clk/keystone/sci-clk.c
>>>>
>>>>>
>>>>>> +
>>>>>> +	handle = devm_ti_sci_get_handle(dev);
>>>>>> +	if (IS_ERR(handle))
>>>>>> +		return PTR_ERR(handle);
>>>>>> +
>>>>>> +	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
>>>>>> +	if (!provider)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	provider->clocks = data;
>>>>>> +
>>>>>> +	provider->sci = handle;
>>>>>> +	provider->ops = &handle->ops.clk_ops;
>>>>>> +	provider->dev = dev;
>>>>>> +
>>>>>> +	ti_sci_init_clocks(provider);
>>>>>
>>>>> And if this fails?
>>>>
>>>> Yea this is kind of controversial. ti_sci_init_clocks() can fail if
>>>> any of the clocks registered will fail. I decided to have it this
>>>> way so that at least some clocks might work in failure cause, and
>>>> you might have a booting device instead of total lock-up.
>>>>
>>>> Obviously it could be done so that if any clock fails, we would
>>>> de-register all clocks at that point, but personally I think this is
>>>> a worse option.
>>>>
>>>> ti_sci_init_clocks could probably be modified to continue
>>>> registering clocks when a single clock fails though. Currently it
>>>> aborts at first failure.
>>>>
>>>
>>> That sounds like a better approach if we don't care about
>>> failures to register a clock. Returning a value from a function
>>> and not using it isn't really a great design.
>>>
>>> I worry that if we start returning errors from clk_hw_register()
>>> that something will go wrong though, so really I don't know why
>>> we want to ignore errors at all. Just for debugging a boot hang?
>>> Can't we use early console to at least see that this driver is
>>> failing to probe and debug that way?
>>
>> Early console can be used to debug that, but it is kind of annoying
>> to recompile most of the kernel when you suddenly need to use it.
>
> I thought SERIAL_EARLYCON was selected by drivers that support
> it? So there shouldn't be any rebuilding required.

Actually you can probably ignore my comment, I was just speaking out of 
OMAP experience where the clocks are initialized very early, but this 
doesn't apply to keystone. Sci-clock is a proper driver now with proper 
probe etc. in place so my comment here is invalid.

>
>>
>> How about modifying the ti_sci_init_clocks func to print an error
>> for each failed clock?
>
> Ok that's fine too. I'd prefer the function had a return type of
> void if we're not planning on using the return value, that's all.

Ok, I'll see which way I go in v2 of the series, but seems I can pick 
either your original proposal or mine.

-Tero
