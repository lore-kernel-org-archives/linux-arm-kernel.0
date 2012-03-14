From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Mar 2012 17:19:53 -0400 (EDT)
Subject: [PATCH v3 1/5] ARM: protect usage of cr_alignment by #ifdef
 CONFIG_CPU_CP15
In-Reply-To: <20120314195120.GA2391@pengutronix.de>
References: <20120314101928.GA29474@pengutronix.de>
 <1331720483-10075-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <alpine.LFD.2.02.1203141103080.24151@xanadu.home>
 <20120314195120.GA2391@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1203141710210.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2012, Uwe Kleine-K?nig wrote:

> On Wed, Mar 14, 2012 at 11:24:36AM -0400, Nicolas Pitre wrote:
> > Again, you could just leave the original display, with cr=00000000 which 
> > is a fairly good representation of reality.
> Maybe having
> 
> 	#define cr_alignment 0
> 
> for the !CONFIG_CPU_CP15 case would be a nice alternative. This way all
> places that want to modify cr_alignment fail to compile, but reading
> gives a "fairly good representation of reality".

Even better, yes.

> Having said that I'm not sure about "fairly good". v7m also supports
> unaligned accesses. But it's not configured in a cp15 register
> (obviously) but in a system register.

Hence having a "control register" displaying as zero is still fairly 
good.

> Quoting ARMARM-v7m:
> 
> 	Configuration and Control Register, CCR
> 	[...]
> 	Bit [3] UNALIGN_TRP	Controls the trapping of unaligned word or
> 				halfword accesses:
> 				0 = Trapping disabled.
> 				1 = Trapping enabled.
> 				Unaligned load-store multiples and word
> 				or halfword exclusive accesses always
> 				fault.
> 
> So we need a more general abstraction to have correct and clean code?

In the context of the alignment trap code, yes.  Maybe on v7m there is 
no point having the alignment trap disabled at all.  It's been almost 
forever that gcc is not relying on the side effect of misaligned 
accesses anymore.

> > >  	flush_cache_all();
> > > +#ifdef CONFIG_CPU_CP15
> > >  	set_cr(cr_alignment);
> > > +#endif
> > 
> > However it might be best to provide a dummy set_cr() instead of 
> > #ifdef'ing it out everywhere.
> What should the dummy set_cr do? Print a runtime warning if called with
> != 0?

Maybe not.  In fact if that code path is used, then something might be 
wrong at a higher level.


Nicolas
