From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Feb 2018 09:08:31 +0000
Subject: [PATCH v3 12/18] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast
 handling
In-Reply-To: <20180204183907.GP21802@cbox>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-13-marc.zyngier@arm.com> <20180204183907.GP21802@cbox>
Message-ID: <1d30fe51-22dd-6938-2f8f-c823858a3bbd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/18 18:39, Christoffer Dall wrote:
> On Thu, Feb 01, 2018 at 11:46:51AM +0000, Marc Zyngier wrote:
>> We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
>> So let's intercept it as early as we can by testing for the
>> function call number as soon as we've identified a HVC call
>> coming from the guest.
> 
> Hmmm.  How often is this expected to happen and what is the expected
> extra cost of doing the early-exit handling in the C code vs. here?

Pretty often. On each context switch of a Linux guest, for example. It
is almost as bad as if we were trapping all VM ops. Moving it to C is
definitely visible on something like hackbench (I remember something
like a 10-12% degradation on Seattle, but I'd need to rerun the tests to
give you something accurate). It is the whole GPR save/restore dance
that costs us a lot (31 registers for the guest, 12 for the host), plus
some the extra SError synchronization that doesn't come for free either.

> I think we'd be better off if we only had a single early-exit path (and
> we should move the FP/SIMD trap to that path as well), but if there's a
> measurable benefit of having this logic in assembly as opposed to in the
> C code, then I'm ok with this as well.

I agree that the multiplication of "earlier than early" paths is
becoming annoying. Moving the FP/SIMD stuff to C would be less
problematic, as we have patches to move some of that to load/put, and
we'd only take the trap once per time slice (as opposed to once per
entry at the moment).

Here, we're trying hard to do exactly nothing, because each instruction
is just an extra overhead (we've already nuked the BP). I even
considered inserting that code as part of the per-CPU-type vectors (and
leave the rest of the KVM code alone), but it felt like a step too far.

> The code in this patch looks fine otherwise.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
