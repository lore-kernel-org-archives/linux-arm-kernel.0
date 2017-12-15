From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 15 Dec 2017 15:48:13 +0900
Subject: [PATCH v2 1/5] extcon: usbc-cros-ec: add support to notify USB
 type cables.
In-Reply-To: <20171213103219.1464-1-enric.balletbo@collabora.com>
References: <CGME20171213103241epcas2p412031074459fa3893388ffca4f894abc@epcas2p4.samsung.com>
 <20171213103219.1464-1-enric.balletbo@collabora.com>
Message-ID: <5A33702D.60004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

Looks good to me. After reviewing the Lee Jones,
I'll take it on next branch.

Regards,
Chanwoo Choi

On 2017? 12? 13? 19:32, Enric Balletbo i Serra wrote:
> From: Benson Leung <bleung@chromium.org>
> 
> Extend the driver to notify host and device type cables and the presence
> of power.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes since v1:
>  - Use the BIT macro. Requested by Lee Jones.
>  - Add the Reviewed-by: Chanwoo Choi.
> 
>  drivers/extcon/extcon-usbc-cros-ec.c | 142 ++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/cros_ec_commands.h |  17 +++++
>  2 files changed, 155 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
> index 6187f73..6721ab0 100644
> --- a/drivers/extcon/extcon-usbc-cros-ec.c
> +++ b/drivers/extcon/extcon-usbc-cros-ec.c
> @@ -34,16 +34,26 @@ struct cros_ec_extcon_info {
>  
>  	struct notifier_block notifier;
>  
> +	unsigned int dr; /* data role */
> +	bool pr; /* power role (true if VBUS enabled) */
>  	bool dp; /* DisplayPort enabled */
>  	bool mux; /* SuperSpeed (usb3) enabled */
>  	unsigned int power_type;
>  };
>  
>  static const unsigned int usb_type_c_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
>  	EXTCON_DISP_DP,
>  	EXTCON_NONE,
>  };
>  
> +enum usb_data_roles {
> +	DR_NONE,
> +	DR_HOST,
> +	DR_DEVICE,
> +};
> +
>  /**
>   * cros_ec_pd_command() - Send a command to the EC.
>   * @info: pointer to struct cros_ec_extcon_info
> @@ -150,6 +160,7 @@ static int cros_ec_usb_get_role(struct cros_ec_extcon_info *info,
>  	pd_control.port = info->port_id;
>  	pd_control.role = USB_PD_CTRL_ROLE_NO_CHANGE;
>  	pd_control.mux = USB_PD_CTRL_MUX_NO_CHANGE;
> +	pd_control.swap = USB_PD_CTRL_SWAP_NONE;
>  	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_CONTROL, 1,
>  				 &pd_control, sizeof(pd_control),
>  				 &resp, sizeof(resp));
> @@ -183,11 +194,72 @@ static int cros_ec_pd_get_num_ports(struct cros_ec_extcon_info *info)
>  	return resp.num_ports;
>  }
>  
> +static const char *cros_ec_usb_role_string(unsigned int role)
> +{
> +	return role == DR_NONE ? "DISCONNECTED" :
> +		(role == DR_HOST ? "DFP" : "UFP");
> +}
> +
> +static const char *cros_ec_usb_power_type_string(unsigned int type)
> +{
> +	switch (type) {
> +	case USB_CHG_TYPE_NONE:
> +		return "USB_CHG_TYPE_NONE";
> +	case USB_CHG_TYPE_PD:
> +		return "USB_CHG_TYPE_PD";
> +	case USB_CHG_TYPE_PROPRIETARY:
> +		return "USB_CHG_TYPE_PROPRIETARY";
> +	case USB_CHG_TYPE_C:
> +		return "USB_CHG_TYPE_C";
> +	case USB_CHG_TYPE_BC12_DCP:
> +		return "USB_CHG_TYPE_BC12_DCP";
> +	case USB_CHG_TYPE_BC12_CDP:
> +		return "USB_CHG_TYPE_BC12_CDP";
> +	case USB_CHG_TYPE_BC12_SDP:
> +		return "USB_CHG_TYPE_BC12_SDP";
> +	case USB_CHG_TYPE_OTHER:
> +		return "USB_CHG_TYPE_OTHER";
> +	case USB_CHG_TYPE_VBUS:
> +		return "USB_CHG_TYPE_VBUS";
> +	case USB_CHG_TYPE_UNKNOWN:
> +		return "USB_CHG_TYPE_UNKNOWN";
> +	default:
> +		return "USB_CHG_TYPE_UNKNOWN";
> +	}
> +}
> +
> +static bool cros_ec_usb_power_type_is_wall_wart(unsigned int type,
> +						unsigned int role)
> +{
> +	switch (type) {
> +	/* FIXME : Guppy, Donnettes, and other chargers will be miscategorized
> +	 * because they identify with USB_CHG_TYPE_C, but we can't return true
> +	 * here from that code because that breaks Suzy-Q and other kinds of
> +	 * USB Type-C cables and peripherals.
> +	 */
> +	case USB_CHG_TYPE_PROPRIETARY:
> +	case USB_CHG_TYPE_BC12_DCP:
> +		return true;
> +	case USB_CHG_TYPE_PD:
> +	case USB_CHG_TYPE_C:
> +	case USB_CHG_TYPE_BC12_CDP:
> +	case USB_CHG_TYPE_BC12_SDP:
> +	case USB_CHG_TYPE_OTHER:
> +	case USB_CHG_TYPE_VBUS:
> +	case USB_CHG_TYPE_UNKNOWN:
> +	case USB_CHG_TYPE_NONE:
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int extcon_cros_ec_detect_cable(struct cros_ec_extcon_info *info,
>  				       bool force)
>  {
>  	struct device *dev = info->dev;
>  	int role, power_type;
> +	unsigned int dr = DR_NONE;
> +	bool pr = false;
>  	bool polarity = false;
>  	bool dp = false;
>  	bool mux = false;
> @@ -206,9 +278,12 @@ static int extcon_cros_ec_detect_cable(struct cros_ec_extcon_info *info,
>  			dev_err(dev, "failed getting role err = %d\n", role);
>  			return role;
>  		}
> +		dev_dbg(dev, "disconnected\n");
>  	} else {
>  		int pd_mux_state;
>  
> +		dr = (role & PD_CTRL_RESP_ROLE_DATA) ? DR_HOST : DR_DEVICE;
> +		pr = (role & PD_CTRL_RESP_ROLE_POWER);
>  		pd_mux_state = cros_ec_usb_get_pd_mux_state(info);
>  		if (pd_mux_state < 0)
>  			pd_mux_state = USB_PD_MUX_USB_ENABLED;
> @@ -216,20 +291,62 @@ static int extcon_cros_ec_detect_cable(struct cros_ec_extcon_info *info,
>  		dp = pd_mux_state & USB_PD_MUX_DP_ENABLED;
>  		mux = pd_mux_state & USB_PD_MUX_USB_ENABLED;
>  		hpd = pd_mux_state & USB_PD_MUX_HPD_IRQ;
> -	}
>  
> -	if (force || info->dp != dp || info->mux != mux ||
> -		info->power_type != power_type) {
> +		dev_dbg(dev,
> +			"connected role 0x%x pwr type %d dr %d pr %d pol %d mux %d dp %d hpd %d\n",
> +			role, power_type, dr, pr, polarity, mux, dp, hpd);
> +	}
>  
> +	/*
> +	 * When there is no USB host (e.g. USB PD charger),
> +	 * we are not really a UFP for the AP.
> +	 */
> +	if (dr == DR_DEVICE &&
> +	    cros_ec_usb_power_type_is_wall_wart(power_type, role))
> +		dr = DR_NONE;
> +
> +	if (force || info->dr != dr || info->pr != pr || info->dp != dp ||
> +	    info->mux != mux || info->power_type != power_type) {
> +		bool host_connected = false, device_connected = false;
> +
> +		dev_dbg(dev, "Type/Role switch! type = %s role = %s\n",
> +			cros_ec_usb_power_type_string(power_type),
> +			cros_ec_usb_role_string(dr));
> +		info->dr = dr;
> +		info->pr = pr;
>  		info->dp = dp;
>  		info->mux = mux;
>  		info->power_type = power_type;
>  
> -		extcon_set_state(info->edev, EXTCON_DISP_DP, dp);
> +		if (dr == DR_DEVICE)
> +			device_connected = true;
> +		else if (dr == DR_HOST)
> +			host_connected = true;
>  
> +		extcon_set_state(info->edev, EXTCON_USB, device_connected);
> +		extcon_set_state(info->edev, EXTCON_USB_HOST, host_connected);
> +		extcon_set_state(info->edev, EXTCON_DISP_DP, dp);
> +		extcon_set_property(info->edev, EXTCON_USB,
> +				    EXTCON_PROP_USB_VBUS,
> +				    (union extcon_property_value)(int)pr);
> +		extcon_set_property(info->edev, EXTCON_USB_HOST,
> +				    EXTCON_PROP_USB_VBUS,
> +				    (union extcon_property_value)(int)pr);
> +		extcon_set_property(info->edev, EXTCON_USB,
> +				    EXTCON_PROP_USB_TYPEC_POLARITY,
> +				    (union extcon_property_value)(int)polarity);
> +		extcon_set_property(info->edev, EXTCON_USB_HOST,
> +				    EXTCON_PROP_USB_TYPEC_POLARITY,
> +				    (union extcon_property_value)(int)polarity);
>  		extcon_set_property(info->edev, EXTCON_DISP_DP,
>  				    EXTCON_PROP_USB_TYPEC_POLARITY,
>  				    (union extcon_property_value)(int)polarity);
> +		extcon_set_property(info->edev, EXTCON_USB,
> +				    EXTCON_PROP_USB_SS,
> +				    (union extcon_property_value)(int)mux);
> +		extcon_set_property(info->edev, EXTCON_USB_HOST,
> +				    EXTCON_PROP_USB_SS,
> +				    (union extcon_property_value)(int)mux);
>  		extcon_set_property(info->edev, EXTCON_DISP_DP,
>  				    EXTCON_PROP_USB_SS,
>  				    (union extcon_property_value)(int)mux);
> @@ -237,6 +354,8 @@ static int extcon_cros_ec_detect_cable(struct cros_ec_extcon_info *info,
>  				    EXTCON_PROP_DISP_HPD,
>  				    (union extcon_property_value)(int)hpd);
>  
> +		extcon_sync(info->edev, EXTCON_USB);
> +		extcon_sync(info->edev, EXTCON_USB_HOST);
>  		extcon_sync(info->edev, EXTCON_DISP_DP);
>  
>  	} else if (hpd) {
> @@ -322,13 +441,28 @@ static int extcon_cros_ec_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	extcon_set_property_capability(info->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(info->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
>  	extcon_set_property_capability(info->edev, EXTCON_DISP_DP,
>  				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(info->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_SS);
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_SS);
>  	extcon_set_property_capability(info->edev, EXTCON_DISP_DP,
>  				       EXTCON_PROP_USB_SS);
>  	extcon_set_property_capability(info->edev, EXTCON_DISP_DP,
>  				       EXTCON_PROP_DISP_HPD);
>  
> +	info->dr = DR_NONE;
> +	info->pr = false;
> +
>  	platform_set_drvdata(pdev, info);
>  
>  	/* Get PD events from the EC */
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 2b16e95..a83f649 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2904,16 +2904,33 @@ enum usb_pd_control_mux {
>  	USB_PD_CTRL_MUX_AUTO = 5,
>  };
>  
> +enum usb_pd_control_swap {
> +	USB_PD_CTRL_SWAP_NONE = 0,
> +	USB_PD_CTRL_SWAP_DATA = 1,
> +	USB_PD_CTRL_SWAP_POWER = 2,
> +	USB_PD_CTRL_SWAP_VCONN = 3,
> +	USB_PD_CTRL_SWAP_COUNT
> +};
> +
>  struct ec_params_usb_pd_control {
>  	uint8_t port;
>  	uint8_t role;
>  	uint8_t mux;
> +	uint8_t swap;
>  } __packed;
>  
>  #define PD_CTRL_RESP_ENABLED_COMMS      (1 << 0) /* Communication enabled */
>  #define PD_CTRL_RESP_ENABLED_CONNECTED  (1 << 1) /* Device connected */
>  #define PD_CTRL_RESP_ENABLED_PD_CAPABLE (1 << 2) /* Partner is PD capable */
>  
> +#define PD_CTRL_RESP_ROLE_POWER         BIT(0) /* 0=SNK/1=SRC */
> +#define PD_CTRL_RESP_ROLE_DATA          BIT(1) /* 0=UFP/1=DFP */
> +#define PD_CTRL_RESP_ROLE_VCONN         BIT(2) /* Vconn status */
> +#define PD_CTRL_RESP_ROLE_DR_POWER      BIT(3) /* Partner is dualrole power */
> +#define PD_CTRL_RESP_ROLE_DR_DATA       BIT(4) /* Partner is dualrole data */
> +#define PD_CTRL_RESP_ROLE_USB_COMM      BIT(5) /* Partner USB comm capable */
> +#define PD_CTRL_RESP_ROLE_EXT_POWERED   BIT(6) /* Partner externally powerd */
> +
>  struct ec_response_usb_pd_control_v1 {
>  	uint8_t enabled;
>  	uint8_t role;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
