From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 19 Jun 2013 16:53:57 +0400
Subject: [PATCH V3 11/11] USB: OHCI: Properly handle ohci-spear suspend
In-Reply-To: <1371643936-3314-12-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-12-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51C1A9E5.7040508@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-2013 16:12, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-spear glue was not
> properly handled as it was not suspending generic part
> of ohci controller. Calling explicitly the ohci_suspend()
> routine in spear_ohci_hcd_drv_suspend() will ensure proper
> handling of suspend scenario.

> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org

> V2:
>   -Incase ohci_suspend() fails, return right away without
>    executing further.
> V3:
>   -Aligned variable "do_wakeup" and "ret".
> ---
>   drivers/usb/host/ohci-spear.c |   12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

> diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
> index 31ff3fc..a3b2696 100644
> --- a/drivers/usb/host/ohci-spear.c
> +++ b/drivers/usb/host/ohci-spear.c
> @@ -130,20 +130,26 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
>   }
>
>   #if defined(CONFIG_PM)
> -static int spear_ohci_hcd_drv_suspend(struct platform_device *dev,
> +static int spear_ohci_hcd_drv_suspend(struct platform_device *pdev,
>   		pm_message_t message)
>   {
> -	struct usb_hcd *hcd = platform_get_drvdata(dev);
> +	struct usb_hcd *hcd = platform_get_drvdata(pdev);
>   	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
>   	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
> +	bool		do_wakeup = device_may_wakeup(&pdev->dev);
> +	int		ret;

    Sigh...

WBR, Sergei
