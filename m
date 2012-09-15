From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 15 Sep 2012 12:50:05 +0200
Subject: [PATCH] mfd: Implement devicetree support for AB8500 fg
In-Reply-To: <CAB4BAkvdwEDViLGXfHHzYjkoL6qPZca2dzOin3GhBrqRJ3xNAg@mail.gmail.com>
References: <CAB4BAkvdwEDViLGXfHHzYjkoL6qPZca2dzOin3GhBrqRJ3xNAg@mail.gmail.com>
Message-ID: <50545D5D.6010101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/10/2012 11:44 AM, Rajanikanth HV wrote:
...
> +static int __devinit
> +fg_of_probe(struct device *dev,
> +		struct device_node *np,
> +		struct abx500_bm_plat_data *bm_pdata)
> +{
> +	u8	val;
> +	u32	pval;
> +	int	i;
> +	int	ext_thermister, lion_battery, ret = 0;
> +	const char *bm_dev_name;
> +	struct	abx500_fg_platform_data *fg = bm_pdata->fg;
> +	struct	abx500_bm_data		   *bat;
> +	struct	abx500_battery_type	   *btype;
> +
> +	ret = of_property_read_u32(np, "num_supplicants", &pval);
> +	if (ret) {
> +		dev_err(dev, "missing property num_supplicants\n");
> +		ret = -EINVAL;
> +		goto inval_pval;
> +	}
> +	fg->num_supplicants = pval;
> +	fg->supplied_to =
> +		devm_kzalloc(dev, fg->num_supplicants *
> +			sizeof(const char *), GFP_KERNEL);
> +	if (fg->supplied_to == NULL) {
> +		dev_err(dev, "%s no mem for supplied_to\n", __func__);
> +		ret = -ENOMEM;
> +		goto inval_pval;
> +	}
> +	for (val = 0; val < fg->num_supplicants; ++val)
> +		if (of_property_read_string_index
> +			(np, "supplied_to", val, &bm_dev_name) == 0)
> +			*(fg->supplied_to + val) = (char *)bm_dev_name;
> +		else {
> +			dev_err(dev, "insufficient number of supplied_to data found\n");
> +			ret = -EINVAL;
> +			goto free_dev_mem;
> +		}
> +	ret = of_property_read_u32(np, "thermister_on_batctrl", &pval);
> +	if (ret) {
> +		dev_err(dev, "missing property thermister_on_batctrl\n");
> +		ret = -EINVAL;
> +		goto free_dev_mem;
> +	}
> +	bm_pdata->battery = &ab8500_bm_data;
> +	bat = bm_pdata->battery;
> +	ext_thermister = 0;
> +	if (pval == 0) {
> +		bat->n_btypes = 4;
> +		bat->bat_type = bat_type_ext_thermister;
> +		bat->adc_therm = ABx500_ADC_THERM_BATTEMP;
> +		ext_thermister = 1;
> +	}
> +	ret = of_property_read_u32(np, "li_ion_9100", &pval);
> +	if (ret) {
> +		dev_err(dev, "missing property li_ion_9100\n");
> +		ret = -EINVAL;
> +		goto free_dev_mem;
> +	}
> +	lion_battery = 0;
> +	if (pval == 1) {
> +		bat->no_maintenance = true;
> +		bat->chg_unknown_bat = true;
> +		bat->bat_type[BATTERY_UNKNOWN].charge_full_design = 2600;
> +		bat->bat_type[BATTERY_UNKNOWN].termination_vol = 4150;
> +		bat->bat_type[BATTERY_UNKNOWN].recharge_vol = 4130;
> +		bat->bat_type[BATTERY_UNKNOWN].normal_cur_lvl = 520;
> +		bat->bat_type[BATTERY_UNKNOWN].normal_vol_lvl = 4200;
> +		lion_battery = 1;
> +	}
> +	/* select the battery resolution table */
> +	for (i = 0; i < bat->n_btypes; ++i) {
> +		btype = (bat->bat_type + i);
> +		if (ext_thermister) {
> +			btype->batres_tbl =
> +				temp_to_batres_tbl_ext_thermister;
> +		} else if (lion_battery) {
> +			btype->batres_tbl =
> +				temp_to_batres_tbl_9100;
> +		} else {
> +			btype->batres_tbl =
> +				temp_to_batres_tbl_thermister;
> +		}
> +	}
> +	return ret;
> +free_dev_mem:
> +	devm_kfree(dev, fg->supplied_to);
> +inval_pval:
> +	return ret;
> +}

Since when fg_of_probe() fails, the driver probe function returns error,
there is no need to devm_kfree() data allocated with devm_kzalloc(), so
you can get rid of the goto statements

>  static int __devinit ab8500_fg_probe(struct platform_device *pdev)
>  {
>  	int i, irq;
>  	int ret = 0;
>  	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct ab8500_fg *di;
> 
> +	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
> +	if (!di) {
> +		dev_err(&pdev->dev, "%s no mem for ab8500_btemp\n", __func__);

Copy&paste error, this is not btemp

> +		ret = -ENOMEM;
> +		goto err_no_mem;
> +	}
> +	if (np) {
> +		if (!plat_data) {
> +			plat_data =
> +			devm_kzalloc(&pdev->dev, sizeof(*plat_data), GFP_KERNEL);
> +			if (!plat_data) {
> +				dev_err(&pdev->dev,
> +					"%s no mem for plat_data\n", __func__);
> +				ret = -ENOMEM;
> +				goto free_device_info;
> +			}
> +			plat_data->fg = devm_kzalloc(&pdev->dev,
> +					sizeof(*plat_data->fg), GFP_KERNEL);
> +			if (!plat_data->fg) {
> +				devm_kfree(&pdev->dev, plat_data);
> +				dev_err(&pdev->dev,
> +					"%s no mem for pdata->fg\n",
> +					__func__);
> +				ret = -ENOMEM;
> +				goto free_device_info;
> +			}
> +		}
> +		/* get battery specific platform data */
> +		ret = fg_of_probe(&pdev->dev, np, plat_data);
> +		if (ret) {
> +			devm_kfree(&pdev->dev, plat_data->fg);
> +			devm_kfree(&pdev->dev, plat_data);
> +			goto free_device_info;
> +		}
> +	}
>  	if (!plat_data) {
> -		dev_err(&pdev->dev, "No platform data\n");
> -		return -EINVAL;
> +		dev_err(&pdev->dev,
> +			"%s no fg platform data found\n", __func__);
> +		ret = -EINVAL;
> +		goto free_device_info;
>  	}
> 
>  	di = kzalloc(sizeof(*di), GFP_KERNEL);

This should be removed, and kfree(di) should be removed from
ab8500_fg_remove()

> @@ -2606,11 +2737,17 @@ free_irq:
>  free_inst_curr_wq:
>  	destroy_workqueue(di->fg_wq);
>  free_device_info:
> -	kfree(di);
> +	devm_kfree(&pdev->dev, di);
> +err_no_mem:
> 
>  	return ret;
>  }

Also in this function, no need to call devm_kfree() on error

Regards,
Francesco
