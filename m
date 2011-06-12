From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2011 14:51:59 +0100
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <20110611051510.GA3283@riccoc20.at.omicron.at>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<20110611051510.GA3283@riccoc20.at.omicron.at>
Message-ID: <20110612135159.GH10283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 11, 2011 at 07:15:10AM +0200, Richard Cochran wrote:
> On Wed, Jun 01, 2011 at 11:58:26PM +0100, Russell King - ARM Linux wrote:
> > On Mon, May 30, 2011 at 10:43:07AM +0200, Richard Cochran wrote:
> > > Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
> > > 
> > >    clocksource: convert ARM 32-bit up counting clocksources
> > > 
> > > broke the build for ixp4xx and made big endian operation impossible.
> > > This commit restores the original behaviour.
> > 
> > I'm really not happy about using the MMIO clocksource stuff with random
> > other read functions like this - it defeats the entire purpose of the
> > MMIO clocksource stuff.  Maybe we should just undo the change for IXP4xx
> > and treat it as "special" for the time being.
> 
> I took another look at the whole MMIO clocksource implementation and
> can't understand why all of the accessors use le_to_cpu. This seems to
> imply that all peripheral buses are little endian (except for ixp,
> which no one cares about, anyhow).

What would they use as an ioremap-compatible interface instead of
readl()/readw() ?

readl_be()/readw_be() doesn't work for the majority of platforms using
this stuff.  We also don't have native endian equivalents across the
kernel.  Not everyone provides the relaxed versions.

It's basically a problem, and its one of the unfortunate prices paid
by consolidating code - things become harder and less efficient to do.

In this case, I think we need a set of _be() clocksource accessors in
mmio.c, and leave it up to the platform to select the correct accessor.
