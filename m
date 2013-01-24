From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 24 Jan 2013 16:35:30 +0200
Subject: [RESEND PATCH v5 4/7] usb: chipidea: consolidate ci_role_driver's
 API for both roles
In-Reply-To: <1358733418-17969-5-git-send-email-peter.chen@freescale.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-5-git-send-email-peter.chen@freescale.com>
Message-ID: <8738xqodhp.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> - Create init/destroy API for probe and remove
> - start/stop API are only used otg id switch process
> - Create the gadget at ci_hdrc_probe if the gadget is supported
> at that port, the main purpose for this is to avoid gadget module
> load fail at init.rc

I don't think it's necessary to mention android-specific init scripts
here in our patches.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/ci.h   |   19 +++++++++++-
>  drivers/usb/chipidea/core.c |   65 ++++++++++++++++++------------------------
>  drivers/usb/chipidea/host.c |    2 +
>  drivers/usb/chipidea/udc.c  |   33 ++++++++++++++++++++-
>  4 files changed, 78 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> index 325d790..00939e6 100644
> --- a/drivers/usb/chipidea/ci.h
> +++ b/drivers/usb/chipidea/ci.h
> @@ -67,14 +67,18 @@ enum ci_role {
>  
>  /**
>   * struct ci_role_driver - host/gadget role driver
> - * start: start this role
> - * stop: stop this role
> + * init: init this role (used at module probe)
> + * start: start this role (used at id switch)
> + * stop: stop this role (used at id switch)
> + * destroy: destroy this role (used at module remove)
>   * irq: irq handler for this role
>   * name: role name string (host/gadget)
>   */
>  struct ci_role_driver {
> +	int		(*init)(struct ci13xxx *);
>  	int		(*start)(struct ci13xxx *);
>  	void		(*stop)(struct ci13xxx *);
> +	void		(*destroy)(struct ci13xxx *);
>  	irqreturn_t	(*irq)(struct ci13xxx *);
>  	const char	*name;
>  };
> @@ -206,6 +210,17 @@ static inline void ci_role_stop(struct ci13xxx *ci)
>  	ci->roles[role]->stop(ci);
>  }
>  
> +static inline void ci_role_destroy(struct ci13xxx *ci)
> +{
> +	enum ci_role role = ci->role;
> +
> +	if (role == CI_ROLE_END)
> +		return;
> +
> +	ci->role = CI_ROLE_END;
> +
> +	ci->roles[role]->destroy(ci);
> +}

What does this do? It should take role an a parameter, at least. Or it
can be called ci_roles_destroy() and, well, destroy all the roles. Now
we're in a situation where we destroy one.

The idea is that, with this api, we can (and should) have both roles
allocated all the time, but only one role start()'ed.

What we can do here is move the udc's .init() code to
ci_hdrc_gadget_init() and add a complementary ci_hdrc_gadget_destroy(),
which we call in ci_hdrc_remove() and probe's error path. And we can
probably do something similar for the host, or just leave it as it is
now. Seems simpler to me.

