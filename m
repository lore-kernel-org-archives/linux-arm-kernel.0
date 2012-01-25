From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 25 Jan 2012 08:40:20 +0100
Subject: [PATCH 1/2] ARM: IOMMU: Tegra20: Add iommu_ops for GART driver
In-Reply-To: <20120123150048.GB6269@8bytes.org>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com><1325747509-29665-2-git-send-email-hdoyu@nvidia.com><20120123150048.GB6269@8bytes.org>
Message-ID: <20120125.094020.983282777619146490.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] ARM: IOMMU: Tegra20: Add iommu_ops for GART driver
Date: Mon, 23 Jan 2012 16:00:48 +0100
Message-ID: <20120123150048.GB6269@8bytes.org>

> Hi,
> 
> first, some questions about the GART on your platform.
> 
> 1) How many GARTs are usually implemented? One GART per device or is
>    there a single GART covering all devices, or a mix of both?

There's a single GART in the system which takes care of all devices.

> 2) Are devices allowed to DMA outside of the remappable range or will
>    this fail?

Fail.

> 
> Besides that I think IOMMU-API is not yet fully ready for GART-like
> drivers like this one. But I will merge it anyway to get things moving.
> But please answer or fix my objections first.
> 
> On Thu, Jan 05, 2012 at 09:11:48AM +0200, Hiroshi DOYU wrote:
> > +static void gart_iommu_domain_destroy(struct iommu_domain *domain)
> > +{
> > +	struct gart_device *gart = domain->priv;
> > +
> > +	spin_lock(&gart->client_lock);
> > +	if (!list_empty(&gart->client)) {
> > +		struct gart_client *c;
> > +
> > +		list_for_each_entry(c, &gart->client, list)
> > +			dev_err(gart->dev,
> > +				"%s is still attached\n", dev_name(c->dev));
> > +	}
> > +	spin_unlock(&gart->client_lock);
> 
> gart needs a NULL check. When you create a domain and immediatly destroy
> it without ever attaching a device this code will dereference a NULL
> pointer.

Fixed.

> As a general improvement I suggest that you introduce a gart_domain
> structure and store it in domain->priv (assigned in domain_init) instead
> of using the hardware descriptor.
> 
> > +static int gart_iommu_attach_dev(struct iommu_domain *domain,
> > +				 struct device *dev)
> > +{
> > +	struct gart_device *gart;
> > +	struct gart_client *client, *c;
> > +	int err = 0;
> > +
> > +	gart = dev_get_drvdata(dev->parent);
> > +	if (!gart)
> > +		return -EINVAL;
> > +	domain->priv = gart;
> 
> What happens when devices behind different GARTs are assigned to the
> same domain? domain->priv can only hold a pointer to one hardware GART.
> This can be solved by a 'struct gart_domain' holding a linked list to
> all gart_devices in this domain.

As discussed in SMMU thread, I'll revisit the above multiple iommu
device support later.

Attached the update patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-IOMMU-Tegra20-Add-iommu_ops-for-GART-driver.patch
Type: text/x-patch
Size: 14203 bytes
Desc: 0001-ARM-IOMMU-Tegra20-Add-iommu_ops-for-GART-driver.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120125/763fd94b/attachment.bin>
