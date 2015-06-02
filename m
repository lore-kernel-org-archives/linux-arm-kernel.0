From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 02 Jun 2015 21:15:22 +0200
Subject: [PATCH 1/3] phy: sun4i-usb: Add support for sun8i A23/A33
In-Reply-To: <1433248152-13753-2-git-send-email-wens@csie.org>
References: <1433248152-13753-1-git-send-email-wens@csie.org>
 <1433248152-13753-2-git-send-email-wens@csie.org>
Message-ID: <556E00CA.2000309@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/02/2015 02:29 PM, Chen-Yu Tsai wrote:
> A23/A33 have separate reset lines for each PHY, like on sun6i,
> but only 2 PHYs instead of 3. Add a new compatible for this.
>
> There is also an HSIC PHY, but no hardware that uses it exists.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Heh, I've pretty much written the exact same patch (not that
it was much work):

https://github.com/jwrdegoede/linux-sunxi/commit/bc062354f5e0ec75047859d7c2ee3fa04594d29c

Note though that:

1) In order to get the disconnect threshold correct you also need:

https://github.com/jwrdegoede/linux-sunxi/commit/f7dabee14450cd93e6d0b01f4b6ab065a55955e3

2) This will only work properly for the A23 not for the A33 on the A33 the phyctl reg
sits at a different offset, see:

https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/usb/host/sunxi_hci.c#L49

So I've written a separate patch (on top of the a23 one, to add control for the A33 phy:
https://github.com/jwrdegoede/linux-sunxi/commit/b4536a92ede3187450b0f1c27c11c1f80fc66fc8

Note I also have patches to add support for the musb on sun6i (no sram controller for the
otg sram, needs reset controller poking) this also works for the a23, and a separate patch
for the a33 which needs some special handling again.

So how to move forward with this? I believe that it is best if I finish my work on this
and post a series to Felipe and Kishon to apply on top of the 2 still outstanding
phy-sun4i-usb / musb-sunxi patches.

As for the dts patches, those I plan to bundle with the dts patches I already have
pending for otg support for sunxi in general.

Does that work for you ?

Regards,

Hans







> ---
>   Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 2 ++
>   drivers/phy/phy-sun4i-usb.c                             | 7 +++++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> index 16528b9eb561..9148f0535b29 100644
> --- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> @@ -7,6 +7,7 @@ Required properties:
>     * allwinner,sun5i-a13-usb-phy
>     * allwinner,sun6i-a31-usb-phy
>     * allwinner,sun7i-a20-usb-phy
> +  * allwinner,sun8i-a23-usb-phy
>   - reg : a list of offset + length pairs
>   - reg-names :
>     * "phy_ctrl"
> @@ -17,6 +18,7 @@ Required properties:
>   - clock-names :
>     * "usb_phy" for sun4i, sun5i or sun7i
>     * "usb0_phy", "usb1_phy" and "usb2_phy" for sun6i
> +  * "usb0_phy", "usb1_phy" for sun8i-a23
>   - resets : a list of phandle + reset specifier pairs
>   - reset-names :
>     * "usb0_reset"
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index a2b08f3ccb03..a60c45c075e7 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -239,7 +239,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>
>   	mutex_init(&data->mutex);
>
> -	if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy"))
> +	if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy") ||
> +	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy"))
>   		data->num_phys = 2;
>   	else
>   		data->num_phys = 3;
> @@ -250,7 +251,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>   	else
>   		data->disc_thresh = 2;
>
> -	if (of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy"))
> +	if (of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy") ||
> +	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy"))
>   		dedicated_clocks = true;
>   	else
>   		dedicated_clocks = false;
> @@ -320,6 +322,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
>   	{ .compatible = "allwinner,sun5i-a13-usb-phy" },
>   	{ .compatible = "allwinner,sun6i-a31-usb-phy" },
>   	{ .compatible = "allwinner,sun7i-a20-usb-phy" },
> +	{ .compatible = "allwinner,sun8i-a23-usb-phy" },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
>
