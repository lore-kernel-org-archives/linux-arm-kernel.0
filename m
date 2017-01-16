From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Jan 2017 14:36:02 +0530
Subject: [PATCH v2 3/3] phy: rockchip-inno-usb2: Set EXTCON_USB when
 EXTCON_CHG_USB_SDP was set
In-Reply-To: <23666cc1a5ff123ece5bdbb9821d1eab280d0927.1482307697.git.baolin.wang@linaro.org>
References: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482307697.git.baolin.wang@linaro.org>
 <23666cc1a5ff123ece5bdbb9821d1eab280d0927.1482307697.git.baolin.wang@linaro.org>
Message-ID: <587C8CFA.2000304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 21 December 2016 01:42 PM, Baolin Wang wrote:
> According to the documentation, we should set the EXTCON_USB when
> one SDP charger connector was reported.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

merged, thanks!

-Kishon
> ---
> Changes since v1:
>  - Change extcon_set_cable_state_() to extcon_set_state_sync().
>  - Add reviewed tag by Chanwoo Choi.
> ---
>  drivers/phy/phy-rockchip-inno-usb2.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
> index 2f99ec9..4ea95c2 100644
> --- a/drivers/phy/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/phy-rockchip-inno-usb2.c
> @@ -595,9 +595,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
>  		if (rport->vbus_attached != vbus_attach) {
>  			rport->vbus_attached = vbus_attach;
>  
> -			if (notify_charger && rphy->edev)
> +			if (notify_charger && rphy->edev) {
>  				extcon_set_cable_state_(rphy->edev,
>  							cable, vbus_attach);
> +				if (cable == EXTCON_CHG_USB_SDP)
> +					extcon_set_state_sync(rphy->edev,
> +							      EXTCON_USB,
> +							      vbus_attach);
> +			}
>  		}
>  		break;
>  	case OTG_STATE_B_PERIPHERAL:
> 
