From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 29 Sep 2017 22:11:41 +0800
Subject: [PATCH 07/12] usb: mtu3: add support for usb3.1 IP
In-Reply-To: <f862f79fce3eb723a7d9bb6d27e60b82d031d918.1506509659.git.chunfeng.yun@mediatek.com>
References: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
 <f862f79fce3eb723a7d9bb6d27e60b82d031d918.1506509659.git.chunfeng.yun@mediatek.com>
Message-ID: <1506694301.17567.26.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-28 at 08:17 +0800, Chunfeng Yun wrote:
> Support SuperSpeedPlus for usb3.1 device IP
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3.h            |    1 +
>  drivers/usb/mtu3/mtu3_core.c       |   14 +++++++++++---
>  drivers/usb/mtu3/mtu3_gadget.c     |    3 ++-
>  drivers/usb/mtu3/mtu3_gadget_ep0.c |   16 ++++++++--------
>  drivers/usb/mtu3/mtu3_hw_regs.h    |    1 +
>  5 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
> index b0c2b5d..d80e4e8 100644
> --- a/drivers/usb/mtu3/mtu3.h
> +++ b/drivers/usb/mtu3/mtu3.h
> @@ -94,6 +94,7 @@ enum mtu3_speed {
>  	MTU3_SPEED_FULL = 1,
>  	MTU3_SPEED_HIGH = 3,
>  	MTU3_SPEED_SUPER = 4,
> +	MTU3_SPEED_SUPER_PLUS = 5,
>  };
>  
>  /**
> diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
> index cd4528f..67f7a30 100644
> --- a/drivers/usb/mtu3/mtu3_core.c
> +++ b/drivers/usb/mtu3/mtu3_core.c
> @@ -237,7 +237,7 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
>  
>  void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
>  {
> -	if (mtu->is_u3_ip && (mtu->max_speed == USB_SPEED_SUPER))
> +	if (mtu->is_u3_ip && mtu->max_speed >= USB_SPEED_SUPER)
>  		mtu3_ss_func_set(mtu, is_on);
>  	else
>  		mtu3_hs_softconn_set(mtu, is_on);
> @@ -547,6 +547,9 @@ static void mtu3_set_speed(struct mtu3 *mtu)
>  		mtu3_clrbits(mbase, U3D_USB3_CONFIG, USB3_EN);
>  		/* HS/FS detected by HW */
>  		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
> +	} else if (mtu->max_speed == USB_SPEED_SUPER) {
> +		mtu3_clrbits(mtu->ippc_base, SSUSB_U3_CTRL(0),
> +			     SSUSB_U3_PORT_SSP_SPEED);
>  	}
>  
>  	dev_info(mtu->dev, "max_speed: %s\n",
> @@ -624,6 +627,10 @@ static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
>  		udev_speed = USB_SPEED_SUPER;
>  		maxpkt = 512;
>  		break;
> +	case MTU3_SPEED_SUPER_PLUS:
> +		udev_speed = USB_SPEED_SUPER_PLUS;
> +		maxpkt = 512;
> +		break;
>  	default:
>  		udev_speed = USB_SPEED_UNKNOWN;
>  		break;
> @@ -825,14 +832,15 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
>  	case USB_SPEED_FULL:
>  	case USB_SPEED_HIGH:
>  	case USB_SPEED_SUPER:
> +	case USB_SPEED_SUPER_PLUS:
>  		break;
>  	default:
>  		dev_err(dev, "invalid max_speed: %s\n",
>  			usb_speed_string(mtu->max_speed));
>  		/* fall through */
>  	case USB_SPEED_UNKNOWN:
> -		/* default as SS */
> -		mtu->max_speed = USB_SPEED_SUPER;
> +		/* default as SSP */
> +		mtu->max_speed = USB_SPEED_SUPER_PLUS;
>  		break;
>  	}
>  
> diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
> index 434fca5..b495471 100644
> --- a/drivers/usb/mtu3/mtu3_gadget.c
> +++ b/drivers/usb/mtu3/mtu3_gadget.c
> @@ -89,6 +89,7 @@ static int mtu3_ep_enable(struct mtu3_ep *mep)
>  
>  	switch (mtu->g.speed) {
>  	case USB_SPEED_SUPER:
> +	case USB_SPEED_SUPER_PLUS:
>  		if (usb_endpoint_xfer_int(desc) ||
>  				usb_endpoint_xfer_isoc(desc)) {
>  			interval = desc->bInterval;
> @@ -456,7 +457,7 @@ static int mtu3_gadget_wakeup(struct usb_gadget *gadget)
>  		return  -EOPNOTSUPP;
>  
>  	spin_lock_irqsave(&mtu->lock, flags);
> -	if (mtu->g.speed == USB_SPEED_SUPER) {
> +	if (mtu->g.speed >= USB_SPEED_SUPER) {
>  		mtu3_setbits(mtu->mac_base, U3D_LINK_POWER_CONTROL, UX_EXIT);
>  	} else {
>  		mtu3_setbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
> diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> index 958d74d..1ca77e8 100644
> --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> @@ -212,8 +212,8 @@ static int ep0_set_sel(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
>  	case USB_RECIP_DEVICE:
>  		result[0] = mtu->is_self_powered << USB_DEVICE_SELF_POWERED;
>  		result[0] |= mtu->may_wakeup << USB_DEVICE_REMOTE_WAKEUP;
> -		/* superspeed only */
> -		if (mtu->g.speed == USB_SPEED_SUPER) {
> +
> +		if (mtu->g.speed >= USB_SPEED_SUPER) {
>  			result[0] |= mtu->u1_enable << USB_DEV_STAT_U1_ENABLED;
>  			result[0] |= mtu->u2_enable << USB_DEV_STAT_U2_ENABLED;
>  		}
> @@ -329,8 +329,8 @@ static int ep0_handle_feature_dev(struct mtu3 *mtu,
>  		handled = handle_test_mode(mtu, setup);
>  		break;
>  	case USB_DEVICE_U1_ENABLE:
> -		if (mtu->g.speed != USB_SPEED_SUPER ||
> -			mtu->g.state != USB_STATE_CONFIGURED)
> +		if (mtu->g.speed <= USB_SPEED_SUPER ||
Here is wrong, I'll fix it up in next version.

> +		    mtu->g.state != USB_STATE_CONFIGURED)
>  			break;
>  
>  		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
> @@ -344,8 +344,8 @@ static int ep0_handle_feature_dev(struct mtu3 *mtu,
>  		handled = 1;
>  		break;
>  	case USB_DEVICE_U2_ENABLE:
> -		if (mtu->g.speed != USB_SPEED_SUPER ||
> -			mtu->g.state != USB_STATE_CONFIGURED)
> +		if (mtu->g.speed <= USB_SPEED_SUPER ||
It's also wrong.

Sorry

> +		    mtu->g.state != USB_STATE_CONFIGURED)
>  			break;
>  
>  		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
> @@ -384,8 +384,8 @@ static int ep0_handle_feature(struct mtu3 *mtu,
>  		break;
>  	case USB_RECIP_INTERFACE:
>  		/* superspeed only */
> -		if ((value == USB_INTRF_FUNC_SUSPEND)
> -			&& (mtu->g.speed == USB_SPEED_SUPER)) {
> +		if (value == USB_INTRF_FUNC_SUSPEND &&
> +		    mtu->g.speed >= USB_SPEED_SUPER) {
>  			/*
>  			 * forward the request because function drivers
>  			 * should handle it
> diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
> index a7e35f6..6953436 100644
> --- a/drivers/usb/mtu3/mtu3_hw_regs.h
> +++ b/drivers/usb/mtu3/mtu3_hw_regs.h
> @@ -467,6 +467,7 @@
>  #define SSUSB_VBUS_CHG_INT_B_EN		BIT(6)
>  
>  /* U3D_SSUSB_U3_CTRL_0P */
> +#define SSUSB_U3_PORT_SSP_SPEED	BIT(9)
>  #define SSUSB_U3_PORT_HOST_SEL		BIT(2)
>  #define SSUSB_U3_PORT_PDN		BIT(1)
>  #define SSUSB_U3_PORT_DIS		BIT(0)
