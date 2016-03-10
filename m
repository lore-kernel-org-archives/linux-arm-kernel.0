From: caesar.upstream@gmail.com (Caesar Wang)
Date: Thu, 10 Mar 2016 10:36:35 +0800
Subject: [PATCH 10/13] thermal: convert rockchip_thermal to use
 devm_thermal_zone_of_sensor_register
In-Reply-To: <1457559336-17652-11-git-send-email-edubezval@gmail.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-11-git-send-email-edubezval@gmail.com>
Message-ID: <56E0DDB3.8080405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016?03?10? 05:35, Eduardo Valentin ??:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-pm at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

Tested-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Caesar Wang <wxt@rock-chips.com>

I just cherry-pick the devm* patches to test the rockchip thermal.

> ---
>   drivers/thermal/rockchip_thermal.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index b58e3fb..792c5d0 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -753,8 +753,8 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
>   
>   	sensor->thermal = thermal;
>   	sensor->id = id;
> -	sensor->tzd = thermal_zone_of_sensor_register(&pdev->dev, id, sensor,
> -						      &rockchip_of_thermal_ops);
> +	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> +					sensor, &rockchip_of_thermal_ops);
>   	if (IS_ERR(sensor->tzd)) {
>   		error = PTR_ERR(sensor->tzd);
>   		dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
> @@ -782,7 +782,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>   	const struct of_device_id *match;
>   	struct resource *res;
>   	int irq;
> -	int i, j;
> +	int i;
>   	int error;
>   
>   	match = of_match_node(of_rockchip_thermal_match, np);
> @@ -865,9 +865,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev,
>   				"failed to register sensor[%d] : error = %d\n",
>   				i, error);
> -			for (j = 0; j < i; j++)
> -				thermal_zone_of_sensor_unregister(&pdev->dev,
> -						thermal->sensors[j].tzd);
>   			goto err_disable_pclk;
>   		}
>   	}
> @@ -879,7 +876,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>   	if (error) {
>   		dev_err(&pdev->dev,
>   			"failed to request tsadc irq: %d\n", error);
> -		goto err_unregister_sensor;
> +		goto err_disable_pclk;
>   	}
>   
>   	thermal->chip->control(thermal->regs, true);
> @@ -891,11 +888,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> -err_unregister_sensor:
> -	while (i--)
> -		thermal_zone_of_sensor_unregister(&pdev->dev,
> -						  thermal->sensors[i].tzd);
> -
>   err_disable_pclk:
>   	clk_disable_unprepare(thermal->pclk);
>   err_disable_clk:
> @@ -913,7 +905,6 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>   		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
>   
>   		rockchip_thermal_toggle_sensor(sensor, false);
> -		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
>   	}
>   
>   	thermal->chip->control(thermal->regs, false);


-- 
Thanks,
Caesar
