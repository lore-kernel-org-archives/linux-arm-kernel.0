From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 26 May 2014 12:08:37 +0200
Subject: [PATCH v2 02/10] iommu/ipmmu-vmsa: Cleanup failures of ARM
 mapping creation or attachment
In-Reply-To: <20140526092310.GA11299@8bytes.org>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1400150451-13469-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140526092310.GA11299@8bytes.org>
Message-ID: <9405311.lnqBdrCsyu@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Monday 26 May 2014 11:23:11 Joerg Roedel wrote:
> On Thu, May 15, 2014 at 12:40:43PM +0200, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/iommu/ipmmu-vmsa.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 49e00f7..49dbedd 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -917,7 +917,8 @@ static int ipmmu_add_device(struct device *dev)
> >  							SZ_1G, SZ_2G);
> >  		if (IS_ERR(mapping)) {
> >  			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
> > -			return PTR_ERR(mapping);
> > +			ret = PTR_ERR(mapping);
> > +			goto error;
> >  		}
> >  		
> >  		mmu->mapping = mapping;
> > @@ -933,6 +934,7 @@ static int ipmmu_add_device(struct device *dev)
> >  	return 0;
> >  
> >  error:
> > +	arm_iommu_release_mapping(mmu->mapping);
> >  	kfree(dev->archdata.iommu);
> >  	dev->archdata.iommu = NULL;
> >  	iommu_group_remove_device(dev);
> 
> Skipped this one because it didn't apply. The others are applied.

Thank you. I'll rebase the patch on top of your tree as soon as you publish 
the related branch and resubmit.

-- 
Regards,

Laurent Pinchart
