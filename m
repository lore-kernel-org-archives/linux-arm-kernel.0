From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Jul 2013 20:04:52 +0800
Subject: [PATCH] reset: allow drivers to request probe deferral
In-Reply-To: <1374148653-14009-1-git-send-email-p.zabel@pengutronix.de>
References: <1374148653-14009-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130718120448.GC16328@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 01:57:33PM +0200, Philipp Zabel wrote:
> If the requested reset controller is not yet available, have reset_control_get
> and device_reset return -EPROBE_DEFER so the driver can decide to request
> probe deferral.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index d1b6089..b3d99a1 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -167,7 +167,7 @@ struct reset_control *reset_control_get(struct device *dev, const char *id)
>  
>  	if (!rcdev) {
>  		mutex_unlock(&reset_controller_list_mutex);
> -		return ERR_PTR(-ENODEV);
> +		return ERR_PTR(-EPROBE_DEFER);

Yeah, with the change the client device driver does not need to
translate error code -ENODEV into -EPROBE_DEFER, but just return
whatever device_reset() returns in error case.  So,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

>  	}
>  
>  	rstc_id = rcdev->of_xlate(rcdev, &args);
> -- 
> 1.8.3.2
> 
