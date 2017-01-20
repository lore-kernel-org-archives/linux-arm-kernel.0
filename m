From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jan 2017 17:21:38 +0100
Subject: [PATCH v3 2/9] ARM64: dts: meson-gxbb-p200: add the ethernet
 PHY's reset GPIO
In-Reply-To: <20170120152232.13943-3-martin.blumenstingl@googlemail.com>
References: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-3-martin.blumenstingl@googlemail.com>
Message-ID: <20170120162138.GE25907@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 04:22:25PM +0100, Martin Blumenstingl wrote:
> This resets the ethernet PHY during boot to get the PHY into a "clean"
> state.
> While here also specify the phy-handle of the ethmac node to make the
> PHY configuration similar to the one we have on GXL devices. This will
> allow us to specify OF-properties for the PHY itself.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
> index 03e3d76626dd..fa0f84cfeaa9 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
> @@ -51,6 +51,30 @@
>  	model = "Amlogic Meson GXBB P200 Development Board";
>  };
>  
> +&ethmac {
> +	status = "okay";
> +	pinctrl-0 = <&eth_rgmii_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&eth_phy0>;
> +	phy-mode = "rgmii";
> +
> +	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	snps,reset-active-low;
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy0: ethernet-phy at 0 {
> +			compatible = "ethernet-phy-id0022.1620",

Hi Martin

You don't need to specify the PHY ID. You really only need this when
the PHY is reporting no ID, or a wrong ID. In fact, if a new revision
of the board is made, with a different PHY, you might have a problem,
the wrong PHY driver is loaded.

   Andrew
