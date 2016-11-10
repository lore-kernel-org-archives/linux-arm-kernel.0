From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 16:22:41 +0100
Subject: [RFC v2 2/8] iommu/iova: fix __alloc_and_insert_iova_range
In-Reply-To: <1478258646-3117-3-git-send-email-eric.auger@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-3-git-send-email-eric.auger@redhat.com>
Message-ID: <20161110152241.GF2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 11:24:00AM +0000, Eric Auger wrote:
> Fix the size check within start_pfn and limit_pfn.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> the issue was observed when playing with 1 page iova domain with
> higher iova reserved.
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index e23001b..ee29dbf 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -147,7 +147,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	if (!curr) {
>  		if (size_aligned)
>  			pad_size = iova_get_pad_size(size, limit_pfn);
> -		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
> +		if ((iovad->start_pfn + size + pad_size - 1) > limit_pfn) {

A >= check is more readable here.


	Joerg
