From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Jan 2013 11:35:25 +0000
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <20130111105525.GC12977@mudshark.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
 <20130110230542.GB11628@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301102006370.6300@xanadu.home>
 <20130111105525.GC12977@mudshark.cambridge.arm.com>
Message-ID: <20130111113525.GE1966@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 10:55:26AM +0000, Will Deacon wrote:
> On Fri, Jan 11, 2013 at 01:26:21AM +0000, Nicolas Pitre wrote:
> > On Thu, 10 Jan 2013, Will Deacon wrote:
> > > On Thu, Jan 10, 2013 at 12:20:36AM +0000, Nicolas Pitre wrote:
> > > > +
> > > > +extern volatile unsigned long bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];
> > > 
> > > Does this actually need to be volatile? I'd have thought a compiler
> > > barrier in place of the smp_wmb below would be enough (following on from
> > > Catalin's comments).
> > 
> > Actually, I did the reverse i.e. I removed the smp_wmb() entirely. A 
> > compiler barrier forces the whole world to memory while here we only 
> > want this particular assignment to be pushed out.
> > 
> > Furthermore, I like the volatile as it flags that this is a special 
> > variable which in this case is also accessed from CPUs with no cache.
> 
> Ok, fair enough. Given that the smp_wmb isn't needed that sounds better.
> 
> > > > +	/* We didn't expect this CPU.  Try to make it quiet. */
> > > > +1:	wfi
> > > > +	wfe
> > > > +	b	1b
> > > 
> > > I realise this CPU is stuck at this point, but you should have a dsb
> > > before a wfi instruction. This could be problematic with the CCI this
> > > early, so maybe just a comment saying that it doesn't matter because we
> > > don't care about this core?
> > 
> > Why a dsb?  No data was even touched at this point.  And since this is 
> > meant to be a better "b ." kind of loop, I'd rather not try to make it 
> > more sophisticated than it already is.  And of course it is meant to 
> > never be executed in practice.
> 
> Sure, that's why I think just mentioning that we don't ever plan to boot
> this CPU is a good idea (so people don't add code here later on).

I agree with the conclusions here.

> > > > diff --git a/arch/arm/include/asm/bL_entry.h b/arch/arm/include/asm/bL_entry.h
> > > > new file mode 100644
> > > > index 0000000000..ff623333a1
> > > > --- /dev/null
> > > > +++ b/arch/arm/include/asm/bL_entry.h
> > > > @@ -0,0 +1,35 @@
> > > > +/*
> > > > + * arch/arm/include/asm/bL_entry.h
> > > > + *
> > > > + * Created by:  Nicolas Pitre, April 2012
> > > > + * Copyright:   (C) 2012  Linaro Limited
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +#ifndef BL_ENTRY_H
> > > > +#define BL_ENTRY_H
> > > > +
> > > > +#define BL_CPUS_PER_CLUSTER	4
> > > > +#define BL_NR_CLUSTERS		2
> > > 
> > > Hmm, I see these have to be constant so you can allocate your space in
> > > the assembly file. In which case, I think it's worth changing their
> > > names to have MAX or LIMIT in them...
> > 
> > Yes, good point.  I'll change them.
> 
> Thanks.
> 
> > >  maybe they could even be CONFIG options?
> > 
> > Nah.  I prefer not adding new config options unless this is really 
> > necessary or useful.  For the forseeable future, we'll see systems with 
> > at most 2 clusters and at most 4 CPUs per cluster.  That could easily be 
> > revisited later if that becomes unsuitable for some new systems.
> 
> The current GIC is limited to 8 CPUs, so 4x2 is also a realistic possibility.
> 
> > Initially I wanted all those things to be runtime sized in relation with 
> > the TODO item in the commit log.  That too can come later.
> 
> Out of interest: how would you achieve that? I also thought about getting
> this information from the device tree, but I can't see how to plug that in
> with static storage.

I think you would just have to bite the bullet and go dynamic in this
case. But it's not a lot of data in total with the current limits, so
this feels like overkill.

If we eventually need to go many-CPU with this code, it will need
addressing, but there are no current plans for that that I know of.

Cheers
---Dave
