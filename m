From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 26 Oct 2015 10:52:32 +0100
Subject: [PATCH 9/9] pinctrl: at91: add missing of_node_put
In-Reply-To: <1445697755-26341-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
 <1445697755-26341-10-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20151026095232.GB22111@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 04:42:35PM +0200, Julia Lawall wrote:
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
> |
> +  of_node_put(child);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> 
> ---
>  drivers/pinctrl/pinctrl-at91.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index ce6e589..0d2fc0c 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1122,8 +1122,10 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
>  		func->groups[i] = child->name;
>  		grp = &info->groups[grp_index++];
>  		ret = at91_pinctrl_parse_groups(child, grp, info, i++);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(child);
>  			return ret;
> +		}
>  	}
>  
>  	return 0;
> @@ -1196,6 +1198,7 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
>  		ret = at91_pinctrl_parse_functions(child, info, i++);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to parse function\n");
> +			of_node_put(child);
>  			return ret;
>  		}
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
