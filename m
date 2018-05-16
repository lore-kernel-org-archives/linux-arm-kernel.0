From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Wed, 16 May 2018 08:48:57 +0000
Subject: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
In-Reply-To: <5AF9916E.8000504@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
 <5AF9916E.8000504@nxp.com>
Message-ID: <HE1PR0401MB24253CF729DDCF3F883AC256E6920@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Monday, May 14, 2018 7:10 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>; robin.murphy at arm.com;
> will.deacon at arm.com; mark.rutland at arm.com; catalin.marinas at arm.com
> Cc: hch at lst.de; gregkh at linuxfoundation.org; joro at 8bytes.org;
> robh+dt at kernel.org; m.szyprowski at samsung.com; shawnguo at kernel.org;
> frowand.list at gmail.com; bhelgaas at google.com; iommu at lists.linux-
> foundation.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org; linux-
> pci at vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder at gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices
> on fsl-mc bus
> 
> Hi Nipun,
> 
> On 04/27/2018 01:27 PM, Nipun Gupta wrote:
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-
> bus.c
> > index 5d8266c..624828b 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev,
> struct kobj_uevent_env *env)
> >   	return 0;
> >   }
> >
> > +static int fsl_mc_dma_configure(struct device *dev)
> > +{
> > +	struct device *dma_dev = dev;
> > +
> > +	while (dev_is_fsl_mc(dma_dev))
> > +		dma_dev = dma_dev->parent;
> > +
> > +	return of_dma_configure(dev, dma_dev->of_node, 0);
> > +}
> > +
> >   static ssize_t modalias_show(struct device *dev, struct device_attribute
> *attr,
> >   			     char *buf)
> >   {
> > @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
> >   	.name = "fsl-mc",
> >   	.match = fsl_mc_bus_match,
> >   	.uevent = fsl_mc_bus_uevent,
> > +	.dma_configure  = fsl_mc_dma_configure,
> >   	.dev_groups = fsl_mc_dev_groups,
> >   };
> >   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> > @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc
> *obj_desc,
> >   		mc_dev->icid = parent_mc_dev->icid;
> >   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
> >   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> > +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
> 
> This change seems a bit unrelated to the patch subject. I wonder if it
> makes sense to split it it in a distinct patch.

Okay. I will spin a v5 after splitting this patch and adding changelog (Greg's comment), fixing typo (Bjorn's comment).

Regards,
Nipun

> 
> ---
> Best Regards, Laurentiu
