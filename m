From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 9 May 2014 14:37:27 +0100
Subject: [RFC][PATCH 6/8] sched,idle: Avoid spurious wakeup IPIs
In-Reply-To: <20140411135218.478299389@infradead.org>
References: <20140411134243.160989490@infradead.org>
 <20140411135218.478299389@infradead.org>
Message-ID: <CAAG0J9_q1KsUx10-XAb7AJnxv2ehctg6q1KME7ahsk1OZV8vZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 11 April 2014 14:42, Peter Zijlstra <peterz@infradead.org> wrote:
> Because mwait_idle_with_hints() gets called from !idle context it must
> call current_clr_polling(). This however means that resched_task() is
> very likely to send an IPI even when we were polling:
>
>   CPU0                                  CPU1
>
>   if (current_set_polling_and_test())
>     goto out;
>
>   __monitor(&ti->flags);
>   if (!need_resched())
>     __mwait(eax, ecx);
>                                         set_tsk_need_resched(p);
>                                         smp_mb();
> out:
>   current_clr_polling();
>                                         if (!tsk_is_polling(p))
>                                           smp_send_reschedule(cpu);
>
>
> So while it is correct (extra IPIs aren't a problem, whereas a missed
> IPI would be) it is a performance problem (for some).
>
> Avoid this issue by using fetch_or() to atomically set NEED_RESCHED
> and test if POLLING_NRFLAG is set.
>
> Since a CPU stuck in mwait is unlikely to modify the flags word,
> contention on the cmpxchg is unlikely and thus we should mostly
> succeed in a single go.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/core.c |   41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -505,6 +505,39 @@ static inline void init_hrtick(void)
>  #endif /* CONFIG_SCHED_HRTICK */
>
>  /*
> + * cmpxchg based fetch_or, macro so it works for different integer types
> + */
> +#define fetch_or(ptr, val)                                             \
> +({     typeof(*(ptr)) __old, __val = *(ptr);                           \
> +       for (;;) {                                                      \
> +               __old = cmpxchg((ptr), __val, __val | (val));           \
> +               if (__old == __val)                                     \
> +                       break;                                          \
> +               __val = __old;                                          \
> +       }                                                               \
> +       __old;                                                          \
> +})
> +
> +#ifdef TIF_POLLING_NRFLAG
> +/*
> + * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
> + * this avoids any races wrt polling state changes and thereby avoids
> + * spurious IPIs.
> + */
> +static bool set_nr_and_not_polling(struct task_struct *p)
> +{
> +       struct thread_info *ti = task_thread_info(p);
> +       return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);

This breaks the build on metag, and I suspect arm64 too:

kernel/sched/core.c In function ?set_nr_and_not_polling?:
kernel/sched/core.c +531 : error: ?_TIF_POLLING_NRFLAG? undeclared

since metag/arm64 define TIF_POLLING_NRFLAG but not
_TIF_POLLING_NRFLAG. Could you please fix that prior to your patch to
avoid breaking bisection?

BTW what is it that determines whether an arch needs TIF_POLLING_NRFLAG?

Thanks
James


> +}
> +#else
> +static bool set_nr_and_not_polling(struct task_struct *p)
> +{
> +       set_tsk_need_resched(p);
> +       return true;
> +}
> +#endif
> +
> +/*
>   * resched_task - mark a task 'to be rescheduled now'.
>   *
>   * On UP this means the setting of the need_resched flag, on SMP it
> @@ -520,17 +553,15 @@ void resched_task(struct task_struct *p)
>         if (test_tsk_need_resched(p))
>                 return;
>
> -       set_tsk_need_resched(p);
> -
>         cpu = task_cpu(p);
> +
>         if (cpu == smp_processor_id()) {
> +               set_tsk_need_resched(p);
>                 set_preempt_need_resched();
>                 return;
>         }
>
> -       /* NEED_RESCHED must be visible before we test polling */
> -       smp_mb();
> -       if (!tsk_is_polling(p))
> +       if (set_nr_and_not_polling(p))
>                 smp_send_reschedule(cpu);
>  }
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
