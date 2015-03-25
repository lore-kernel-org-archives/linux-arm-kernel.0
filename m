From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 09:48:14 +0000
Subject: [RFC 1/4] arm64: kvm: add a cpu tear-down function
In-Reply-To: <55126C6F.2080500@linaro.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
 <1427111639-4575-2-git-send-email-takahiro.akashi@linaro.org>
 <551135AE.1080401@arm.com> <55126C6F.2080500@linaro.org>
Message-ID: <5512845E.40804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

On 25/03/15 08:06, AKASHI Takahiro wrote:

>>> +	/* Switch back to boot page tables */
>>> +	msr	ttbr0_el2, x0
>>> +	isb
>>
>> This is the place where you want TLBI to occur.
> 
> Will remove tlbi above and put it here.

There is only need for one TLBI, if at all.

>>> +	/* Branch into PA space */
>>> +	adr	x0, 1f
>>> +	bfi	x1, x0, #0, #PAGE_SHIFT
>>> +	br	x1
>>> +
>>> +	/* We're now in idmap */
>>> +1:	/* Invalidate the old TLBs again */
>>> +	tlbi	alle2
>>> +	dsb	sy
>>
>> See? This is the only TLBI that actually makes sense. Now, given that
>> you are actually disabling the MMU, I'm not sure these TBLIs make much
>> sense.
> 
> Probably you're right, but
> otherwise, I guess, bogus TLB might remain and be used when MMU get enabled again.
> (MMU setting would be the same across disabling/enabling hyp mode though.)

Anyone enabling the MMU must invalidate the TLB before doing so (we've
been caught by that before). Invalidation on the way out doesn't hurt,
but it also give a false sense of security.

I'll leave it up to you.

Thanks,

	M.

-- 
Jazz is not dead. It just smells funny...
