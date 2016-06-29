From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 11:09:13 +0800
Subject: [PATCH 08/21] usb: chipidea: Kick OTG state machine for AVVIS
 with vbus extcon
In-Reply-To: <20160626072838.28082-9-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-9-stephen.boyd@linaro.org>
Message-ID: <20160629030913.GC25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28:25AM -0700, Stephen Boyd wrote:
> Force the OTG state machine to go forward when we're using an
> extcon for vbus detection. In this case, the controller may never
> raise an interrupt for AVVIS, so we need to simulate the event by
> toggling the appropriate OTG fsm bits and kicking the state
> machine again.
> 

Well, I think you may misunderstand the OTG FSM and dual-role.
>From my and Felipe's point, there are seldom users for USB FSM,
there are only OTG FSM spec and related OTG certification.

The OTG FSM needs related SoC support, the vbus will be off at
several states, and the SRP should be supported by SoC.

By default, the dts needs below properties for disabling it if you
choose otg fsm support at kernel configuration.

&usbotg1 {
	vbus-supply = <&reg_usb_otg1_vbus>;
	srp-disable;
	hnp-disable;
	adp-disable;
	status = "okay";
};

See Documentation/devicetree/bindings/usb/generic.txt.

Peter

> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/otg_fsm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
> index de8e22ec3902..aab076fc4d82 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -475,6 +475,14 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  				return;
>  			}
>  		}
> +		/*
> +		 * Force state machine forward if we use extcon
> +		 * to detect vbus state (i.e. simulate AVVIS event)
> +		 */
> +		if (!IS_ERR(ci->platdata->vbus_extcon.edev)) {
> +			fsm->a_vbus_vld = 1;
> +			ci_otg_queue_work(ci);
> +		}
>  		/* Disable data pulse irq */
>  		hw_write_otgsc(ci, OTGSC_DPIE, 0);
>  
> @@ -486,6 +494,15 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  
>  		fsm->a_bus_drop = 1;
>  		fsm->a_bus_req = 0;
> +		/*
> +		 * Force state machine forward if we use extcon
> +		 * to detect vbus state (i.e. simulate AVVIS event)
> +		 */
> +		if (!IS_ERR(ci->platdata->vbus_extcon.edev)) {
> +			fsm->a_vbus_vld = 0;
> +			fsm->b_conn = 0;
> +			ci_otg_queue_work(ci);
> +		}
>  	}
>  }
>  
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
