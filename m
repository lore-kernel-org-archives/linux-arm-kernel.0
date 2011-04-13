From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Apr 2011 23:00:08 +0100
Subject: [PATCH 2.6.39 v2] V4L: videobuf-dma-contig: fix mmap_mapper
	broken on ARM
In-Reply-To: <201104132256.40325.jkrzyszt@tis.icnet.pl>
References: <201104122306.34909.jkrzyszt@tis.icnet.pl>
	<201104131252.32011.jkrzyszt@tis.icnet.pl>
	<20110413183231.GA23631@n2100.arm.linux.org.uk>
	<201104132256.40325.jkrzyszt@tis.icnet.pl>
Message-ID: <20110413220008.GA23901@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 10:56:39PM +0200, Janusz Krzysztofik wrote:
> Dnia ?roda 13 kwiecie? 2011 o 20:32:31 Russell King - ARM Linux 
> napisa?(a):
> > On Wed, Apr 13, 2011 at 12:52:31PM +0200, Janusz Krzysztofik wrote:
> > > Taking into account that I'm just trying to fix a regression, and
> > > not invent a new, long term solution: are you able to name an ARM
> > > based board which a) is already supported in 2.6.39, b) is (or can
> > > be) equipped with a device supported by a V4L driver which uses
> > > videobuf- dma-config susbsystem, c) has a bus structure with which
> > > virt_to_phys(bus_to_virt(dma_handle)) is not equal dma_handle?
> > 
> > I have no idea - and why should whether someone can name something
> > that may break be a justification to allow something which is
> > technically wrong?
> > 
> > Surely it should be the other way around - if its technically wrong
> > and _may_ break something then it shouldn't be allowed.
> 
> In theory - of course. In practice - couldn't we now, close to -rc3, 
> relax the rules a little bit and stop bothering with something that may 
> break in the future if it doesn't break on any board supported so far (I 
> hope)?

If we are worried about closeness to -final, then what should happen is
that the original commit is reverted; the "fix" for IOMMUs resulted in
a regression for existing users which isn't trivial to resolve without
risking possible breakage of other users.

Do we even know whether bus_to_virt(iommu_bus_address) works?  I suspect
it doesn't, so by doing so you're already re-breaking the IOMMU case.
