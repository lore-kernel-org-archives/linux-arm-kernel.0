From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 12 Jun 2013 19:54:04 +0400
Subject: [PATCH 03/10] USB: OHCI: Properly handle ohci-da8xx suspend
In-Reply-To: <1371050918-29472-4-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371050918-29472-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51B8999C.30506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-06-2013 19:28, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-da8xx glue was not
> properly handled as it was not suspending generic part
> of ohci controller.Calling explicitly the ohci_suspend()
> routine in ohci_da8xx_suspend() will ensure proper
> handling of suspend scenario.

> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> ---
>   drivers/usb/host/ohci-da8xx.c |   13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index 6aaa9c9..3b1d9bd 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -406,19 +406,24 @@ static int ohci_hcd_da8xx_drv_remove(struct platform_device *dev)
>   }
>
>   #ifdef CONFIG_PM
> -static int ohci_da8xx_suspend(struct platform_device *dev, pm_message_t message)
> +static int ohci_da8xx_suspend(struct platform_device *pdev,
> +		pm_message_t message)
>   {
> -	struct usb_hcd	*hcd	= platform_get_drvdata(dev);
> +	struct usb_hcd	*hcd	= platform_get_drvdata(pdev);
>   	struct ohci_hcd	*ohci	= hcd_to_ohci(hcd);
> +	bool do_wakeup = device_may_wakeup(&pdev->dev);

     Could you align = with other intializers above?

> +	int ret;
>

WBR, Sergei
