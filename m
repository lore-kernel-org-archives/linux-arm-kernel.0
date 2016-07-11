From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 11 Jul 2016 10:25:43 +0800
Subject: [PATCH v2 09/22] usb: chipidea: Kick OTG state machine for AVVIS
 with vbus extcon
In-Reply-To: <20160707222114.1673-10-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-10-stephen.boyd@linaro.org>
Message-ID: <20160711022543.GB30448@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:21:00PM -0700, Stephen Boyd wrote:
> Force the OTG state machine to go forward when we're using an
> extcon for vbus detection. In this case, the controller may never
> raise an interrupt for AVVIS, so we need to simulate the event by
> toggling the appropriate OTG fsm bits and kicking the state
> machine again.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
> 
> I think this was rejected last time around but I've kept it in the
> series to continue discussion on how we're supposed to be emulating
> vbus an id pin interrupts and the otgsc register.
> 
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

Well, if we don't have a_valid, we can't know a_vbus_err state at
A device side if vbus is error (eg, less than 4.4v), and B device
will NOT be disconnect if vbus is still larger than BSV.

Do you really need OTG FSM? If you can pass the OTG test described at
Documentation/usb/chipidea.txt, I can accept it, I find the OTG
compliance test does not test ~a_vbus_vld either, see
otgeh_compliance_plan_1_2, ch6.7.12.2 Paths not tested.

-- 

Best Regards,
Peter Chen
