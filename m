From: antony@phenome.org (Antony Antony)
Date: Fri, 1 Sep 2017 12:53:13 +0200
Subject: [PATCH v5] arm64: allwinner: h5: add support for NanoPi NEO Plus2
In-Reply-To: <20170831145859.rief3fqo36ns23rm@flea>
References: <20170824231716.2623-1-antony@phenome.org>
 <20170830125057.38529-1-antony@phenome.org>
 <20170831145859.rief3fqo36ns23rm@flea>
Message-ID: <20170901105313.m26y2re3ulskua43@AntonyAntony.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime

Thanks for the review. I will send a PATCH v6 soon.

On Thu, Aug 31, 2017 at 04:58:59PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Aug 30, 2017 at 02:50:57PM +0200, Antony Antony wrote:
> > 	Add initial DT support for NanoPi NEO Plus2 by FriendlyARM
> > 		Allwinner quad core H5 Cortex A53 with an ARM Mali-450MP GPU
> > 		1 GB DDR3 RAM
> > 		8GB eMMC flash (Samsung KLM8G1WEPD-B031)
> > 		micro SD card slot
> > 		Gigabit Ethernet (external RTL8211E-VB-CG chip)
> > 		802.11 b/g/n WiFi, Bluetooth 4.0 (Ampak AP6212A module)
> > 		2x USB 2.0 host ports & 2x USB via headers
> 
> This indendation is weird

I will fix it.

> >     The DTS is based on OrangePi PC 2, sun50i-h5-orangepi-pc2
> >     Added dwmac-sun8i Gigabit Ethernet support based on
> >     Nano Pi Neo2 DT and the schematics.
> 
> And that's outdated.

Now I am glad to delete it.

> > +	wifi_pwrseq: wifi_pwrseq {
> > +		compatible = "mmc-pwrseq-simple";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&wifi_en_npi>;
> > +		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> > +		post-power-on-delay-ms = <200>;
> > +	};
> 
> You should order these nodes alphabetically.

good point I did.

> > +&codec {
> > +	allwinner,audio-routing =
> > +		"Line Out", "LINEOUT",
> > +		"MIC1", "Mic",
> > +		"Mic",  "MBIAS";
> > +	status = "okay";
> > +};
> > +
> > +&ehci0 {
> > +	status = "okay";
> > +};
> > +
> > +&ehci3 {
> > +	status = "okay";
> > +};
> > +
> > +&emac {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&emac_rgmii_pins>;
> > +	phy-supply = <&reg_gmac_3v3>;
> > +	phy-handle = <&ext_rgmii_phy>;
> > +	phy-mode = "rgmii";
> > +	status = "okay";
> > +};
> > +
> > +&mdio {
> > +	ext_rgmii_phy: ethernet-phy at 7 {
> > +		compatible = "ethernet-phy-ieee802.3-c22";
> > +		reg = <7>;
> > +	};
> > +};
> 
> This will not compile.

I don't understand you, because, v5 file compiled for me. Here is output 
from running system, just the relevant part.  using dtc -I fs 
/proc/device-tree

ext_rgmii_phy = "/soc/ethernet at 1c30000/mdio/ethernet-phy at 7";

