From: hzpeterchen@gmail.com (Peter Chen)
Date: Sun, 22 Jan 2017 10:10:59 +0800
Subject: [PATCH v7 2/5] usb: chipidea: msm: Configure phy for appropriate
 mode
In-Reply-To: <20170120185057.16206-3-stephen.boyd@linaro.org>
References: <20170120185057.16206-1-stephen.boyd@linaro.org>
 <20170120185057.16206-3-stephen.boyd@linaro.org>
Message-ID: <20170122021059.GA6522@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 10:50:54AM -0800, Stephen Boyd wrote:
> When the qcom chipidea controller is used with an extcon, we need
> to signal device mode or host mode to the phy so it can configure
> itself for the correct mode. This should be done after the phy is
> powered up, so that the register writes work correctly. Add in
> the appropriate phy_set_mode() call here.
> 
> To signal the correct state to the qcom glue driver we need to
> change the ci->role before we do the role switch. Make sure to
> undo the change if the role switch fails, but otherwise update
> the state before calling the role start function so that the glue
> driver knows what state to configure for.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
> 
> Made this msm specific because of how msm handles phy powerup.
> 
>  drivers/usb/chipidea/ci.h          | 7 +++++--
>  drivers/usb/chipidea/ci_hdrc_msm.c | 4 ++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index 59e22389c10b..18348b0529af 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -268,6 +268,7 @@ static inline struct ci_role_driver *ci_role(struct ci_hdrc *ci)
>  static inline int ci_role_start(struct ci_hdrc *ci, enum ci_role role)
>  {
>  	int ret;
> +	enum ci_role prev_role;
>  
>  	if (role >= CI_ROLE_END)
>  		return -EINVAL;
> @@ -275,9 +276,11 @@ static inline int ci_role_start(struct ci_hdrc *ci, enum ci_role role)
>  	if (!ci->roles[role])
>  		return -ENXIO;
>  
> +	prev_role = ci->role;
> +	ci->role = role;
>  	ret = ci->roles[role]->start(ci);
> -	if (!ret)
> -		ci->role = role;
> +	if (ret)
> +		ci->role = prev_role;
>  	return ret;

Sorry, this changes ci->role's life cycle. You may try to get coming
role at your glue layer code (eg, through usbmode), or add your
changes at ci_role_start directly if the sequence can make your requirement.

Peter
>  }
>  
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index f1ede7909f54..9c58d13970ca 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -125,6 +125,10 @@ static int ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
>  			hw_write(ci, OP_USBCMD, HSPHY_SESS_VLD_CTRL,
>  				 HSPHY_SESS_VLD_CTRL);
>  
> +			if (ci->role == CI_ROLE_GADGET)
> +				phy_set_mode(ci->phy, PHY_MODE_USB_DEVICE);
> +			else if (ci->role == CI_ROLE_HOST)
> +				phy_set_mode(ci->phy, PHY_MODE_USB_HOST);
>  		}
>  		break;
>  	case CI_HDRC_CONTROLLER_STOPPED_EVENT:
> -- 
> 2.10.0.297.gf6727b0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
