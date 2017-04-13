From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 13 Apr 2017 17:17:19 +0530
Subject: [PATCH 1/2] phy: qcom-usb-hs: Replace the extcon API
In-Reply-To: <1490675909-2533-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170328043830epcas1p4069bda461ad648cfd6598905b7167e9f@epcas1p4.samsung.com>
 <1490675909-2533-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <ade390be-3104-916c-5fac-780369763411@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Tuesday 28 March 2017 10:08 AM, Chanwoo Choi wrote:
> This patch uses the resource-managed extcon API for extcon_register_notifier()
> and replaces the deprecated extcon API as following:
> - (deprecated) extcon_get_cable_state_() -> extcon_get_state()
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

I've missed merging this patch for the next merge window. If you want to take
this yourself.
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
> ---
>  drivers/phy/phy-qcom-usb-hs.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/phy-qcom-usb-hs.c b/drivers/phy/phy-qcom-usb-hs.c
> index 94dfbfd739c3..f630fa553b7d 100644
> --- a/drivers/phy/phy-qcom-usb-hs.c
> +++ b/drivers/phy/phy-qcom-usb-hs.c
> @@ -156,12 +156,12 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
>  	}
>  
>  	if (uphy->vbus_edev) {
> -		state = extcon_get_cable_state_(uphy->vbus_edev, EXTCON_USB);
> +		state = extcon_get_state(uphy->vbus_edev, EXTCON_USB);
>  		/* setup initial state */
>  		qcom_usb_hs_phy_vbus_notifier(&uphy->vbus_notify, state,
>  					      uphy->vbus_edev);
> -		ret = extcon_register_notifier(uphy->vbus_edev, EXTCON_USB,
> -				&uphy->vbus_notify);
> +		ret = devm_extcon_register_notifier(&ulpi->dev, uphy->vbus_edev,
> +				EXTCON_USB, &uphy->vbus_notify);
>  		if (ret)
>  			goto err_ulpi;
>  	}
> @@ -180,16 +180,8 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
>  
>  static int qcom_usb_hs_phy_power_off(struct phy *phy)
>  {
> -	int ret;
>  	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
>  
> -	if (uphy->vbus_edev) {
> -		ret = extcon_unregister_notifier(uphy->vbus_edev, EXTCON_USB,
> -						 &uphy->vbus_notify);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	regulator_disable(uphy->v3p3);
>  	regulator_disable(uphy->v1p8);
>  	clk_disable_unprepare(uphy->sleep_clk);
> 
