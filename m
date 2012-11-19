From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 12:18:38 +0100
Subject: [PATCH 0/1] ARM: kirkwood: Convert the mplcec4 board to pinctrl
In-Reply-To: <cover.1353319919.git.s.peter@mpl.ch>
References: <cover.1353319919.git.s.peter@mpl.ch>
Message-ID: <20121119111838.GH10259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:26:44AM +0100, Stefan Peter wrote:
> Hello Andrew
> 
> This is my try to convert the mplcec4 board to your pinctrl patches. The 
> only problem I see is that I get an uart1 using mpp13 and mpp14 which
> are used by the mvsdio driver

Hi Stefan

Interesting.

If you convert the dtb back to a dtc:

dtc -o mplcec4.dts -O dts arch/arm/boot/kirkwood-mplcec4.dtb

you see:

		pinctrl at 10000 {
			compatible = "marvell,88f6281-pinctrl";
			reg = <0x10000 0x20>;
			pinctrl-0 = <0x2 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xa 0xb 0xc 0xd>;
			pinctrl-names = "default";

			pmx-nand {
				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3", "mpp4", "mpp5", "mpp18", "mpp19";
				marvell,function = "nand";
				linux,phandle = <0x2>;
				phandle = <0x2>;
			};

			pmx-sata0 {
				marvell,pins = "mpp35";
				marvell,function = "sata0";
				linux,phandle = <0x6>;
				phandle = <0x6>;
			};

			pmx-sata1 {
				marvell,pins = "mpp34";
				marvell,function = "sata1";
				linux,phandle = <0x7>;
				phandle = <0x7>;
			};

			pmx-spi {
				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
				marvell,function = "spi";
			};

			pmx-twsi0 {
				marvell,pins = "mpp8", "mpp9";
				marvell,function = "twsi0";
			};

			pmx-uart0 {
				marvell,pins = "mpp10", "mpp11";
				marvell,function = "uart0";
				linux,phandle = <0x3>;
				phandle = <0x3>;
			};

			pmx-uart1 {
				marvell,pins = "mpp13", "mpp14";
				marvell,function = "uart1";
			};

			pmx-led-health {
				marvell,pins = "mpp7";
				marvell,function = "gpo";
				linux,phandle = <0x4>;
				phandle = <0x4>;
			};

			pmx-sdio {
				marvell,pins = "mpp12", "mmp13", "mpp14", "mpp15", "mpp16", "mpp17";
				marvell,function = "sdio";
				linux,phandle = <0x5>;
				phandle = <0x5>;
			};

			pmx-led-user1o {
				marvell,pins = "mpp40";
				marvell,function = "gpio";
				linux,phandle = <0x8>;
				phandle = <0x8>;
			};

			pmx-led-user1g {
				marvell,pins = "mpp41";
				marvell,function = "gpio";
				linux,phandle = <0x9>;
				phandle = <0x9>;
			};

			pmx-led-user0o {
				marvell,pins = "mpp44";
				marvell,function = "gpio";
				linux,phandle = <0xa>;
				phandle = <0xa>;
			};

			pmx-led-user0g {
				marvell,pins = "mpp45";
				marvell,function = "gpio";
				linux,phandle = <0xb>;
				phandle = <0xb>;
			};

			pmx-led-misc {
				marvell,pins = "mpp46";
				marvell,function = "gpio";
				linux,phandle = <0xc>;
				phandle = <0xc>;
			};

			pmx-sdio-cd {
				marvell,pins = "mpp47";
				marvell,function = "gpio";
				linux,phandle = <0xd>;
				phandle = <0xd>;
			};
		};
	};

pmx-uart1 has no linux.phandle, and its not listed in 

pinctrl-0 = <0x2 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xa 0xb 0xc 0xd>;

so it should not be used as a pin hog.

So, during boot do you see:

f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 34) is a 16550A

I expect 'no', since:

                serial at 12100 {
                        compatible = "ns16550a";
                        reg = <0x12100 0x100>;
                        reg-shift = <0x2>;
                        interrupts = <0x22>;
                        status = "disabled";
                };

What do you see in /debug/pinctrl/f1010000.pinctrl/pinmux-pins contain?

Since i have a second UART on my board i have:

pin 13 (PIN13): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp13
pin 14 (PIN14): f1010000.pinctrl (GPIO UNCLAIMED) (HOG) function uart1 group mpp14

but i would expect to see function sdio.

Thanks
	Andrew
