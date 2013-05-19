From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 May 2013 08:01:52 +0200
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <5197D6C1.3060702@gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
 <CAF6AEGtx7RbvKEEc5uSFvz-2uveB1cnJNf_ESn6JYhfte5UmZQ@mail.gmail.com>
 <20130518205845.2dfe9fe5@armhf> <5197D6C1.3060702@gmail.com>
Message-ID: <20130519080152.0b486b75@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 May 2013 21:30:09 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> So in the end, we will have a DT node for the HW controllers found
> in Dove SoCs, a node for TDA998x, and a node for the video card, i.e.
> _how_ lcd controllers, external encoders, clocks, maybe audio, ...
> are hooked up on that specific board.

Here is my dove-cubox.dts. What is wrong with it?

/dts-v1/;

/include/ "dove.dtsi"

/ {
	model = "SolidRun CuBox";
	compatible = "solidrun,cubox", "marvell,dove";

	memory {
		device_type = "memory";
		reg = <0x00000000 0x40000000>;
	};

	chosen {
		bootargs = "console=ttyS0,115200n8 earlyprintk";
	};

	leds {
		compatible = "gpio-leds";
		pinctrl-0 = <&pmx_gpio_18>;
		pinctrl-names = "default";

		power {
			label = "Power";
			gpios = <&gpio0 18 1>;
			linux,default-trigger = "default-on";
		};
	};

	regulators {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;

		usb_power: regulator at 1 {
			compatible = "regulator-fixed";
			reg = <1>;
			regulator-name = "USB Power";
			regulator-min-microvolt = <5000000>;
			regulator-max-microvolt = <5000000>;
			enable-active-high;
			regulator-always-on;
			regulator-boot-on;
			gpio = <&gpio0 1 0>;
		};
	};

	clocks {
		/* 25MHz reference crystal */
		ref25: oscillator {
			compatible = "fixed-clock";
			#clock-cells = <0>;
			clock-frequency = <25000000>;
		};

		lcdclk: fixed-clock {
			compatible = "fixed-clock";
			#clock-cells = <0>;
			clock-frequency = <400000000>;
		};
	};

	audio {
		compatible = "marvell,kirkwood-spdif-audio";
		id = <1>;
	};

	video {
		compatible = "marvell,dove-video";
	};
};

&uart0 { status = "okay"; };
&sata0 { status = "okay"; };
&i2c0 {
	status = "okay";
	clock-frequency = <100000>;

	si5351: clock-generator {
		compatible = "silabs,si5351a-msop";
		reg = <0x60>;
		#address-cells = <1>;
		#size-cells = <0>;
		#clock-cells = <1>;

		/* connect xtal input to 25MHz reference */
		clocks = <&ref25>;

		/* connect xtal input as source of pll0 and pll1 */
		silabs,pll-source = <0 0>, <1 0>;

		clkout0 {
			reg = <0>;
			silabs,drive-strength = <8>;
			silabs,multisynth-source = <0>;
			silabs,clock-source = <0>;
			silabs,pll-master;
		};

		clkout1 {
			reg = <1>;
			silabs,drive-strength = <8>;
			silabs,multisynth-source = <1>;
			silabs,clock-source = <0>;
			silabs,pll-master;
		};

		clkout2 {
			reg = <2>;
			silabs,multisynth-source = <1>;
			silabs,clock-source = <0>;
		};
	};

	tda998x: hdmi-encoder {
		compatible = "nxp,tda998x";
		reg = <0x70>;
		interrupt-parent = <&gpio0>;
		interrupts = <27 2>;		/* falling edge */
	};
};

&sdio0 {
	status = "okay";
	/* sdio0 card detect is connected to wrong pin on CuBox */
	cd-gpios = <&gpio0 12 1>;
};

&spi0 {
	status = "okay";

	/* spi0.0: 4M Flash Winbond W25Q32BV */
	spi-flash at 0 {
		compatible = "st,w25q32";
		spi-max-frequency = <20000000>;
		reg = <0>;
	};
};

&pinctrl {
	pinctrl-0 = <&pmx_gpio_1 &pmx_gpio_12 &pmx_gpio_13 &pmx_gpio_camera>;
	pinctrl-names = "default";

	pmx_gpio_1: pmx-gpio-1 {
		marvell,pins = "mpp1";
		marvell,function = "gpio";
	};

	pmx_gpio_12: pmx-gpio-12 {
		marvell,pins = "mpp12";
		marvell,function = "gpio";
	};

/* kirkwood i2s */
	pmx_gpio_13: pmx-gpio-13 {
		marvell,pins = "mpp13";
		marvell,function = "gpio";
	};

	pmx_gpio_18: pmx-gpio-18 {
		marvell,pins = "mpp18";
		marvell,function = "gpio";
	};
/* nxp HDMI irq on pin 27 */
	pmx_gpio_camera: pmx-gpio-camera {
		marvell,pins = "mpp_camera";
		marvell,function = "gpio";
	};
};

&mdio { status = "okay"; };
&ethernet { status = "okay"; };
&lcd0 {
	status = "okay";
	clocks = <&core_clk 3>, <0>, <&lcdclk>, <&si5351 0>;
	marvell,port-type = <11>;		/* HDMIA */
	marvell,external-encoder = <&tda998x>;
};

&i2s1 { status = "okay"; };

/* --- test (not cubox) ---- *
&dcon { status = "okay"; };

&lcd1 {
	status = "okay";
	clocks = <&core_clk 3>, <0>, <&lcdclk>, <0>;
	marvell,port-type = <1>;
	display-timings {
		mode {
			hactive = <1920>;
			vactive = <1080>;
			hfront-porch = <88>;
			hsync-len = <44>;
			hback-porch = <148>;
			vfront-porch = <4>;
			vsync-len = <5>;
			vback-porch = <36>;
			clock = <148500>;
		};
	};
};
 * ---- */

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
