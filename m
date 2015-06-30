From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Jun 2015 23:07:42 +0200
Subject: [PATCH v2 3/5] ARM: dts: rcm-k1879xb1: Add dts files for
 K1879XB1YA
In-Reply-To: <1435677307-6526-4-git-send-email-andrew@ncrmnt.org>
References: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
 <1435677307-6526-4-git-send-email-andrew@ncrmnt.org>
Message-ID: <2031644.ugW3XV6Cq8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 June 2015 18:15:05 Andrew Andrianov wrote:
> +	memory {
> +		device_type = "memory";
> +		reg = <0x40000000 0x8000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,38400n8 earlyprintk=serial";
> +	};

Can you use earlycon instead?

> +
> +	clocks {
> +			clk_core: clk_core at 324M {
> +				/* Core 324MHz clock. */
> +				compatible = "fixed-factor-clock";
> +				#clock-cells = <0>;
> +				clocks = <&oscillator_27m>;
> +				clock-div = <1>;
> +				clock-mult = <12>;
> +				clock-output-names = "clk_core";
> +			};

Indentation looks wrong.

> +	axi {
> +		compatible = "arm,amba-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0xFFFFFFFF>;
> +
> +		usbehci: ehci at 0x10040000 {
> +			compatible = "generic-ehci";
> +			reg = <0x10040000 0x2000>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <3>; /* 35 */
> +			status = "disabled";
> +		};
> +

Please use standard node names, e.g. "usb" instead of "ehci" and "ohci",
and "serial" instead of "uart".

> +
> +		dvb_ci0: dvb-ci at 10050000 {
> +			compatible = "rcm,mdvbci";
> +			reg = <0x10050000 0x10000>;
> +			interrupts = <37>;
> +		};
> +
> +		xdmac0: xdmac at 10070000 {
> +			compatible = "rcm,xdmac";
> +			reg = <0x10070000 0x10000>;
> +			interrupts = <16 17 18 19 20 21 22 23>;
> +		};

Remove the nodes that don't have an established binding for now.

> +		pinmux: sysconfigh at 0x20033084 {
> +			compatible = "rcm,pinmux";
> +			reg = <0x20033084 0x4>;
> +			reg-names = "controlH";
> +		};

This looks like it's only one register out of a larger area of
random things. Can you use a "syscon" device instead"?

	Arnd
