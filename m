From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 15 Nov 2016 19:12:46 +0530
Subject: [PATCH -next] phy: meson8b-usb2: fix missing
 clk_disable_unprepare() on error
In-Reply-To: <1477146822-31327-1-git-send-email-weiyj.lk@gmail.com>
References: <1477146822-31327-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <582B10D6.9040003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 22 October 2016 08:03 PM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix the missing clk_disable_unprepare() before return from
> phy_meson8b_usb2_power_on() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

merged, thanks.

-Kishon
> ---
>  drivers/phy/phy-meson8b-usb2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/phy/phy-meson8b-usb2.c b/drivers/phy/phy-meson8b-usb2.c
> index 73bf632..dca3947 100644
> --- a/drivers/phy/phy-meson8b-usb2.c
> +++ b/drivers/phy/phy-meson8b-usb2.c
> @@ -158,6 +158,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>  	ret = clk_prepare_enable(priv->clk_usb);
>  	if (ret) {
>  		dev_err(&phy->dev, "Failed to enable USB DDR clock\n");
> +		clk_disable_unprepare(priv->clk_usb_general);
>  		return ret;
>  	}
>  
> @@ -190,6 +191,8 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>  		if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
>  			REG_ADP_BC_ACA_PIN_FLOAT) {
>  			dev_warn(&phy->dev, "USB ID detect failed!\n");
> +			clk_disable_unprepare(priv->clk_usb);
> +			clk_disable_unprepare(priv->clk_usb_general);
>  			return -EINVAL;
>  		}
>  	}
> 
