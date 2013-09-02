From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Sep 2013 09:50:58 +0100
Subject: [PATCH] iommu/arm-smmu: use devm_ioremap_resource() instead of
 devm_request_and_ioremap()
In-Reply-To: <005201cea77b$c0e14d90$42a3e8b0$%han@samsung.com>
References: <005201cea77b$c0e14d90$42a3e8b0$%han@samsung.com>
Message-ID: <20130902085057.GA17780@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Sep 02, 2013 at 02:28:39AM +0100, Jingoo Han wrote:
> Use devm_ioremap_resource() because devm_request_and_ioremap() is
> obsoleted by devm_ioremap_resource().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/iommu/arm-smmu.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f417e89..31c709c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1786,9 +1786,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	}
>  
>  	smmu->size = resource_size(res);
> -	smmu->base = devm_request_and_ioremap(dev, res);
> -	if (!smmu->base)
> -		return -EADDRNOTAVAIL;
> +	smmu->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(smmu->base))
> +		return PTR_ERR(smmu->base);

Cheers, but I've already got a patch like this queued from Julia. I was
going to send a pull request to Joerg after the merge window, since it's a
bit late in the day for things like this at the moment.

Will
