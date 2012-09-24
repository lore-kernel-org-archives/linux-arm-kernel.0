From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 24 Sep 2012 15:32:29 -0700
Subject: [PATCH 03/10] msm: iommu: Convert to clk_prepare/unprepare
In-Reply-To: <1348194419-11486-4-git-send-email-sboyd@codeaurora.org>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <5060DF7D.9000305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2012 07:26 PM, Stephen Boyd wrote:
> Add calls to clk_prepare and unprepare so that MSM can migrate to
> the common clock framework. We never unprepare the clocks until
> driver remove because the clocks are enabled and disabled in irq
> context. Finer grained power management is possible in the future
> via runtime power management techniques.
>
> Signed-off-by: Stephen Boyd<sboyd@codeaurora.org>
> ---
>   drivers/iommu/msm_iommu_dev.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
> index 8e8fb07..d344f6a 100644
> --- a/drivers/iommu/msm_iommu_dev.c
> +++ b/drivers/iommu/msm_iommu_dev.c
> @@ -160,7 +160,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
>   		goto fail;
>   	}
>
> -	ret = clk_enable(iommu_pclk);
> +	ret = clk_prepare_enable(iommu_pclk);
>   	if (ret)
>   		goto fail_enable;
>
> @@ -170,7 +170,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
>   		if (clk_get_rate(iommu_clk) == 0)
>   			clk_set_min_rate(iommu_clk, 1);
>
> -		ret = clk_enable(iommu_clk);
> +		ret = clk_prepare_enable(iommu_clk);
>   		if (ret) {
>   			clk_put(iommu_clk);
>   			goto fail_pclk;
> @@ -261,7 +261,7 @@ fail_clk:
>   		clk_put(iommu_clk);
>   	}
>   fail_pclk:
> -	clk_disable(iommu_pclk);
> +	clk_disable_unprepare(iommu_pclk);
>   fail_enable:
>   	clk_put(iommu_pclk);
>   fail:
> @@ -275,8 +275,11 @@ static int msm_iommu_remove(struct platform_device *pdev)
>
>   	drv = platform_get_drvdata(pdev);
>   	if (drv) {
> -		if (drv->clk)
> +		if (drv->clk) {
> +			clk_unprepare(drv->clk);
>   			clk_put(drv->clk);
> +		}
> +		clk_unprepare(drv->pclk);

Are these changes right? Every other clk API change in this patch is 
using the combined prepare_enable/disable_unprepare() calls. So, when 
would we end up at this location with the clocks prepared but not enabled?

Also, what if the device gets probed and then immediately removed. Will 
it work correctly?

-Saravana

>   		clk_put(drv->pclk);
>   		memset(drv, 0, sizeof(*drv));
>   		kfree(drv);
> @@ -314,14 +317,14 @@ static int msm_iommu_ctx_probe(struct platform_device *pdev)
>   	INIT_LIST_HEAD(&ctx_drvdata->attached_elm);
>   	platform_set_drvdata(pdev, ctx_drvdata);
>
> -	ret = clk_enable(drvdata->pclk);
> +	ret = clk_prepare_enable(drvdata->pclk);
>   	if (ret)
>   		goto fail;
>
>   	if (drvdata->clk) {
> -		ret = clk_enable(drvdata->clk);
> +		ret = clk_prepare_enable(drvdata->clk);
>   		if (ret) {
> -			clk_disable(drvdata->pclk);
> +			clk_disable_unprepare(drvdata->pclk);
>   			goto fail;
>   		}
>   	}


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
