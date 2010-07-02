From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Jul 2010 13:58:15 +0300
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <alpine.LFD.2.00.1007011849590.4507@localhost.localdomain>
References: <alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
	<1278002123.7482.18.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007011849590.4507@localhost.localdomain>
Message-ID: <20100702105806.GK6632@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [100701 19:54]:
> Catalin,
> 
> On Thu, 1 Jul 2010, Catalin Marinas wrote:
> 
> > On Thu, 2010-07-01 at 17:28 +0100, Thomas Gleixner wrote:
> > > On Thu, 1 Jul 2010, Catalin Marinas wrote:
> > > > On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> > > > > The following patch series addresses the problem, that the kexec code
> > > > > does not disable the outer cache before disabling the inner cache and
> > > > > jumping into the new kernel. This results in random crashes of the new
> > > > > kernel.
> > > >
> > > > We may need other ways to work around this problem. There are platforms
> > > > like OMAP3 (I think) where the L2 cache cannot be disabled as Linux is
> > > > running in non-secure (normal) mode.
> > > 
> > > But it can disable the inner caches? That's weird.
> > 
> > That's because the CP15 SCTLR register is a banked one, so independent
> > configuration for secure and normal worlds.
> > 
> > The outer cache controller doesn't have banked registers and I'm not
> > even sure it has a notion of secure or non-secure cache line.
> 
> Brilliant design.

FYI, on secure omaps disabling/enabling/configuring of L2 cache must
be done via SMI that runs some function in the secure software (PPA)..
The code is there in arch/arm/mach-omap2/sleep34xx.S, just search
for SMI or PPA.

Trying to set things via the ARM aux ctrl register will hang the system,
so we need to figure out some way to select the L2 enable/disable based
on if we're running in secure mode or not.

Regards,

Tony