>  /******************************************************************************
>   * REGISTERS
>   *****************************************************************************/
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index f8f8484..a5adf1a 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -315,27 +315,16 @@ static void ci_handle_id_switch(struct ci13xxx *ci)
>  			ci_role(ci)->name, ci->roles[role]->name);
>  
>  		/* 1. Finish the current role */
> -		if (ci->role == CI_ROLE_GADGET) {
> -			usb_gadget_vbus_disconnect(&ci->gadget);
> -			/* host doesn't care B_SESSION_VALID event */
> -			ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
> -			ci_disable_otg_interrupt(ci, OTGSC_BSVIE);
> -			ci->role = CI_ROLE_END;
> -			/* reset controller */
> -			hw_device_reset(ci, USBMODE_CM_IDLE);
> -		} else if (ci->role == CI_ROLE_HOST) {
> -			ci_role_stop(ci);
> -			/* reset controller */
> -			hw_device_reset(ci, USBMODE_CM_IDLE);
> -		}
> +		ci_role_stop(ci);
> +		hw_device_reset(ci, USBMODE_CM_IDLE);
>  
>  		/* 2. Turn on/off vbus according to coming role */
> -		if (ci_otg_role(ci) == CI_ROLE_GADGET) {
> +		if (role == CI_ROLE_GADGET) {
>  			otg_set_vbus(&ci->otg, false);
>  			/* wait vbus lower than OTGSC_BSV */
>  			hw_wait_reg(ci, OP_OTGSC, OTGSC_BSV, 0,
>  					CI_VBUS_STABLE_TIMEOUT);
> -		} else if (ci_otg_role(ci) == CI_ROLE_HOST) {
> +		} else if (role == CI_ROLE_HOST) {
>  			otg_set_vbus(&ci->otg, true);
>  			/* wait vbus higher than OTGSC_AVV */
>  			hw_wait_reg(ci, OP_OTGSC, OTGSC_AVV, OTGSC_AVV,
> @@ -343,13 +332,7 @@ static void ci_handle_id_switch(struct ci13xxx *ci)
>  		}
>  
>  		/* 3. Begin the new role */
> -		if (ci_otg_role(ci) == CI_ROLE_GADGET) {
> -			ci->role = role;
> -			ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
> -			ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
> -		} else if (ci_otg_role(ci) == CI_ROLE_HOST) {
> -			ci_role_start(ci, role);
> -		}
> +		ci_role_start(ci, role);
>  	}
>  }
>  
> @@ -585,7 +568,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  
>  	ret = ci_hdrc_gadget_init(ci);
>  	if (ret)
> -		dev_info(dev, "doesn't support gadget\n");
> +		dev_info(dev, "doesn't support gadget, ret=%d\n", ret);
>  
>  	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
>  		dev_err(dev, "no supported roles\n");
> @@ -607,22 +590,30 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  			: CI_ROLE_GADGET;
>  	}
>  
> -	ret = ci_role_start(ci, ci->role);
> -	if (ret) {
> -		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
> -		ret = -ENODEV;
> -		goto rm_wq;
> -	}
> -
>  	otgsc = hw_read(ci, OP_OTGSC, ~0);
> +
>  	/*
> -	 * if it is device mode:
> -	 * - Enable vbus detect
> -	 * - If it has already connected to host, notify udc
> +	 * If the gadget is supported, call its init unconditionally,
> +	 * We need to support load gadget module at init.rc.
>  	 */
> -	if (ci->role == CI_ROLE_GADGET) {
> -		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
> -		ci_handle_vbus_change(ci);
> +	if (ci->roles[CI_ROLE_GADGET]) {
> +		ret = ci->roles[CI_ROLE_GADGET]->init(ci);
> +		if (ret) {
> +			dev_err(dev, "can't init %s role, ret=%d\n",
> +					ci_role(ci)->name, ret);
> +			ret = -ENODEV;
> +			goto rm_wq;
> +		}
> +	}
> +
> +	if (ci->role == CI_ROLE_HOST) {
> +		ret = ci->roles[CI_ROLE_HOST]->init(ci);
> +		if (ret) {
> +			dev_err(dev, "can't init %s role, ret=%d\n",
> +					ci_role(ci)->name, ret);
> +			ret = -ENODEV;
> +			goto rm_wq;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, ci);
> @@ -660,7 +651,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
>  	destroy_workqueue(ci->wq);
>  	device_remove_file(ci->dev, &dev_attr_role);
>  	free_irq(ci->irq, ci);
> -	ci_role_stop(ci);
> +	ci_role_destroy(ci);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index caecad9..6024a4f 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -92,8 +92,10 @@ int ci_hdrc_host_init(struct ci13xxx *ci)
>  	if (!rdrv)
>  		return -ENOMEM;
>  
> +	rdrv->init	= host_start;
>  	rdrv->start	= host_start;
>  	rdrv->stop	= host_stop;
> +	rdrv->destroy	= host_stop;

Will this allocate the hcd twice if we start in host role? Looks like that.

>  	rdrv->irq	= host_irq;
>  	rdrv->name	= "host";
>  	ci->roles[CI_ROLE_HOST] = rdrv;
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 83e54bb..e6a4ec0 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -31,6 +31,7 @@
>  
>  #include "ci.h"
>  #include "udc.h"
> +#include "otg.h"
>  #include "bits.h"
>  #include "debug.h"
>  
> @@ -1754,6 +1755,16 @@ static int udc_start(struct ci13xxx *ci)
>  	pm_runtime_no_callbacks(&ci->gadget.dev);
>  	pm_runtime_enable(&ci->gadget.dev);
>  
> +	/*
> +	 * if it is device mode:
> +	 * - Enable vbus detect
> +	 * - If it has already connected to host, notify udc
> +	 */
> +	if (ci->role == CI_ROLE_GADGET) {
> +		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
> +		ci_handle_vbus_change(ci);
> +	}
> +
>  	return retval;
>  
>  remove_trans:
> @@ -1780,6 +1791,22 @@ free_qh_pool:
>  	return retval;
>  }
>  
> +static int udc_id_switch_for_device(struct ci13xxx *ci)
> +{
> +	ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
> +	ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
> +
> +	return 0;
> +}
> +
> +static void udc_id_switch_for_host(struct ci13xxx *ci)
> +{
> +	usb_gadget_vbus_disconnect(&ci->gadget);
> +	/* host doesn't care B_SESSION_VALID event */
> +	ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
> +	ci_disable_otg_interrupt(ci, OTGSC_BSVIE);
> +}
> +
>  /**
>   * udc_remove: parent remove must call this to remove UDC
>   *
> @@ -1825,8 +1852,10 @@ int ci_hdrc_gadget_init(struct ci13xxx *ci)
>  	if (!rdrv)
>  		return -ENOMEM;
>  
> -	rdrv->start	= udc_start;
> -	rdrv->stop	= udc_stop;
> +	rdrv->init	= udc_start;
> +	rdrv->start	= udc_id_switch_for_device;
> +	rdrv->stop	= udc_id_switch_for_host;
> +	rdrv->destroy	= udc_stop;
>  	rdrv->irq	= udc_irq;
>  	rdrv->name	= "gadget";
>  	ci->roles[CI_ROLE_GADGET] = rdrv;
> -- 
> 1.7.0.4
