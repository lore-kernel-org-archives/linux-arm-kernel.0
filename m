From: tsoni@codeaurora.org (Trilok Soni)
Date: Fri, 25 Feb 2011 12:59:06 +0530
Subject: [PATCH 2/4] msm: iommu: Rework clock logic and add IOMMU bus
	clock control
In-Reply-To: <1298599242-21971-2-git-send-email-stepanm@codeaurora.org>
References: <1298599242-21971-1-git-send-email-stepanm@codeaurora.org>
	<1298599242-21971-2-git-send-email-stepanm@codeaurora.org>
Message-ID: <4D675A42.9090803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

> 
>  /**
> diff --git a/arch/arm/mach-msm/iommu_dev.c b/arch/arm/mach-msm/iommu_dev.c
> index b83c73b..69acd1e 100644
> --- a/arch/arm/mach-msm/iommu_dev.c
> +++ b/arch/arm/mach-msm/iommu_dev.c
> @@ -1,4 +1,4 @@
> -/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> +/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
> @@ -29,6 +29,7 @@
> 
>  #include <mach/iommu_hw-8xxx.h>
>  #include <mach/iommu.h>
> +#include <mach/clk.h>
> 
>  struct iommu_ctx_iter_data {
>  	/* input */
> @@ -130,117 +131,134 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  {
>  	struct resource *r, *r2;
>  	struct clk *iommu_clk;
> +	struct clk *iommu_pclk;
>  	struct msm_iommu_drvdata *drvdata;
>  	struct msm_iommu_dev *iommu_dev = pdev->dev.platform_data;

const please.

> +	iommu_pclk = clk_get(NULL, "smmu_pclk");
> +	if (IS_ERR(iommu_pclk)) {
> +		ret = -ENODEV;
> +		goto fail;
> +	}

I am not a big fan of this when you have the "device" around. You should just do

iommu_pclk = clk_get(&pdev->dev, NULL);

...error logic...

iommu_clk = clk_get(&pdev->dev, "iommu_clk");

...error logic...


> +
> +	ret = clk_enable(iommu_pclk);
> +	if (ret)
> +		goto fail_enable;
> +
> +	iommu_clk = clk_get(&pdev->dev, "iommu_clk");
> +
> +	if (!IS_ERR(iommu_clk))	{
> +		if (clk_get_rate(iommu_clk) == 0)
> +			clk_set_min_rate(iommu_clk, 1);
> +
> +		ret = clk_enable(iommu_clk);
> +		if (ret) {
>  			clk_put(iommu_clk);
> +			goto fail_pclk;
>  		}
> +	} else
> +		iommu_clk = NULL;
> 
> -		r = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -						 "physbase");
> -		if (!r) {
> -			ret = -ENODEV;
> -			goto fail;
> -		}
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "physbase");
> 
> -		len = r->end - r->start + 1;
> +	if (!r) {
> +		ret = -ENODEV;
> +		goto fail_clk;
> +	}
> 
> -		r2 = request_mem_region(r->start, len, r->name);
> -		if (!r2) {
> -			pr_err("Could not request memory region: "
> -			"start=%p, len=%d\n", (void *) r->start, len);
> -			ret = -EBUSY;
> -			goto fail;
> -		}
> +	len = r->end - r->start + 1;


resource_size please.


---Trilok Soni


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
