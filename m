From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Oct 2017 23:03:40 +0200
Subject: [PATCH 2/6] ARM: sun8i: r40: add USB host port nodes for R40
In-Reply-To: <20171008042906.46779-3-icenowy@aosc.io>
References: <20171008042906.46779-1-icenowy@aosc.io>
 <20171008042906.46779-3-icenowy@aosc.io>
Message-ID: <20171009210340.ak6wo3vqnwj4gom4@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 08, 2017 at 04:29:02AM +0000, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Allwinner R40 SoC features a USB OTG port and two USB HOST ports.
> 
> Add support for the host ports in the DTSI file.
> 
> The OTG controller still cannot work with existing compatibles, and needs
> more investigation. So it's not added yet.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 78 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index d5a6745409ae..f6c917cbbaac 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -173,6 +173,84 @@
>  			#size-cells = <0>;
>  		};
>  
> +		usbphy: phy at 1c13400 {
> +			compatible = "allwinner,sun8i-r40-usb-phy";
> +			reg = <0x01c13400 0x14>,
> +			      <0x01c14800 0x4>,
> +			      <0x01c19800 0x4>,
> +			      <0x01c1c800 0x4>;
> +			reg-names = "phy_ctrl",
> +				    "pmu0",
> +				    "pmu1",
> +				    "pmu2";
> +			clocks = <&ccu CLK_USB_PHY0>,
> +				 <&ccu CLK_USB_PHY1>,
> +				 <&ccu CLK_USB_PHY2>;
> +			clock-names = "usb0_phy",
> +				      "usb1_phy",
> +				      "usb2_phy";
> +			resets = <&ccu RST_USB_PHY0>,
> +				 <&ccu RST_USB_PHY1>,
> +				 <&ccu RST_USB_PHY2>;
> +			reset-names = "usb0_reset",
> +				      "usb1_reset",
> +				      "usb2_reset";
> +			status = "disabled";
> +			#phy-cells = <1>;
> +		};
> +
> +		ehci1: usb at 1c19000 {
> +			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
> +			reg = <0x01c19000 0x100>;

What is the actual size here?

> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI1>,
> +				 <&ccu CLK_BUS_EHCI1>,
> +				 <&ccu CLK_USB_OHCI1>;
> +			resets = <&ccu RST_BUS_OHCI1>,
> +				 <&ccu RST_BUS_EHCI1>;

Why do you need to take the OHCI resources too?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171009/2ae2132e/attachment.sig>
