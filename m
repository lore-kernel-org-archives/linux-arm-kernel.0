From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 26 Oct 2015 03:20:36 +0200
Subject: [PATCH 5/8] [media] v4l: xilinx-vipp: add missing of_node_put
In-Reply-To: <1445781427-7110-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1445781427-7110-1-git-send-email-Julia.Lawall@lip6.fr>
 <1445781427-7110-6-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <8217156.HJH9oYGKMG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

Thank you for the patch.

On Sunday 25 October 2015 14:57:04 Julia Lawall wrote:
> for_each_child_of_node performs an of_node_get on each iteration, so
> a break out of the loop requires an of_node_put.
> 
> A simplified version of the semantic patch that fixes this problem is as
> follows (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> @@
> 
>  for_each_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> (
>    return child;
> 
> +  of_node_put(child);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/xilinx/xilinx-vipp.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/xilinx/xilinx-vipp.c
> b/drivers/media/platform/xilinx/xilinx-vipp.c index 7b7cb9c..b9bf24f 100644
> --- a/drivers/media/platform/xilinx/xilinx-vipp.c
> +++ b/drivers/media/platform/xilinx/xilinx-vipp.c
> @@ -476,8 +476,10 @@ static int xvip_graph_dma_init(struct
> xvip_composite_device *xdev)
> 
>  	for_each_child_of_node(ports, port) {
>  		ret = xvip_graph_dma_init_one(xdev, port);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			of_node_put(port);
>  			return ret;
> +		}
>  	}
> 
>  	return 0;

-- 
Regards,

Laurent Pinchart
