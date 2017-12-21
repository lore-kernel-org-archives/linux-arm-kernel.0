From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 16:16:07 +0100
Subject: [PATCH 1/2] ARM: sun8i: v3s: add EHCI/OHCI0 device nodes
In-Reply-To: <20171221150537.20304-2-icenowy@aosc.io>
References: <20171221150537.20304-1-icenowy@aosc.io>
 <20171221150537.20304-2-icenowy@aosc.io>
Message-ID: <20171221151607.bepvzy5wa4bj34ep@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 21, 2017 at 11:05:36PM +0800, Icenowy Zheng wrote:
> The USB PHY 0 on V3s SoC can also be routed to a pair of EHCI/OHCI
> controllers.
> 
> Add the device nodes for the controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index 443b083c6adc..cc315dc742d2 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -264,6 +264,25 @@
>  			#phy-cells = <1>;
>  		};
>  
> +		ehci0: usb at 01c1a000 {
> +			compatible = "allwinner,sun8i-v3s-ehci", "generic-ehci";
> +			reg = <0x01c1a000 0x100>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>;
> +			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;

Why are you taking the OHCI clocks and resets in the OHCI node..

> +			status = "disabled";
> +		};
> +
> +		ohci0: usb at 01c1a400 {
> +			compatible = "allwinner,sun8i-v3s-ohci", "generic-ohci";
> +			reg = <0x01c1a400 0x100>;
> +			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>,
> +				 <&ccu CLK_USB_OHCI0>;
> +			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;

... And the EHCI clocks and resets in the OHCI node?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171221/96d46b00/attachment.sig>
