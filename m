From: joerg.roedel@amd.com (Joerg Roedel)
Date: Fri, 16 Dec 2011 16:39:04 +0100
Subject: [PATCH v2 2/2] [RFC] ARM: IOMMU: Tegra30: iommu_ops for SMMU
 driver
In-Reply-To: <1323954690-7000-3-git-send-email-hdoyu@nvidia.com>
References: <1323954690-7000-1-git-send-email-hdoyu@nvidia.com>
 <1323954690-7000-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <20111216153904.GC29877@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 03:11:30PM +0200, Hiroshi DOYU wrote:
> +static int smmu_iommu_attach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct smmu_as *as = domain->priv;
> +	struct smmu_client *client, *c;
> +	u32 map;
> +	int err;
> +
> +	client = kmalloc(sizeof(*c), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +	client->dev = dev;
> +	client->as = as;
> +	map = (unsigned long)dev->platform_data;
> +	if (!map)
> +		return -EINVAL;
> +
> +	err = smmu_client_enable_hwgrp(client, map);
> +	if (err)
> +		goto err_hwgrp;
> +
> +	spin_lock(&as->client_lock);
> +	list_for_each_entry(c, &as->client, list) {
> +		if (c->dev == dev) {
> +			pr_err("%s is already attached\n", dev_name(dev));
> +			err = -EINVAL;
> +			goto err_client;
> +		}
> +	}
> +	list_add(&client->list, &as->client);
> +	spin_unlock(&as->client_lock);
> +
> +	/*
> +	 * Reserve "page zero" for AVP vectors using a common dummy
> +	 * page.
> +	 */
> +	if (map & HWG_AVPC) {
> +		struct page *page;
> +
> +		page = as->smmu->avp_vector_page;
> +		__smmu_iommu_map_pfn(as, 0, page_to_pfn(page));
> +
> +		pr_info("Reserve \"page zero\" for AVP vectors using a common dummy\n");
> +	}
> +
> +	pr_debug("Attached %s\n", dev_name(dev));
> +	return 0;
> +err_client:
> +	smmu_client_disable_hwgrp(client);
> +	spin_unlock(&as->client_lock);
> +err_hwgrp:
> +	kfree(client);
> +	return err;
> +}

Hmm, I have a question about that. Reading the code it looks like your
SMMU exists per pheripheral device and the SMMU hardware supports
multiple address spaces per device, right? The domains are implemented
for one address-space. So is it right that a device can have multiple
address-spaces? If so, what kind of devices do you bind to the domains
then. I doesn't make sense to bind whole peripheral devices in this
case.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
