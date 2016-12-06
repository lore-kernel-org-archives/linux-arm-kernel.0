From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Dec 2016 18:13:01 +0000
Subject: [RFC v3 06/10] iommu: iommu_get_group_resv_regions
In-Reply-To: <1479215363-2898-7-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <1479215363-2898-7-git-send-email-eric.auger@redhat.com>
Message-ID: <8eb9662b-d677-546c-feb8-32fe5bd624f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/16 13:09, Eric Auger wrote:
> Introduce iommu_get_group_resv_regions whose role consists in
> enumerating all devices from the group and collecting their
> reserved regions. It checks duplicates.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> - we do not move list elements from device to group list since
>   the iommu_put_resv_regions() could not be called.
> - at the moment I did not introduce any iommu_put_group_resv_regions
>   since it simply consists in voiding/freeing the list
> ---
>  drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h |  8 ++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a4530ad..e0fbcc5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -133,6 +133,59 @@ static ssize_t iommu_group_show_name(struct iommu_group *group, char *buf)
>  	return sprintf(buf, "%s\n", group->name);
>  }
>  
> +static bool iommu_resv_region_present(struct iommu_resv_region *region,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *entry;
> +
> +	list_for_each_entry(entry, head, list) {
> +		if ((region->start == entry->start) &&
> +		    (region->length == entry->length) &&
> +		    (region->prot == entry->prot))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int
> +iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
> +				 struct list_head *group_resv_regions)
> +{
> +	struct iommu_resv_region *entry, *region;
> +
> +	list_for_each_entry(entry, dev_resv_regions, list) {
> +		if (iommu_resv_region_present(entry, group_resv_regions))
> +			continue;

In the case of overlapping regions which _aren't_ an exact match, would
it be better to expand the existing one rather than leave the caller to
sort it out? It seems a bit inconsistent to handle only the one case here.

> +		region = iommu_alloc_resv_region(entry->start, entry->length,
> +					       entry->prot);
> +		if (!region)
> +			return -ENOMEM;
> +
> +		list_add_tail(&region->list, group_resv_regions);
> +	}
> +	return 0;
> +}
> +
> +int iommu_get_group_resv_regions(struct iommu_group *group,
> +				 struct list_head *head)
> +{
> +	struct iommu_device *device;
> +	int ret = 0;
> +
> +	list_for_each_entry(device, &group->devices, list) {

Should we not be taking the group mutex around this?

Robin.

> +		struct list_head dev_resv_regions;
> +
> +		INIT_LIST_HEAD(&dev_resv_regions);
> +		iommu_get_resv_regions(device->dev, &dev_resv_regions);
> +		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
> +		iommu_put_resv_regions(device->dev, &dev_resv_regions);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
> +
>  static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
>  
>  static void iommu_group_release(struct kobject *kobj)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0aea877..0f7ae2c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -243,6 +243,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  extern int iommu_request_dm_for_dev(struct device *dev);
>  extern struct iommu_resv_region *
>  iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot);
> +extern int iommu_get_group_resv_regions(struct iommu_group *group,
> +					struct list_head *head);
>  
>  extern int iommu_attach_group(struct iommu_domain *domain,
>  			      struct iommu_group *group);
> @@ -462,6 +464,12 @@ static inline void iommu_put_resv_regions(struct device *dev,
>  	return NULL;
>  }
>  
> +static inline int iommu_get_group_resv_regions(struct iommu_group *group,
> +					       struct list_head *head)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int iommu_request_dm_for_dev(struct device *dev)
>  {
>  	return -ENODEV;
> 
