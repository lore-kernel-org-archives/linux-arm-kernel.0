From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Oct 2013 05:19:03 -0700
Subject: linux-next: manual merge of the arm-soc tree
In-Reply-To: <1382454649-16442-4-git-send-email-treding@nvidia.com>
References: <1382369814-7582-1-git-send-email-treding@nvidia.com>
 <1382454649-16442-1-git-send-email-treding@nvidia.com>
 <1382454649-16442-4-git-send-email-treding@nvidia.com>
Message-ID: <20131023121903.GT15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding <thierry.reding@gmail.com> [131022 08:13]:
> Today's linux-next merge of the arm-soc tree got a conflict in
> 
> 	arch/arm/boot/dts/omap3-evm.dts
> 
> caused by commits 975d963 (ARM: dts: omap: update usb_otg_hs data) and
> 465ce68 (ARM: dts: Add common support for omap3-evm).
> 
> I fixed it up (see below). Please verify that the resolution looks good.
> Note that the resolution adds the phys and phy-names properties in the
> usb_otg_hs node to complement the common omap3-evm DTSI introduced in
> 465ce68 with the changes done in 975d963.

Sigh there was no conflict in sight when I acked patch "ARM: dts: Add common
support for omap3-evm", then I created the omap3-evm-common.dtsi not
remembering about the earlier patch. So a totally self-inflicted merge
conflict again and more proof that the dts files need to be always
merged seprately from the drivers.

The merge conflict below looks correct thanks.

Regards,

Tony
 
> diff --cc arch/arm/boot/dts/omap3-evm-common.dtsi
> index 0000000,b549329..3007e79
> mode 000000,100644..100644
> --- a/arch/arm/boot/dts/omap3-evm-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
> @@@ -1,0 -1,94 +1,96 @@@
> + /*
> +  * Common support for omap3 EVM boards
> +  */
> + 
> + #include "omap-gpmc-smsc911x.dtsi"
> + 
> + / {
> + 	cpus {
> + 		cpu at 0 {
> + 			cpu0-supply = <&vcc>;
> + 		};
> + 	};
> + 
> + 	leds {
> + 		compatible = "gpio-leds";
> + 		ledb {
> + 			label = "omap3evm::ledb";
> + 			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
> + 			linux,default-trigger = "default-on";
> + 		};
> + 	};
> + 
> + 	wl12xx_vmmc: wl12xx_vmmc {
> + 		compatible = "regulator-fixed";
> + 		regulator-name = "vwl1271";
> + 		regulator-min-microvolt = <1800000>;
> + 		regulator-max-microvolt = <1800000>;
> + 		gpio = <&gpio5 22 0>;	/* gpio150 */
> + 		startup-delay-us = <70000>;
> + 		enable-active-high;
> + 		vin-supply = <&vmmc2>;
> + 	};
> + };
> + 
> + &i2c1 {
> + 	clock-frequency = <2600000>;
> + 
> + 	twl: twl at 48 {
> + 		reg = <0x48>;
> + 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> + 		interrupt-parent = <&intc>;
> + 	};
> + };
> + 
> + #include "twl4030.dtsi"
> + #include "twl4030_omap3.dtsi"
> + 
> + &i2c2 {
> + 	clock-frequency = <400000>;
> + };
> + 
> + &i2c3 {
> + 	clock-frequency = <400000>;
> + 
> + 	/*
> + 	 * TVP5146 Video decoder-in for analog input support.
> + 	 */
> + 	tvp5146 at 5c {
> + 		compatible = "ti,tvp5146m2";
> + 		reg = <0x5c>;
> + 	};
> + };
> + 
> + &mmc1 {
> + 	vmmc-supply = <&vmmc1>;
> + 	vmmc_aux-supply = <&vsim>;
> + 	bus-width = <8>;
> + };
> + 
> + &mmc2 {
> + 	vmmc-supply = <&wl12xx_vmmc>;
> + 	non-removable;
> + 	bus-width = <4>;
> + 	cap-power-off-card;
> + };
> + 
> + &twl_gpio {
> + 	ti,use-leds;
> + };
> + 
> + &usb_otg_hs {
> + 	interface-type = <0>;
> + 	usb-phy = <&usb2_phy>;
> ++	phys = <&usb2_phy>;
> ++	phy-names = "usb2-phy";
> + 	mode = <3>;
> + 	power = <50>;
> + };
> + 
> + &gpmc {
> + 	ethernet at gpmc {
> + 		interrupt-parent = <&gpio6>;
> + 		interrupts = <16 8>;
> + 		reg = <5 0 0xff>;
> + 	};
> + };
