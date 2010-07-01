From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 1 Jul 2010 18:52:35 +0200 (CEST)
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <1278002123.7482.18.camel@e102109-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
	<1278002123.7482.18.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1007011849590.4507@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

On Thu, 1 Jul 2010, Catalin Marinas wrote:

> On Thu, 2010-07-01 at 17:28 +0100, Thomas Gleixner wrote:
> > On Thu, 1 Jul 2010, Catalin Marinas wrote:
> > > On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> > > > The following patch series addresses the problem, that the kexec code
> > > > does not disable the outer cache before disabling the inner cache and
> > > > jumping into the new kernel. This results in random crashes of the new
> > > > kernel.
> > >
> > > We may need other ways to work around this problem. There are platforms
> > > like OMAP3 (I think) where the L2 cache cannot be disabled as Linux is
> > > running in non-secure (normal) mode.
> > 
> > But it can disable the inner caches? That's weird.
> 
> That's because the CP15 SCTLR register is a banked one, so independent
> configuration for secure and normal worlds.
> 
> The outer cache controller doesn't have banked registers and I'm not
> even sure it has a notion of secure or non-secure cache line.

Brilliant design.

> > > Cannot some extra cache flushing work around this problem?
> > 
> > We tried to keep the L2 on and just doing the l2x0_inv_all() call and
> > it hangs.
> 
> You would probably need an l2x0_flush_all() function which does clean
> +invalidate. If you only do invalidate you may just remove valid cache
> lines that have reached the RAM.

Tried that, no fun.
 
Thanks,

	tglx
