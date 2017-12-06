From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 6 Dec 2017 11:54:11 +0000
Subject: [PATCH] arm64: fpsimd: Prevent registers leaking from dead tasks
In-Reply-To: <CAKv+Gu9i_XXxN08BMzV7LRFnMpsqA5TGdNTgwrihNGA3J2r7hQ@mail.gmail.com>
References: <1512485802-29489-1-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu9i_XXxN08BMzV7LRFnMpsqA5TGdNTgwrihNGA3J2r7hQ@mail.gmail.com>
Message-ID: <20171206115411.GA22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 09:57:15AM +0000, Ard Biesheuvel wrote:
> On 5 December 2017 at 14:56, Dave Martin <Dave.Martin@arm.com> wrote:

[...]

> > This patch fixes the problem by ensuring that the sched-in check
> > fails in (5): fpsimd_flush_task_state(T) is called when T is
> > forked, so that T->thread.fpsimd_state.cpu == C cannot be true.
> > This relies on the fact that T is not schedulable until after
> > copy_thread() completes.
> >
> > Once T's fpsimd state has been loaded on some CPU C there may still
> > be other cpus D for which per_cpu(fpsimd_last_state, D) ==
> > &X->thread.fpsimd_state.  But D is necessarily != C in this case,
> > and the check in (5) must fail.
> >
> > An alternative fix would be to do refcounting on task_struct.  This
> > would result in each CPU holding a reference to the last task whose
> > fpsimd state was loaded there.  It's not clear whether this is
> > preferable, and it involves higher overhead than the fix proposed
> > in this patch.  It would also moves all the task_struct freeing
> 
> move
> 
> > work into the context switch critical section, or otherwise some
> > deferred cleanup mechanism would need to be introduced, neither of
> > which seems obviously justified.
> >
> > Fixes: 005f78cd8849 ("arm64: defer reloading a task's FPSIMD state to userland resume")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kernel/process.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index b2adcce..5387d15 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -313,6 +313,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
> >          */
> >         clear_tsk_thread_flag(p, TIF_SVE);
> >         p->thread.sve_state = NULL;
> > +       fpsimd_flush_task_state(p);
> >
> >         if (likely(!(p->flags & PF_KTHREAD))) {
> >                 *childregs = *current_pt_regs();
> > --
> > 2.1.4
> >
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks
---Dave
