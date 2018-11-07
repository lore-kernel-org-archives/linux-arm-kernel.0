From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 7 Nov 2018 17:39:14 +0000
Subject: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
In-Reply-To: <20181107171031.22573-1-alex.bennee@linaro.org>
References: <20181107171031.22573-1-alex.bennee@linaro.org>
Message-ID: <CAFEAcA8LL0uC6o1V3W2T=2P47xZ0zGhMR5mEE+x=8qwmDKZL_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2018 at 17:10, Alex Benn?e <alex.bennee@linaro.org> wrote:
> Not all faults handled by handle_exit are instruction emulations. For
> example a ESR_ELx_EC_IABT will result in the page tables being updated
> but the instruction that triggered the fault hasn't actually executed
> yet. We use the simple heuristic of checking for a changed PC before
> seeing if kvm_arm_handle_step_debug wants to claim we stepped an
> instruction.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

What's the rationale for this change? Presumably it's fixing
something, but the commit message doesn't really say what...

This feels to me like it's working around the fact that
we've separated two things ("advance pc (or set it if we're
going to make the guest take an exception)" and "notice that
we have completed a single step") that should be handled
at one point in the code.

thanks
-- PMM
