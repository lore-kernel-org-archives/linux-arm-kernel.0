From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 18:16:16 +0100
Subject: [PATCH] Add missing include of linux/ftrace.h
In-Reply-To: <20111001171202.GA13684@gallagher>
References: <1317309202-1001-1-git-send-email-jamie@jamieiles.com>
	<20111001163511.GI11710@n2100.arm.linux.org.uk>
	<20111001171202.GA13684@gallagher>
Message-ID: <20111001171616.GO11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2011 at 06:12:02PM +0100, Jamie Iles wrote:
> On Sat, Oct 01, 2011 at 05:35:11PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Sep 29, 2011 at 04:13:22PM +0100, Jamie Iles wrote:
> > > __exception_irq_entry uses __irq_entry which is defined in
> > > linux/ftrace.h.
> > > 
> > > Reported-by: Zoltan Devai <zdevai@gmail.com>
> > > Cc: Rabin Vincent <rabin@rab.in>
> > > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > 
> > This introduces a circular dependency:
> > 
> > linux/ftrace.h -> linux/kallsyms.h -> linux/kernel.h -> linux/bitops.h
> >  -> asm/bitops.h -> asm/system.h -> linux/ftrace.h
> > 
> > This is not good as it means that we end up with indeterminant effects
> > happening depending on where in that cycle the first include happens.
> 
> Crap.  I don't think having users of __exception_irq_entry include 
> linux/ftrace.h is great, so how about this instead?

This looks much better - and won't involve any circular dependencies.
It might be worth adding a comment in the new header file that this
should only be used on functions called from the low level entry code
and not from intervening C code.

Finally, could you stick it in the patch system please?

Thanks.
