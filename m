From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 1 Jul 2016 14:40:23 -0700
Subject: [PATCH] soc: qcom: smem: Silence probe defer error
In-Reply-To: <20160701211859.23471-1-sboyd@codeaurora.org>
References: <20160701211859.23471-1-sboyd@codeaurora.org>
Message-ID: <20160701214023.GM1190@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 01 Jul 14:18 PDT 2016, Stephen Boyd wrote:

> If we fail to get the hwspinlock due to probe defer, we shouldn't
> print an error message. Just be silent in this case.
> 

This generally seems to result in a large pile of drivers ending up on
the probe deferr list, so something we should try to avoid.

But the patch itself looks good:
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/soc/qcom/smem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 2e1aa9f130f4..18ec52f2078a 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -740,7 +740,8 @@ static int qcom_smem_probe(struct platform_device *pdev)
>  
>  	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
>  	if (hwlock_id < 0) {
> -		dev_err(&pdev->dev, "failed to retrieve hwlock\n");
> +		if (hwlock_id != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to retrieve hwlock\n");
>  		return hwlock_id;
>  	}
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
