From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 11 Jul 2016 11:24:08 +0800
Subject: [PATCH v2 12/22] usb: chipidea: msm: Rely on core to override
 AHBBURST
In-Reply-To: <20160707222114.1673-13-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-13-stephen.boyd@linaro.org>
Message-ID: <20160711032408.GE30448@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:21:03PM -0700, Stephen Boyd wrote:
> The core framework already handles setting this parameter with a
> platform quirk. Add the appropriate flag so that we always set
> AHBBURST to 0. Technically DT should be doing this, but we always
> do it for msm chipidea devices so setting the flag in the driver
> works just as well.

You may need to mention if the platform needs to set value rather
than 0, it needs to "ahb-burst-config" at dts, others are ok.

Acked-by: Peter Chen <peter.chen@nxp.com>

> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 89c1a02d69b5..719b20caf88e 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -24,7 +24,6 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
>  	switch (event) {
>  	case CI_HDRC_CONTROLLER_RESET_EVENT:
>  		dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
> -		writel(0, USB_AHBBURST);
>  		/* use AHB transactor, allow posted data writes */
>  		writel(0x8, USB_AHBMODE);
>  		usb_phy_init(ci->usb_phy);
> @@ -47,7 +46,8 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
>  	.name			= "ci_hdrc_msm",
>  	.capoffset		= DEF_CAPOFFSET,
>  	.flags			= CI_HDRC_REGS_SHARED |
> -				  CI_HDRC_DISABLE_STREAMING,
> +				  CI_HDRC_DISABLE_STREAMING |
> +				  CI_HDRC_OVERRIDE_AHB_BURST,
>  
>  	.notify_event		= ci_hdrc_msm_notify_event,
>  };
> -- 
> 2.9.0.rc2.8.ga28705d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
