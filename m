From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 17 Jul 2012 15:34:47 +0200
Subject: [PATCH 2/8] ARM: MCS814x: add Device Tree based MCS8140 board
 support
In-Reply-To: <201207171319.43593.arnd@arndb.de>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-3-git-send-email-florian@openwrt.org>
 <201207171319.43593.arnd@arndb.de>
Message-ID: <6873084.DUBYG1ACKX@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012 13:19:43 Arnd Bergmann wrote:
> On Sunday 15 July 2012, Florian Fainelli wrote:
> 
> > +
> > +			uart0: serial at 400dc000 {
> > +				compatible = "ns16550";
> > +				reg = <0x400dc000 0x20>;
> > +				clock-frequency = <50000000>;
> > +				reg-shift = <2>;
> > +				interrupts = <21>;
> > +				status = "okay";
> > +			};
> 
> We often mark stuff like the uart as status="disabled" in the .dtsi file
> and only enable it in the board specific .dts file when it's actually
> connected. For components that are always present and usable, that's
> of course not necessary.

Ok, I thought it could be handy to have the uart enabled by default to avoid 
mixing with the status property, I don't mind setting it to "disabled" by 
default.

> 
> > +
> > +			adc {
> > +				compatible = "simple-bus";
> > +				#address-cells = <2>;
> > +				#size-cells = <1>;
> > +				// 8 64MB chip-selects
> > +				ranges = <0 0 0x00000000 0x4000000	// sdram
> > +					  1 0 0x04000000 0x4000000	// sdram
> > +					  2 0 0x08000000 0x4000000	// reserved
> > +					  3 0 0x0c000000 0x4000000	// 
flash/localbus
> > +					  4 0 0x10000000 0x4000000	// 
flash/localbus
> > +					  5 0 0x14000000 0x4000000	// 
flash/localbus
> > +					  6 0 0x18000000 0x4000000	// 
flash/localbus
> > +					  7 0 0x1c000000 0x4000000>;	// 
flash/localbus
> > +
> > +				sdram: memory at 0,0 {
> > +					reg = <0 0 0>;
> > +				};
> > +
> > +				nor: flash at 7,0 {
> > +					reg = <7 0 0x4000000>;
> > +					compatible = "cfi-flash";
> > +					bank-width = <1>;		// 8-bit external 
flash
> > +					#address-cells = <1>;
> > +					#size-cells = <1>;
> > +                                };
> > +                        };
> 
> Nice representation of the external buses. It does seem however that at
> least the nor flash entry is board specific and should be moved into the
> board .dts file.

In fact, MCS8140 only supports 8-bit CFI Flash chips, so this really is the 
common point of all MCS8140-based boards. As you can see in the following 
board-specific DTS patches, only the partition layout is different.

> I would probably do the same for the memory node, but that one is less
> obvious as it seems that there is not much choice here.

The memory node is also overridden by the board-specific DTS files in subsequent 
patches.

> 
> > +			usb0: ehci at 400fc000 {
> > +				compatible = "moschip,mcs814x-ehci", "usb-ehci";
> > +				reg = <0x400fc000 0x74>;
> > +				interrupts = <2>;
> > +			};
> > +
> > +			usb1: ohci at 400fd000 {
> > +				compatible = "moschip,mcs814x-ohci", "ohci-le";
> > +				reg = <0x400fd000 0x74>;
> > +				interrupts = <11>;
> > +			};
> > +
> > +			usb2: ohci at 400fe000 {
> > +				compatible = "moschip,mcs814x-ohci", "ohci-le";
> > +				reg = <0x400fe000 0x74>;
> > +				interrupts = <12>;
> > +			};
> > +
> > +			usb3: otg at 400ff000 {
> > +				compatible = "moschip,msc814x-otg", "usb-otg";
> > +				reg = <0x400ff000 0x1000>;
> > +				interrupts = <13>;
> > +			};
> 
> same comment as for the uart, I would mark these as disabled and only
> enable the ones that are connected on a give board.
> 
> > +
> > +static void __init mcs814x_dt_device_init(void)
> > +{
> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +	mcs814x_init_machine();
> > +}
> > +
> > +static const char *mcs8140_dt_board_compat[] __initdata = {
> > +	"moschip,mcs8140",
> > +	NULL,	/* sentinel */
> > +};
> > +
> > +DT_MACHINE_START(mcs8140_dt, "Moschip MCS8140 board")
> > +	/* Maintainer: Florian Fainelli <florian@openwrt.org> */
> > +	.timer		= &mcs814x_timer,
> > +	.map_io		= mcs814x_map_io,
> > +	.init_early	= mcs814x_clk_init,
> > +	.init_irq	= mcs814x_of_irq_init,
> > +	.init_machine	= mcs814x_dt_device_init,
> > +	.restart	= mcs814x_restart,
> > +	.dt_compat	= mcs8140_dt_board_compat,
> > +MACHINE_END
> 
> Not much to see here. Just move this into the common.c file. There is no
> need to have a separate board file when all boards use the same one.

Allright.

> 
> 	Arnd
