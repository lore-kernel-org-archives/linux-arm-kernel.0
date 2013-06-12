From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 12 Jun 2013 12:04:50 -0400 (EDT)
Subject: [PATCH 01/10] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <1371050918-29472-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306121203180.1431-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-at91 glue was not properly
> handled as it was not suspending generic part of ohci controller.
> Calling explicitly the ohci_suspend()routine in ohci_hcd_at91_drv_suspend()
> will ensure proper handling of suspend scenario.

> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index fb2f127..28400a7 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -619,8 +619,12 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
>  {
>  	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
>  	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
> +	bool do_wakeup = device_may_wakeup(&pdev->dev);
> +	int ret;
>  
> -	if (device_may_wakeup(&pdev->dev))
> +	ret = ohci_suspend(hcd, do_wakeup);
> +
> +	if (do_wakeup)
>  		enable_irq_wake(hcd->irq);
>  
>  	/*
> @@ -637,7 +641,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
>  		at91_stop_clock();
>  	}
>  
> -	return 0;
> +	return ret;

If ohci_suspend() fails, we should return right away.  Don't execute 
the enable_irq_wake() and all the other stuff.

Alan Stern
