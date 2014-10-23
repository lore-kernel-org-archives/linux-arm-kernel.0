From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Oct 2014 15:22:27 +0100
Subject: [PATCH v4 3/7] [RFC] arm/arm64: introduce is_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410221703560.876@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
 <1412941908-5850-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <20141010120702.GI7755@arm.com>
 <alpine.DEB.2.02.1410101401250.17038@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1410131215400.17038@kaball.uk.xensource.com>
 <20141013125725.GA19156@arm.com>
 <alpine.DEB.2.02.1410131358490.17038@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1410221703560.876@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1410231516450.876@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Oct 2014, Stefano Stabellini wrote:
> On Mon, 13 Oct 2014, Stefano Stabellini wrote:
> > On Mon, 13 Oct 2014, Will Deacon wrote:
> > > On Mon, Oct 13, 2014 at 12:16:14PM +0100, Stefano Stabellini wrote:
> > > > On Fri, 10 Oct 2014, Stefano Stabellini wrote:
> > > > > On Fri, 10 Oct 2014, Will Deacon wrote:
> > > > > > On Fri, Oct 10, 2014 at 12:51:44PM +0100, Stefano Stabellini wrote:
> > > > > > > Introduce a function to check whether a device is dma coherent.
> > > > > > > 
> > > > > > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > > > > > CC: linux at arm.linux.org.uk
> > > > > > > CC: catalin.marinas at arm.com
> > > > > > > CC: will.deacon at arm.com
> > > > > > > CC: linux-arm-kernel at lists.infradead.org
> > > > > > > ---
> > > > > > >  arch/arm/include/asm/dma-mapping.h   |    6 ++++++
> > > > > > >  arch/arm64/include/asm/dma-mapping.h |    5 +++++
> > > > > > >  2 files changed, 11 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > > > > > > index c45b61a..bededbb 100644
> > > > > > > --- a/arch/arm/include/asm/dma-mapping.h
> > > > > > > +++ b/arch/arm/include/asm/dma-mapping.h
> > > > > > > @@ -126,6 +126,12 @@ static inline int set_arch_dma_coherent_ops(struct device *dev)
> > > > > > >  	set_dma_ops(dev, &arm_coherent_dma_ops);
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > > +
> > > > > > > +static inline bool is_dma_coherent(struct device *dev)
> > > > > > > +{
> > > > > > > +    return (__generic_dma_ops(dev) == &arm_coherent_dma_ops);
> > > > > > > +}
> > > > > > 
> > > > > > Hmm, what about the IOMMU ops?
> > > > > 
> > > > > Maybe I should check __generic_dma_ops(dev) != &arm_dma_ops?
> > > > > Do you have any better suggestions?
> > > > 
> > > > ping?
> > > 
> > > Without any clear idea about why this is needed or how it's used, I don't
> > > have any better ideas.
> > 
> > Thanks for the quick reply.
> > 
> > It is used in dom0 to figure out whether the device is not coherent: in
> > that case Dom0 is going to issue an hypercall and Xen is going to
> > execute the required cache maintenance operations on Dom0's behalf.
> > 
> > In practice for this use case iommu_dma_ops is not a problem, as the
> > device is never going to appear as being behind an SMMU in dom0.
> 
> re-ping?

I don't mean to be pushy but this series is required to fix a regression
that causes dom0 to crash when running as dom0 on Xen on ARM if
non-coherent devices are present on the platform.

We should aim at getting it in 3.18 or we are going to release a broken
kernel.

I am thinking of reposting the series keeping the ugly is_dma_coherent
function in a Xen specific source file as a static function and then fix
it up properly in common code later with your help?
