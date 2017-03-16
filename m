From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu, 16 Mar 2017 09:32:34 -0600
Subject: [PATCH] usb: dwc3 dwc3_exynos_probe() change goto labels to
 meaningful names
In-Reply-To: <20170130192504.19046-1-shuahkh@osg.samsung.com>
References: <20170130192504.19046-1-shuahkh@osg.samsung.com>
Message-ID: <8da7ab58-9d4c-2e71-df98-40bbceea8858@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2017 12:25 PM, Shuah Khan wrote:
> Change goto labels to meaningful names from a series of errNs.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
> 
> Rebased to usb-next

Hi Felipe,

Are you planning to get this in or is there something you are
waiting in for me to do?

thanks,
-- Shuah


> 
>  drivers/usb/dwc3/dwc3-exynos.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 1515d45..98f74ff 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -147,53 +147,53 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
>  	if (IS_ERR(exynos->vdd33)) {
>  		ret = PTR_ERR(exynos->vdd33);
> -		goto err2;
> +		goto vdd33_err;
>  	}
>  	ret = regulator_enable(exynos->vdd33);
>  	if (ret) {
>  		dev_err(dev, "Failed to enable VDD33 supply\n");
> -		goto err2;
> +		goto vdd33_err;
>  	}
>  
>  	exynos->vdd10 = devm_regulator_get(dev, "vdd10");
>  	if (IS_ERR(exynos->vdd10)) {
>  		ret = PTR_ERR(exynos->vdd10);
> -		goto err3;
> +		goto vdd10_err;
>  	}
>  	ret = regulator_enable(exynos->vdd10);
>  	if (ret) {
>  		dev_err(dev, "Failed to enable VDD10 supply\n");
> -		goto err3;
> +		goto vdd10_err;
>  	}
>  
>  	ret = dwc3_exynos_register_phys(exynos);
>  	if (ret) {
>  		dev_err(dev, "couldn't register PHYs\n");
> -		goto err4;
> +		goto phys_err;
>  	}
>  
>  	if (node) {
>  		ret = of_platform_populate(node, NULL, NULL, dev);
>  		if (ret) {
>  			dev_err(dev, "failed to add dwc3 core\n");
> -			goto err5;
> +			goto populate_err;
>  		}
>  	} else {
>  		dev_err(dev, "no device node, failed to add dwc3 core\n");
>  		ret = -ENODEV;
> -		goto err5;
> +		goto populate_err;
>  	}
>  
>  	return 0;
>  
> -err5:
> +populate_err:
>  	platform_device_unregister(exynos->usb2_phy);
>  	platform_device_unregister(exynos->usb3_phy);
> -err4:
> +phys_err:
>  	regulator_disable(exynos->vdd10);
> -err3:
> +vdd10_err:
>  	regulator_disable(exynos->vdd33);
> -err2:
> +vdd33_err:
>  	clk_disable_unprepare(exynos->axius_clk);
>  axius_clk_err:
>  	clk_disable_unprepare(exynos->susp_clk);
> 
