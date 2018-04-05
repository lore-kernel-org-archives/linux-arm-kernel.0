From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Apr 2018 11:05:01 +0100
Subject: [PATCH] arm64: only advance singlestep for user instruction traps
In-Reply-To: <20180405015144.GC19607@linaro.org>
References: <20180403102251.42309-1-mark.rutland@arm.com>
 <20180405015144.GC19607@linaro.org>
Message-ID: <20180405100500.e6cxtamjsvhztqlk@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 10:51:45AM +0900, AKASHI Takahiro wrote:
> On Tue, Apr 03, 2018 at 11:22:51AM +0100, Mark Rutland wrote:
> > Our arm64_skip_faulting_instruction() helper advances the userspace
> > singlestep state machine, but this is also called by the kernel BRK
> > handler, as used for WARN*().
> > 
> > Thus, if we happen to hit a WARN*() while the user singlestep state
> > machine is in the active-no-pending state, we'll advance to the
> > active-pending state without having executed a user instruction, and
> > will take a step exception earlier than expected when we return to
> > userspace.
> > 
> > Let's fix this by only advancing the state machine when skipping a user
> > instruction.
> 
> Is it possible to have TIF_SINGLESTEP set even if !user_mode()?

I believe this can happen if we're single-stepping a user task, then in
the process of handling some exception (e.g. an instruction abort) we
hit a WARN(). That WARN() will have a BRK, triggering an EL1 BRK64
exception, where !user_mode(regs), but as we're in the context of the
user task, TIF_SINGLESTEP can be set.

> If WARN*() is only an issue, why not fix bug_handler() directly?

In bug_handler() we call arm64_skip_faulting_instruction(), so we'd
either need to open-code the PC modification there, or have a separate
arm64_skip_faulting_{user,kernel}_instruction() helpers.

I'd prototyped the latter, but it was very churny, and this seemed the
simlpest option.

Thanks,
Mark.

> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/traps.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index ba964da31a25..75625a401a4e 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -277,7 +277,8 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> >  	 * If we were single stepping, we want to get the step exception after
> >  	 * we return from the trap.
> >  	 */
> > -	user_fastforward_single_step(current);
> > +	if (user_mode(regs))
> > +		user_fastforward_single_step(current);
> >  }
> >  
> >  static LIST_HEAD(undef_hook);
> > -- 
> > 2.11.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
