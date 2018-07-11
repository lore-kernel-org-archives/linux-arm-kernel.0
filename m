From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 16:47:58 +0100
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
In-Reply-To: <CAKv+Gu-PLsWZLPM-OfXHLGKs7PojRB4jFsyp+X_5OW6ryi7gRQ@mail.gmail.com>
References: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
 <CAKv+Gu-PLsWZLPM-OfXHLGKs7PojRB4jFsyp+X_5OW6ryi7gRQ@mail.gmail.com>
Message-ID: <20180711154758.4k2phfrzl2r5m34o@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 09:20:03AM +0200, Ard Biesheuvel wrote:
> On 11 July 2018 at 03:09, Yandong.Zhao <yandong77520@gmail.com> wrote:
> > From: Yandong Zhao <yandong77520@gmail.com>
> >
> > It does not matter if the caller of may_use_simd() migrates to
> > another cpu after the call, but it is still important that the
> > kernel_neon_busy percpu instance that is read matches the cpu the
> > task is running on at the time of the read.
> >
> > This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
> > may appear true if the caller migrates during the execution of
> > raw_cpu_read() and the next task to be scheduled in on the initial
> > cpu calls kernel_neon_begin().
> >
> > This patch replaces raw_cpu_read() with this_cpu_read() to protect
> > against this race.
> >
> > Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> 
> I had a bit of trouble disentangling the per-cpu spaghetti to decide
> whether this may trigger warnings when CONFIG_DEBUG_PREEMPT=y, but I
> don't think so. So assuming this is *not* the case:

It shouldn't, since:

* this_cpu_*() are prempt-safe

* __this_cpu_*() are not preempt-safe (and warn when preemptible)

* raw_cpu_*() are not preempt safe (but don't warn when preemptible)

> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> 
> > ---
> >  arch/arm64/include/asm/simd.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> > index fa8b3fe..784a8c2 100644
> > --- a/arch/arm64/include/asm/simd.h
> > +++ b/arch/arm64/include/asm/simd.h
> > @@ -29,7 +29,8 @@
> >  static __must_check inline bool may_use_simd(void)
> >  {
> >         /*
> > -        * The raw_cpu_read() is racy if called with preemption enabled.
> > +        * The this_cpu_read() is racy if called with preemption enabled,
> > +        * since the task may subsequently migrate to another CPU.
> >          * This is not a bug: kernel_neon_busy is only set when
> >          * preemption is disabled, so we cannot migrate to another CPU
> >          * while it is set, nor can we migrate to a CPU where it is set.

It would be nice if we could clarify the "is racy" part here.

How about:

	/*
	 * kernel_neon_busy is only set while preemption is disabled,
	 * and is clear whenever preemption is enabled. Since
	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
	 * cannot change under our feet -- if it's set we cannot be
	 * migrated, and if it's clear we cannot be migrated to a CPU
	 * where it is set.
	 */

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm..com>

Thanks,
Mark.

> > @@ -42,7 +43,7 @@ static __must_check inline bool may_use_simd(void)
> >          * false.
> >          */
> >         return !in_irq() && !irqs_disabled() && !in_nmi() &&
> > -               !raw_cpu_read(kernel_neon_busy);
> > +               !this_cpu_read(kernel_neon_busy);
> >  }
> >
> >  #else /* ! CONFIG_KERNEL_MODE_NEON */
> > --
> > 1.9.1
> >
