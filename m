From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Mon, 20 Jan 2014 22:29:08 +0100
Subject: [PATCH 02/11] iommu/arm-smmu: Introduce bus notifier block
In-Reply-To: <419c2609cab14842b5258f7048ce6d43@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
 <419c2609cab14842b5258f7048ce6d43@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140120212908.GF3471@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 03:59:53PM -0500, Varun Sethi wrote:
> > -----Original Message-----
> > From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> > bounces at lists.linux-foundation.org] On Behalf Of Andreas Herrmann
> > Sent: Thursday, January 16, 2014 6:14 PM
> > To: Will Deacon
> > Cc: Andreas Herrmann; iommu at lists.linux-foundation.org; linux-arm-
> > kernel at lists.infradead.org
> > Subject: [PATCH 02/11] iommu/arm-smmu: Introduce bus notifier block
> > 
> > At the moment just handle BUS_NOTIFY_BIND_DRIVER to conditionally isolate
> > all master devices for an SMMU.
> > 
> > Depending on DT information each device is put into its own protection
> > domain (if possible).  For configuration with one or just a few masters
> > per SMMU that is easy to achieve.
> > 
> > In case of many devices per SMMU (e.g. MMU-500 with it's distributed
> > translation support) isolation of each device might not be possible --
> > depending on number of available SMR groups and/or context banks.
> > 
> > Default is that device isolation is contolled per SMMU with SMMU node
> > property "arm,smmu-isolate-devices" in a DT. If this property is set for
> > an SMMU node, device isolation is performed.

> [Sethi Varun-B16395] What if the devices have to be assigned to
> different virtual machines? Would the absence of this property
> indicate that devices can't Be assigned to different virtual
> machines i.e. devices would be in the same iommu group?

The absence of this property implies that arm-smmu driver handling of
master devices is equivalent to the current handling.
(I.e. assignment to different VMs works or doesn't work as with the current
mainline driver.)

> > W/o device isolation the driver detects SMMUs but no translation is
> > configured (transactions just bypass translation process).
> > 
> [Sethi Varun-B16395] Would SMR and S2CR still be allocated?

That's similar to the current handling of the driver. SMRs will be
marked as invalid and all S2CRs are configured as bypass.

As long as nobody creates a domain and attaches a device to it this
won't change.

> > Note that for device isolation dma_base and size are fixed as 0 and
> > SZ_128M at the moment. Additional patches will address this restriction
> > and allow automatic growth of mapping size.
> > 
> > Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |   45
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > 0b97d03..bc81dd0 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -46,6 +46,7 @@
> >  #include <linux/amba/bus.h>
> > 
> >  #include <asm/pgalloc.h>
> > +#include <asm/dma-iommu.h>
> > 
> >  /* Driver options */
> >  #define ARM_SMMU_OPT_ISOLATE_DEVICES		(1 << 0)
> > @@ -1964,6 +1965,48 @@ static int arm_smmu_device_remove(struct
> > platform_device *pdev)
> >  	return 0;
> >  }
> > 
> > +static int arm_smmu_device_notifier(struct notifier_block *nb,
> > +				unsigned long action, void *data)
> > +{
> > +	struct device *dev = data;
> > +	struct dma_iommu_mapping *mapping;
> > +	struct arm_smmu_device *smmu;
> > +	int ret;
> > +
> > +	switch (action) {
> > +	case BUS_NOTIFY_BIND_DRIVER:
> > +
> > +		arm_smmu_add_device(dev);
> [Sethi Varun-B16395] This would have already happened by virtue of the add_device iommu_ops.

You are right. That call is there for no good reason.

> > +		smmu = dev->archdata.iommu;
> > +		if (!smmu || !(smmu->options & ARM_SMMU_OPT_ISOLATE_DEVICES))
> > +			break;
> > +
> > +		mapping = arm_iommu_create_mapping(&platform_bus_type,
> > +						0, SZ_128M, 0);
> > +		if (IS_ERR(mapping)) {
> > +			ret = PTR_ERR(mapping);
> > +			dev_info(dev, "arm_iommu_create_mapping failed\n");
> > +			break;
> > +		}
> > +
> > +		ret = arm_iommu_attach_device(dev, mapping);
> > +		if (ret < 0) {
> > +			dev_info(dev, "arm_iommu_attach_device failed\n");
> > +			arm_iommu_release_mapping(mapping);
> > +		}
> > +
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct notifier_block device_nb = {
> > +	.notifier_call = arm_smmu_device_notifier, };
> > +
> >  #ifdef CONFIG_OF
> >  static struct of_device_id arm_smmu_of_match[] = {
> >  	{ .compatible = "arm,smmu-v1", },
> > @@ -2000,6 +2043,8 @@ static int __init arm_smmu_init(void)
> >  	if (!iommu_present(&amba_bustype))
> >  		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
> > 
> > +	bus_register_notifier(&platform_bus_type, &device_nb);
> > +

> [Sethi Varun-B16395] Notifier was already registered for the
>  platform bus via bus_set_iommu. You can actually register a iommu
>  group (once iommu group gets created) notifier
>  (iommu_group_register_notifier) and listen for the
>  IOMMU_GROUP_NOTIFY_BIND_DRIVER event.

Sounds reasonable.

So far the driver didn't care about iommu_groups. But there is already
a patch "iommu/arm-smmu: add devices attached to the SMMU to an IOMMU
group" pending in Will's iommu/devel branch that fixes this.

I'll adapt my patch to use iommu_group notifier instead of bus
notifier.

Thanks for your review!


Andreas
