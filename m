From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 12 Dec 2012 12:56:24 +0100
Subject: [PATCH] drivers/pinctrl/pinctrl-at91.c: convert kfree to
 devm_kfree
In-Reply-To: <1355223525-19165-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1355223525-19165-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20121212115624.GI4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:58 Tue 11 Dec     , Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The function at91_dt_node_to_map is ultimately called by the function
> pinctrl_get, which is an exported function.  Since it is possible that this
> function is not called from within a probe function, for safety, the kfree
> is converted to a devm_kfree, to both free the data and remove it from the
> device in a failure situation.
> 
> A newline is added in the call to devm_kfree to avoid exceeding the 80
> character limit.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/pinctrl/pinctrl-at91.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index c5e7571..0da8a5f 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -255,7 +255,8 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	}
>  
>  	map_num += grp->npins;
> -	new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num, GFP_KERNEL);
> +	new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num,
> +			       GFP_KERNEL);
not related please drop
>  	if (!new_map)
>  		return -ENOMEM;
>  
> @@ -265,7 +266,7 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	/* create mux map */
>  	parent = of_get_parent(np);
>  	if (!parent) {
> -		kfree(new_map);
> +		devm_kfree(pctldev->dev, new_map);
ok
>  		return -EINVAL;
>  	}
>  	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
>
Best Regards,
J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
