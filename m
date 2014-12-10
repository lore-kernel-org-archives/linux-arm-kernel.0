From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 10 Dec 2014 13:09:30 +0800
Subject: [PATCH 1/2] usb: chipidea: usbmisc: skip clocks on i.MX6
In-Reply-To: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
References: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20141210050928.GB11802@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 05:13:35PM +0100, Philipp Zabel wrote:
> On i.MX6Q, the USBMISC registers are clocked by the IPG clock,
> so there is no need to enable USBOH3 for the USBMISC driver.
> 

Access the registers at usbmisc needs the same clock with chipidea core,
both are usboh3.

For i.mx6 series, there is only one usb clock gate at ccm which is
usboh3, it is used to access register. For transfer data, it needs
usb phy's (using mxs phy) clock is enabled.

> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 926c997..f7b878d 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -338,23 +338,27 @@ static int usbmisc_imx_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->base))
>  		return PTR_ERR(data->base);
>  
> -	data->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(data->clk)) {
> -		dev_err(&pdev->dev,
> -			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
> -		return PTR_ERR(data->clk);
> -	}
> -
> -	ret = clk_prepare_enable(data->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"clk_prepare_enable failed, err=%d\n", ret);
> -		return ret;
> -	}
> -
>  	tmp_dev = (struct of_device_id *)
>  		of_match_device(usbmisc_imx_dt_ids, &pdev->dev);
>  	data->ops = (const struct usbmisc_ops *)tmp_dev->data;
> +
> +	/* on i.MX6Q, the USBMISC register space is clocked by the IPG clock */
> +	if (data->ops != &imx6q_usbmisc_ops) {
> +		data->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(data->clk)) {
> +			dev_err(&pdev->dev, "failed to get clock, err=%ld\n",
> +				PTR_ERR(data->clk));
> +			return PTR_ERR(data->clk);
> +		}
> +
> +		ret = clk_prepare_enable(data->clk);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"clk_prepare_enable failed, err=%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
> -- 
> 2.1.3
> 

-- 

Best Regards,
Peter Chen
