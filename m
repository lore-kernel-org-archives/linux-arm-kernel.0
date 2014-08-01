From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 01 Aug 2014 10:11:52 +0100
Subject: [PATCH] arm64: KVM: export current vcpu->pause state via pseudo
 regs
In-Reply-To: <20140731163805.GK11610@cbox>
References: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
 <20140731143538.GI11610@cbox> <87mwbpimgz.fsf@linaro.org>
 <20140731163805.GK11610@cbox>
Message-ID: <87fvhgin6s.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall writes:

> On Thu, Jul 31, 2014 at 04:14:51PM +0100, Alex Benn?e wrote:
>> 
>> Christoffer Dall writes:
>> 
>> > On Wed, Jul 09, 2014 at 02:55:12PM +0100, Alex Benn?e wrote:
>> >> To cleanly restore an SMP VM we need to ensure that the current pause
>> >> state of each vcpu is correctly recorded. Things could get confused if
>> >> the CPU starts running after migration restore completes when it was
>> >> paused before it state was captured.
>> >> 
>> <snip>
>> >> +/* Power state (PSCI), not real registers */
>> >> +#define KVM_REG_ARM_PSCI		(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
>> >> +#define KVM_REG_ARM_PSCI_REG(n) \
>> >> +	(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_PSCI | \
>> >> +         (n & ~KVM_REG_ARM_COPROC_MASK))
>> >
>> > I don't understand this mask, why isn't this
>> >             (n & 0xffff))
>> 
>> I was trying to use the existing masks, but of course if anyone changes
>> that it would be an ABI change so probably not worth it.
>> 
>
> the KVM_REG_ARM_COPROC_MASK is part of the uapi IIRC, so that's not the
> issue, but that mask doesn't cover all the upper bits, so it feels weird
> to use that to me.

Yeah I missed that. I could do a:

#define KVM_REG_ARM_COPROC_INDEX_MASK   ((1<<KVM_REG_ARM_COPROC_SHIFT)-1)

and use that. I'm generally try to avoid hardcoded numbers but I could
be being a little OCD here ;-)

>> > Can you add the 32-bit counterpart as part of this patch?
>> 
>> Same patch? Sure.
>
> really up to you if you want to split it up into two patches, but I
> think it's small enough that you can just create one patch.

Given the similarity of this code between arm and arm64 I'm wondering if
it's worth doing a arch/arm/kvm/guest_common.c or something to reduce
the amount of copy paste stuff?

-- 
Alex Benn?e
