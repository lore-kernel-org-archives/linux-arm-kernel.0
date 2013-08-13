From: balbi@ti.com (Felipe Balbi)
Date: Tue, 13 Aug 2013 10:37:53 -0500
Subject: [PATCH] usb: musb dsps: fix pdev cast in suspend/resume
In-Reply-To: <1376397630-26863-1-git-send-email-zonque@gmail.com>
References: <1376397630-26863-1-git-send-email-zonque@gmail.com>
Message-ID: <20130813153738.GJ27954@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 02:40:30PM +0200, Daniel Mack wrote:
> dsps_suspend() and dsps_resume() are called with the device that has the
> glue assigned as drvdata. Using dev->parent seems wrong and causes a
> NULL pointer exception on an AM33xx board.
> 
> The code was introduced by commit c68bb4c6 ("usb: musb: dsps: control
> module handling (quirk)") but I wonder whether it was ever used.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/usb/musb/musb_dsps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 5233804..f20218e 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -692,7 +692,7 @@ static int dsps_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int dsps_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev->parent);
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct dsps_glue *glue = platform_get_drvdata(pdev);

actually, can you get rid of the platform_device access here ? The
following should work:

	struct dsps_glue *glue = dev_get_drvdata(dev);

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/498c8e60/attachment-0001.sig>
