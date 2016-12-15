From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Dec 2016 11:46:41 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <20161215113539.GK14217@n2100.armlinux.org.uk>
References: <20161213113044.GC19985@leverpostej>
 <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
 <72f93940-cf87-fd91-90f2-760b7ff050fb@arm.com>
 <20161215113539.GK14217@n2100.armlinux.org.uk>
Message-ID: <06fca797-da5d-f7f2-eecb-9b1b33b7e83f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/16 11:35, Russell King - ARM Linux wrote:
> On Thu, Dec 15, 2016 at 11:18:48AM +0000, Marc Zyngier wrote:
>> On 14/12/16 10:46, Russell King wrote:
>>> @@ -231,10 +244,14 @@ ENDPROC(__hyp_stub_do_trap)
>>>   * initialisation entry point.
>>>   */
>>>  ENTRY(__hyp_get_vectors)
>>> -	mov	r0, #-1
>>> +	mov	r0, #HVC_GET_VECTORS
>>
>> This breaks the KVM implementation of __hyp_get_vectors, easily fixed
>> with the following patchlet:
> 
> Right, so what Mark said is wrong:
> 
> "The hyp-stub is part of the kernel image, and the API is private to
>  that particular image, so we can change things -- there's no ABI to
>  worry about."

I think Mark is right. The API *is* private to the kernel, and KVM being
the only in-kernel hypervisor on ARM, this is not an ABI.

It is an unfortunate bug that no symbolic constant was used to highlight
the two implementations of the same functionality, but I don't think
that makes anything wrong in what Mark said here.

> So no, I'm going with my original patch (which TI has tested) which is
> the minimal change, and if we _then_ want to rework the HYP mode
> interfaces, that's the time to do the other changes when more people
> (such as KVM folk) are paying attention and we can come to a cross-
> hypervisor agreement on what the interface should be.

Given that there is a single in-kernel hypervisor, I can't really see
who we're going to agree anything with...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
