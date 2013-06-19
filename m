From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 19 Jun 2013 16:47:14 +0400
Subject: [PATCH V3 06/11] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <1371643936-3314-7-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-7-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51C1A852.6080606@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-2013 16:12, Manjunath Goudar wrote:

> Suspend scenario in case of ohci-exynos glue was not
> properly handled as it was not suspending generic part
> of ohci controller. Calling explicitly the ohci_suspend()
> routine in exynos_ohci_suspend() will ensure proper
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
>   -rid of unwanted code from ohci_hcd_s3c2410_drv_suspend() which already
>    ohci_suspend() does it.
>   -Aligned variable "do_wakeup" and "ret".
> ---
>   drivers/usb/host/ohci-exynos.c |   24 +++++++-----------------
>   1 file changed, 7 insertions(+), 17 deletions(-)

> diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
> index ae6068d..b5926f8 100644
> --- a/drivers/usb/host/ohci-exynos.c
> +++ b/drivers/usb/host/ohci-exynos.c
> @@ -203,24 +203,15 @@ static int exynos_ohci_suspend(struct device *dev)
>   	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
>   	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
>   	struct platform_device *pdev = to_platform_device(dev);
> -	unsigned long flags;
> -	int rc = 0;
> +	bool		do_wakeup = device_may_wakeup(dev);
> +	unsigned long	flags;
> +	int		rc = 0;

    Sigh, here there was no any alignment of variable names, why you 
aligned your variables? Doing everything with the single template? :-)

WBR, Sergei
