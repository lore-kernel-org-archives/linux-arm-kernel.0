From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 14:46:50 +0100
Subject: [RFC PATCH] arm64: neon: Remove support for nested or hardirq
 kernel-mode NEON
In-Reply-To: <CAKv+Gu8KKuD6Rgbq++kzJayHN8X-Kb7vrS-aj=N_kymqSnfVdQ@mail.gmail.com>
References: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu8KKuD6Rgbq++kzJayHN8X-Kb7vrS-aj=N_kymqSnfVdQ@mail.gmail.com>
Message-ID: <20170519134650.GE3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 01:34:37PM +0100, Ard Biesheuvel wrote:
> On 19 May 2017 at 12:26, Dave Martin <Dave.Martin@arm.com> wrote:
> > The benefits of nested kernel-mode NEON may be marginal.  Likewise,
> > use of kernel-mode NEON in hardirq context is rare to nonexistent.
> >
> 
> The only use case for kernel mode NEON outside of process context is
> the mac80211 subsystem which performs crypto on the packets in softirq
> context.
> 
> > Removing support for these eliminates signifcant cost and complexity.
> >
> 
> typo: significant

Good spot -- thanks.

[...]

> > This patch is broken without some conversion of preempt_disable()/
> > enable() to local_bh_disable()/enable() around some of the context
> > handling code in fpsimd.c, in order to be robust against the task's
> > FPSIMD context being unexpectedly saved by a preempting softirq.
> >
> 
> Yes, this is basically the issue we originally discussed in the
> context of SVE support.

Agreed -- I'll come back to that.

[...]

> > diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h

[...]

> > +#ifdef CONFIG_KERNEL_MODE_NEON
> > +
> > +extern DEFINE_PER_CPU(local_t, kernel_neon_busy);
> 
> DECLARE_PER_CPU

Arg, yes.

> 
> > +
> > +/*
> > + * Returns true if and only if it is safe to call kernel_neon_begin().
> > + * Callers must not assume that the result remains true beyond the next
> > + * preempt_enable() or return from softirq context.
> > + */
> > +static bool __maybe_unused kernel_neon_allowed(void)
> 
> If you make it static inline, you don't need the __maybe_unused

True.  I'm a bit prejudiced against inline due to the inconsistent
interpretations between C/C++/gcc.

But it is cleaner and it's used with an appropriate meaning
elsewhere in the kernel.

[...]

> > +        * If we are in between kernel_neon_begin()...kernel_neon_end(), the
> > +        * flag will be set, but preemption is also disabled, so we can't
> > +        * migrate to another CPU and spuriously see it become false.
> > +        */
> > +       return !(in_irq() || in_nmi()) &&
> > +               !local_read(this_cpu_ptr(&kernel_neon_busy));
> 
> For readability, could we change this to '!x && !y && !z' instead?

Agreed, this mis-evolved from !in_irq() && !local_read(...

[...]

> static inline here as well

Ditto

[...]

> > -       }
> > +
> > +       busy = local_xchg(this_cpu_ptr(&kernel_neon_busy), 0);
> > +       WARN_ON(!busy); /* No matching kernel_neon_begin()? */
> > +
> > +       preempt_enable();
> >  }
> >  EXPORT_SYMBOL(kernel_neon_end);

[...]

> I think the general approach is sound. I still think we could call
> kernel_neon_allowed() may_use_simd(), and let it override the
> asm-generic version in asm/simd.h. In any case, given this is a prereq
> for SVE support which is still far out, we should probably phase this
> change by migrating KMN users to kernel_neon_allowed/may_use_simd
> first (and add a 'return true' version for the former if needed), so
> that the crypto changes can be queued for v4.13

OK -- when do you expect your kernel-mode-neon series (or relevant bits
of it) to be merged?  With that in place, I can carry this patch in
the SVE series, or propose it to be merged separately.

I'd also expect CONFIG_KERNEL_NEON_MODE_NEON_FALLBACK and
kernel_neon_need_fallback() to be folded in (=y and true respectively),
since removal of nesting support will mean that fallback code is always
needed for clients that may run elsewhere than in task context.

Cheers
---Dave
