From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 13 Nov 2015 11:58:51 +0530
Subject: [PATCH 1/8] phy: rockchip-usb: fix clock get-put mismatch
In-Reply-To: <1446673454-9529-2-git-send-email-heiko@sntech.de>
References: <1446673454-9529-1-git-send-email-heiko@sntech.de>
 <1446673454-9529-2-git-send-email-heiko@sntech.de>
Message-ID: <56458323.6040506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 05 November 2015 03:14 AM, Heiko Stuebner wrote:
> Currently the phy driver only gets the optional clock reference but
> never puts it again, neither during error handling nor on remove.
> Fix that by moving the clk_put to a devm-action that gets called at
> the right time when all other devm actions are done.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/phy/phy-rockchip-usb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
> index 91d6f34..dfc056b 100644
> --- a/drivers/phy/phy-rockchip-usb.c
> +++ b/drivers/phy/phy-rockchip-usb.c
> @@ -90,6 +90,14 @@ static const struct phy_ops ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static void rockchip_usb_phy_action(void *data)
> +{
> +	struct rockchip_usb_phy *rk_phy = data;
> +
> +	if (rk_phy->clk)
> +		clk_put(rk_phy->clk);
> +}
> +
>  static int rockchip_usb_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -124,6 +132,13 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
>  		if (IS_ERR(rk_phy->clk))
>  			rk_phy->clk = NULL;
>  
> +		err = devm_add_action(dev, rockchip_usb_phy_action, rk_phy);
> +		if (err) {
> +			if (rk_phy->clk)
> +				clk_put(rk_phy->clk);

If devm_add_action is added before clk_get this check wouldn't be required at all.

Thanks
Kishon
