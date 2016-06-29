From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 10:30:52 +0800
Subject: [PATCH 06/21] usb: chipidea: Initialize and reinitialize phy later
In-Reply-To: <20160626072838.28082-7-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-7-stephen.boyd@linaro.org>
Message-ID: <20160629023052.GB25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28:23AM -0700, Stephen Boyd wrote:
> The ULPI phy on qcom platforms needs to be initialized and
> powered on after a USB reset and before we toggle the run/stop
> bit. Otherwise, the phy locks up and doesn't work properly.

This requirement is so strange, try to see if any other initialization
sequences.
     
Since this driver is multi-platforms, I can't accept this change for
common, if you had to do that, would you please move your changes to
msm glue layer using CI_HDRC_CONTROLLER_RESET_EVENT and
CI_HDRC_CONTROLLER_STOPPED_EVENT? Besides, you need to add one flag
at ci_hdrc_platform_data.flags for your case to avoid normal
initialization.

Peter

> Move
> the phy initialization to a later point, and shut it down outside
> of driver remove so that the phy state is properly managed across
> role switches.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/ci.h   |  3 ++-
>  drivers/usb/chipidea/core.c | 23 ++++++++++-------------
>  drivers/usb/chipidea/host.c |  5 ++---
>  drivers/usb/chipidea/udc.c  |  2 ++
>  4 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index cd414559040f..f87805235caa 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -431,7 +431,8 @@ u8 hw_port_test_get(struct ci_hdrc *ci);
>  int hw_wait_reg(struct ci_hdrc *ci, enum ci_hw_regs reg, u32 mask,
>  				u32 value, unsigned int timeout_ms);
>  
> -void ci_platform_configure(struct ci_hdrc *ci);
> +void ci_usb_phy_exit(struct ci_hdrc *ci);
> +int ci_platform_configure(struct ci_hdrc *ci);
>  
>  int dbg_create_files(struct ci_hdrc *ci);
>  
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 01390e02ee53..a01611c7f815 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -359,7 +359,7 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
>   * interfaces
>   * @ci: the controller
>   */
> -static void ci_usb_phy_exit(struct ci_hdrc *ci)
> +void ci_usb_phy_exit(struct ci_hdrc *ci)
>  {
>  	if (ci->phy) {
>  		phy_power_off(ci->phy);
> @@ -412,9 +412,14 @@ static int ci_usb_phy_init(struct ci_hdrc *ci)
>   * @ci: the controller
>   *
>   */
> -void ci_platform_configure(struct ci_hdrc *ci)
> +int ci_platform_configure(struct ci_hdrc *ci)
>  {
>  	bool is_device_mode, is_host_mode;
> +	int ret;
> +
> +	ret = ci_usb_phy_init(ci);
> +	if (ret)
> +		return ret;
>  
>  	is_device_mode = hw_read(ci, OP_USBMODE, USBMODE_CM) == USBMODE_CM_DC;
>  	is_host_mode = hw_read(ci, OP_USBMODE, USBMODE_CM) == USBMODE_CM_HC;
> @@ -453,6 +458,8 @@ void ci_platform_configure(struct ci_hdrc *ci)
>  			hw_write(ci, OP_BURSTSIZE, RX_BURST_MASK,
>  				ci->platdata->rx_burst_size);
>  	}
> +
> +	return 0;
>  }
>  
>  /**
> @@ -511,9 +518,7 @@ int hw_device_reset(struct ci_hdrc *ci)
>  		return -ENODEV;
>  	}
>  
> -	ci_platform_configure(ci);
> -
> -	return 0;
> +	return ci_platform_configure(ci);
>  }
>  
>  static irqreturn_t ci_irq(int irq, void *data)
> @@ -917,12 +922,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  			ci->usb_phy = NULL;
>  	}
>  
> -	ret = ci_usb_phy_init(ci);
> -	if (ret) {
> -		dev_err(dev, "unable to init phy: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ci->hw_bank.phys = res->start;
>  
>  	ci->irq = platform_get_irq(pdev, 0);
> @@ -1025,7 +1024,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  stop:
>  	ci_role_destroy(ci);
>  deinit_phy:
> -	ci_usb_phy_exit(ci);
>  
>  	return ret;
>  }
> @@ -1044,7 +1042,6 @@ static int ci_hdrc_remove(struct platform_device *pdev)
>  	ci_extcon_unregister(ci);
>  	ci_role_destroy(ci);
>  	ci_hdrc_enter_lpm(ci, true);
> -	ci_usb_phy_exit(ci);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index 053bac9d983c..523c155daea8 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -87,9 +87,7 @@ static int ehci_ci_reset(struct usb_hcd *hcd)
>  	if (ret)
>  		return ret;
>  
> -	ci_platform_configure(ci);
> -
> -	return ret;
> +	return ci_platform_configure(ci);
>  }
>  
>  static const struct ehci_driver_overrides ehci_ci_overrides = {
> @@ -186,6 +184,7 @@ static void host_stop(struct ci_hdrc *ci)
>  	if (hcd) {
>  		usb_remove_hcd(hcd);
>  		usb_put_hcd(hcd);
> +		ci_usb_phy_exit(ci);
>  		if (ci->platdata->reg_vbus && !ci_otg_is_fsm_mode(ci) &&
>  			(ci->platdata->flags & CI_HDRC_TURN_VBUS_EARLY_ON))
>  				regulator_disable(ci->platdata->reg_vbus);
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 065f5d97aa67..8f44e2d1e0c0 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1534,6 +1534,7 @@ static int ci_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
>  			if (ci->driver)
>  				ci->driver->disconnect(&ci->gadget);
>  			hw_device_state(ci, 0);
> +			ci_usb_phy_exit(ci);
>  			if (ci->platdata->notify_event)
>  				ci->platdata->notify_event(ci,
>  				CI_HDRC_CONTROLLER_STOPPED_EVENT);
> @@ -1794,6 +1795,7 @@ static int ci_udc_stop(struct usb_gadget *gadget)
>  			ci->platdata->notify_event(ci,
>  			CI_HDRC_CONTROLLER_STOPPED_EVENT);
>  		spin_unlock_irqrestore(&ci->lock, flags);
> +		ci_usb_phy_exit(ci);
>  		_gadget_stop_activity(&ci->gadget);
>  		spin_lock_irqsave(&ci->lock, flags);
>  		pm_runtime_put(&ci->gadget.dev);
> -- 
> 2.9.0.rc2.8.ga28705d
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 

Best Regards,
Peter Chen
