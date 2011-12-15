From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 15 Dec 2011 09:10:56 +0100
Subject: [PATCH] iommu: Initialize domain->handler in iommu_domain_alloc()
In-Reply-To: <1323760466-30333-1-git-send-email-pullip.cho@samsung.com>
References: <1323760466-30333-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <20111215081056.GC4475@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 04:14:26PM +0900, KyongHo Cho wrote:
> Since it is not guaranteed that an iommu driver initializes in its
> domain_init() function, it must be initialized with NULL to prevent
> calling a function in an arbitrary location when iommu fault occurred.
> 
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> ---
>  drivers/iommu/iommu.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7cc3c65..1afb896 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -148,6 +148,7 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>  		return NULL;
>  
>  	domain->ops = bus->iommu_ops;
> +	domain->handler = NULL;

Good catch. But it is better to change the kmalloc in the function to
kzalloc. This will implicitly initialize all future members correctly.

Thanks,

	Joerg
