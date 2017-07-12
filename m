From: peda@axentia.se (Peter Rosin)
Date: Wed, 12 Jul 2017 08:45:24 +0200
Subject: [PATCH 2/3] usb: chipidea: Hook into mux framework to toggle usb
 switch
In-Reply-To: <20170712010255.26855-3-stephen.boyd@linaro.org>
References: <20170712010255.26855-1-stephen.boyd@linaro.org>
 <20170712010255.26855-3-stephen.boyd@linaro.org>
Message-ID: <2db7bc39-9274-6007-d971-59e2a577d437@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-07-12 03:02, Stephen Boyd wrote:
> On the db410c 96boards platform we have a TC7USB40MU on the board
> to mux the D+/D- lines coming from the controller between a micro
> usb "device" port and a USB hub for "host" roles[1]. During a
> role switch, we need to toggle this mux to forward the D+/D-
> lines to either the port or the hub. Add the necessary code to do
> the role switch in chipidea core via the generic mux framework.
> Board configurations like on db410c are expected to change roles
> via the sysfs API described in
> Documentation/ABI/testing/sysfs-platform-chipidea-usb2.
> 
> [1] https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf
> 
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt |  8 ++++++++
>  drivers/usb/chipidea/core.c                            | 17 +++++++++++++++++
>  drivers/usb/chipidea/host.c                            | 10 ++++++++++
>  drivers/usb/chipidea/udc.c                             | 11 +++++++++++
>  include/linux/usb/chipidea.h                           | 14 ++++++++++++++
>  5 files changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> index 0e03344e2e8b..96ce81d975d5 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> @@ -76,6 +76,11 @@ Optional properties:
>    needs to make sure it does not send more than 90%
>    maximum_periodic_data_per_frame. The use case is multiple transactions, but
>    less frame rate.
> +- mux-controls: The mux control for toggling host/device output of this
> +  controller.
> +- mux-control-names: Shall be "usb_switch" if mux-controls is specified.
> +- usb-switch-states: Two u32's defining the state to set on the mux for the
> +  host mode and device modes respectively.
>  
>  i.mx specific properties
>  - fsl,usbmisc: phandler of non-core register device, with one
> @@ -102,4 +107,7 @@ Example:
>  		rx-burst-size-dword = <0x10>;
>  		extcon = <0>, <&usb_id>;
>  		phy-clkgate-delay-us = <400>;
> +		mux-controls = <&usb_switch>;
> +		mux-control-names = "usb_switch";
> +		usb-switch-states = <0>, <1>;

I don't see the need for usb-switch-states? Just assume states 0/1 and
if someone later needs some other states, make them add a property that
overrides the defaults. Just document that 0 is host and 1 is device.

