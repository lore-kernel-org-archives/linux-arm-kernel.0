From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Thu, 21 Jun 2018 15:42:00 -0300
Subject: [PATCH] arm64: dts: rockchip: add 96boards RK3399 Ficus board
In-Reply-To: <1621532.NjQG3041Bx@phil>
References: <20180618220804.18468-1-ezequiel@collabora.com>
 <1621532.NjQG3041Bx@phil>
Message-ID: <64a5bb5856d4115a313be81de2803a99cbaecae4.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-21 at 15:27 +0200, Heiko Stuebner wrote:
> Hi Ezequiel,
> 
> Am Dienstag, 19. Juni 2018, 00:08:04 CEST schrieb Ezequiel Garcia:
> > The RK3399 Ficus board is an Enterprise Edition board
> > manufactured by Vamrs Ltd., based on the Rockchip RK3399 SoC.
> > 
> > The board exposes a bunch of nice peripherals, including
> > SATA, HDMI, MIPI CSI, Ethernet, WiFi, USB 2.0, USB 3.0
> > and PCIe.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> > I am not including USB support because I cannot seem
> > to make it work.
> > 
> > [    1.677293] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
> > [    1.677937] dwc3 fe800000.dwc3: Configuration mismatch. dr_mode
> > forced to host
> > [    1.678602] dwc3 fe800000.dwc3: failed to initialize core
> > [    1.679409] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2
> > [    1.679988] dwc3 fe900000.dwc3: failed to initialize core
> > 
> > I am under the impression it is related to:
> > 
> > commit fe8abf332b8f66868013cfcd6bfe727136a2ab5f
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Wed May 16 11:41:07 2018 +0900
> > 
> >     usb: dwc3: support clocks and resets for DWC3 core
> > 
> > Any ideas? Would like to sort out the USB issue before
> > merging.
> 
> From what I remember, we had an issue with usb ports not providing
> an extcon to the typc-c phys, making the dwc3 fail to probe.
> Enric did a nice patch adding support for extcon-less type-c phys in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co
> mmit/?id=ec1fcd7b7e6f50dd6e259ca76c6e41e2346b3afe
> 
> So maybe the kernel you were working on was just to old?
> 

I was working on top of next-20180618, quite new :).
However, at least that is a nice hint for me to chase.

> 
> > Also, I should probably split the rk3399.dtsi change.
> 
> correct :-D
> 
> 
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 564
> > ++++++++++++++++++
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |   9 +
> >  3 files changed, 574 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> 
> Please also add an entry to
> Documentation/devicetree/bindings/arm/rockchip.txt
> 

Got it.

> 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > new file mode 100644
> > index 000000000000..17471b4b7a14
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > @@ -0,0 +1,564 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2018 Collabora Ltd.
> > + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3399.dtsi"
> > +#include "rk3399-opp.dtsi"
> > +
> > +/ {
> > +	model = "96boards RK3399 Ficus";
> > +	compatible = "vamrs,ficus", "rockchip,rk3399";
> > +
> > +	chosen {
> > +		stdout-path = "serial2:1500000n8";
> > +	};
> > +
> > +	clkin_gmac: external-gmac-clock {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <125000000>;
> > +		clock-output-names = "clkin_gmac";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	usb_typec_vbus: usb-typec-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "typec-vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> > +	};
> > +
> > +	vcc1v8_s0: vcc1v8-s0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc1v8_s0";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	vcc_sys: vcc-sys {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_sys";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	vcc_phy: vcc-phy-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_phy";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> 
> please try to double-check the regulator setup with the schematics.
> 
> Like this completely unconnected vcc_phy regulator is normally copy-
> pasted
> from Rockchip's default board-dt and never matches the actual power-
> tree.
> 

Yeah, regulators need another look.

> Schematics seem to a at
> 	https://www.96boards.org/documentation/consumer/rock960/hardwar
> e-docs/
> and there doesn't even seem to be network interface on the board?
> 

You are looking at a consumer edition board, and this is
the enterprise edition (aka ficus). It has network :)

Here's a nice video where Tom talks about it:

https://youtu.be/2UYcmhbKyP4

FWIW, I have tested mainline U-Boot and Linux. Gigabit network
and mmc tested on both. Also, this board is where I found the
iommu/vpu stall you fixed recently.

Haven't test SATA, but I will soon.

> Also please use regulator names as defined in the schematics.
> 
> 
> This applies to all regulators defined here. I'd really like to see a
> real
> supply-tree with regulators connected to their supplies.
> 
> See for example the rk3399-gru boards for an example :-)
> And you can also check $DEBUGFS/regulator/regulator_summary
> which should form a nice tree structure if everything is correct.
> 
> 
> > +&gmac {
> > +	assigned-clocks = <&cru SCLK_RMII_SRC>;
> > +	assigned-clock-parents = <&clkin_gmac>;
> > +	clock_in_out = "input";
> > +	phy-supply = <&vcc_phy>;
> > +	phy-mode = "rgmii";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&rgmii_pins>;
> > +	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> > +	snps,reset-active-low;
> > +	snps,reset-delays-us = <0 10000 50000>;
> > +	tx_delay = <0x28>;
> > +	rx_delay = <0x11>;
> > +	status = "okay";
> > +};
> 
> Looking at the 96boards page, there is no gmac on the board at all?
> 
> 
> > +	fusb0: fusb30x at 22 {
> 
> node name should be generic ... typec at 22 or something like that
> 

OK.

> 
> 
> > +		vbus-supply = <&usb_typec_vbus>;
> > +		compatible = "fairchild,fusb302";
> > +		reg = <0x22>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&fusb0_int>;
> > +		int-n-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> > +		status = "okay";
> 
> Please do
> - compatible
> - reg
> - interrupts
> [alphabetical]
> - status
> for properties.
> 
> Again applies to everything.
> 

OK, thanks for the review.

Regards,
Eze
