From: davidb@codeaurora.org (David Brown)
Date: Fri, 2 Sep 2011 11:36:34 -0700
Subject: [PATCH 5/7] iommu/msm: ->unmap() should return order of unmapped
	page
In-Reply-To: <1314984756-4400-6-git-send-email-ohad@wizery.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
	<1314984756-4400-6-git-send-email-ohad@wizery.com>
Message-ID: <20110902183634.GA25775@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 08:32:34PM +0300, Ohad Ben-Cohen wrote:
> Users of the IOMMU API (kvm specifically) assume that iommu_unmap()
> returns the order of the unmapped page (on success).
> 
> Fix msm_iommu_unmap() accordingly.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> ---
>  drivers/iommu/msm_iommu.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 1a584e0..d1733f6 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -543,6 +543,13 @@ static int msm_iommu_unmap(struct iommu_domain *domain, unsigned long va,
>  	}
>  
>  	ret = __flush_iotlb(domain);
> +
> +	/*
> +	 * the IOMMU API requires us to return the order of the unmapped
> +	 * page (on success).
> +	 */
> +	if (!ret)
> +		ret = order;
>  fail:
>  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
>  	return ret;

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