>  	};
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index b17ed3a9a304..6531d771f296 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -64,6 +64,7 @@
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/usb/ehci_def.h>
> +#include <linux/mux/consumer.h>
>  
>  #include "ci.h"
>  #include "udc.h"
> @@ -606,6 +607,7 @@ static int ci_get_platdata(struct device *dev,
>  {
>  	struct extcon_dev *ext_vbus, *ext_id;
>  	struct ci_hdrc_cable *cable;
> +	struct ci_hdrc_switch *usb_switch;
>  	int ret;
>  
>  	if (!platdata->phy_mode)
> @@ -690,6 +692,21 @@ static int ci_get_platdata(struct device *dev,
>  	if (of_find_property(dev->of_node, "non-zero-ttctrl-ttha", NULL))
>  		platdata->flags |= CI_HDRC_SET_NON_ZERO_TTHA;
>  
> +	if (IS_ENABLED(CONFIG_MULTIPLEXER)) {
> +		usb_switch = &platdata->usb_switch;
> +		usb_switch->mux = devm_mux_control_get(dev, "usb_switch");
> +		if (!IS_ERR(usb_switch->mux)) {
> +			if (of_property_read_u32_index(dev->of_node,
> +						       "usb-switch-states",
> +						       0, &usb_switch->device))
> +				return -EINVAL;
> +			if (of_property_read_u32_index(dev->of_node,
> +						       "usb-switch-states",
> +						       1, &usb_switch->host))
> +				return -EINVAL;
> +		}
> +	}
> +
>  	ext_id = ERR_PTR(-ENODEV);
>  	ext_vbus = ERR_PTR(-ENODEV);
>  	if (of_property_read_bool(dev->of_node, "extcon")) {
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index 18cb8e46262d..9fd23ecc2da3 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -25,6 +25,7 @@
>  #include <linux/usb/hcd.h>
>  #include <linux/usb/chipidea.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/mux/consumer.h>
>  
>  #include "../host/ehci.h"
>  
> @@ -123,6 +124,13 @@ static int host_start(struct ci_hdrc *ci)
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> +	if (!IS_ERR(ci->platdata->usb_switch.mux)) {
> +		ret = mux_control_select(ci->platdata->usb_switch.mux,
> +					 ci->platdata->usb_switch.host);
> +		if (ret)
> +			return ret;
> +	}
> +

You *must* call mux_control_deselect to clean up if there is a failure
later in host_start. Is that handled in some non-obvious way?

>  	hcd = __usb_create_hcd(&ci_ehci_hc_driver, ci->dev->parent,
>  			       ci->dev, dev_name(ci->dev), NULL);
>  	if (!hcd)
> @@ -205,6 +213,8 @@ static void host_stop(struct ci_hdrc *ci)
>  		if (ci->platdata->reg_vbus && !ci_otg_is_fsm_mode(ci) &&
>  			(ci->platdata->flags & CI_HDRC_TURN_VBUS_EARLY_ON))
>  				regulator_disable(ci->platdata->reg_vbus);
> +		if (!IS_ERR(ci->platdata->usb_switch.mux))
> +			mux_control_deselect(ci->platdata->usb_switch.mux);
>  	}
>  	ci->hcd = NULL;
>  	ci->otg.host = NULL;
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index d68b125796f9..ab3355905740 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -22,6 +22,7 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg-fsm.h>
>  #include <linux/usb/chipidea.h>
> +#include <linux/mux/consumer.h>
>  
>  #include "ci.h"
>  #include "udc.h"
> @@ -1899,6 +1900,13 @@ static int udc_start(struct ci_hdrc *ci)
>  	ci->gadget.name         = ci->platdata->name;
>  	ci->gadget.otg_caps	= otg_caps;
>  
> +	if (!IS_ERR(ci->platdata->usb_switch.mux)) {
> +		retval = mux_control_select(ci->platdata->usb_switch.mux,
> +					    ci->platdata->usb_switch.device);
> +		if (retval)
> +			return retval;
> +	}
> +

Dito.

Cheers,
peda

>  	if (ci->is_otg && (otg_caps->hnp_support || otg_caps->srp_support ||
>  						otg_caps->adp_support))
>  		ci->gadget.is_otg = 1;
> @@ -1982,6 +1990,9 @@ static void udc_id_switch_for_host(struct ci_hdrc *ci)
>  		hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS, OTGSC_BSVIS);
>  
>  	ci->vbus_active = 0;
> +
> +	if (!IS_ERR(ci->platdata->usb_switch.mux))
> +		mux_control_deselect(ci->platdata->usb_switch.mux);
>  }
>  
>  /**
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index c5fdfcf99828..559bd470b8c0 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -9,6 +9,7 @@
>  #include <linux/usb/otg.h>
>  
>  struct ci_hdrc;
> +struct mux_control;
>  
>  /**
>   * struct ci_hdrc_cable - structure for external connector cable state tracking
> @@ -29,6 +30,18 @@ struct ci_hdrc_cable {
>  	struct notifier_block		nb;
>  };
>  
> +/**
> + * struct ci_hdrc_switch - structure for usb mux control
> + * @mux: mux to set @host state or @device state on during role switch
> + * @host: Value to set for mux to connect D+/D- to host D+/D- lines
> + * @device: Value to set for mux to connect D+/D- to device D+/D- lines
> + */
> +struct ci_hdrc_switch {
> +	struct mux_control		*mux;
> +	int				host;
> +	int				device;
> +};
> +
>  struct ci_hdrc_platform_data {
>  	const char	*name;
>  	/* offset of the capability registers */
> @@ -74,6 +87,7 @@ struct ci_hdrc_platform_data {
>  	/* VBUS and ID signal state tracking, using extcon framework */
>  	struct ci_hdrc_cable		vbus_extcon;
>  	struct ci_hdrc_cable		id_extcon;
> +	struct ci_hdrc_switch		usb_switch;
>  	u32			phy_clkgate_delay_us;
>  };
>  
> 
