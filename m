From: skannan@codeaurora.org (Saravana Kannan)
Date: Sat, 11 Dec 2010 20:58:58 -0800
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <AANLkTi=PnnT8rVKMxK0tVTdKnKdcKf71fsX2o594Qx3e@mail.gmail.com>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>	<20101202221909.GK29347@n2100.arm.linux.org.uk>	<4CF94DDD.8000409@codeaurora.org>	<20101203203653.GB10245@n2100.arm.linux.org.uk>	<4CFDD297.4020600@codeaurora.org>	<15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>	<20101209103835.GA31465@n2100.arm.linux.org.uk>	<4D017B45.4000805@codeaurora.org>
	<AANLkTi=PnnT8rVKMxK0tVTdKnKdcKf71fsX2o594Qx3e@mail.gmail.com>
Message-ID: <4D045692.4050607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2010 02:00 AM, Catalin Marinas wrote:
> On 10 December 2010 00:58, Saravana Kannan<skannan@codeaurora.org>  wrote:
>> Russell King - ARM Linux wrote:
>>>
>>> On Thu, Dec 09, 2010 at 01:23:24AM -0800, skannan at codeaurora.org wrote:
>>>>
>>>> Russell, Have you had a chance to look at this? Any comments? How do we
>>>> move ahead?
>>>
>>> I had connected the other thread with this one - it's pretty hard not
>>> to as it included this patch in that set as the first patch.
>>
>> Ok. So what's your take on handling the cache coherency with secure domain?
>> Do we get to add cache invalidate APIs outside of DMA APIs?
>
> Can the secure software not create NS pages and be fully coherent?
>

IMHO, trying to keep the cache fully coherent with the secure world 
without using explicit cache flush/invalidate raises the following 
concerns (in decreasing order of importance):
1. Since the secure world would need to enable the MMU to mark the pages 
as NS, it removes the possibility of secure world implementations that 
don't use MMU. The secure world image that's in use for MSM8660 as of 
today doesn't enable its MMU.
2. Even if MMU was enabled in secure world, the same binary needs to 
operate with different non-secure kernels. I'm certainly not a cache 
expert, but if I'm not mistaken, there are other page attributes that 
need to match between virt mem mappings for them to end up on the same 
cache lines (wasn't this a reason that Russell added the "already 
mapped?" check to ioremap). Trying to coordinate this between various 
non-secure kernels would be harder than having the various non-secure 
kernels do a flush/invalidate.
3. *If* a user of the SCM driver wants to pass phys addr of other memory 
pages to a service on the secure world (say, to avoid multiple copies), 
then they will also have to start coordinating on the page attributes. 
That would be harder to maintain than just an "invalidate before reading 
if secure-world service will write to this memory" approach.
4. Coordinating to make sure all the necessary page attributes match 
becomes harder if OEMs decide to make changes to the secure world 
implementation or drop in a new one.

As you and James suggested, having the NS bit set by the secure world is 
definitely a solution that would work. But IMHO, the explicit cache 
flush/invalidate approach keeps the design simple and easy to maintain.

Thanks,
Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
