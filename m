From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 11:32:47 -0700
Subject: [PATCHv7 02/12] iommu/of: introduce a global iommu device list
In-Reply-To: <1386835033-4701-3-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF474F.7080701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> This enables to find an populated IOMMU device via a device node. This
> can be used to see if an dependee IOMMU is populated or not to keep
> correct device population order. Client devices need to wait an IOMMU
> to be populated.
> 
> Suggested by Thierry Reding and copied his example code.

> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c

> +static struct iommu *of_find_iommu_by_node(struct device_node *np)
> +{
> +	struct iommu *iommu;
> +
> +	mutex_lock(&iommus_lock);
> +	list_for_each_entry(iommu, &iommus_list, list) {
> +		if (iommu->dev->of_node == np) {
> +			mutex_unlock(&iommus_lock);

Now that the list is unlocked, the IOMMU could be removed from the list,
and the driver unregistered. Should you do something like
iommu_get(iommu); before the mutex_unlock() call, and call iommu_put()
somewhere (i.e. in the next patch ...)?
