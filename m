From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 15:20:42 -0400 (EDT)
Subject: [PATCH V2 02/10] USB: OHCI: Properly handle ohci-s3c2410 suspend
In-Reply-To: <1371114989-2342-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306131515020.1561-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-s3c2410 glue was not
> properly handled as it was not suspending generic part
> of ohci controller.Calling explicitly the ohci_suspend()
> routine in ohci_hcd_s3c2410_drv_suspend() will ensure
> proper handling of suspend scenario.
> 
> V2:
>  -Incase ohci_suspend() fails, return right away
>   without executing further.

> diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
> index 8018bb1..01430f2 100644
> --- a/drivers/usb/host/ohci-s3c2410.c
> +++ b/drivers/usb/host/ohci-s3c2410.c
> @@ -430,7 +430,15 @@ static int ohci_hcd_s3c2410_drv_suspend(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	unsigned long flags;
>  	int rc = 0;
> +	bool do_wakeup = device_may_wakeup(dev);
>  
> +	rc = ohci_suspend(hcd, do_wakeup);
> +	if (rc == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
> +		ohci_resume(hcd, false);
> +		rc = -EBUSY;
> +	}
> +	if (rc)
> +		return rc;
>  	/*
>  	 * Root hub was already suspended. Disable irq emission and
>  	 * mark HW unaccessible, bail out if RH has been resumed. Use

The part that follows this patch doesn't make sense any more.  I think
we can afford to get rid of the test for ohci->rh_state !=
OHCI_RH_SUSPENDED; the PM core has been quite stable for years and it
won't try to suspend the controller if the root hub is active.

Also, the

	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);

line isn't needed, because ohci_suspend() does it.

Putting this all together, all that's left is the spin_lock/unlock and 
the call to s3c2410_stop_hc().  The comment isn't needed, nor is the 
statement label.  (In fact, I'm not even sure if the spin_lock/unlock 
lines are needed.  It depends on the hardware details.)

Alan Stern
