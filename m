From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Mar 2013 14:59:43 -0600
Subject: [PATCH v3 5/6] ARM: dts: omap: update usb_otg_hs data
In-Reply-To: <1363770725-13717-6-git-send-email-kishon@ti.com>
References: <1363770725-13717-1-git-send-email-kishon@ti.com>
 <1363770725-13717-6-git-send-email-kishon@ti.com>
Message-ID: <514A233F.8010105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2013 03:12 AM, Kishon Vijay Abraham I wrote:
> Updated the usb_otg_hs dt data to include the *phy* and *phy-names*
> binding in order for the driver to use the new generic PHY framework.
> Also updated the Documentation to include the binding information.

> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> index abce256..3d6f9f6 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -19,6 +19,9 @@ OMAP MUSB GLUE
>   - power : Should be "50". This signifies the controller can supply upto
>     100mA when operating in host mode.
>   - usb-phy : the phandle for the PHY device
> + - phy : the phandle for the PHY device (used by generic PHY framework)
> + - phy-names : the names of the PHY corresponding to the PHYs present in the
> +   *phy* phandle.

If the intent is for those properties to be generic and used by any DT
binding that refers to a PHY node, I think you'd want to define those
properties in e.g. Documentation/devicetree/bindings/phy/phy.txt, just
like common clock/GPIO/... properties are defined in standalone common
files.

I think you want to require that DT nodes that represent PHYs have a
#phy-cells property, and that the format of the phy property be
<&phy_phandle phy_specifier*>, where #phy-cells in the referenced node
defines how many cells are part of phy_specifier*, just like (almost)
any other DT property that references another node by phandle. That way,
if a single DT node represents a HW block that implements e.g. 3 PHYs,
it can use #phy-cells = <1>, and the referencing phy property can
include a cell that indicates which of those 3 PHYs is being referenced.
