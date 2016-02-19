From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 19 Feb 2016 11:35:57 +0000
Subject: [PATCH] arm64: kasan: clear stale stack poison
In-Reply-To: <20160218181356.GF2538@e104818-lin.cambridge.arm.com>
References: <1455816458-19485-1-git-send-email-mark.rutland@arm.com>
 <20160218175447.GD2538@e104818-lin.cambridge.arm.com>
 <20160218180353.GG16883@arm.com>
 <20160218181356.GF2538@e104818-lin.cambridge.arm.com>
Message-ID: <20160219113556.GA7797@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 06:13:57PM +0000, Catalin Marinas wrote:
> On Thu, Feb 18, 2016 at 06:03:54PM +0000, Will Deacon wrote:
> > On Thu, Feb 18, 2016 at 05:54:47PM +0000, Catalin Marinas wrote:
> > > On Thu, Feb 18, 2016 at 05:27:38PM +0000, Mark Rutland wrote:
> > > > @@ -145,6 +146,7 @@ ENTRY(cpu_resume_mmu)
> > > >  ENDPROC(cpu_resume_mmu)
> > > >  	.popsection
> > > >  cpu_resume_after_mmu:
> > > > +	kasan_unpoison_stack 96
> > > 
> > > I don't think the 96 here is needed since we populate the stack in
> > > assembly (__cpu_suspend_enter) and unwind it again still in assembly
> > > (cpu_resume_after_mmu), so no KASAN shadow writes/reads.
> > > 
> > > Otherwise the patch looks fine.
> > 
> > I'd much rather it was written in C -- is there a reason we can't do
> > that if we use a separate compilation unit where the compiler will
> > honour the fno-sanitize flag?
> 
> A simple, non-sanitised C wrapper around __cpu_suspend_enter() would
> probably work. We need to make sure it is static inline when !KASAN to
> avoid an unnecessary function call.

I think this could work, but I don't see a way that we can get a safe
value of the SP. Using current_stack_pointer() only gives us a snapshot,
and the real SP value may move before/after. So that snaphot, even if
taken in cpu_suspend, is not guaranteed to be above all the shadow
poison.

> Or we just move cpu_suspend() to a different compilation unit, though
> that's a slightly larger function which we may want to track under
> KASAN.

If we're going to force something into another compilation unit, that
may as well be the functions on the critical path:
psci_suspend_finisher, psci_cpu_suspend, and invoke_psci_fn_*.

Then we don't need to bother with the clearing on the return path at
all, as there should never be any stale shadow to begin with.

Thanks,
Mark.
