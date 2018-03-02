From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 2 Mar 2018 12:25:48 +0000
Subject: [PATCH 03/14] iommu: Create a base struct for io_mm
In-Reply-To: <20180221225924.30737-4-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
 <20180221225924.30737-4-jcrouse@codeaurora.org>
Message-ID: <fddafdae-4384-4826-ef63-9075e9866ae9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jordan,

Thank you for this, SMMUv3 and virtio-iommu need these SVA patches as well.

On 21/02/18 22:59, Jordan Crouse wrote:
[...]> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e2c49e583d8d..e998389cf195 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -110,8 +110,17 @@ struct iommu_domain {
>  	struct list_head mm_list;
>  };
>  
> +enum iommu_io_type {
> +	IO_TYPE_MM,
> +};
> +
> +struct io_base {
> +	int type;
> +	int pasid;
> +};

"io_base" is a bit vague. I'm bad at naming so my opinion doesn't hold
much water, but I'd rather this be something like "io_mm_base". When I
initially toyed with the idea I intended to keep io_mm as parent structure
and have "private" and "shared" sub-structures. Even if private PASIDs
don't rely on the kernel mm subsystem, this structure would still
represent an I/O mm of sorts, with a pgd and pgtable info.

Thanks,
Jean

> +
>  struct io_mm {
> -	int			pasid;
> +	struct io_base		base;
>  	struct list_head	devices;
>  	struct kref		kref;
>  #if defined(CONFIG_MMU_NOTIFIER)
> 
