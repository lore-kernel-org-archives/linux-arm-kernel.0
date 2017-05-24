From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 May 2017 08:42:28 -0700
Subject: [RFC PATCH v2 2/2] arm64: neon: Remove support for nested or
 hardirq kernel-mode NEON
In-Reply-To: <20170524153555.GM3559@e103592.cambridge.arm.com>
References: <1495636986-30515-1-git-send-email-Dave.Martin@arm.com>
 <1495636986-30515-3-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu8+y9qrQqLWqpmwcd61L+vMN2iOTqFmK6dVJOFy0oiSbQ@mail.gmail.com>
 <20170524153555.GM3559@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu8OPzm1fnxthgjqLxezB2K-Xja0=fBX3M-uvGOYWBq2Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2017 at 08:35, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, May 24, 2017 at 08:22:18AM -0700, Ard Biesheuvel wrote:
>> On 24 May 2017 at 07:42, Dave Martin <Dave.Martin@arm.com> wrote:
>> > Support for kernel-mode NEON to be nested and/or used in hardirq
>> > context adds significant complexity, and the benefits may be
>> > marginal.  In practice, kernel-mode NEON is not used in hardirq
>> > context, and is rarely used in softirq context (by certain mac80211
>> > drivers).
>> >
>> > This patch implements an arm64 may_use_simd() function to allow
>> > clients to check whether kernel-mode NEON is usable in the current
>> > context, and simplifies kernel_neon_{begin,end}() to handle only
>> > saving of the task FPSIMD state (if any).  Without nesting, there
>> > is no other state to save.
>> >
>> > The partial fpsimd save/restore functions become redundant as a
>> > result of these changes, so they are removed too.
>> >
>> > The save/restore model is changed to operate directly on
>> > task_struct without additional percpu storage.  This simplifies the
>> > code and saves a bit of memory, but means that softirqs must now be
>> > disabled when manipulating the task fpsimd state from task context:
>> > correspondingly, preempt_{en,dis}sable() calls are upgraded to
>> > local_bh_{en,dis}able() as appropriate, and softirqs are also
>> > disabled around the context switch code in fpsimd_thread_switch().
>> > The will be some increase in softirq latency, but hardirqs should
>> > be unaffected.
>> >
>> > These changes should make it easier to support kernel-mode NEON in
>> > the presence of the Scalable Vector Extension in the future.
>> >
>> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>
> [...]
>
>> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> > index 06da8ea..02023da 100644
>> > --- a/arch/arm64/kernel/fpsimd.c
>> > +++ b/arch/arm64/kernel/fpsimd.c
>> > @@ -17,16 +17,20 @@
>
> [...]
>
>> > + * In order to allow softirq handlers to use FPSIMD, kernel_neon_begin() may
>> > + * save the task's FPSIMD context back to task_struct from softirq context.
>> > + * To prevent this from racing with the manipulation of the task's FPSIMD state
>> > + * from task context and thereby corrupting the state, it is necessary to
>> > + * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
>> > + * flag with local_bh_disable().
>> > + *
>>
>> Surely, this doesn't mean all kernel mode NEON should execute with
>> bottom halves disabled? Because that is what this patch appears to be
>> doing.
>
> Dang, I was deliberately paranoid when updating
> kernel_neon_{begin,end}(), but was _too_ paranoid.
>
> softirq must be masked around the read-modify-write on
> TIF_FOREIGN_FPSTATE and thread.fpsimd_state: from kernel_neon_begin() to
> kernel_neon_end() we only need to disable preemption, to hide the lack
> of context switch machinery for kernel-mode NEON state in task context
> (as at present).
>
> I think they should do:
>
> [...]
>
>> > +void kernel_neon_begin(void)
>> >  {
>> >         if (WARN_ON(!system_supports_fpsimd()))
>> >                 return;
>
> [...]
>
>> > +       BUG_ON(!may_use_simd());
>> > +
>> > +       local_bh_disable();
>> > +
>> > +       __this_cpu_write(kernel_neon_busy, true);
>> > +
>> > +       /*
>> > +        * If there is unsaved task fpsimd state in the CPU, save it
>> > +        * and invalidate the copy stored in the fpsimd regs:
>> > +        */
>> > +       if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
>> > +               fpsimd_save_state(&current->thread.fpsimd_state);
>> >                 this_cpu_write(fpsimd_last_state, NULL);
>> >         }
>
>         preempt_disable();
>
>         local_bh_enable();
>
>> >  }
>> > -EXPORT_SYMBOL(kernel_neon_begin_partial);
>> > +EXPORT_SYMBOL(kernel_neon_begin);
>> >
>> > +/*
>> > + * kernel_neon_end(): give the CPU FPSIMD registers back to the current task
>> > + *
>> > + * Must be called from a context in which kernel_neon_begin() was previously
>> > + * called, with no call to kernel_neon_end() in the meantime.
>> > + *
>> > + * The caller must not use the FPSIMD registers after this function is called,
>> > + * unless kernel_neon_begin() is called again in the meantime.
>> > + */
>> >  void kernel_neon_end(void)
>> >  {
>> > +       bool busy;
>> > +
>> >         if (!system_supports_fpsimd())
>> >                 return;
>
> [...]
>
>> > +
>> > +       busy = __this_cpu_xchg(kernel_neon_busy, false);
>> > +       WARN_ON(!busy); /* No matching kernel_neon_begin()? */
>> > +
>
>         preempt_enable();
>
>> >  }
>> >  EXPORT_SYMBOL(kernel_neon_end);
>
> Make sense?
>


Yes, that looks more like what I was expecting
