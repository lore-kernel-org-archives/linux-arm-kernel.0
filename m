From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 13:41:38 +0200
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <1309945678-18813-2-git-send-email-bs14@csr.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
Message-ID: <201107061341.38591.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Barry Song wrote:
> From: Binghua Duan <binghua.duan@csr.com>
> 
> SiRFprimaII is the latest generation application processor from CSR?s
> Multifunction SoC product family. Designed around an ARM cortex A9 core,
> high-speed memory bus, advanced 3D accelerator and full-HD multi-format
> video decoder, SiRFprimaII is able to meet the needs of complicated
> applications for modern multifunction devices that require heavy concurrent
> applications and fluid user experience. Integrated with GPS baseband,
> analog and PMU, this new platform is designed to provide a cost effective
> solution for Automotive and Consumer markets.
> 
> This patch adds the basic support for this SoC and EVB board based on device
> tree. It is following the ZYNQ of Grant Likely in some degree.
> 
> Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Huayi Li <Huayi.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I think this is good for 3.1, but there are still a few things about
the device tree file could be improved.

> +	axi {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x40000000 0x40000000 0x80000000>;
> +
> +		sirfsoc-iobus {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x40000000 0x40000000 0x80000000>;
> +
> +			l2-cache-controller at 0x80040000 {
> +				compatible = "arm,pl310-cache";
> +				reg = <0x80040000 0x1000>;
> +				interrupts = <59>;
> +			};
> +
> +			intc: interrupt-controller at 0x80020000 {
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +				compatible = "sirf,prima2-intc";
> +				reg = <0x80020000 0x1000>;
> +			};
> +
> +                     sys-iobg {
> +                             compatible = "simple-bus";
> +                             #address-cells = <1>;
> +                             #size-cells = <1>;
> +                             ranges = <0x88000000 0x88000000 0x40000>;
> +
> +                             clock-controller at 0x88000000 {
> +                                     compatible = "sirf,prima2-clkc";
> +                                     reg = <0x88000000 0x1000>;
> +                                     interrupts = <3>;
> +                             };


The axi bus and the sirfsoc-iobus seem to be identical in their scope,
so it's probably enough to model one of them.

I would normally recommend defining the ranges so that addresses are local
to the respective bus, like

	axi {
		ranges = <0 0x40000000 0x80000000>;

		sys-iobg {
			ranges = <0 0x48000000 0x40000>;
                        clock-controller at 0x88000000 {
                               compatible = "sirf,prima2-clkc";
                               reg = <0 0x1000>;
			}

                        reset-controller at 0x88010000 {
                               compatible = "sirf,prima2-rstc";
                               reg = <0x10000 0x1000>;
                        };
		}
	}


> +			disp-iobg {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0x90010000 0x90010000 0x30000>;
> +
> +				display at 0x90010000 {
> +					compatible = "sirf,prima2-lcd";
> +					reg = <0x90010000 0x20000>;
> +					interrupts = <30>;
> +				};
> +
> +				vpp at 0x90020000 {
> +					compatible = "sirf,prima2-vpp";
> +					reg = <0x90020000 0x10000>;
> +					interrupts = <31>;
> +				};
> +			};
> +
> +			graphics-iobg {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0x98000000 0x98000000 0x8000000>;
> +
> +				graphics at 0x98000000 {
> +					compatible = "sirf,prima2-graphics";
> +					reg = <0x98000000 0x8000000>;
> +					interrupts = <6>;
> +				};
> +			};

Are the display and graphics units CSR developments? If the GPU is
in fact licensed from someone else (powervr, arm, ...), you should
probably list the actual name of the device.

> +			multimedia-iobg {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0xa0000000 0xa0000000 0x8000000>;
> +
> +				multimedia at 0xa0000000 {
> +					compatible = "sirf,prima2-multimedia";
> +					reg = <0xa0000000 0x8000000>;
> +					interrupts = <5>;
> +				};
> +			};

"multimedia" sounds like a too generic term. What does this do?

> +				uart0: uart at 0xb0050000 {
> +					cell-index = <0>;
> +					compatible = "sirf,prima2-uart";
> +					reg = <0xb0050000 0x10000>;
> +					interrupts = <17>;
> +				};
> +
> +	 			uart1: uart at 0xb0060000 {
> +					cell-index = <1>;
> +					compatible = "sirf,prima2-uart";
> +					reg = <0xb0060000 0x10000>;
> +					interrupts = <18>;
> +				};
> +
> +	 			uart2: uart at 0xb0070000 {
> +					cell-index = <2>;
> +					compatible = "sirf,prima2-uart";
> +					reg = <0xb0070000 0x10000>;
> +					interrupts = <19>;
> +				};

Are these proprietary uarts, or are they compatible to 8250 and the
like? You might want to set a clock-frequency property as of_serial.c
uses.

> +			rtc-iobg {
> +				compatible = "sirf,prima2-rtciobg", "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0x80030000 0x10000>;
> +
> +				gpsrtc at 0x1000 {
> +					compatible = "sirf,prima2-gpsrtc";
> +					reg = <0x1000 0x1000>;
> +					interrupts = <55 56 57>;
> +				};
> +
> +				sysrtc at 0x2000 {
> +					compatible = "sirf,prima2-sysrtc";
> +					reg = <0x2000 0x1000>;
> +					interrupts = <52 53 54>;
> +				};
> +
> +				pwrc at 0x3000 {
> +					compatible = "sirf,prima2-pwrc";
> +					reg = <0x3000 0x1000>;
> +					interrupts = <32>;
> +				};
> +			};

Are these rtc implementations related? From the register layout, I would
guess that they are supposed to be used by the same driver, so it's
probably a good idea to add a "compatible" property with a common name
for all three.

> +			uus-iobg {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0xb8000000 0xb8000000 0x40000>;
> +
> +	 			usb0: usb at 0xb00E0000 {
> +					compatible = "sirf,prima2-usb";
> +					reg = <0xb8000000 0x10000>;
> +					interrupts = <10>;
> +				};
> +
> +	 			usb1: usb at 0xb00f0000 {
> +					compatible = "sirf,prima2-usb";
> +					reg = <0xb8010000 0x10000>;
> +					interrupts = <11>;
> +				};

Is the usb implementation compatible to an existing one? Many SoCs
use one of ehci, ohci or musb. If that's the case, you should look
at the respective bindings.

> +				sata at 0xb00f0000 {
> +					compatible = "sirf,prima2-sata";
> +					reg = <0xb8020000 0x10000>;
> +					interrupts = <37>;
> +				};

Same thing here. Most sata controllers are compatible to some
standard implementation.

> +				security at 0xb00f0000 {
> +					compatible = "sirf,prima2-security";
> +					reg = <0xb8030000 0x10000>;
> +					interrupts = <42>;
> +				};
> +			};
> +		};
> +	};
> +};

	Arnd
