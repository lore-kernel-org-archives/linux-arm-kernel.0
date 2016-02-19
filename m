From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 19 Feb 2016 10:52:29 +0000
Subject: [PATCH] arm64: kasan: clear stale stack poison
In-Reply-To: <20160218181356.GF2538@e104818-lin.cambridge.arm.com>
References: <1455816458-19485-1-git-send-email-mark.rutland@arm.com>
 <20160218175447.GD2538@e104818-lin.cambridge.arm.com>
 <20160218180353.GG16883@arm.com>
 <20160218181356.GF2538@e104818-lin.cambridge.arm.com>
Message-ID: <20160219105229.GA18597@red-moon>
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
> avoid an unnecessary function call. Or we just move cpu_suspend() to a
> different compilation unit, though that's a slightly larger function
> which we may want to track under KASAN.

Both options are ok with me. There is one more. We pass the "saved" sp
to __cpu_suspend_save (ie in cpu_suspend_ctx), you can stash it and
use it in the resume path (through logical cpu indexing) to carry
out the kasan clean-up, in C, with no wrapper needed.

With James' hibernate patches:

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/408597.html

this is going to be even easier, since the struct above is on the
cpu_suspend stack upon cpu_resume, so you can use the sp in there
straight away.

We can put together a fix following Catalin's suggestion and when James'
patches land in mainline we will update the code.

Thanks,
Lorenzo
