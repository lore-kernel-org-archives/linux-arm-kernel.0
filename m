From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 19 Jun 2013 16:49:39 +0400
Subject: [PATCH V3 08/11] USB: OHCI: Properly handle ohci-platform suspend
In-Reply-To: <1371643936-3314-9-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-9-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51C1A8E3.4050800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-2013 16:12, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-platform glue was not
> properly handled as it was not suspending generic part
> of ohci controller. Calling explicitly the ohci_suspend()
> routine in ohci_platform_suspend() will ensure proper
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
>   drivers/usb/host/ohci-platform.c |    9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index bc30475..f4830a5 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -139,14 +139,21 @@ static int ohci_platform_remove(struct platform_device *dev)
>
>   static int ohci_platform_suspend(struct device *dev)
>   {
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
>   	struct usb_ohci_pdata *pdata = dev->platform_data;
>   	struct platform_device *pdev =
>   		container_of(dev, struct platform_device, dev);

    Again, the above variables weren't aligned. I bet you were just 
cut-and-pasting the same code without looking... :-/

> +	bool		do_wakeup = device_may_wakeup(dev);
> +	int		ret;

WBR, Sergei
