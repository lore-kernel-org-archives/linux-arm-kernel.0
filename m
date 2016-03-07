From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Mar 2016 11:15:30 -0300
Subject: [RFT 1/2] [media] exynos4-is: Add missing endpoint of_node_put on
 error paths
In-Reply-To: <1453768906-28979-1-git-send-email-k.kozlowski@samsung.com>
References: <1453768906-28979-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56DD8D02.3080504@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/25/2016 09:41 PM, Krzysztof Kozlowski wrote:
> In fimc_md_parse_port_node() endpoint node is get with of_get_next_child()
> but it is not put on error path.
> 
> Fixes: 56fa1a6a6a7d ("[media] s5p-fimc: Change the driver directory name to exynos4-is")
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Not tested on hardware, only built+static checkers.
> ---
>  drivers/media/platform/exynos4-is/media-dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
> index f3b2dd30ec77..de0977479327 100644
> --- a/drivers/media/platform/exynos4-is/media-dev.c
> +++ b/drivers/media/platform/exynos4-is/media-dev.c
> @@ -339,8 +339,10 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
>  		return 0;
>  
>  	v4l2_of_parse_endpoint(ep, &endpoint);
> -	if (WARN_ON(endpoint.base.port == 0) || index >= FIMC_MAX_SENSORS)
> +	if (WARN_ON(endpoint.base.port == 0) || index >= FIMC_MAX_SENSORS) {
> +		of_node_put(ep);
>  		return -EINVAL;
> +	}
>  
>  	pd->mux_id = (endpoint.base.port - 1) & 0x1;
>  
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
