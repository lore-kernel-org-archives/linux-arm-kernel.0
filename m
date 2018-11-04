From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 15:37:43 +0100
Subject: [PATCH 13/15] power: supply: olpc_battery: Move priv data to a
 struct
In-Reply-To: <20181010172300.317643-14-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-14-lkundrak@v3.sk>
Message-ID: <20181104143743.GF23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The global variables for private data are not too nice. I'd like some
> more, and that would clutter the global name space even further.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Ok...

> -	olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
> -	if (IS_ERR(olpc_bat)) {
> -		ret = PTR_ERR(olpc_bat);
> -		goto battery_failed;
> -	}
> +	data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
> +	if (IS_ERR(data->olpc_bat))
> +		return PTR_ERR(data->olpc_bat);
>  
> -	ret = device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	ret = device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
> -		goto eeprom_failed;
> +		return ret;
>  
> -	ret = device_create_file(&olpc_bat->dev, &olpc_bat_error);
> +	ret = device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
>  		goto error_failed;
>  
>  	if (olpc_ec_wakeup_available()) {
> -		device_set_wakeup_capable(&olpc_ac->dev, true);
> -		device_set_wakeup_capable(&olpc_bat->dev, true);
> +		device_set_wakeup_capable(&data->olpc_ac->dev, true);
> +		device_set_wakeup_capable(&data->olpc_bat->dev, true);
>  	}
>  
>  	return 0;
>  
>  error_failed:
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -eeprom_failed:
> -	power_supply_unregister(olpc_bat);
> -battery_failed:
> -	power_supply_unregister(olpc_ac);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	return ret;
>  }

...but you are changing error handling here, which is not mentioned in
the changelog, and I'm nut sure you got it right.

Are you sure?

>  static int olpc_battery_remove(struct platform_device *pdev)
>  {
> -	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
> -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> -	power_supply_unregister(olpc_bat);
> -	power_supply_unregister(olpc_ac);
> +	struct olpc_battery_data *data = platform_get_drvdata(pdev);
> +
> +	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	return 0;
>  }

Here too.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/c6262847/attachment.sig>
