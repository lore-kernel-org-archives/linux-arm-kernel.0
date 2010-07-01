From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 01 Jul 2010 17:41:23 +0100
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
References: <20100701160206.539545857@linutronix.de>
	<1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007011820000.4507@localhost.localdomain>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5E41E0C@dbde02.ent.ti.com>
Message-ID: <1278002483.7482.23.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-01 at 17:38 +0100, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Thomas Gleixner
> > Sent: Thursday, July 01, 2010 9:59 PM
> > To: Catalin Marinas
> > Cc: LAK
> > Subject: Re: [patch 0/2] ARM: Disable outer cache before kexec call
> >
> > Catalin,
> >
> > On Thu, 1 Jul 2010, Catalin Marinas wrote:
> > >
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
> If the C bit is disabled then it is as good as L1 and L2 are disabled.

You may want to disable the I bit in SCTLR as well. With MMU disabled I
think the D side acts as strongly ordered (uncached) but you can still
get cached fetches in the I-cache (needs some TRM checking though). If
that's the case, the L2 cache could see I-cache L1 fetches as cacheable
accesses since L2 is a unified cache.

-- 
Catalin
