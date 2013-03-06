From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Mar 2013 21:20:32 -0800
Subject: [PATCH] ARM: proc: Add Krait proc info
In-Reply-To: <51366B9E.7010502@codeaurora.org>
References: <1362439299-29617-1-git-send-email-sboyd@codeaurora.org>
 <20130305083421.GA19391@mudshark.cambridge.arm.com>
 <51366B9E.7010502@codeaurora.org>
Message-ID: <5136D220.5090904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/13 14:03, Stephen Boyd wrote:
> On 03/05/13 00:34, Will Deacon wrote:
>> Hi Stephen, Stepan,
>>
>> On Mon, Mar 04, 2013 at 11:21:39PM +0000, Stephen Boyd wrote:
>>> From: Stepan Moskovchenko <stepanm@codeaurora.org>
>>>
>>> Add processor info for the Qualcomm, Inc. Krait family of
>>> processors, to use the generic ARMv7 initialisation
>>> procedure but explicitly enable the IDIV hardware
>>> capability flag.
>>>
>>> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>> ---
>>>  arch/arm/mm/proc-v7.S |   10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>>> index 3a3c015..81adeb3 100644
>>> --- a/arch/arm/mm/proc-v7.S
>>> +++ b/arch/arm/mm/proc-v7.S
>>> @@ -434,6 +434,16 @@ __v7_ca15mp_proc_info:
>>>  	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
>>>  
>>>  	/*
>>> +	 * Qualcomm Inc. Krait processors.
>>> +	 */
>>> +	.type	__krait_proc_info, #object
>>> +__krait_proc_info:
>>> +	.long	0x510f0400		@ Required ID value
>>> +	.long	0xff0ffc00		@ Mask for ID
>>> +	__v7_proc __v7_setup, hwcaps = HWCAP_IDIV
>> I was looking at this the other day and wondered whether we could set
>> HWCAP_IDIV in __v7_setup, depending on ID_ISAR0[27:24]. I can't immediately
>> think why that would be difficult, but similarly there may well be a reason
>> why we assign it like this.
>>
>> Fancy taking a look?
> Ok I'll take a look. 

Hmm. I wonder if we did it this way because between version B and C of
DDI0406 the definition of those bits changed.

In DDI0406B we have

    0 - no support
    1 - support

and in DDI0406C we have

    0 - no support
    1 - support in Thumb
    2 - support in Thumb and ARM

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
