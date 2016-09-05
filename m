From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 5 Sep 2016 10:07:05 +0300
Subject: [PATCHv2 3/3] clk: keystone: Add sci-clk driver support
In-Reply-To: <20160902233235.GM12510@codeaurora.org>
References: <1472733635-22661-1-git-send-email-t-kristo@ti.com>
 <1472733635-22661-4-git-send-email-t-kristo@ti.com>
 <20160902233235.GM12510@codeaurora.org>
Message-ID: <827e0a46-3771-67a8-1414-0cbaf0e2548e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/16 02:32, Stephen Boyd wrote:
> On 09/01, Tero Kristo wrote:
>> +
>> +/**
>> + * _sci_clk_get - Gets a handle for an SCI clock
>> + * @provider: Handle to SCI clock provider
>> + * @dev_id: device ID for the clock to register
>> + * @clk_id: clock ID for the clock to register
>> + * @parse_parents: indicator whether parents for this clock should be handled
>> + *
>> + * Gets a handle to an existing TI SCI hw clock, or builds a new clock
>> + * entry and registers it with the common clock framework. Called from
>> + * the common clock framework, when a corresponding of_clk_get call is
>> + * executed, or recursively from itself when parsing parent clocks.
>> + * Returns a pointer to the hw clock struct, or ERR_PTR value in failure.
>> + */
>> +static struct clk_hw *_sci_clk_get(struct sci_clk_provider *provider,
>> +				   u16 dev_id, u8 clk_id, bool parse_parents)
>
> I still don't get it. We should be registering hw pointers in
> probe and handing them out in the xlate function. Not register
> hws in the xlate function and then handing them out as well. I
> haven't reviewed anything else in this patch.

Ok, let me try to explain the functionality.

Probe time hw pointer registration is only needed for special clocks 
that require extra flags, like adding the spread spectrum flag. There is 
ever going to be only handful of these.

Xlate checks out the sci_clk list, and picks up an existing hw clock if 
it is there. If not, it will create a new one. The reason this is done 
like this, the device IDs / clock IDs don't mean anything to the driver 
itself, the driver just passes these forward to the underlying SCI fwk. 
And, we don't have inherent knowledge of valid device / clock IDs 
either, the SCI fwk returns a failure if a specific clock ID is bad. The 
device / clock IDs are going to be different between different 
generations of SoC also, and in addition there can be holes in the ID 
ranges.

-Tero
