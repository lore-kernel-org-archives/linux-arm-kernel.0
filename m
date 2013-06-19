From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 19 Jun 2013 16:43:45 +0400
Subject: [PATCH V3 05/11] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <1371643936-3314-6-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-6-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51C1A781.2040603@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-06-2013 16:12, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-ep93xx glue was not
> properly handled as it was not suspending generic part
> of ohci controller. Calling explicitly the ohci_suspend()
> routine in ohci_hcd_ep93xx_drv_suspend() will ensure proper
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
>   drivers/usb/host/ohci-ep93xx.c |   10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

> diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
> index 8704e9f..f5f11d1 100644
> --- a/drivers/usb/host/ohci-ep93xx.c
> +++ b/drivers/usb/host/ohci-ep93xx.c
> @@ -174,13 +174,21 @@ static int ohci_hcd_ep93xx_drv_suspend(struct platform_device *pdev, pm_message_
>   {
>   	struct usb_hcd *hcd = platform_get_drvdata(pdev);
>   	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> +	bool	do_wakeup = device_may_wakeup(&pdev->dev);
> +	int		ret;

    There was no need to use tabs here, didn't you see that here the 
variables aren't aligned?

WBR, Sergei
