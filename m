From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 17 Mar 2016 15:15:50 +0900
Subject: [RFC PATCH 1/4] usb: chipidea: Do not rely on OTG while using
 extcon
In-Reply-To: <a3dc1c8adc4266d36267901ce6e975ddfca09abb.1458030082.git.maitysanchayan@gmail.com>
References: <cover.1458030082.git.maitysanchayan@gmail.com>
 <a3dc1c8adc4266d36267901ce6e975ddfca09abb.1458030082.git.maitysanchayan@gmail.com>
Message-ID: <56EA4B96.8000700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanchayan,

I recommend that you use the unique id (ex. EXTCON_USB, EXTCON_USB_HOST)
when getting/setting the state of external connector with extcon functions
- extcon_get_cable_state() is deprecated -> extcon_get_cable_state_()
- extcon_set_cable_state() is deprecated -> extcon_set_cable_state_()

You can refer to usage for new function with unique id on patch[1]
[1] 5960387a2fb83 (usb: dwc3: omap: Replace deprecated API of extcon)

I'll remove the extcon_[get/set]_cable_state() functions using the string type
to identify the external connector.

On 2016? 03? 15? 17:38, Sanchayan Maity wrote:
> The existing usage of extcon in Chipidea driver relies on OTG
> registers. In case of SoC with dual role device but not a true
> OTG controller, this does not work. Such SoC's should specify
> the existing CI_HDRC_DUAL_ROLE_NOT_OTG flag and do the role
> switch without checking any of the OTG registers.
> 
> This patch almost reverts most of commit "usb: chipidea: Use
> extcon framework for VBUS and ID detect". We do not rely
> anymore on emulating an OTG capable controller by faking OTG
> controller reads.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  drivers/usb/chipidea/core.c  | 64 ++++++++++++++++++++++++--------------------
>  drivers/usb/chipidea/otg.c   | 39 +--------------------------
>  include/linux/usb/chipidea.h |  2 --
>  3 files changed, 36 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 7404064..d29118d 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -607,14 +607,15 @@ static int ci_vbus_notifier(struct notifier_block *nb, unsigned long event,
>  	struct ci_hdrc_cable *vbus = container_of(nb, struct ci_hdrc_cable, nb);
>  	struct ci_hdrc *ci = vbus->ci;
>  
> +	pm_runtime_get_sync(ci->dev);
> +
>  	if (event)
> -		vbus->state = true;
> +		usb_gadget_vbus_connect(&ci->gadget);
>  	else
> -		vbus->state = false;
> +		usb_gadget_vbus_disconnect(&ci->gadget);
>  
> -	vbus->changed = true;
> +	pm_runtime_put_sync(ci->dev);
>  
> -	ci_irq(ci->irq, ci);
>  	return NOTIFY_DONE;
>  }
>  
> @@ -624,14 +625,19 @@ static int ci_id_notifier(struct notifier_block *nb, unsigned long event,
>  	struct ci_hdrc_cable *id = container_of(nb, struct ci_hdrc_cable, nb);
>  	struct ci_hdrc *ci = id->ci;
>  
> -	if (event)
> -		id->state = false;
> -	else
> -		id->state = true;
> +	pm_runtime_get_sync(ci->dev);
> +
> +	ci_role_stop(ci);
> +
> +	hw_wait_phy_stable();
> +
> +	if (ci_role_start(ci, event ? CI_ROLE_HOST : CI_ROLE_GADGET))
> +		dev_err(ci->dev,
> +			"Can't start %s role\n",
> +			event ? "host" : "gadget");
>  
> -	id->changed = true;
> +	pm_runtime_put_sync(ci->dev);
>  
> -	ci_irq(ci->irq, ci);
>  	return NOTIFY_DONE;
>  }
>  
> @@ -738,25 +744,10 @@ static int ci_get_platdata(struct device *dev,
>  	cable->nb.notifier_call = ci_vbus_notifier;
>  	cable->edev = ext_vbus;
>  
> -	if (!IS_ERR(ext_vbus)) {
> -		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB);
> -		if (ret)
> -			cable->state = true;
> -		else
> -			cable->state = false;
> -	}
> -
>  	cable = &platdata->id_extcon;
>  	cable->nb.notifier_call = ci_id_notifier;
>  	cable->edev = ext_id;
>  
> -	if (!IS_ERR(ext_id)) {
> -		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB_HOST);
> -		if (ret)
> -			cable->state = false;
> -		else
> -			cable->state = true;
> -	}
>  	return 0;
>  }
>  
> @@ -896,6 +887,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	void __iomem	*base;
>  	int		ret;
>  	enum usb_dr_mode dr_mode;
> +	struct ci_hdrc_cable *cable;
>  
>  	if (!dev_get_platdata(dev)) {
>  		dev_err(dev, "platform data missing\n");
> @@ -963,6 +955,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  
>  	ci_get_otg_capable(ci);
>  
> +	ret = ci_extcon_register(ci);
> +	if (ret) {
> +		dev_err(dev, "extcon registration failed\n");
> +		goto deinit_phy;
> +	}
> +
>  	dr_mode = ci->platdata->dr_mode;
>  	/* initialize role(s) before the interrupt is requested */
>  	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> @@ -1003,6 +1001,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  			 * user can switch it through debugfs.
>  			 */
>  			ci->role = CI_ROLE_GADGET;
> +			cable = &ci->platdata->id_extcon;
> +			if (!IS_ERR(cable->edev)) {
> +				if (extcon_get_cable_state(cable->edev,

Use extcon_get_cable_state_() to use the EXTCON_USB_HOST id instead of using string type directly ("USB-HOST")

> +						"USB-HOST") == true)
> +					ci->role = CI_ROLE_HOST;
> +			}
>  		}
>  	} else {
>  		ci->role = ci->roles[CI_ROLE_HOST]
> @@ -1021,6 +1025,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  						ci_role(ci)->name);
>  			goto stop;
>  		}
> +		cable = &ci->platdata->vbus_extcon;
> +		if (!IS_ERR(cable->edev)) {
> +			if ((ci->role == CI_ROLE_GADGET) &&
> +			(extcon_get_cable_state(cable->edev, "USB") == true))

Use extcon_get_cable_state_(cable->edev, EXTCON_USB)

[snip]

Best Regards,
Chanwoo Choi
