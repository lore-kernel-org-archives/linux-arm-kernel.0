From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Oct 2013 12:05:48 -0400 (EDT)
Subject: [RFC v3 PATCH 0/7] ARM[64]: kernel mode NEON in atomic
 contexts
In-Reply-To: <CAKv+Gu-rbNmwJf09JVUYYyJjoGrJqpsrv=x_wWMJ6r-EofbYDQ@mail.gmail.com>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1310142353210.1873@syhkavp.arg>
 <CAKv+Gu-rbNmwJf09JVUYYyJjoGrJqpsrv=x_wWMJ6r-EofbYDQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1310151104000.1873@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Oct 2013, Ard Biesheuvel wrote:

> On 15 October 2013 06:01, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Sun, 13 Oct 2013, Ard Biesheuvel wrote:
> >
> >> The stack area is allocated by DEFINE_NEON_REGSTACK[_PARTIAL](varname), where
> >> the partial version takes an additional int num_regs indicating how many
> >> registers need to be freed up.
> >>
> >> In the !in_interrupt() case, these functions operate as before, and the regstack
> >> is defined to minimal size in this case as it will remain unused anyway. In the
> >> in_interrupt() case, 'num_regs' (or all) NEON registers are stacked/unstacked
> >> using the allocated stack region.
> >
> > Would have been nice to have the stack simply be a NULL pointer when
> > !in_interrupt() or when the number of regs is 0.  This would remove the
> > need for a runtime check on !num_regs.  I don't see an obvious way to
> > accomplish that right now though.
> >
> 
> We could address both of these issues by implementing Catalin's
> suggestion to reserve per-process vfp_states[] for both irq and
> softirq context in addition to the ordinary one, but it would waste a
> lot of space imo. What is your take on that?

I agree that this would be rather wasteful.  I really like your current 
approach of dynamically allocating just the right amount of space on the 
stack.  I'm not a big fan of statically allocated memory which is 
seldomly used.

What I meant by my suggestion was something like this:

#define kernel_neon_begin(p) \
	__kernel_neon_begin(sizeof((p).qregs) ? &(p).regs : NULL, \
			    sizeof((p).qregs)/16)

However it seems gcc is not clever enough to optimize the stack usage 
away at all in that case which is worse than your current version.  So 
better forget about this suggestion.


Nicolas
