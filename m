From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Nov 2013 09:56:58 +0000
Subject: [PATCH 1/2] chipidea: ci_hdrc_imx: Allow handling the clock
 for an USB phy/hub
In-Reply-To: <1384394987-15134-1-git-send-email-festevam@gmail.com>
References: <1384394987-15134-1-git-send-email-festevam@gmail.com>
Message-ID: <20131114095658.GY16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 12:09:46AM -0200, Fabio Estevam wrote:
> @@ -107,10 +108,22 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	data->clk_phy = devm_clk_get(&pdev->dev, "phy");
> +	if (IS_ERR(data->clk_phy)) {
> +		data->clk_phy = NULL;
> +	} else {

Please stop using NULL as a indicator with functions which only return
failure as an error pointer.  Replace the above three lines with

	if (!IS_ERR(data->clk_phy)) {

> +		ret = clk_prepare_enable(data->clk_phy);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to enable clk_phy: %d\n", ret);
> +			goto err_clk;
> +		}
> +	}
> +
>  	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
>  	if (IS_ERR(data->phy)) {
>  		ret = PTR_ERR(data->phy);
> -		goto err_clk;
> +		goto err_clk_phy;
>  	}
>  
>  	pdata.phy = data->phy;
> @@ -157,6 +170,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  
>  disable_device:
>  	ci_hdrc_remove_device(data->ci_pdev);
> +err_clk_phy:
> +	if (data->clk_phy)

This test should not be necessary if you've nested the error cleanup.

> +		clk_disable_unprepare(data->clk_phy);
>  err_clk:
>  	clk_disable_unprepare(data->clk);
>  	return ret;
> @@ -168,6 +184,8 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  	ci_hdrc_remove_device(data->ci_pdev);
> +	if (data->clk_phy)

	if (!IS_ERR(data->clk_phy))

> +		clk_disable_unprepare(data->clk_phy);
>  	clk_disable_unprepare(data->clk);
>  
>  	return 0;
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
