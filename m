From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 03 May 2018 14:23:07 +0200
Subject: [PATCH 50/61] thermal: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
Message-ID: <3499277.H47n29vZV6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 19. April 2018, 16:06:20 CEST schrieb Wolfram Sang:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/thermal/rockchip_thermal.c | 8 +++-----
>  drivers/thermal/spear_thermal.c    | 8 +++-----
>  drivers/thermal/zx2967_thermal.c   | 6 ++----
>  3 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index f36375d5a16c..9c7643d62ed7 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1327,8 +1327,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++)
> @@ -1346,8 +1345,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  
>  static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  	int error;
>  
> @@ -1376,7 +1374,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  					      id, thermal->regs,
>  					      thermal->tshut_temp);
>  		if (error)
> -			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
> +			dev_err(dev, "%s: invalid tshut=%d, error=%d\n",
>  				__func__, thermal->tshut_temp, error);
>  	}
>  

for the Rockchip-part
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
