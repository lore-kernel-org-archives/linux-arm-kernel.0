From: abailon@baylibre.com (Alexandre Bailon)
Date: Fri, 21 Jul 2017 17:18:17 +0200
Subject: Warning dump on OMAP-L138 when g_zero module is removed
In-Reply-To: <d3e5f067-81eb-80bb-c8e9-c7f147fe0145@ti.com>
References: <748a9491-e834-34cb-993f-e8c7e2538961@ti.com>
 <260e5199-624d-b402-5481-2d818d282ce7@baylibre.com>
 <d3e5f067-81eb-80bb-c8e9-c7f147fe0145@ti.com>
Message-ID: <7c53882e-b70b-91dc-df2f-9f67fdd3cf40@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 07/10/2017 01:00 PM, Sekhar Nori wrote:
> On Thursday 06 July 2017 10:43 PM, Alexandre Bailon wrote:
>> On 06/29/2017 03:50 PM, Sekhar Nori wrote:
>>> Hi Alexandre, Bin,
>>>
>>> With latest linux-next, I see a warning dump when I remove g_zero[1] on 
>>> OMAP-L138 LCDK board. I am building the kernel with davinci_all_defconfig.
>>>
>>> It is not present in latest mainline because the warnings are introduced
>>> with CPPI DMA getting enabled in latest -next.
>>>
>>> Subsequent insertion of g_ether leads to a warning too[2], although the 
>>> gadget seems to work (ping test).
>>>
>>> Since these are pretty annoying, it will be nice to get rid of them. I 
>>> have not been able to debug any further. But if you have
>>> ideas/experiments to try, I can do that.
> 
>> I got a lot of these warnings during development but it was only for the
>> host mode.
>> If I remember correctly, the cause was a race between the teardown
>> function and the interrupt handler.
>> The teardwon descriptor was pop from the queue by the interrupt handler,
>> preventing cppi41_tear_down_chan() to get it, which will result after
>> some retries to a couple of warnings.
>>
>> I will take a look to see if that is the same issue.
That is not the same issue. Still, for some reasons, we never get the
teardown descriptor.
Two possibilities:
 - Like the issue I had, the teardown is pop at the wrong place.
 - The teardown doesn't complete or the descriptor is not queued.

I think we should eliminate the first one before to work on the second one.
I think adding some logs to cppi41_pop_desc() could help to figure out
what is happening.
> 
> Thanks! I also see similar warnings under fast ping traffic and g_ether
> inserted on LCDK. They dont come immediately though. Only after an hour
> or so under traffic.
I would not have expected to have them during a ping but this probably
happens because some USB packet have timed out, which cause may a teardown.
> 
> I can those provide logs too if its going to be helpful.
Currently, I think we should focus on the warnings that happens during
the rmmod as they are always reproducible.

Thanks,
Alexandre
