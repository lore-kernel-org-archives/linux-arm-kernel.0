From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 16:37:24 +0100
Subject: [RFC v2 4/8] iommu: Add a list of iommu_reserved_region in
 iommu_domain
In-Reply-To: <1478258646-3117-5-git-send-email-eric.auger@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-5-git-send-email-eric.auger@redhat.com>
Message-ID: <20161110153724.GG2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 11:24:02AM +0000, Eric Auger wrote:
> Introduce a new iommu_reserved_region struct. This embodies
> an IOVA reserved region that cannot be used along with the IOMMU
> API. The list is protected by a dedicated mutex.
> 
> An iommu domain now owns a list of those.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> ---
>  drivers/iommu/iommu.c |  2 ++
>  include/linux/iommu.h | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9a2f196..0af07492 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1061,6 +1061,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  
>  	domain->ops  = bus->iommu_ops;
>  	domain->type = type;
> +	INIT_LIST_HEAD(&domain->reserved_regions);
> +	mutex_init(&domain->resv_mutex);

These regions are a property of the iommu-group, they are specific to a
device or a group of devices, not to a particular domain where devics
(iommu-groups) can come and go.

Further I agree with Robin that this is similar to the
get_dm_regions/set_dm_regions approach, which should be changed/extended
for this instead of adding something new.


	Joerg
