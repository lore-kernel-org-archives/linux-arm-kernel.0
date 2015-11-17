From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 17 Nov 2015 22:18:01 +0800
Subject: [PATCH] pinctrl: mediatek: fix a memleak when do dt maps.
In-Reply-To: <1447734177-17258-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1447734177-17258-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1447769881.3218.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-11-16 at 20:22 -0800, Hongzhou Yang wrote:
> configs will kmemdup to dup_configs in pictrl util function.
> So configs need to be freed.
> 
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  Fix a memleak issue.
> 
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index bbf0230..0f9e416 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -520,21 +520,23 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>  	if (has_config && num_pins >= 1)
>  		maps_per_pin++;
>  
> -	if (!num_pins || !maps_per_pin)
> -		return -EINVAL;
> +	if (!num_pins || !maps_per_pin) {
> +		err = -EINVAL;
> +		goto exit;
> +	}


In line 510:

        err = pinconf_generic_parse_dt_config(node, pctldev, &configs,
                &num_configs);
        if (num_configs)
                has_config = 1;

if the function return err<0, configs and num_configs might not be
initialized and you'll crash the kernel when doing kfree(configs);

Joe.C

>  
>  	reserve = num_pins * maps_per_pin;
>  
>  	err = pinctrl_utils_reserve_map(pctldev, map,
>  			reserved_maps, num_maps, reserve);
>  	if (err < 0)
> -		goto fail;
> +		goto exit;
>  
>  	for (i = 0; i < num_pins; i++) {
>  		err = of_property_read_u32_index(node, "pinmux",
>  				i, &pinfunc);
>  		if (err)
> -			goto fail;
> +			goto exit;
>  
>  		pin = MTK_GET_PIN_NO(pinfunc);
>  		func = MTK_GET_PIN_FUNC(pinfunc);
> @@ -543,20 +545,21 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>  				func >= ARRAY_SIZE(mtk_gpio_functions)) {
>  			dev_err(pctl->dev, "invalid pins value.\n");
>  			err = -EINVAL;
> -			goto fail;
> +			goto exit;
>  		}
>  
>  		grp = mtk_pctrl_find_group_by_pin(pctl, pin);
>  		if (!grp) {
>  			dev_err(pctl->dev, "unable to match pin %d to group\n",
>  					pin);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto exit;
>  		}
>  
>  		err = mtk_pctrl_dt_node_to_map_func(pctl, pin, func, grp, map,
>  				reserved_maps, num_maps);
>  		if (err < 0)
> -			goto fail;
> +			goto exit;
>  
>  		if (has_config) {
>  			err = pinctrl_utils_add_map_configs(pctldev, map,
> @@ -564,13 +567,14 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>  					configs, num_configs,
>  					PIN_MAP_TYPE_CONFIGS_GROUP);
>  			if (err < 0)
> -				goto fail;
> +				goto exit;
>  		}
>  	}
>  
> -	return 0;
> +	err = 0;
>  
> -fail:
> +exit:
> +	kfree(configs);
>  	return err;
>  }
>  
