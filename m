From: sr@denx.de (Stefan Roese)
Date: Fri, 16 Mar 2012 13:20:25 +0100
Subject: [PATCH v4] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <20120316115022.GF7757@game.jcrosoft.org>
References: <1331890216-8361-1-git-send-email-sr@denx.de>
 <20120316115022.GF7757@game.jcrosoft.org>
Message-ID: <201203161320.25873.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012 12:50:22 Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:30 Fri 16 Mar     , Stefan Roese wrote:
> > This patch adds a generic target for SPEAr600 board that can be
> > configured via the device-tree. Currently the following devices
> > are supported via the devicetree:
> > 
> > - VIC interrupts
> > - PL011 UART
> > - PL061 GPIO
> > - Synopsys DW I2C
> > - Synopsys DW ethernet
> > 
> > Other peripheral devices (e.g. SMI flash, FSMC NAND flash etc) will
> > follow in later patches.
> 
> so drop USB, nand & co from the dtsi
> 
> this will be add later when the binding will documentated and Acked

Okay. As I described in an earlier mail, I included those devices upon Arnd's 
request. But I'll drop them for now in a new patch version.
 
> > Only the spear600-evb is currently supported. Other SPEAr600
> > based boards will follow later.
> > 
> > Since the current mainline SPEAr600 code only supports the SPEAr600
> > evaluation board, with nearly zero peripheral devices (only UART
> > and GPIO), it makes sense to switch over to DT based configuration
> > completely now. So this patch also removes all non-DT stuff, mainly
> > platform device data. The files spear600.c and spear600_evb.c are
> > removed completely.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Cc: Viresh Kumar <viresh.kumar@st.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> > v4:
> > - Added memory node to all dts/dtsi files
> > - Reorganizes bus topology in the dtsi file, to match the
> > 
> >   real SoC layout
> > 
> > v3:
> > - Removed non-DT SPEAr600 board support completely
> > - Removed OF_DEV_AUXDATA and changed clkdev instead, since we
> > 
> >   don't support non-DT targets any more
> > 
> > - Changed gmac0 -> gmac etc for single instance devices in the
> > 
> >   dts
> > 
> > - Added max memory size to memory node (instead of 0)
> > - Dropped mac-address property
> > - Removed some headers from spear6xx.c
> > 
> > v2:
> > - Added DT support to spear6xx.c instead of creating board-dt.c
> > - Removed UART (PL011) and GPIO (PL061) platform data for
> > 
> >   devicetree board port. This works now via DT probing
> > 
> > - Added OF_DEV_AUXDATA for clock device name matching for some
> > 
> >   device drivers
> > 
> > - Removed sper600.c file completely
> > - Added DW I2C and ethernet nodes to the dts files
> > - Added other DT nodes (SMI, FSMC, ECHI, OHCI), currently disabled
> > 
> >   since the corresponding device drivers don't support DT probing
> > 
> > - Removed Linaro/FSL copyright notice from SPEAr DT files (copy-paste
> > cruft) - Many smaller modification to the dts/dtsi files
> > - Changed Documentation/devicetree/bindings/arm/spear.txt to match
> > 
> >   the changed bindings
> >  
> >  Documentation/devicetree/bindings/arm/spear.txt |    8 ++
> >  arch/arm/boot/dts/spear600-evb.dts              |   37 +++++
> >  arch/arm/boot/dts/spear600.dtsi                 |  170
> >  +++++++++++++++++++++++ arch/arm/mach-spear6xx/Kconfig                 
> >  |    7 +-
> >  arch/arm/mach-spear6xx/Makefile                 |    6 -
> >  arch/arm/mach-spear6xx/clock.c                  |   14 +-
> >  arch/arm/mach-spear6xx/spear600.c               |   25 ----
> >  arch/arm/mach-spear6xx/spear600_evb.c           |   54 -------
> >  arch/arm/mach-spear6xx/spear6xx.c               |  132
> >  +++++------------- 9 files changed, 262 insertions(+), 191 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/spear.txt
> >  create mode 100644 arch/arm/boot/dts/spear600-evb.dts
> >  create mode 100644 arch/arm/boot/dts/spear600.dtsi
> >  delete mode 100644 arch/arm/mach-spear6xx/spear600.c
> >  delete mode 100644 arch/arm/mach-spear6xx/spear600_evb.c
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/spear.txt
> > b/Documentation/devicetree/bindings/arm/spear.txt new file mode 100644
> > index 0000000..f8e54f0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/spear.txt
> > @@ -0,0 +1,8 @@
> > +ST SPEAr Platforms Device Tree Bindings
> > +---------------------------------------
> > +
> > +Boards with the ST SPEAr600 SoC shall have the following properties:
> > +
> > +Required root node property:
> > +
> > +compatible = "st,spear600";
> > diff --git a/arch/arm/boot/dts/spear600-evb.dts
> > b/arch/arm/boot/dts/spear600-evb.dts new file mode 100644
> > index 0000000..bf706b2
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/spear600-evb.dts
> > @@ -0,0 +1,37 @@
> > +/*
> > + * Copyright 2012 Stefan Roese <sr@denx.de>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +/dts-v1/;
> > +/include/ "spear600.dtsi"
> > +
> > +/ {
> > +	model = "ST SPEAr600 Evaluation Board";
> > +	compatible = "st,spear600-evb", "st,spear600";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0 0x10000000>;
> > +	};
> > +
> > +	ahb {
> > +		gmac: ethernet at e0800000 {
> > +			phy-mode = "gmii";
> > +		};
> > +
> > +		apb {
> > +			i2c at d0200000 {
> > +				clock-frequency = <400000>;
> 
> disable everything not core is good in the dtsi
> so board enable what they need and do not get surprised whe updating the
> dtsi
> 
> but you need to consistant

Let me check, if I understand you correctly. I should disable all peripheral 
devices in the *.dtsi file?  All devices? Also interrupt controller? Is this 
common practice? I don't see it in other dtsi file (e.g. omap4/tegra).

> > +			};
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/boot/dts/spear600.dtsi
> > b/arch/arm/boot/dts/spear600.dtsi new file mode 100644
> > index 0000000..cf14762
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/spear600.dtsi
> > @@ -0,0 +1,170 @@
> > +/*
> > + * Copyright 2012 Stefan Roese <sr@denx.de>
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	compatible = "st,spear600";
> > +
> > +	cpus {
> > +		cpu at 0 {
> > +			compatible = "arm,arm926ejs";
> > +		};
> > +	};
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0 0x40000000>;
> > +	};
> > +
> > +	ahb {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "simple-bus";
> > +		ranges;
> > +
> > +		vic0: interrupt-controller at f1100000 {
> > +			compatible = "arm,pl190-vic";
> > +			interrupt-controller;
> > +			reg = <0xf1100000 0x1000>;
> > +			#interrupt-cells = <1>;
> > +		};
> > +
> > +		vic1: interrupt-controller at f1000000 {
> > +			compatible = "arm,pl190-vic";
> > +			interrupt-controller;
> > +			reg = <0xf1000000 0x1000>;
> > +			#interrupt-cells = <1>;
> > +		};
> > +
> > +		gmac: ethernet at e0800000 {
> > +			compatible = "st,spear600-gmac";
> > +			reg = <0xe0800000 0x8000>;
> > +			interrupt-parent = <&vic1>;
> > +			interrupts = <24 23>;
> > +			interrupt-names = "macirq", "eth_wake_irq";
> > +		};
> > +
> > +		fsmc: flash at d1800000 {
> > +			status = "disabled";
> > +			compatible = "st,spear600-fsmc-nand";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0xd1800000 0x1000	/* FSMC Register */
> > +			       0xd2000000 0x4000>;	/* NAND Base */
> > +			reg-names = "fsmc_regs", "nand_data";
> > +			st,ale-off = <0x20000>;
> > +			st,cle-off = <0x10000>;
> > +		};
> > +
> > +		smi: flash at fc000000 {
> > +			status = "disabled";
> > +			compatible = "st,spear600-smi";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0xfc000000 0x1000>;
> > +			interrupt-parent = <&vic1>;
> > +			interrupts = <12>;
> > +		};
> > +
> > +		ehci at e1800000 {
> > +			status = "disabled";
> > +			compatible = "st,spear600-ehci", "usb-ehci";
> > +			reg = <0xe1800000 0x1000>;
> > +			interrupt-parent = <&vic1>;
> > +			interrupts = <27>;
> > +		};
> > +
> > +		ehci at e2000000 {
> > +			status = "disabled";
> > +			compatible = "st,spear600-ehci", "usb-ehci";
> > +			reg = <0xe2000000 0x1000>;
> > +			interrupt-parent = <&vic1>;
> > +			interrupts = <29>;
> > +		};
> > +
> > +		ohci at e1900000 {
> > +			status = "disabled";
> > +			compatible = "st,spear600-ohci", "usb-ohci";
> > +			reg = <0xe1900000 0x1000>;
> > +			interrupt-parent = <&vic1>;
> > +			interrupts = <26>;
> > +		};
> > +
> > +		ohci at e2100000 {
> > +			status = "disabled";
> > +			compatible = "st,spear600-ohci", "usb-ohci";
> > +			reg = <0xe2100000 0x1000>;
> > +			interrupt-parent = <&vic1>;
> > +			interrupts = <28>;
> > +		};
> > +
> > +		apb {
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "simple-bus";
> > +			ranges;
> > +
> > +			serial at d0000000 {
> > +				compatible = "arm,pl011", "arm,primecell";
> > +				reg = <0xd0000000 0x1000>;
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <24>;
> > +			};
> > +
> > +			serial at d0080000 {
> > +				compatible = "arm,pl011", "arm,primecell";
> > +				reg = <0xd0080000 0x1000>;
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <25>;
> > +			};
> > +
> > +			/* local/cpu GPIO */
> > +			gpio0: gpio at f0100000 {
> > +				#gpio-cells = <2>;
> > +				compatible = "arm,pl061", "arm,primecell";
> > +				gpio-controller;
> > +				reg = <0xf0100000 0x1000>;
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <18>;
> > +			};
> > +
> > +			/* basic GPIO */
> > +			gpio1: gpio at fc980000 {
> 
> on ST SoC the gpio are usally called pio so pio0

Not on SPEAr600 as far as I can tell.
 
> > +				#gpio-cells = <2>;
> > +				compatible = "arm,pl061", "arm,primecell";
> > +				gpio-controller;
> > +				reg = <0xfc980000 0x1000>;
> > +				interrupt-parent = <&vic1>;
> > +				interrupts = <19>;
> > +			};
> > +
> > +			/* appl GPIO */
> > +			gpio2: gpio at d8100000 {
> > +				#gpio-cells = <2>;
> > +				compatible = "arm,pl061", "arm,primecell";
> > +				gpio-controller;
> > +				reg = <0xd8100000 0x1000>;
> > +				interrupt-parent = <&vic1>;
> > +				interrupts = <4>;
> > +			};
> > +
> > +			i2c at d0200000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "snps,designware-i2c";
> > +				reg = <0xd0200000 0x1000>;
> > +				interrupt-parent = <&vic0>;
> > +				interrupts = <28>;
> > +			};
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/mach-spear6xx/Kconfig
> > b/arch/arm/mach-spear6xx/Kconfig index ff4ae5b..fbe298b 100644
> > --- a/arch/arm/mach-spear6xx/Kconfig
> > +++ b/arch/arm/mach-spear6xx/Kconfig
> > @@ -5,11 +5,12 @@
> > 
> >  if ARCH_SPEAR6XX
> >  
> >  menu "SPEAr6xx Implementations"
> > 
> > -config BOARD_SPEAR600_EVB
> > -	bool "SPEAr600 Evaluation Board"
> > +config BOARD_SPEAR600_DT
> > +	bool "SPEAr600 generic board configured via device-tree"
> > 
> >  	select MACH_SPEAR600
> > 
> > +	select USE_OF
> > 
> >  	help
> > 
> > -	  Supports ST SPEAr600 Evaluation Board
> > +	  Supports ST SPEAr600 boards configured via the device-tree
> > 
> >  endmenu
> > 
> > diff --git a/arch/arm/mach-spear6xx/Makefile
> > b/arch/arm/mach-spear6xx/Makefile index cc1a4d8..76e5750 100644
> > --- a/arch/arm/mach-spear6xx/Makefile
> > +++ b/arch/arm/mach-spear6xx/Makefile
> > @@ -4,9 +4,3 @@
> > 
> >  # common files
> >  obj-y	+= clock.o spear6xx.o
> > 
> > -
> > -# spear600 specific files
> > -obj-$(CONFIG_MACH_SPEAR600) += spear600.o
> > -
> > -# spear600 boards files
> > -obj-$(CONFIG_BOARD_SPEAR600_EVB) += spear600_evb.o
> > diff --git a/arch/arm/mach-spear6xx/clock.c
> > b/arch/arm/mach-spear6xx/clock.c index ac70e0d..358f280 100644
> > --- a/arch/arm/mach-spear6xx/clock.c
> > +++ b/arch/arm/mach-spear6xx/clock.c
> > @@ -641,8 +641,8 @@ static struct clk_lookup spear_clk_lookups[] = {
> > 
> >  	{ .con_id = "gpt0_synth_clk",	.clk = &gpt0_synth_clk},
> >  	{ .con_id = "gpt2_synth_clk",	.clk = &gpt2_synth_clk},
> >  	{ .con_id = "gpt3_synth_clk",	.clk = &gpt3_synth_clk},
> > 
> > -	{ .dev_id = "uart0",		.clk = &uart0_clk},
> > -	{ .dev_id = "uart1",		.clk = &uart1_clk},
> > +	{ .dev_id = "d0000000.serial",	.clk = &uart0_clk},
> > +	{ .dev_id = "d0080000.serial",	.clk = &uart1_clk},
> 
> switch to the macro CLK_.. will be good but can be done later

Sure. Still a lot to do... 
 
> otherwise look good

Ufff. Good.

Thanks,
Stefan
