From: gdavis@mvista.com (George G. Davis)
Date: Thu, 6 May 2010 11:57:38 -0400
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the ARMv6
	DMA cache ops
In-Reply-To: <1273156832.2094.21.camel@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<20100505132641.GA3169@mvista.com>
	<1273156832.2094.21.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100506155738.GC18436@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 03:40:32PM +0100, Catalin Marinas wrote:
> On Wed, 2010-05-05 at 14:26 +0100, George G. Davis wrote:
> > Definitely need this for stable DMA on ARM11 MPCore.
> > 
> > On Tue, May 04, 2010 at 05:44:26PM +0100, Catalin Marinas wrote:
> > > The Snoop Control Unit on the ARM11MPCore hardware does not detect the
> > > cache operations and the dma_cache_maint*() functions may leave stale
> > > cache entries on other CPUs. The solution implemented in this patch
> > > performs a Read or Write For Ownership in the ARMv6 DMA cache
> > > maintenance functions. These LDR/STR instructions change the cache line
> > > state to shared or exclusive so that the cache maintenance operation has
> > > the desired effect.
> > >
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Tested-by: George G. Davis <gdavis@mvista.com>
> 
> Thanks.
> 
> > FWIW, lack of ARM11 MPCore DMA cache coherency has been a problem for
> > well over two years now and it would be good if we can finally get this
> > fixed in mainline.  Without this applied on current, I observe various
> > oopses and/or filesystem errors which are resolved by this patch.
> 
> What platform was this tested on?

Tested on the EMMA Car Series EC-4260 board [1] and (EC-4270) NE1BOARD [2]
using ext4 root filesystem over USB Mass Storage and SD Card.  Here is
the ID Code Register, same for both systems (I've given up trying to make
sense as to whether this is r1p0, r0p4 or other : ):

CPU: ARMv6-compatible processor [410fb024] revision 4 (ARMv7), cr=08c5387f

> > If there is some other testing that I can do to help getting this
> > or some other variation accepted for mainline, let me know.
> 
> The more platforms tested, the better. Anyway, I don't think we have
> much choice in how this workaround is implemented, unless the hardware
> supports FIQs.

FWIW, I've also tried testing on a RealView EB ARM11 MPCore [3] but
unfortunately it has a rather old core (r0p0/[410fb020]) which no
longer boots on linux-2.6.34-rc (but oddly still works ok on
v2.6.33).

Thanks!

--
Regards,
George

[1] http://www.arm.linux.org.uk/developer/machines/list.php?id=2639
[2] http://www.arm.linux.org.uk/developer/machines/list.php?id=1655
[3] http://www.arm.linux.org.uk/developer/machines/list.php?id=827

> 
> -- 
> Catalin
