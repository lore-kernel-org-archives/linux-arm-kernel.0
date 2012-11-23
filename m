From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 23 Nov 2012 13:36:36 +0800
Subject: [PATCH v3 3/7] usb: chipidea: usbmisc: fix a potential race
 condition
In-Reply-To: <1353506793-8354-4-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-4-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20121123053635.GB22420@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 03:06:29PM +0100, Michael Grzeschik wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> This fixes a potential race condition where the ci13xxx_imx glue code
> could be fast enough to call one of the usbmisc_ops before he got a
> valid value on the static usbmisc pointer. To fix that we first set
> usbmisc, then call usbmisc_set_ops().

usbmisc is subsys_initcall, and cil13xxx_imx is module_init. Any
potential situation that the ci13xxx_imx's probe is ran before the
usbmisc's probe is completed? Besides, there is usbmisc_ops value
check at the beginning of cil13xxx_imx's probe.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> Changes since v1:
> * split previous patch into two seperate.
> 
>  drivers/usb/chipidea/usbmisc_imx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 552c63f..9145e04 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -116,14 +116,14 @@ static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	usbmisc = data;
>  	ret = usbmisc_set_ops(&imx6q_usbmisc_ops);
>  	if (ret) {
> +		usbmisc = NULL;
>  		clk_disable_unprepare(data->clk);
>  		return ret;
>  	}
>  
> -	usbmisc = data;
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
