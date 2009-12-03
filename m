From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 3 Dec 2009 11:55:34 +0100
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <1259836558-3007-1-git-send-email-valentin.longchamp@epfl.ch>
References: <4B169E48.2000804@epfl.ch>
	<1259836558-3007-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20091203105534.GN14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 11:35:58AM +0100, Valentin Longchamp wrote:
> On various mxc boards, the intial ULPI reads resulted in a timeout
> which prevented the transceiver to be identified and thus the ehci
> device to be probed.
> 
> Initializing the hardware lines connected to the transceiver (through
> pdata->init call) before actually enabling clocks and configuring
> registers in the devices fixes this problem.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>

Acked-by: Daniel Mack <daniel@caiaq.de>


> ---
>  drivers/usb/host/ehci-mxc.c |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index 35c56f4..23cd917 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -162,6 +162,17 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  		goto err_ioremap;
>  	}
>  
> +	/* call platform specific init function */
> +	if (pdata->init) {
> +		ret = pdata->init(pdev);
> +		if (ret) {
> +			dev_err(dev, "platform init failed\n");
> +			goto err_init;
> +		}
> +		/* platforms need some time to settle changed IO settings */
> +		mdelay(10);
> +	}
> +
>  	/* enable clocks */
>  	priv->usbclk = clk_get(dev, "usb");
>  	if (IS_ERR(priv->usbclk)) {
> @@ -192,18 +203,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_init;
>  
> -	/* call platform specific init function */
> -	if (pdata->init) {
> -		ret = pdata->init(pdev);
> -		if (ret) {
> -			dev_err(dev, "platform init failed\n");
> -			goto err_init;
> -		}
> -	}
> -
> -	/* most platforms need some time to settle changed IO settings */
> -	mdelay(10);
> -
>  	/* Initialize the transceiver */
>  	if (pdata->otg) {
>  		pdata->otg->io_priv = hcd->regs + ULPI_VIEWPORT_OFFSET;
> -- 
> 1.6.3.3
> 
