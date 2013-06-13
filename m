From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 15:14:48 -0400 (EDT)
Subject: [PATCH V2 01/10] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <1371114989-2342-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306131513140.1561-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-at91 glue was not properly
> handled as it was not suspending generic part of ohci controller.
> Calling explicitly the ohci_suspend() routine in ohci_hcd_at91_drv_suspend()
> will ensure proper handling of suspend scenario.
> 
> V2:
>   -Incase ohci_suspend() fails, return right away without executing further.

> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index fb2f127..6620e3a 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -619,8 +619,18 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
>  {
>  	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
>  	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
> +	bool do_wakeup = device_may_wakeup(&pdev->dev);
> +	int ret;

Please use tab characters so that "do_wakeup" and "ret" are lined up 
directly beneath "*hcd" and "*ohci".  The rest of this patch is okay.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
