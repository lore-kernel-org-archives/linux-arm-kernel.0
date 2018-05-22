From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 15:12:00 -0500
Subject: [PATCH 1/5] phy: allwinner: add phy driver for USB3 PHY on
 Allwinner H6 SoC
In-Reply-To: <20180507151817.55663-2-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
 <20180507151817.55663-2-icenowy@aosc.io>
Message-ID: <20180522201200.GA17465@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 11:18:13PM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
> controlled).
> 
> Add a driver for it.
> 
> The register operations in this driver is mainly extracted from the BSP
> USB3 driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/phy/sun50i-usb3-phy.txt          |  24 +++

Please split bindings to separate patch.

>  drivers/phy/allwinner/Kconfig                 |  13 ++
>  drivers/phy/allwinner/Makefile                |   1 +
>  drivers/phy/allwinner/phy-sun50i-usb3.c       | 195 ++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>  create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..912d55f9f69d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun50i USB3 PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of
> +  * allwinner,sun60i-h6-usb3-phy
> +- reg : a list of offset + length pairs
> +- #phy-cells : from the generic phy bindings, must be 0
> +- clocks : phandle + clock specifier for the phy clock
> +- resets : phandle + reset specifier for the phy reset
> +
> +Optional Properties:
> +- phy-supply : from the generic phy bindings, a phandle to a regulator that
> +	       provides power to VBUS.
> +
> +Example:
> +	usb3phy: phy at 5210000 {

usb-phy at ...

> +		compatible = "allwinner,sun50i-h6-usb3-phy";
> +		reg = <0x5210000 0x10000>;
> +		clocks = <&ccu CLK_USB_PHY1>;
> +		resets = <&ccu RST_USB_PHY1>;
> +		#phy-cells = <0>;
> +		status = "disabled";

Don't show status in examples.

> +	};
