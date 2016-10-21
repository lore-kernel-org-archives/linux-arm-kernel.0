From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 13:54:39 +0100
Subject: [PATCH] arm64: fix show_regs fallout from KERN_CONT changes
In-Reply-To: <3a8485da-3f7d-07f8-95db-281e0115494d@arm.com>
References: <1476962596-21046-1-git-send-email-mark.rutland@arm.com>
 <3a8485da-3f7d-07f8-95db-281e0115494d@arm.com>
Message-ID: <20161021125439.GE16630@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 21, 2016 at 12:34:11PM +0100, Robin Murphy wrote:
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index ddce61b..3f31cf93 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -187,10 +187,19 @@ void __show_regs(struct pt_regs *regs)
> >  	printk("pc : [<%016llx>] lr : [<%016llx>] pstate: %08llx\n",
> >  	       regs->pc, lr, regs->pstate);
> >  	printk("sp : %016llx\n", sp);
> > -	for (i = top_reg; i >= 0; i--) {
> > +
> > +	i = top_reg;
> > +
> > +	while (i >= 0) {
> >  		printk("x%-2d: %016llx ", i, regs->regs[i]);
> > -		if (i % 2 == 0)
> > -			printk("\n");
> > +		i--;
> > +
> > +		if (i % 2 == 0) {
> > +			pr_cont("x%-2d: %016llx ", i, regs->regs[i]);
> > +			i--;
> > +		}
> > +
> > +		pr_cont("\n");
> >  	}
> 
> Might it be nicer to simply do this (or thereabouts)?

I don't think so; top_reg is either 12 (for compat), or 29 (for native),
so for the compat case, with the existing code the first line should be
one register (r12), with r1; r0 on the final line.

> 	for (i = top_reg; i > 1; i -= 2)
> 		printk("x%-2d: %016llx x%-2d: %016llx\n", i-1,
> 			regs->regs[i-1], i, regs->regs[i]);

... whereas here the first line would be two (r12 and r11) ... 

> 	if (i > 0)
> 		printk("x%-2d: %016llx\n", i-1, regs->regs[i-1]);

... and then r0 on its own.

Perhaps that's fine, but it would differ from the existing behaviour,
and make native and compat noticeably different.

We could try fixing up the first line prior to the loop, but that still
requires duplicating the format string thrice, manipulation of i, etc.

It looks like Will's taken my patch as-is, but if we can clean this up
further it would certainly be nice.

Thanks,
Mark.
