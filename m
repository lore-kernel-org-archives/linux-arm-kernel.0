From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Jan 2017 13:47:34 +0000
Subject: [RFC PATCH] iommu/arm-smmu: Add global SMR masking property
In-Reply-To: <20161221032921.hdcnyiq6m224ejlv@rob-hp-laptop>
References: <ad6b6a4937b1fe183e6d48ccbaf4cb46db92fed4.1481893907.git.robin.murphy@arm.com>
 <20161221032921.hdcnyiq6m224ejlv@rob-hp-laptop>
Message-ID: <20170103134733.GG6986@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 09:29:21PM -0600, Rob Herring wrote:
> On Fri, Dec 16, 2016 at 01:19:29PM +0000, Robin Murphy wrote:
> > The current SMR masking support using a 2-cell iommu-specifier is
> > primarily intended to handle individual masters with large and/or
> > complex Stream ID assignments; it quickly gets a bit clunky in other SMR
> > use-cases where we just want to consistently mask out the same part of
> > every Stream ID (e.g. for MMU-500 configurations where the appended TBU
> > number gets in the way unnecessarily). Let's add a new property to allow
> > a single global mask value to better fit the latter situation.
> > 
> > CC: Stuart Yoder <stuart.yoder@nxp.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > Compile-tested only...
> > 
> >  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 8 ++++++++
> >  drivers/iommu/arm-smmu.c                             | 4 +++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > index e862d1485205..98f5cbe5fdb4 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -60,6 +60,14 @@ conditions.
> >                    aliases of secure registers have to be used during
> >                    SMMU configuration.
> >  
> > +- stream-match-mask : Specifies a fixed SMR mask value to combine with
> 
> Needs a vendor prefix.

Why does this need a vendor prefix? I'm not fussed either way, but since
the stream-match-mask is an optional architectural concept and not specific
to an implementation, it seems strange to me that it would need a prefix
whereas something like #global-interrupts does not.

> > +                  the Stream ID value from every iommu-specifier. This
> > +                  may be used instead of an "#iommu-cells" value of 2
> > +                  when there is no need for per-master SMR masks, but
> > +                  it is still desired to mask some portion of every
> > +                  Stream ID (e.g. for certain MMU-500 configurations
> > +                  given globally unique external IDs).

Robin -- it might be worth a sentence here saying that the property is
ignored if stream matching isn't supported by the hardware.

Will
