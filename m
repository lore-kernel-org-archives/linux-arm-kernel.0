From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 30 Aug 2018 14:22:32 +0200
Subject: [PATCH] ARM: dts: rockchip: add rk3188 lcd controller nodes
In-Reply-To: <42ff42a7-ebd8-e717-af3d-a18de5e4d05c@rock-chips.com>
References: <20180830111134.2098-1-heiko@sntech.de>
 <42ff42a7-ebd8-e717-af3d-a18de5e4d05c@rock-chips.com>
Message-ID: <2119603.JzqsNBunkW@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandy,

Am Donnerstag, 30. August 2018, 13:59:35 CEST schrieb Sandy Huang:
> Hi heiko,
> 
> ? 2018/8/30 19:11, Heiko Stuebner ??:
> > Add the core display subsystem and vop nodes to rk3188.
> > Vop0 has a fully dedicated set of pins and only vop1 needs to
> > do pinctrl to have display output, so also add the necessary
> > pinctrl entries for it.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >   arch/arm/boot/dts/rk3188.dtsi | 84 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 84 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> > index aa123f93f181..ff607f11f5b0 100644
> > --- a/arch/arm/boot/dts/rk3188.dtsi
> > +++ b/arch/arm/boot/dts/rk3188.dtsi
> > @@ -56,6 +56,11 @@
> >   		};
> >   	};
> >   
> > +	display-subsystem {
> > +		compatible = "rockchip,display-subsystem";
> > +		ports = <&vop0_out>, <&vop1_out>;
> > +	};
> > +
> >   	sram: sram at 10080000 {
> >   		compatible = "mmio-sram";
> >   		reg = <0x10080000 0x8000>;
> > @@ -69,6 +74,40 @@
> >   		};
> >   	};
> >   
> > +	vop0: vop at 1010c000 {
> > +		compatible = "rockchip,rk3188-vop";
> > +		reg = <0x1010c000 0x1000>;
> > +		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&cru ACLK_LCDC0>, <&cru DCLK_LCDC0>, <&cru HCLK_LCDC0>;
> > +		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> > +		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
> > +		reset-names = "axi", "ahb", "dclk";
> > +		status = "disabled";
> > +
> > +		vop0_out: port {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +	};
> > +
> > +	vop1: vop at 1010e000 {
> > +		compatible = "rockchip,rk3188-vop";
> > +		reg = <0x1010e000 0x1000>;
> > +		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&cru ACLK_LCDC1>, <&cru DCLK_LCDC1>, <&cru HCLK_LCDC1>;
> > +		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&lcdc1_dclk &lcdc1_den &lcdc1_hsync &lcdc1_vsync &lcdc1_rgb24>;
> Some product maybe use vop0 for display, this io maybe used for other 
> function. So i think pincrtl default state should be moved from here and 
> define at dts file.

For the rk3188 we should be fine then. I.e. the rk3188 only has the rgb
output and no encoders of its own. So at any time vop1 is used it will
need the pinctrl entries.

Its default state is "disabled", and pinctrl settings will only be used if
the node gets enabled in a board file.

For other socs like the px30 and rk3066 which mix rgb and hdmi or so
I definitly agree that pinctrl should be set in board files :-) .

Heiko
