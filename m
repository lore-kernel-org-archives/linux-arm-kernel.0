From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Mar 2016 11:17:44 -0300
Subject: [RFT 2/2] [media] exynos4-is: Add missing port parent of_node_put
 on error paths
In-Reply-To: <1453768906-28979-2-git-send-email-k.kozlowski@samsung.com>
References: <1453768906-28979-1-git-send-email-k.kozlowski@samsung.com>
 <1453768906-28979-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56DD8D88.9020500@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/25/2016 09:41 PM, Krzysztof Kozlowski wrote:
> In fimc_md_parse_port_node() remote port parent node is get with
> of_graph_get_remote_port_parent() but it is not put on error path.
> 
> Fixes: fa91f1056f17 ("[media] exynos4-is: Add support for asynchronous subdevices registration")
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
> index de0977479327..d2e564878e06 100644
> --- a/drivers/media/platform/exynos4-is/media-dev.c
> +++ b/drivers/media/platform/exynos4-is/media-dev.c
> @@ -385,8 +385,10 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
>  	else
>  		pd->fimc_bus_type = pd->sensor_bus_type;
>  
> -	if (WARN_ON(index >= ARRAY_SIZE(fmd->sensor)))
> +	if (WARN_ON(index >= ARRAY_SIZE(fmd->sensor))) {
> +		of_node_put(rem);
>  		return -EINVAL;
> +	}
>  
>  	fmd->sensor[index].asd.match_type = V4L2_ASYNC_MATCH_OF;
>  	fmd->sensor[index].asd.match.of.node = rem;
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
