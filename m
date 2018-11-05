From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 5 Nov 2018 16:07:19 +0100
Subject: [PATCH 5/5] thermal: zx2967_thermal: simplify getting .driver_data
In-Reply-To: <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
Message-ID: <1de46d0b-a241-8ee6-7bf3-eb8ae4c22251@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/2018 22:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/zx2967_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
> index 6acce0bce7c0..145ebf371598 100644
> --- a/drivers/thermal/zx2967_thermal.c
> +++ b/drivers/thermal/zx2967_thermal.c
> @@ -207,8 +207,7 @@ MODULE_DEVICE_TABLE(of, zx2967_thermal_id_table);
>  #ifdef CONFIG_PM_SLEEP
>  static int zx2967_thermal_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
>  
>  	if (priv && priv->clk_topcrm)
>  		clk_disable_unprepare(priv->clk_topcrm);
> @@ -221,8 +220,7 @@ static int zx2967_thermal_suspend(struct device *dev)
>  
>  static int zx2967_thermal_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
>  	int error;
>  
>  	error = clk_prepare_enable(priv->clk_topcrm);
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
