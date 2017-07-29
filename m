From: architt@codeaurora.org (Archit Taneja)
Date: Sat, 29 Jul 2017 20:02:50 +0530
Subject: [PATCH v6 1/7] drm/stm: ltdc: Fix leak of px clk enable in some
 error paths
In-Reply-To: <1500277223-29553-2-git-send-email-philippe.cornu@st.com>
References: <1500277223-29553-1-git-send-email-philippe.cornu@st.com>
 <1500277223-29553-2-git-send-email-philippe.cornu@st.com>
Message-ID: <bd6aeb5d-8f39-3e5e-0f72-a1d50e4438ef@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On 07/17/2017 01:10 PM, Philippe CORNU wrote:
> The pixel clock gets enabled early during init, since it's required
> in order to read registers. This pixel clock must be disabled if
> errors during this init phase.
> 

This patch was pulled in to drm-misc-next, but it lacks your Sign-off.
It looks like the Ack and the Sign-off got accidentally mixed up

Can you please reply to this mail with your "Signed-off-by" so that
we have proof of it on dri-devel?

Thanks,
Archit

> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 5331760..7f64d5a 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -1045,13 +1045,15 @@ int ltdc_load(struct drm_device *ddev)
>   
>   	if (of_address_to_resource(np, 0, &res)) {
>   		DRM_ERROR("Unable to get resource\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err;
>   	}
>   
>   	ldev->regs = devm_ioremap_resource(dev, &res);
>   	if (IS_ERR(ldev->regs)) {
>   		DRM_ERROR("Unable to get ltdc registers\n");
> -		return PTR_ERR(ldev->regs);
> +		ret = PTR_ERR(ldev->regs);
> +		goto err;
>   	}
>   
>   	for (i = 0; i < MAX_IRQ; i++) {
> @@ -1064,7 +1066,7 @@ int ltdc_load(struct drm_device *ddev)
>   						dev_name(dev), ddev);
>   		if (ret) {
>   			DRM_ERROR("Failed to register LTDC interrupt\n");
> -			return ret;
> +			goto err;
>   		}
>   	}
>   
> @@ -1079,7 +1081,7 @@ int ltdc_load(struct drm_device *ddev)
>   	if (ret) {
>   		DRM_ERROR("hardware identifier (0x%08x) not supported!\n",
>   			  ldev->caps.hw_version);
> -		return ret;
> +		goto err;
>   	}
>   
>   	DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
