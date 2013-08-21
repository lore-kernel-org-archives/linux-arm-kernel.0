From: zonque@gmail.com (Daniel Mack)
Date: Wed, 21 Aug 2013 10:50:34 +0200
Subject: [PATCH] usb: musb dsps: fix pdev cast in suspend/resume
In-Reply-To: <1376397630-26863-1-git-send-email-zonque@gmail.com>
References: <1376397630-26863-1-git-send-email-zonque@gmail.com>
Message-ID: <52147F5A.90801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.08.2013 14:40, Daniel Mack wrote:
> dsps_suspend() and dsps_resume() are called with the device that has the
> glue assigned as drvdata. Using dev->parent seems wrong and causes a
> NULL pointer exception on an AM33xx board.
> 
> The code was introduced by commit c68bb4c6 ("usb: musb: dsps: control
> module handling (quirk)") but I wonder whether it was ever used.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Felipe, is this one good to go in?



Thanks,
Daniel



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
>  	const struct dsps_musb_wrapper *wrp = glue->wrp;
>  	int i;
> @@ -705,7 +705,7 @@ static int dsps_suspend(struct device *dev)
>  
>  static int dsps_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev->parent);
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct dsps_glue *glue = platform_get_drvdata(pdev);
>  	const struct dsps_musb_wrapper *wrp = glue->wrp;
>  	int i;
> 
