From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Jan 2015 15:24:45 +0000
Subject: [PATCH 2/2] ARM: dma-mapping: don't detach devices without an
 IOMMU during teardown
In-Reply-To: <2890986.UZklX6cuTS@avalon>
References: <1421083413-24798-1-git-send-email-will.deacon@arm.com>
 <1421083413-24798-3-git-send-email-will.deacon@arm.com>
 <2890986.UZklX6cuTS@avalon>
Message-ID: <20150113152445.GD31784@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 02:53:44PM +0000, Laurent Pinchart wrote:
> On Monday 12 January 2015 17:23:33 Will Deacon wrote:
> > When tearing down the DMA ops for a device via of_dma_deconfigure, we
> > unconditionally detach the device from its IOMMU domain. For devices
> > that aren't actually behind an IOMMU, this produces a "Not attached"
> > warning message on the console.
> > 
> > This patch changes the teardown code so that we don't detach from the
> > IOMMU domain when there isn't an IOMMU dma mapping to start with.
> > 
> > Repoerted-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I might have reported the problem, but I haven't repoerted it :-)

D'oh, fat fingers. Sorry!

> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mm/dma-mapping.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 7864797609b3..711c3d2802fb 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -2023,7 +2023,10 @@ static bool arm_setup_iommu_dma_ops(struct device
> > *dev, u64 dma_base, u64 size,
> > 
> >  static void arm_teardown_iommu_dma_ops(struct device *dev)
> >  {
> > -	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
> > +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> 
> As the function is already protected by an #ifdef CONFIG_ARM_DMA_USE_IOMMU is 
> there a specific reason for this change ?

I just wanted to hide the archdata access, since we shouldn't really care
where it's stored. I could do it as a seperate patch, but I was in the
area...

Will
