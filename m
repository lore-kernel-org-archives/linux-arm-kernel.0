From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 27 Oct 2012 17:11:59 +0200
Subject: [PATCH 4/4] mfd: ab8500: add devicetree support for chargalg
In-Reply-To: <1351146654-9110-5-git-send-email-rajanikanth.hv@stericsson.com>
References: <1351146654-9110-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1351146654-9110-5-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <508BF9BF.4080602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 08:30 AM, Rajanikanth H.V wrote:
> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
> 
> This patch adds device tree support for charging algorithm
> driver
> 
> Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
[...]
> diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
> index 88b5cc1..829fcfd 100644
> --- a/drivers/power/abx500_chargalg.c
> +++ b/drivers/power/abx500_chargalg.c
> @@ -21,6 +21,8 @@
>  #include <linux/completion.h>
>  #include <linux/workqueue.h>
>  #include <linux/kobject.h>
> +#include <linux/of.h>
> +#include <linux/mfd/core.h>
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ux500_chargalg.h>
>  #include <linux/mfd/abx500/ab8500-bm.h>
> @@ -231,7 +233,6 @@ struct abx500_chargalg {
>  	struct abx500_chargalg_charger_info chg_info;
>  	struct abx500_chargalg_battery_data batt_data;
>  	struct abx500_chargalg_suspension_status susp_status;
> -	struct abx500_bmdevs_plat_data *pdata;

pdata should be removed from the description of the struct members as well.

>  	struct abx500_bm_data *bat;
>  	struct power_supply chargalg_psy;
>  	struct ux500_charger *ac_chg;
> @@ -1795,25 +1796,45 @@ static int __devexit abx500_chargalg_remove(struct platform_device *pdev)
>  	flush_scheduled_work();
>  	power_supply_unregister(&di->chargalg_psy);
>  	platform_set_drvdata(pdev, NULL);
> -	kfree(di);
>  
>  	return 0;
>  }
>  
> +static char *supply_interface[] = {
> +	"ab8500_fg",
> +};
> +
>  static int __devinit abx500_chargalg_probe(struct platform_device *pdev)
>  {
> -	struct abx500_bmdevs_plat_data *plat_data;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct abx500_chargalg *di;
>  	int ret = 0;
>  
> -	struct abx500_chargalg *di =
> -		kzalloc(sizeof(struct abx500_chargalg), GFP_KERNEL);
> -	if (!di)
> +	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
> +	if (!di) {
> +		dev_err(&pdev->dev, "%s no mem for ab8500_chargalg\n", __func__);
>  		return -ENOMEM;
> +	}
> +	di->bat = pdev->mfd_cell->platform_data;
> +	if (!di->bat) {
> +		if (np) {
> +			ret = bmdevs_of_probe(&pdev->dev, np, &di->bat);
> +			if (ret) {
> +				dev_err(&pdev->dev,
> +					"failed to get battery information\n");
> +				return ret;
> +			}
> +		} else {
> +			dev_err(&pdev->dev, "missing dt node for ab8500_chargalg\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		dev_info(&pdev->dev, "falling back to legacy platform data\n");
> +		printk("%s falling back to legacy platform data\n", __func__);

You forgot to remove the printk() call.

--
Francesco
