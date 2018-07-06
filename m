From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Fri, 6 Jul 2018 12:17:09 +0000
Subject: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices on
 fsl-mc bus
In-Reply-To: <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
 <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
Message-ID: <HE1PR0401MB2425626DB35517BFD4FA9E15E6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy at arm.com]
> Sent: Tuesday, July 3, 2018 9:44 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>; will.deacon at arm.com;
> robh+dt at kernel.org; robh at kernel.org; mark.rutland at arm.com;
> catalin.marinas at arm.com; gregkh at linuxfoundation.org; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>; bhelgaas at google.com
> Cc: hch at lst.de; joro at 8bytes.org; m.szyprowski at samsung.com;
> shawnguo at kernel.org; frowand.list at gmail.com; iommu at lists.linux-
> foundation.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linuxppc-dev at lists.ozlabs.org; linux-
> pci at vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder at gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices
> on fsl-mc bus
> 
> On 20/05/18 14:49, Nipun Gupta wrote:
> > This patch adds support of dma configuration for devices on fsl-mc
> > bus using 'dma_configure' callback for busses. Also, directly calling
> > arch_setup_dma_ops is removed from the fsl-mc bus.
> 
> Looks like this is the final arch_setup_dma_ops offender, yay!
> 
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >   drivers/bus/fsl-mc/fsl-mc-bus.c | 15 +++++++++++----
> >   1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-
> bus.c
> > index 5d8266c..fa43c7d 100644
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
> > @@ -633,10 +644,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc
> *obj_desc,
> >   			goto error_cleanup_dev;
> >   	}
> >
> > -	/* Objects are coherent, unless 'no shareability' flag set. */
> > -	if (!(obj_desc->flags &
> FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> 
> Although it seems we do end up without any handling of this
> "non-coherent object behind coherent MC" case, and I'm not sure how
> easily that could be accommodated by generic code... :/ How important is
> the quirk?

We have all the devices as coherent in our SoC's now :) So this is fine.
We have internally discussed it.

Regards,
Nipun

> 
> Robin.
> 
> > -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> > -
> >   	/*
> >   	 * The device-specific probe callback will get invoked by device_add()
> >   	 */
> >
