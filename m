From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Thu, 3 Jul 2014 10:37:30 +0000
Subject: [RFC 01/10] iommu: Add IOMMU device registry
In-Reply-To: <20140627065850.GG9258@ulmo>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-2-git-send-email-thierry.reding@gmail.com>
 <20140627065850.GG9258@ulmo>
Message-ID: <3ea656c6ec62435fb6f4cc20fe5e14a9@BL2PR03MB468.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> bounces at lists.linux-foundation.org] On Behalf Of Thierry Reding
> Sent: Friday, June 27, 2014 12:29 PM
> To: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala;
> Stephen Warren; Arnd Bergmann; Will Deacon; Joerg Roedel
> Cc: Olav Haugan; devicetree at vger.kernel.org; Grant Grundler; Rhyland
> Klein; iommu at lists.linux-foundation.org; linux-kernel at vger.kernel.org;
> Marc Zyngier; Allen Martin; Paul Walmsley; linux-tegra at vger.kernel.org;
> Cho KyongHo; Dave Martin; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC 01/10] iommu: Add IOMMU device registry
> 
> On Thu, Jun 26, 2014 at 10:49:41PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Add an IOMMU device registry for drivers to register with and
> > implement a method for users of the IOMMU API to attach to an IOMMU
> > device. This allows to support deferred probing and gives the IOMMU
> > API a convenient hook to perform early initialization of a device if
> necessary.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 93
> > +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/iommu.h | 27 +++++++++++++++
> >  2 files changed, 120 insertions(+)
> 
> I thought that perhaps I should elaborate on this a bit since I have a
> few ideas on how the API could be enhanced.
> 
> > +static int of_iommu_attach(struct device *dev) {
> > +	struct of_phandle_iter iter;
> > +	struct iommu *iommu;
> > +
> > +	mutex_lock(&iommus_lock);
> > +
> > +	of_property_for_each_phandle_with_args(iter, dev->of_node,
> "iommus",
> > +					       "#iommu-cells", 0) {
> > +		bool found = false;
> > +		int err;
> > +
> > +		/* skip disabled IOMMUs */
> > +		if (!of_device_is_available(iter.out_args.np))
> > +			continue;
> > +
> > +		list_for_each_entry(iommu, &iommus, list) {
> > +			if (iommu->dev->of_node == iter.out_args.np) {
> > +				err = iommu->ops->attach(iommu, dev);
> > +				if (err < 0) {
> > +				}
> > +
> > +				found = true;
> > +			}
> > +		}
> > +
> > +		if (!found) {
> > +			mutex_unlock(&iommus_lock);
> > +			return -EPROBE_DEFER;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&iommus_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int of_iommu_detach(struct device *dev) {
> > +	/* TODO: implement */
> > +	return -ENOSYS;
> > +}
> > +
> > +int iommu_attach(struct device *dev)
> > +{
> > +	int err = 0;
> > +
> > +	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
> > +		err = of_iommu_attach(dev);
> > +		if (!err)
> > +			return 0;
> > +	}
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_attach);
> 
> I think it might make sense to introduce an explicit object for an IOMMU
> master attachment. Maybe something like:
> 
> 	struct iommu_master {
> 		struct iommu *iommu;
> 		struct device *dev;
> 
> 		...
> 	};
> 
> iommu_attach() could then return a pointer to that attachment and the
> IOMMU user driver could subsequently use that as a handle to access other
> parts of the API.
> 
> The reason is that if we ever need to support more than a single master
> interface (and perhaps even multiple master interfaces on different
> IOMMUs) for a single device, then we need a way for the IOMMU user to
> differentiate between its master interfaces.
> 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > 284a4683fdc1..ac2ceef194d4 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -43,6 +43,17 @@ struct notifier_block;  typedef int
> > (*iommu_fault_handler_t)(struct iommu_domain *,
> >  			struct device *, unsigned long, int, void *);
> >
> > +struct iommu {
> > +	struct device *dev;
> > +
> > +	struct list_head list;
> > +
> > +	const struct iommu_ops *ops;
> > +};
> 
> For reasons explained above, I also think that it would be a good idea to
> modify the iommu_ops functions to take a struct iommu * as their first
> argument. This may become important when one driver needs to support
> multiple IOMMU devices. With the current API drivers have to rely on
> global variables to track the driver-specific context. As far as I can
> tell, only .domain_init(), .add_device(), .remove_device() and
> .device_group(). .domain_init() could set up a pointer to struct iommu in
> struct iommu_domain so the functions dealing with domains could gain
> access to the IOMMU device via that pointer.
Would the proposed interface be an alternate to the add_device interface? Also, how would the iommu group creation work? We are dependent on device driver initialization to attach device an IOMMU, but the add_device allows creation of iommu_groups during bus probing. 
Can't the same thing be achieved using the add device interface where an IOMMU driver can determine (in add_device) if the device is attached to a particular IOMMU. If the device is attached to that IOMMU then it can create the corresponding IOMMU group. IOMMU information can be stored in archdata.

-Varun
