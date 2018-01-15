From: lollivier@baylibre.com (Loys Ollivier)
Date: Mon, 15 Jan 2018 14:25:16 +0100
Subject: [PATCH v3] firmware: qcom: scm: Fix incorrect of_node_put calls
 in scm_init
In-Reply-To: <1513345214-22835-1-git-send-email-lollivier@baylibre.com>
References: <1513345214-22835-1-git-send-email-lollivier@baylibre.com>
Message-ID: <a39633d8-fa2a-1184-9a4d-4545eae34dd4@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello guys,

Any news on this fix ? Anything else you need on my side ?

Thanks

On 15/12/2017 14:40, Loys Ollivier wrote:
> When using other platform architectures, in the init of the qcom_scm
> driver, of_node_put is called on /firmware if no qcom dt is found.
> This results in a kernel error: Bad of_node_put() on /firmware.
> 
> These calls to of_node_put from the qcom_scm init are unnecessary as
> of_find_matching_node and of_platform_populate are calling it
> automatically.
> 
> Remove the calls to of_node_put() on fw_np.
> 
> Fixes: d0f6fa7ba2d6 ("firmware: qcom: scm: Convert SCM to platform driver")
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>  drivers/firmware/qcom_scm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index af4c75217ea6..f6d7b7cffe0c 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -632,17 +632,13 @@ static int __init qcom_scm_init(void)
>  
>  	np = of_find_matching_node(fw_np, qcom_scm_dt_match);
>  
> -	if (!np) {
> -		of_node_put(fw_np);
> +	if (!np)
>  		return -ENODEV;
> -	}
>  
>  	of_node_put(np);
>  
>  	ret = of_platform_populate(fw_np, qcom_scm_dt_match, NULL, NULL);
>  
> -	of_node_put(fw_np);
> -
>  	if (ret)
>  		return ret;
>  
> 