ethernet at 1c30000 {
	mdio {
	..
		ethernet-phy at 7 {
			compatible = "ethernet-phy-ieee802.3-c22";
			phandle = <0x1c>;
			reg = <0x7>;
			linux,phandle = <0x1c>;
		};
};

Is this what you expect?

> > +&mmc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins_a>;
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	vqmmc-supply = <&reg_vcc3v3>;
> > +	mmc-pwrseq = <&wifi_pwrseq>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	boot_device = <0>;
> 
> This property is not documented anywhere, I'm not sure what it's here
> for.

boot_device is deleted. A u-boot property got mixed up in kernel DT.
 
> > +	status = "okay";
> > +
> > +	/*
> > +	 * AMPAK AP6212A WiFi module with BCM43430, rev=1 inside
> > +	 * sdio vendor ID: 0x02d0, sdio device ID: 0xa9a6
> > +	 * There is no specific Documentation: dt-binding for BCM43430
> > +	 * brcm,bcm4329-fmac compatible can initialize this module
> > +	 */
> 
> This is not really relevant.

would you prefer no comment or a rewrite? How does this look?

/*
 * AMPAK AP6212A WiFi module with BCM43430, rev=1 inside
 * sdio vendor ID: 0x02d0, sdio device ID: 0xa9a6
 */

I am afraid a casual reader would think "brcm,bcm4329-fmac" is wrong, 
because that is not the actual chip inside the module.

> > +	brcmf: wifi at 1 {
> > +		reg = <1>;
> > +		compatible = "brcm,bcm4329-fmac";
> > +	};
> > +};
> > +

> > +&mmc2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc2_8bit_pins>;
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	bus-width = <8>;
> > +	non-removable;
> > +	cap-mmc-hw-reset;
> > +	boot_device = <0>;
> > +	status = "okay";
> > +};
> > +
> > +&mmc2_8bit_pins {
> > +	/* Increase drive strength for DDR modes */
> > +	drive-strength = <40>;
> 
> It's very likely that you actually don't need 40mA

drive-strength and the node mmc2_8bit_pins are gone. When I removed it 
drive-strength = <0x1e>;  seems the default. And eMMC seems to work when 
booting from Micro SD.

NOTE: the  40mA came from a vresion of vendor's old dts file and I also 
noticed the same value is used in other dts in kernel e.g 
sun8i-h3-orangepi-plus.dts, sun9i-a80-cubieboard4.dts
It could be a copy paste error or those boards need it. Anyway I removed it.

> > +	/* eMMC is missing pull-ups */
> > +	bias-pull-up;
> > +};
> 
> And that one is already here by default.

good, deleteed.

> 
> > +&ohci0 {
> > +	status = "okay";
> > +};
> > +
> > +&ohci3 {
> > +	status = "okay";
> > +};
> > +
> > +&pio {
> > +	leds_npi: led_pins at 0 {
> > +		pins = "PA10";
> > +		function = "gpio_out";
> > +	};
> > +	gmac_power_pin_nanopi: gmac_power_pin at 0 {
> > +			pins = "PD6";
> > +			function = "gpio_out";
> > +	};
> > +};
> 
> You don't need these nodes


&pio { } and gmac_power_pin_nanopi{} are deleted.
along with
pinctrl-0 = <&gmac_power_pin_nanopi>; 

> > +
> > +&r_pio {
> > +	leds_r_npi: led_pins at 0 {
> > +		pins = "PL10";
> > +		function = "gpio_out";
> > +	};
> > +
> > +	vdd_cpux_r_npi: regulator_pins at 0 {
> > +		allwinner,pins = "PL6";
> > +		allwinner,function = "gpio_out";
> > +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +	};
> > +
> > +	wifi_en_npi: wifi_en_pin {
> > +		pins = "PL7";
> > +		function = "gpio_out";
> > +	};
> > +};
> 
> Or those.

deleted wifi_en_npi.
> 
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_pins_a>;
> > +	status = "okay";
> > +};
> > +
> > +&usb_otg {
> > +	dr_mode = "host";
> > +	status = "okay";
> > +};
> > +
> > +&usbphy {
> > +	/* USB Type-A ports' VBUS is always on */
> > +	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> 
> If it has an ID-detect pin, then it's not a host-only USB OTG
> controller. dr_mode should be set to otga 

good point. I don't see an ID-detect connected in the schematic. The 
previous generation had. 

I will leave 
&usb_otg {
  dr_mode = "host";
  status = "okay";
};

&usbphy {
	/* USB Type-A ports' VBUS is always on */
	status = "okay";
};

Wow, a nice cleanup.

I am surprised defaults works well and thanks for pointing these out.

-antony
