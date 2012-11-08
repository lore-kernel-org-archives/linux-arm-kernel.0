From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Nov 2012 16:25:05 -0800
Subject: [PATCH v4 3/9] pinctrl: single: support pinconf generic
In-Reply-To: <1352301582-12244-4-git-send-email-haojian.zhuang@gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-4-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121108002505.GT6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:21]:
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index a7c5fdd..77aec05 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
>  static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
>  				unsigned pin, unsigned long *config)
>  {
> +	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	unsigned data;
> +	u32 offset;

Do you need a check here (and also in other pinconf related functions)
for driver instances that don't have pinconf enabled?

Something like:

	if (!pcs->pinconf)
		return -ENOTSUPP;
...


> @@ -806,34 +1000,27 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
>  
>  	pcs = pinctrl_dev_get_drvdata(pctldev);
>  
> -	*map = devm_kzalloc(pcs->dev, sizeof(**map), GFP_KERNEL);
> -	if (!map)
> -		return -ENOMEM;
> +	if (!pcs->conf.nconfs)
> +		*num_maps = 1;
> +	else
> +		*num_maps = 2;
>  
> -	*num_maps = 0;
> +	*map = devm_kzalloc(pcs->dev, sizeof(**map) * (*num_maps), GFP_KERNEL);
> +	if (!*map)
> +		return -ENOMEM;
>  
>  	pgnames = devm_kzalloc(pcs->dev, sizeof(*pgnames), GFP_KERNEL);
> -	if (!pgnames) {
> -		ret = -ENOMEM;
> -		goto free_map;
> -	}
> +	if (!pgnames)
> +		return -ENOMEM;
>  
>  	ret = pcs_parse_one_pinctrl_entry(pcs, np_config, map, pgnames);
>  	if (ret < 0) {
>  		dev_err(pcs->dev, "no pins entries for %s\n",
>  			np_config->name);
> -		goto free_pgnames;
> +		return ret;
>  	}
> -	*num_maps = 1;
>  
>  	return 0;
> -
> -free_pgnames:
> -	devm_kfree(pcs->dev, pgnames);
> -free_map:
> -	devm_kfree(pcs->dev, *map);
> -
> -	return ret;
>  }

Here looks like you're changing the behaviour to not free entries in cases
where parsing with cs_parse_one_pinctrl_entry() fails. I'd prefer the freeing
it in case of parsing errors so we don't waste memory when the system is
running. Also there's a tiny chance that *num_maps will be wrong if the
second devm_kzalloc fails.. But it's more likely that we get a broken device
tree to parse and end up potentially hogging hundreds of maps.

Regards,

Tony
