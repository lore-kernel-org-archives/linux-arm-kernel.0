From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 16 Oct 2017 15:35:46 +0100
Subject: ARM64: Regression with commit e3067861ba66 ("arm64: add basic
 VMAP_STACK support")
In-Reply-To: <20171016142622.6yjuzdwxxw3sxjed@lakrids.cambridge.arm.com>
References: <20171010142725.GA24797@leoy-linaro>
 <20171010154558.GJ27659@leverpostej>
 <da09fd83-f3f0-f800-fea4-988cfa56bac7@arm.com>
 <20171016011723.GB12470@leoy-linaro>
 <20171016134819.jv3udrcwsedc4cgs@lakrids.cambridge.arm.com>
 <34ccf02d-fd65-bade-327a-ed8df1d3eea5@arm.com>
 <20171016142622.6yjuzdwxxw3sxjed@lakrids.cambridge.arm.com>
Message-ID: <dad6105d-1ec0-d5a6-e78c-ff832afe3f9e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/17 15:26, Mark Rutland wrote:
> On Mon, Oct 16, 2017 at 03:12:45PM +0100, Robin Murphy wrote:
>> On 16/10/17 14:48, Mark Rutland wrote:
>>> Hi Leo,
>>>
>>> On Mon, Oct 16, 2017 at 09:17:23AM +0800, Leo Yan wrote:
>>>> On Tue, Oct 10, 2017 at 05:03:44PM +0100, Robin Murphy wrote:
>>>>> On 10/10/17 16:45, Mark Rutland wrote:
>>>>>> On Tue, Oct 10, 2017 at 10:27:25PM +0800, Leo Yan wrote:
>>>>>>> I work mainline kernel on Hikey620 board, I find it's easily to
>>>>>>> introduce the panic and report the log as below. So I bisect the kernel
>>>>>>> and finally narrow down the commit e3067861ba66 ("arm64: add basic
>>>>>>> VMAP_STACK support") which introduce this issue.
>>>>>>>
>>>>>>> I tried to remove 'select HAVE_ARCH_VMAP_STACK' from
>>>>>>> arch/arm64/Kconfig, then I can see the panic issue will dismiss. So
>>>>>>> could you check this and have insight for this issue?
>>>>>>
>>>>>> Given the stuff in the backtrace, my suspicion is something is trying to
>>>>>> perform DMA to/from the stack, getting junk addresses form the attempted
>>>>>> virt<->phys conversions.
>>>>>>
>>>>>> Could you try enabling both VMAP_STACK and CONFIG_DEBUG_VIRTUAL?
>>>>>
>>>>> CONFIG_DMA_API_DEBUG should scream about drivers trying to use stack
>>>>> addresses either way, too.
>>>>
>>>> Thanks for suggestions, Mark & Robin.
>>>>
>>>> I enabled these debugging configs but cannot get clue from it; but
>>>> occasionally found this issue is quite likely related with CA53 errata,
>>>> especialy ERRATA_A53_855873 is the relative one. So I changed to use
>>>> ARM-TF mainline code with ERRATA fixing, this issue can be dismissed.
>>>
>>> Thanks for the update.
>>>
>>> Just to confirm, with the updated firmware you no longer see the issue?
>>>
>>> I can't immediately see how that would be related.
>>
>> Cores up to r0p2 have the other errata to which
>> ARM64_WORKAROUND_CLEAN_CACHE also applies anyway; r3p0+ have an ACTLR
>> bit to do thee CVAC->CIVAC upgrade in hardware, and our policy is that
>> we expect firmware to enable such hardware workarounds where possible. I
>> assume that's why we don't explicitly document 855873 anywhere in Linux.
> 
> Sure, I also looked it up. ;)
> 
> I meant that I couldn't immediately see why VMAP'd stacks were likely to
> tickle issues with that more reliably.

Ah, right - in context, "that" appeared to refer to "updated firmware",
not "VMAP_STACK". Sorry.

I guess the vmap addresses might tickle the "same L2 set" condition
differently to when both stack and DMA buffer are linear map addresses.

Robin.
