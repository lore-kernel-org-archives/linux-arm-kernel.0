From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jul 2018 11:39:23 +0100
Subject: [PATCH] arm64: fix infinite stacktrace
In-Reply-To: <alpine.LRH.2.02.1807101408150.30968@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1806141457200.4243@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115823.2oq5d7amzwlliczg@lakrids.cambridge.arm.com>
 <20180627164150.GB8729@arm.com>
 <20180628164900.GB26019@e103592.cambridge.arm.com>
 <alpine.LRH.2.02.1807092300520.24277@file01.intranet.prod.int.rdu2.redhat.com>
 <20180710091338.GA29791@arm.com>
 <alpine.LRH.2.02.1807101408150.30968@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180712103922.GC23415@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 02:10:04PM -0400, Mikulas Patocka wrote:
> On Tue, 10 Jul 2018, Will Deacon wrote:
> > On Mon, Jul 09, 2018 at 11:04:33PM -0400, Mikulas Patocka wrote:
> > > Index: linux-2.6/arch/arm64/kernel/stacktrace.c
> > > ===================================================================
> > > --- linux-2.6.orig/arch/arm64/kernel/stacktrace.c	2018-07-10 05:01:56.990000000 +0200
> > > +++ linux-2.6/arch/arm64/kernel/stacktrace.c	2018-07-10 05:02:51.650000000 +0200
> > > @@ -56,6 +56,9 @@ int notrace unwind_frame(struct task_str
> > >  	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
> > >  	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> > >  
> > > +	if (frame->fp == fp)
> > > +		return -EINVAL;
> > 
> > I've already queued your previous patch using '<=' (it's in -next). If you
> > want to change it, please send patches on top of the arm64 for-next/core
> > branch.
> > 
> > Will
> 
> I don't know - is this function supposed to backtrace against more 
> discontiguous stacks? If yes, then the patch with (frame->fp <= fp) is 
> incorrect. If no, then the condition (frame->fp <= fp) could be there.

Ah yes, your original patch breaks with irqstacks, so I'll need to revert
it. Using '==' feels like a big hack to me.

Will
