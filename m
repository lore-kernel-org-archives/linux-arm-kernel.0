From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Tue, 02 Aug 2016 17:08:30 +0200
Subject: mxs-mmc 80014000.ssp: mxs_mmc_probe: failed to request dma
Message-ID: <1470150510.13930.16.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying set up a custom i.MX28 board with an BCM43362 wifi chip
connected over the SDIO interface to SSP2 using "mmc-pwrseq".

The MCU toggles the power to the wifi chip with GPIO 1,16 with is
connected to an external 3.9V regulator which provides the power for
the chip.

Furthermore, the CPU is directly connected to the wifi chip via GPIO
1,17 to the WL_RST_N.

This is a snippet of the device tree, which shoud be okay so far:

/ {
	regulators {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;

		reg_wlan: regulator-wlan {
			pinctrl-names = "default";
			pinctrl-0 = <&pinctrl_reg_wlan>;
			compatible = "regulator-fixed";
			regulator-name = "regulator-wlan";
			regulator-min-microvolt = <3300000>;
			regulator-max-microvolt = <3300000>;
			startup-delay-us = <70000>;
			gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;
			enable-active-high;
		};
	};

	ssp2_pwrseq: ssp2-pwrseq {
		compatible = "mmc-pwrseq-simple";
		reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
	};
};

&ssp2 {
	compatible = "fsl,imx28-mmc";
	pinctrl-names = "default";
	pinctrl-0 = <&ssp2_4bit_pins_a &ssp2_sck_cfg>;
	bus-width = <4>;
	vmmc-supply = <&reg_wlan>;
	mmc-pwrseq = <&ssp2_pwrseq>;
	non-removable;
	status = "okay";

	brcmf: bcrmf at 1 {
		reg = <1>;
		compatible = "brcm,bcm4329-fmac";
	};
};

However, when booting the device the following error message is shown
and the wifi chip is not ready:

mxs-mmc 80014000.ssp: mxs_mmc_probe: failed to request dma

Note, that the wifi chip works if I do the GPIO handling in the
bootloader.

Any ideas what's missing here?

Best regards
J?rg Krause
