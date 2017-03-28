From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 28 Mar 2017 19:10:27 +0800
Subject: [PATCH] usb: mtu3: Replace the extcon API
In-Reply-To: <1490676122-2655-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170328044203epcas5p3a1c11c5eae084c06cdc5291f37232b83@epcas5p3.samsung.com>
 <1490676122-2655-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1490699427.19361.3.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2017-03-28 at 13:42 +0900, Chanwoo Choi wrote:
> This patch uses the resource-managed extcon API for extcon_register_notifier()
> and replaces the deprecated extcon API as following:
> - extcon_get_cable_state_() -> extcon_get_state()
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/usb/mtu3/mtu3_dr.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
> index 1a8987e7c5b0..11a0d3b84c5e 100644
> --- a/drivers/usb/mtu3/mtu3_dr.c
> +++ b/drivers/usb/mtu3/mtu3_dr.c
> @@ -223,25 +223,25 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
>  		return 0;
>  
>  	otg_sx->vbus_nb.notifier_call = ssusb_vbus_notifier;
> -	ret = extcon_register_notifier(edev, EXTCON_USB,
> +	ret = devm_extcon_register_notifier(ssusb->dev, edev, EXTCON_USB,
>  					&otg_sx->vbus_nb);
>  	if (ret < 0)
>  		dev_err(ssusb->dev, "failed to register notifier for USB\n");
>  
>  	otg_sx->id_nb.notifier_call = ssusb_id_notifier;
> -	ret = extcon_register_notifier(edev, EXTCON_USB_HOST,
> +	ret = devm_extcon_register_notifier(ssusb->dev, edev, EXTCON_USB_HOST,
>  					&otg_sx->id_nb);
>  	if (ret < 0)
>  		dev_err(ssusb->dev, "failed to register notifier for USB-HOST\n");
>  
>  	dev_dbg(ssusb->dev, "EXTCON_USB: %d, EXTCON_USB_HOST: %d\n",
> -		extcon_get_cable_state_(edev, EXTCON_USB),
> -		extcon_get_cable_state_(edev, EXTCON_USB_HOST));
> +		extcon_get_state(edev, EXTCON_USB),
> +		extcon_get_state(edev, EXTCON_USB_HOST));
>  
>  	/* default as host, switch to device mode if needed */
> -	if (extcon_get_cable_state_(edev, EXTCON_USB_HOST) == false)
> +	if (extcon_get_state(edev, EXTCON_USB_HOST) == false)
>  		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
> -	if (extcon_get_cable_state_(edev, EXTCON_USB) == true)
> +	if (extcon_get_state(edev, EXTCON_USB) == true)
>  		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
>  
>  	return 0;
> @@ -367,13 +367,6 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
>  
>  	cancel_delayed_work(&otg_sx->extcon_reg_dwork);
>  
> -	if (otg_sx->edev) {
> -		extcon_unregister_notifier(otg_sx->edev,
> -			EXTCON_USB, &otg_sx->vbus_nb);
> -		extcon_unregister_notifier(otg_sx->edev,
> -			EXTCON_USB_HOST, &otg_sx->id_nb);
> -	}
> -
>  	if (otg_sx->manual_drd_enabled)
>  		ssusb_debugfs_exit(ssusb);
>  }

Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks
