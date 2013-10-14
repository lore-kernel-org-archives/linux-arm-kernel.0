From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Oct 2013 08:49:46 -0700
Subject: [PATCH 05/11] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <1380708947-15966-6-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380708947-15966-6-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <CAOesGMhiMD2_OOdR1_GDrJUWgU-qU9MyirhGtxXiWRQcMWy8+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Greg,

[Adding ep93xx maintainers as well]

On Wed, Oct 2, 2013 at 3:15 AM, Majunath Goudar <csmanjuvijay@gmail.com> wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>
> Suspend scenario in case of ohci-ep93xx glue was not
> properly handled as it was not suspending generic part
> of ohci controller. Alan Stern suggested, properly handle
> ohci-ep93xx suspend scenario.
>
> Calling explicitly the ohci_suspend() routine in
> ohci_hcd_ep93xx_drv_suspend() will ensure proper handling of
> suspend scenario.
>
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: linux-usb at vger.kernel.org
> ---
>  drivers/usb/host/ohci-ep93xx.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
> index 492f681..08409bf 100644
> --- a/drivers/usb/host/ohci-ep93xx.c
> +++ b/drivers/usb/host/ohci-ep93xx.c
> @@ -112,13 +112,20 @@ static int ohci_hcd_ep93xx_drv_suspend(struct platform_device *pdev, pm_message_
>  {
>         struct usb_hcd *hcd = platform_get_drvdata(pdev);
>         struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> +       bool do_wakeup = device_may_wakeup(&pdev->dev);
> +       int ret;
>
>         if (time_before(jiffies, ohci->next_statechange))
>                 msleep(5);
>         ohci->next_statechange = jiffies;
>
> -       clk_disable(usb_host_clock);
> -       return 0;
> +       ret = ohci_suspend(hcd, do_wakeup);
> +       if (ret)
> +               return ret;
> +
> +       ep93xx_stop_hc(&pdev->dev);
> +
> +       return ret;
>  }

This patch showed up in -next today (or maybe a while ago and I didn't
notice). It's causing a build failure on ep93xx:

>From http://arm-soc.lixom.net/buildlogs/next-thierry/v3.12-rc5-5366-gba2e8c2/buildall.arm.ep93xx_defconfig.log.failed:

drivers/usb/host/ohci-ep93xx.c: In function 'ohci_hcd_ep93xx_drv_suspend':
drivers/usb/host/ohci-ep93xx.c:126:2: error: implicit declaration of
function 'ep93xx_stop_hc'


It's really confusing though, because Majunath has posted this patch
three times. The first time it had the ep93xx_stop_hc() call in there,
the second patch (labelled V2) did not, and the third(?) version,
without version label, also lacked it. No revision log in the patch,
and no comments on it.

But it does seem like the wrong version was merged based on build results.


-Olof
