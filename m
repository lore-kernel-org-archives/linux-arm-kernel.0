From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 23 Sep 2016 11:06:04 +0300
Subject: [PATCHv2 3/3] clk: keystone: Add sci-clk driver support
In-Reply-To: <20160916230101.GM7243@codeaurora.org>
References: <1472733635-22661-1-git-send-email-t-kristo@ti.com>
 <1472733635-22661-4-git-send-email-t-kristo@ti.com>
 <20160902233235.GM12510@codeaurora.org>
 <827e0a46-3771-67a8-1414-0cbaf0e2548e@ti.com>
 <20160916230101.GM7243@codeaurora.org>
Message-ID: <9f71ab9b-7aed-ae6f-c057-ed3da0bd5200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/16 02:01, Stephen Boyd wrote:
> On 09/05, Tero Kristo wrote:
>> On 03/09/16 02:32, Stephen Boyd wrote:
>>> I still don't get it. We should be registering hw pointers in
>>> probe and handing them out in the xlate function. Not register
>>> hws in the xlate function and then handing them out as well. I
>>> haven't reviewed anything else in this patch.
>>
>> Ok, let me try to explain the functionality.
>>
>> Probe time hw pointer registration is only needed for special clocks
>> that require extra flags, like adding the spread spectrum flag.
>> There is ever going to be only handful of these.
>>
>> Xlate checks out the sci_clk list, and picks up an existing hw clock
>> if it is there. If not, it will create a new one. The reason this is
>> done like this, the device IDs / clock IDs don't mean anything to
>> the driver itself, the driver just passes these forward to the
>> underlying SCI fwk. And, we don't have inherent knowledge of valid
>> device / clock IDs either, the SCI fwk returns a failure if a
>> specific clock ID is bad. The device / clock IDs are going to be
>> different between different generations of SoC also, and in addition
>> there can be holes in the ID ranges.
>
> Ok. Thanks for the explanation.
>
> I understand the desire to make this SoC agnostic and consumer/dt
> driven. Constructor pattern and all. Unfortunately the OF clk
> provider is a getter pattern; not a constructor pattern. I'm
> seriously concerned about the locking here because we're in the
> framework creating a clk and tying it into a consumer list which
> could cause all sorts of problems if we want to reenter the
> framework and register more clks. Recursion abounds and my head
> explodes! The recursive clk prepare mutex is not something anyone
> should be thrilled about keeping around.
>
> So, just don't do this. Instead, register the clks during probe
> that exist for the firmware. That list could be discoverable with
> firmware calls, or known based on different compatible strings
> from DT that have the soc name in it, or something else. Even
> scanning the entire DT tree for
>
> 	clocks = <&my_clk_node x y>
> 	
> would be better, but probably hugely inefficient and outright
> buggy with DT overlays so don't do it. If the firmware can't tell
> us what clks are there, just have a table based on compatible
> string and be done.

Ok, I will add a static mapping of valid clock IDs within the driver and 
init all of these during probe. I have a working solution for this 
already, but will post it out only once 4.9-rc1 is out.

-Tero
