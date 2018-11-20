From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 20 Nov 2018 17:18:37 +0000
Subject: [RFC PATCH v2 13/23] KVM: arm64/sve: Context switch the SVE
 registers
In-Reply-To: <87muq3ix62.fsf@linaro.org>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-14-git-send-email-Dave.Martin@arm.com>
 <87sgzxhvny.fsf@linaro.org>
 <20181119170303.GX3505@e103592.cambridge.arm.com>
 <87o9akhr6f.fsf@linaro.org>
 <20181120141659.GZ3505@e103592.cambridge.arm.com>
 <87muq3ix62.fsf@linaro.org>
Message-ID: <20181120171837.GB3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 03:30:29PM +0000, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:

[...]

> >> Put calculating guest_has_sve at the top of __hyp_switch_fpsimd make
> >> most of that go away and just moves things around a little bit. So I
> >> guess it could makes sense for the fast(ish) path although I'd be
> >> interested in knowing if it made any real difference to the numbers.
> >> After all the first read should be well cached and moving it through the
> >> stack is just additional memory and register pressure.
> >
> > Hmmm, I will have a think about this when I respin.
> >
> > Explicitly caching guest_has_sve() does reduce the compiler's freedom to
> > optimise.
> >
> > We might be able to mark it as __pure or __attribute_const__ to enable
> > the compiler to decide whether to cache the result, but this may not be
> > 100% safe.
> >
> > Part of me would prefer to leave things as they are to avoid the risk of
> > breaking the code again...
> 
> Given that the only place you call __hyp_switch_fpsimd is here you could
> just roll in into __hyp_trap_is_fpsimd and have:
> 
> 	if (__hyp_trap_is_fpsimd(vcpu))
> 		return true;

Possibly, though the function should be renamed in this case, something
like __hyp_handle_fpsimd_trap() I guess.

Cheers
---Dave
