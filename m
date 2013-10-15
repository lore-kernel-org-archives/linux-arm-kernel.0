From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Oct 2013 17:53:58 +0100
Subject: [RFC v3 PATCH 0/7] ARM[64]: kernel mode NEON in atomic contexts
In-Reply-To: <alpine.LFD.2.03.1310151104000.1873@syhkavp.arg>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1310142353210.1873@syhkavp.arg>
 <CAKv+Gu-rbNmwJf09JVUYYyJjoGrJqpsrv=x_wWMJ6r-EofbYDQ@mail.gmail.com>
 <alpine.LFD.2.03.1310151104000.1873@syhkavp.arg>
Message-ID: <20131015165358.GF1591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 05:05:48PM +0100, Nicolas Pitre wrote:
> On Tue, 15 Oct 2013, Ard Biesheuvel wrote:
> 
> > On 15 October 2013 06:01, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > On Sun, 13 Oct 2013, Ard Biesheuvel wrote:
> > >
> > >> The stack area is allocated by DEFINE_NEON_REGSTACK[_PARTIAL](varname), where
> > >> the partial version takes an additional int num_regs indicating how many
> > >> registers need to be freed up.
> > >>
> > >> In the !in_interrupt() case, these functions operate as before, and the regstack
> > >> is defined to minimal size in this case as it will remain unused anyway. In the
> > >> in_interrupt() case, 'num_regs' (or all) NEON registers are stacked/unstacked
> > >> using the allocated stack region.
> > >
> > > Would have been nice to have the stack simply be a NULL pointer when
> > > !in_interrupt() or when the number of regs is 0.  This would remove the
> > > need for a runtime check on !num_regs.  I don't see an obvious way to
> > > accomplish that right now though.
> > >
> > 
> > We could address both of these issues by implementing Catalin's
> > suggestion to reserve per-process vfp_states[] for both irq and
> > softirq context in addition to the ordinary one, but it would waste a
> > lot of space imo. What is your take on that?
> 
> I agree that this would be rather wasteful.  I really like your current 
> approach of dynamically allocating just the right amount of space on the 
> stack.  I'm not a big fan of statically allocated memory which is 
> seldomly used.

I agree here, especially since we need to cover both soft and hard irqs.
It would be about 1KB per CPU, not noticeable even on big systems but
still looks like it's only going to be used rarely.

-- 
Catalin
