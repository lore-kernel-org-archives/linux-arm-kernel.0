From: liviu.dudau@arm.com (liviu.dudau at arm.com)
Date: Mon, 25 Jan 2016 12:17:20 +0000
Subject: [PATCH] bus: vexpress-config: Add missing of_node_put
In-Reply-To: <20160122180838.GA12069@amitoj-Inspiron-3542>
References: <20160122180838.GA12069@amitoj-Inspiron-3542>
Message-ID: <20160125121720.GC1194@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 11:38:38PM +0530, Amitoj Kaur Chawla wrote:
> for_each_compatible_node performs an of_node_get on each iteration, so
> to break out of the loop an of_node_put is required.
> 
> Found using Coccinelle. The semantic patch used for this is as follows:
> 
> // <smpl>
> @@
> expression e;
> local idexpression n;
> @@
> 
>  for_each_compatible_node(n, ...) {
>    ... when != of_node_put(n)
>        when != e = n
> (
>    return n;
> +  of_node_put(n);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

Hi Amitoj,

> ---
>  drivers/bus/vexpress-config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
> index 6575c0f..c3cb76b 100644
> --- a/drivers/bus/vexpress-config.c
> +++ b/drivers/bus/vexpress-config.c
> @@ -192,8 +192,10 @@ static int __init vexpress_config_init(void)
>  	/* Need the config devices early, before the "normal" devices... */
>  	for_each_compatible_node(node, NULL, "arm,vexpress,config-bus") {
>  		err = vexpress_config_populate(node);
> -		if (err)
> +		if (err) {
> +			of_node_put(node);
>  			break;
> +		}

This automatically generated patch only solves half of the problem (for the error
path).

>  	}
>  
>  	return err;
> -- 
> 1.9.1
> 

I feel that a better patch would be the following, where the node is released
regardless of the result of vexpress_config_populate().

--8<--------------------------------------------------------------------------
diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index 6575c0f..c57453d 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -192,6 +192,7 @@ static int __init vexpress_config_init(void)
 	/* Need the config devices early, before the "normal" devices... */
 	for_each_compatible_node(node, NULL, "arm,vexpress,config-bus") {
 		err = vexpress_config_populate(node);
+		of_node_put(node);
 		if (err)
 			break;
 	}
-->8--------------------------------------------------------------------------

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
