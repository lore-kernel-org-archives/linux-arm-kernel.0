From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 19 Oct 2016 09:15:35 +0800
Subject: [PATCH v5 11/23] usb: chipidea: Emulate OTGSC interrupt enable
 path
In-Reply-To: <20161018015636.11701-12-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-12-stephen.boyd@linaro.org>
Message-ID: <20161019011535.GC6294@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 06:56:24PM -0700, Stephen Boyd wrote:
> In the case of an extcon-usb-gpio device being used with the
> chipidea driver we'll sometimes miss the BSVIS event in the OTGSC
> register. Consider the case where we don't have a cable attached
> and the id pin is indicating "host" mode. When we plug in the usb
> cable for "device" mode a gpio goes high and indicates that we
> should do the role switch and that vbus is high. When we're in
> "host" mode the OTGSC register doesn't have BSVIE set.

I have some questions for your description:

- Do you have any pending or related patches what this patch set
  is based on? Afaik, the extcon-usb-gpio has no vbus event supported.
- When the ID from 0->1, the chipidea driver will do role switch, and
  set BSVIE, why it does not occur for your case?

Peter
> 
> The following scenario can happen:
> 
> CPU0
> ----
> <extcon notifier chain>
>  ci_cable_notifier()
>   update id cable state
>   ci_irq()
>    if (ci->is_otg && (otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) { // true
>     ci->id_event = true;
>     ci_otg_queue_work()
>      schedule()
> 
> <extcon notifier event> // same task as before
>  ci_cable_notifier()
>   update vbus cable state
>    ci_irq()
>     if (ci->is_otg && (otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) // false
>    return IRQ_NONE
> 
> ci_otg_work() // switch task to the workqueue now
>  if (ci->id_event)
>   ci_handle_id_switch()
>    ci_role_stop()
>     host_stop()
>    hw_wait_vbus_lower_bsv(ci); // this times out because vbus is already set
>    ci_role_start()
>     udc_id_switch_for_device()
>      hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE, OTGSC_BSVIS | OTGSC_BSVIE);
> 
> At this point, we don't replay the vbus connect event because the
> vbus event has already happened. This causes things like gadget
> instances to never see vbus appear, and thus the gadget is never
> started. Furthermore, we see timeout messages like:
> 
> 	timeout waiting for 0000800 in OTGSC
> 
> Let's workaround this by skiping the wait for BSV when we're
> using an extcon for the vbus notification and let's properly
> emulate the BSVIS event that would happen when we enable the
> vbus interrupt while enabling "device" mode.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/ci.h   |  2 ++
>  drivers/usb/chipidea/core.c | 23 +++++++++++++++++------
>  drivers/usb/chipidea/otg.c  | 31 ++++++++++++++++++++++++-------
>  3 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index 59e22389c10b..e099b8bc79e2 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -437,6 +437,8 @@ static inline void ci_ulpi_exit(struct ci_hdrc *ci) { }
>  static inline int ci_ulpi_resume(struct ci_hdrc *ci) { return 0; }
>  #endif
>  
> +irqreturn_t __ci_irq(int irq, struct ci_hdrc *ci);
> +
>  u32 hw_read_intr_enable(struct ci_hdrc *ci);
>  
>  u32 hw_read_intr_status(struct ci_hdrc *ci);
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 83bc2f2dd6a8..d1ae9a03e0fa 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -524,9 +524,8 @@ int hw_device_reset(struct ci_hdrc *ci)
>  	return 0;
>  }
>  
> -static irqreturn_t ci_irq(int irq, void *data)
> +irqreturn_t __ci_irq(int irq, struct ci_hdrc *ci)
>  {
> -	struct ci_hdrc *ci = data;
>  	irqreturn_t ret = IRQ_NONE;
>  	u32 otgsc = 0;
>  
> @@ -570,9 +569,20 @@ static irqreturn_t ci_irq(int irq, void *data)
>  		return IRQ_HANDLED;
>  	}
>  
> -	/* Handle device/host interrupt */
> -	if (ci->role != CI_ROLE_END)
> -		ret = ci_role(ci)->irq(ci);
> +	return ret;
> +}
> +
> +static irqreturn_t ci_irq(int irq, void *data)
> +{
> +	irqreturn_t ret;
> +	struct ci_hdrc *ci = data;
> +
> +	ret = __ci_irq(irq, ci);
> +	if (ret == IRQ_NONE) {
> +		/* Handle device/host interrupt */
> +		if (ci->role != CI_ROLE_END)
> +			ret = ci_role(ci)->irq(ci);
> +	}
>  
>  	return ret;
>  }
> @@ -586,7 +596,8 @@ static int ci_cable_notifier(struct notifier_block *nb, unsigned long event,
>  	cbl->connected = event;
>  	cbl->changed = true;
>  
> -	ci_irq(ci->irq, ci);
> +	__ci_irq(ci->irq, ci);
> +
>  	return NOTIFY_DONE;
>  }
>  
> diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
> index 695f3fe3ae21..f4a21ade1901 100644
> --- a/drivers/usb/chipidea/otg.c
> +++ b/drivers/usb/chipidea/otg.c
> @@ -84,36 +84,44 @@ u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
>  void hw_write_otgsc(struct ci_hdrc *ci, u32 mask, u32 data)
>  {
>  	struct ci_hdrc_cable *cable;
> +	bool raise_irq = false;
>  
>  	cable = &ci->platdata->vbus_extcon;
>  	if (!IS_ERR(cable->edev)) {
> -		if (data & mask & OTGSC_BSVIS)
> -			cable->changed = false;
> -
>  		/* Don't enable vbus interrupt if using external notifier */
>  		if (data & mask & OTGSC_BSVIE) {
> +			if (cable->enabled == false && cable->changed == true)
> +				raise_irq = true;
>  			cable->enabled = true;
>  			data &= ~OTGSC_BSVIE;
>  		} else if (mask & OTGSC_BSVIE) {
>  			cable->enabled = false;
>  		}
> +
> +		if (data & mask & OTGSC_BSVIS && !raise_irq)
> +			cable->changed = false;
>  	}
>  
>  	cable = &ci->platdata->id_extcon;
>  	if (!IS_ERR(cable->edev)) {
> -		if (data & mask & OTGSC_IDIS)
> -			cable->changed = false;
> -
>  		/* Don't enable id interrupt if using external notifier */
>  		if (data & mask & OTGSC_IDIE) {
> +			if (cable->enabled == false && cable->changed == true)
> +				raise_irq = true;
>  			cable->enabled = true;
>  			data &= ~OTGSC_IDIE;
>  		} else if (mask & OTGSC_IDIE) {
>  			cable->enabled = false;
>  		}
> +
> +		if (data & mask & OTGSC_IDIS && !raise_irq)
> +			cable->changed = false;
>  	}
>  
>  	hw_write(ci, OP_OTGSC, mask | OTGSC_INT_STATUS_BITS, data);
> +
> +	if (raise_irq)
> +		__ci_irq(ci->irq, ci);
>  }
>  
>  /**
> @@ -175,7 +183,16 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
>  
>  		ci_role_stop(ci);
>  
> -		if (role == CI_ROLE_GADGET)
> +		/*
> +		 * BSV could be set "immediately" if we're using extcon for
> +		 * VBUS because sometimes it's a single GPIO for ID and VBUS
> +		 * like in the case of extcon-usb-gpio. In that case we ignore
> +		 * waiting for a BSV transition. Really we can't tell when BSV
> +		 * is low and the cable is connected, all we know is that the
> +		 * BSV is high when we update BSV state.
> +		 */
> +		if (role == CI_ROLE_GADGET &&
> +		    IS_ERR(ci->platdata->vbus_extcon.edev))
>  			/*
>  			 * wait vbus lower than OTGSC_BSV before connecting
>  			 * to host
> -- 
> 2.10.0.297.gf6727b0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 

Best Regards,
Peter Chen
