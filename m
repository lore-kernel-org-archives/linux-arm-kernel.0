From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Sep 2012 14:10:11 +0000
Subject: [PATCH] mfd: Implement devicetree support for AB8500 fg
In-Reply-To: <CAB4BAkvdwEDViLGXfHHzYjkoL6qPZca2dzOin3GhBrqRJ3xNAg@mail.gmail.com>
References: <CAB4BAkvdwEDViLGXfHHzYjkoL6qPZca2dzOin3GhBrqRJ3xNAg@mail.gmail.com>
Message-ID: <201209101410.11793.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 September 2012, Rajanikanth HV wrote:

> +Required Properties:
> +- compatible = "stericsson,ab8500-fg"
> +
> +supplied-to:
> +	This is a logical binding w.r.t power supply event change
> +	across energy-management-module drivers where in the
> +	runtime battery properties are shared along with uevent
> +	notification.
> +	ref: di->fg.external_power_changed =
> +		ab8500_fg_external_power_changed;
> +		ab8500_fg.c
> +
> +	Need for this property:
> +		btemp, fg and charger updates power-supply properties
> +		based on the events listed above.
> +		Event handler invokes power supply change notifier
> +		which in-turn invokes registered power supply class call-back
> +		based on the 'supplied_to' string.
> +		ref:
> +		power_supply_changed_work(..) ./drivers/power/power_supply_core.c
> +
> +	example:
> +	ab8500-fg {
> +		/* Other enery management module */
> +		supplied_to = "ab8500_chargalg", "ab8500_usb";
> +		num_supplicants = <2>;
> +	};

same comments as for the btemp driver.

> diff --git a/drivers/power/ab8500_bmdata.h b/drivers/power/ab8500_bmdata.h
> new file mode 100644
> index 0000000..748334a
> --- /dev/null
> +++ b/drivers/power/ab8500_bmdata.h
> @@ -0,0 +1,442 @@
> +static struct abx500_res_to_temp temp_tbl_A_thermister[] = {
> +	{-5, 53407},
> +	{ 0, 48594},
> +	{ 5, 43804},
> +	{10, 39188},
> +	{15, 34870},

Static variable definitions never belong in a header file. If you want to
share these between multiple drivers, put a single copy in one file and
make the symbols extern (or even exported).

If they are used in only one driver, just put the tables into that driver.
You probably want to make them 'const' as well.

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

I think for this driver it makes more sense to put all the information into
the struct ab8500_fg rather than having some of it in abx500_bm_plat_data,
so you can skip the allocation part here. In case of static platform
definitions, just copy the pointers from the platform data into the
ab8500_fg data.

	Arnd
