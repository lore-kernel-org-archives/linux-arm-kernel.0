From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 14:32:11 +0800
Subject: [PATCH 10/21] usb: chipidea: msm: Rely on core to override
 AHBBURST
In-Reply-To: <20160626072838.28082-11-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-11-stephen.boyd@linaro.org>
Message-ID: <20160629063211.GE25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28:27AM -0700, Stephen Boyd wrote:
> The core framework already handles setting this parameter with a
> platform quirk. Add the appropriate flag so that we always set
> AHBBURST to 0. Technically DT should be doing this, but we always
> do it for msm chipidea devices so setting the flag in the driver
> works just as well.

You still need to set AHB burst value at dts, this flag is just for
override, see below:

ahb-burst-config = <0x0>;

> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 3889809fd0c4..37591a4b1346 100644
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
