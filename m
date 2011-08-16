From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Aug 2011 17:15:54 +0100
Subject: [PATCH] ARM: Add safe diagnostic to indicate when
	__cpu_architecture isn't set up
In-Reply-To: <alpine.LFD.2.00.1108161058220.20358@xanadu.home>
References: <1313504340-28004-1-git-send-email-dave.martin@linaro.org>
	<1313505921.2235.6.camel@computer2>
	<alpine.LFD.2.00.1108161058220.20358@xanadu.home>
Message-ID: <20110816161553.GB1993@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 10:59:18AM -0400, Nicolas Pitre wrote:
> On Tue, 16 Aug 2011, Tixy wrote:
> 
> > On Tue, 2011-08-16 at 15:19 +0100, Dave Martin wrote:
> > [...]
> > > This patch is useful for debugging, but I'm not convinced it should
> > > be merged.
> > [...] 
> > >  static inline int __pure cpu_architecture(void)
> > >  {
> > > -	BUG_ON(__cpu_architecture == CPU_ARCH_UNKNOWN);
> > > -	return __cpu_architecture;
> > > +	if (unlikely(__cpu_architecture == CPU_ARCH_UNKNOWN)) {
> > > +		extern int __pure __get_cpu_architecture(void);
> > > +
> > > +		WARN_ONCE(1, "__cpu_architecture not set yet!\n");
> > > +		return __get_cpu_architecture();
> > > +	} else
> > > +		return __cpu_architecture;
> > >  }
> > 
> > Seems to me that if we go down this route, cpu_architecture() may as
> > well remain a non-inline function which just calculates the arch if it's
> > not already set...
> 
> My thought as well.
> 
> > 	if (unlikely(__cpu_architecture == CPU_ARCH_UNKNOWN))
> > 		__cpu_architecture = __get_cpu_architecture();
> > 	return __cpu_architecture;
> > 
> > There seems to be too many ways to skin this cat :-)
> 
> Agreed.

Well, I guess the flipside is, do we need this check at all?

Because __cpu_architecture is set really early, and because if
it's referenced too early, the kernel will either not boot or
we'll hit BUG(), it's hard to imaging such a failure going unnoticed.

So this check could simply be viewed as overkill, though it does
feel safer to check.

Any thoughts?

---Dave
