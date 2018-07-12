From: samuel@sholland.org (Samuel Holland)
Date: Wed, 11 Jul 2018 21:23:36 -0500
Subject: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <d72937af-cb46-27cf-809a-507ba5e47568@linaro.org>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
 <d72937af-cb46-27cf-809a-507ba5e47568@linaro.org>
Message-ID: <903c9e71-dde1-78d5-ed52-fcf47821918e@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/18 03:41, Daniel Lezcano wrote:
> On 04/07/2018 10:16, Marc Zyngier wrote:
>> On 03/07/18 19:42, Samuel Holland wrote:
>>> On 07/03/18 10:09, Marc Zyngier wrote:
>>>> On 11/05/18 03:27, Samuel Holland wrote:
>>>>> Hello,
>>>>>
>>>>> Several people (including me) have experienced extremely large system
>>>>> clock jumps on their A64-based devices, apparently due to the architectural
>>>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>>>> around after 2^56 cycles.
>>>>>
>>>>> Investigation led to discovery of some obvious problems with this SoC's 
>>>>> architectural timer, and this patch series introduces what I believe is
>>>>> the simplest workaround. More details are in the commit message for patch
>>>>> 1. Patch 2 simply enables the workaround in the device tree.
>>>>
>>>> What's the deal with this series? There was a couple of nits to address, and 
>>>> I was more or less expecting a v2.
>>>
>>> I got reports that people were still occasionally having clock jumps after
>>> applying this series, so I wanted to attempt a more complete fix, but I haven't
>>> had time to do any deeper investigation. I think this series is still beneficial
>>> even if it's not a complete solution, so I'll come back with another patch on
>>> top of this if/once I get it fully fixed.
>>>
>>> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
>>> timer) ? 150 should be a conservative iteration limit?
>>
>> Should be OK.
>>
>> Maxime: How do you want to deal with the documentation aspect? We need
>> an erratum number, but AFAIU the concept hasn't made it into the silicom
>> vendor's brain yet. Any chance you could come up with something that
>> uniquely identifies this?
> 
> I went through the different pointers provided in the description but I
> did not find a clear statement that is a hardware issue or may be I
> missed it.
> 
> Are we sure there isn't another subsystem responsible on this
> instability ? (eg PM or something else)

This issue has been observed on kernels with and without DVFS, across several
Linux, U-Boot, and Trusted Firmware versions. It has not been observed on any
other Allwinner SoC, including the A64's twin, the H5.

In fact, this workaround was recently successfully used in U-Boot [1] to fix
issues with an MMC driver that needed reliable numbers from CNTVCT.

So while the vendor hasn't confirmed it (and I wouldn't count on that
happening), everything I've seen points to it being a silicon bug, not a
software issue.

[1]:
https://git.denx.de/?p=u-boot.git;a=commit;h=be0d217952222b2bd3ed071de9bb0c66d8cc80d9

>>> Also, does this make sense to CC to stable?
>>
>> Probably not, as the HW never worked, so it is not a regression.
>>
>> Thanks,
>>
>> 	M.
>>
> 
> 
