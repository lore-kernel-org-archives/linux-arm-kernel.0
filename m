From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 11 Nov 2014 17:18:53 +0100
Subject: [PATCH] iommu/arm-smmu: Play nice on non-ARM/SMMU systems
In-Reply-To: <20141110172539.GM23942@arm.com>
References: <1415373978-16203-1-git-send-email-thierry.reding@gmail.com>
 <20141110172539.GM23942@arm.com>
Message-ID: <20141111161852.GB27754@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 05:25:39PM +0000, Will Deacon wrote:
> On Fri, Nov 07, 2014 at 03:26:18PM +0000, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Currently the driver registers IOMMU bus operations for all busses even
> > if no ARM SMMU is present on a system. Depending on the driver probing
> > order this prevents the driver for the real IOMMU to register itself as
> > the bus-wide IOMMU.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 60558f794922..e154826d8b1d 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -2072,8 +2072,20 @@ static struct platform_driver arm_smmu_driver = {
> >  
> >  static int __init arm_smmu_init(void)
> >  {
> > +	struct device_node *np;
> >  	int ret;
> >  
> > +	/*
> > +	 * Play nice with systems that don't have an ARM SMMU by checking that
> > +	 * an ARM SMMU exists in the system before proceeding with the driver
> > +	 * and IOMMU bus operation registration.
> > +	 */
> > +	np = of_find_matching_node(NULL, arm_smmu_of_match);
> > +	if (!np)
> > +		return 0;
> > +
> > +	of_node_put(np);
> > +
> 
> Hopefully, this will be solved shortly by the of_iommu_configure series I've
> been dragging my feet with recently. However, since that's not done yet,
> this looks like the best thing for now, even if it's a bit of a bodge.
> 
> Have you checked/updated other IOMMMU drivers too?

ARM SMMU was the only one being enabled on 64-bit where I noticed this,
but from a quick glance a couple of the other ARM driver are affected as
well. I'll see if I can find the time to come up with a similar patch.

Of course if these IOMMU drivers were proper drivers and bind to a
device, then this problem wouldn't exist in the first place.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/4f1cb4d7/attachment.sig>
