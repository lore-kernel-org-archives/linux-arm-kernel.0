From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 1 Feb 2016 16:20:40 +0000
Subject: [PATCH v2 06/21] arm64: KVM: VHE: Patch out use of HVC
In-Reply-To: <20160201153635.GH15514@e104818-lin.cambridge.arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-7-git-send-email-marc.zyngier@arm.com>
 <20160201131634.GI1478@cbox> <56AF5ED8.7010303@arm.com>
 <20160201153635.GH15514@e104818-lin.cambridge.arm.com>
Message-ID: <56AF85D8.7080907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/16 15:36, Catalin Marinas wrote:
> On Mon, Feb 01, 2016 at 01:34:16PM +0000, Marc Zyngier wrote:
>> On 01/02/16 13:16, Christoffer Dall wrote:
>>> On Mon, Jan 25, 2016 at 03:53:40PM +0000, Marc Zyngier wrote:
>>>> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
>>>> index 93e8d983..9e0683f 100644
>>>> --- a/arch/arm64/kvm/hyp/hyp-entry.S
>>>> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
>>>> @@ -38,6 +38,32 @@
>>>>  	ldp	x0, x1, [sp], #16
>>>>  .endm
>>>>  
>>>> +.macro do_el2_call
>>>> +	/*
>>>> +	 * Shuffle the parameters before calling the function
>>>> +	 * pointed to in x0. Assumes parameters in x[1,2,3].
>>>> +	 */
>>>> +	stp	lr, xzr, [sp, #-16]!
>>>
>>> remind me why this pair isn't just doing "str" instead of "stp" with the
>>> xzr ?
>>
>> Because SP has to be aligned on a 16 bytes boundary at all times.
> 
> You could do something like:
> 
> 	sub	sp, sp, #16
> 	str	lr, [sp]
> 

Ah, fair enough. I'll fold that in.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
