From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Nov 2018 18:21:33 +0800
Subject: [linux-sunxi] [PATCH v4 04/10] arm64: allwinner: dts: h6: add
 USB2-related device nodes
In-Reply-To: <20181004122855.22981-5-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-5-icenowy@aosc.io>
Message-ID: <CAGb2v668dozjLm9mWUw_Y12AZ6DM2ku9dgQ8B8feABNeFf3QSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 4, 2018 at 8:30 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> Allwinner H6 has two USB2 ports, one OTG and one host-only.
>
> Add device tree nodes related to them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> No changes in v4.
>
> Changes in v3:
> - Removed the wrongly introduced usb3phy node.
> - Added Chen-Yu's Review tag.
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 81 ++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 040828d2e2c0..3d60af6cb3ae 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -258,6 +258,87 @@
>                         status = "disabled";
>                 };
>
> +               usb2otg: usb at 5100000 {
> +                       compatible = "allwinner,sun8i-a33-musb";

I added an SoC-specific compatible: "allwinner,sun50i-h6-musb".

I'm also curious as to whether the MUSB controller was tested or not,
since Allwinner now has EHCI/OHCI host pairs for host mode, and the Pine H64
only does host mode.

> +                       reg = <0x05100000 0x0400>;
> +                       clocks = <&ccu CLK_BUS_OTG>;
> +                       resets = <&ccu RST_BUS_OTG>;
> +                       interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "mc";
> +                       phys = <&usb2phy 0>;
> +                       phy-names = "usb";
> +                       extcon = <&usb2phy 0>;
> +                       status = "disabled";
> +               };
> +
> +               usb2phy: phy at 5100400 {
> +                       compatible = "allwinner,sun50i-h6-usb-phy";
> +                       reg = <0x05100400 0x14>,
> +                             <0x05101800 0x4>,
> +                             <0x05311800 0x4>;
> +                       reg-names = "phy_ctrl",
> +                                   "pmu0",
> +                                   "pmu3";
> +                       clocks = <&ccu CLK_USB_PHY0>,
> +                                <&ccu CLK_USB_PHY3>;
> +                       clock-names = "usb0_phy",
> +                                     "usb3_phy";
> +                       resets = <&ccu RST_USB_PHY0>,
> +                                <&ccu RST_USB_PHY3>;
> +                       reset-names = "usb0_reset",
> +                                     "usb3_reset";
> +                       status = "disabled";
> +                       #phy-cells = <1>;
> +               };
> +
> +               ehci0: usb at 5101000 {
> +                       compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
> +                       reg = <0x05101000 0x100>;
> +                       interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI0>,
> +                                <&ccu CLK_BUS_EHCI0>,
> +                                <&ccu CLK_USB_OHCI0>;
> +                       resets = <&ccu RST_BUS_OHCI0>,
> +                                <&ccu RST_BUS_EHCI0>;
> +                       status = "disabled";
> +               };
> +
> +               ohci0: usb at 5101400 {
> +                       compatible = "allwinner,sun50i-h6-ohci", "generic-ohci";
> +                       reg = <0x05101400 0x100>;
> +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI0>,
> +                                <&ccu CLK_USB_OHCI0>;
> +                       resets = <&ccu RST_BUS_OHCI0>;
> +                       status = "disabled";
> +               };
> +
> +               ehci3: usb at 5311000 {
> +                       compatible = "allwinner,sun50i-h6-ehci", "generic-ehci";
> +                       reg = <0x05311000 0x100>;
> +                       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI3>,
> +                                <&ccu CLK_BUS_EHCI3>,
> +                                <&ccu CLK_USB_OHCI3>;
> +                       resets = <&ccu RST_BUS_OHCI3>,
> +                                <&ccu RST_BUS_EHCI3>;
> +                       phys = <&usb2phy 3>;
> +                       phy-names = "usb";
> +                       status = "disabled";
> +               };
> +
> +               ohci3: usb at 5311400 {
> +                       compatible = "allwinner,sun50i-h6-ohci", "generic-ohci";
> +                       reg = <0x05311400 0x100>;
> +                       interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_OHCI3>,
> +                                <&ccu CLK_USB_OHCI3>;
> +                       resets = <&ccu RST_BUS_OHCI3>;
> +                       phys = <&usb2phy 3>;
> +                       phy-names = "usb";
> +                       status = "disabled";
> +               };
> +

This didn't apply cleanly due to the new HDMI nodes. I fixed it up locally.

ChenYu

>                 r_ccu: clock at 7010000 {
>                         compatible = "allwinner,sun50i-h6-r-ccu";
>                         reg = <0x07010000 0x400>;
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
