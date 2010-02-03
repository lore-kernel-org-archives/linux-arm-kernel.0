From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 19:01:38 +0100
Subject: [PATCH 05/13] ARM: LPC32XX: arch Kconfig, plat Kconfig, and
	makefiles
In-Reply-To: <20100203105152.GF11354@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-6-git-send-email-wellsk40@gmail.com>
	<20100203105152.GF11354@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B78779@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> lpc32xx/Kconfig
> > new file mode 100644
> > index 0000000..a277885
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/Kconfig
> > @@ -0,0 +1,158 @@
> > +if ARCH_LPC32XX
> > +
> > +menu "LPC32XX chip options"
> > +
> > +config ARCH_LPC32XX_IRAM_SIZE
> > +	int
> > +	default 131072 if ARCH_LPC32XX_20
> > +	default 262144 if ARCH_LPC32XX_30 || ARCH_LPC32XX_40 ||
> ARCH_LPC32XX_50
> > +
> > +choice
> > +    prompt "Select 32x0 device variation"
> > +    default ARCH_LPC32XX_50
> > +
> > +	config ARCH_LPC32XX_20
> > +		bool "LPC3220"
> > +		help
> > +		 128K IRAM, no ethernet or LCD
> > +
> > +	config ARCH_LPC32XX_30
> > +		bool "LPC3230"
> > +		help
> > +		 256K IRAM and LCD, no ethernet
> > +
> > +	config ARCH_LPC32XX_40
> > +		bool "LPC3240"
> > +		help
> > +		 256K IRAM and ethernet, no LCD
> > +
> > +	config ARCH_LPC32XX_50
> > +		bool "LPC3250"
> > +		help
> > +		 256K IRAM and ethernet and LCD
> > +
> > +endchoice
> It's sad this is a choice and only a single "device variation" is
> selectable.  Maybe you can autodetect these?

Hi Uwe, thank your for your comments and thorough review.
Most systems can simply disable support for unused options by disabling
the driver. I can reduce this.

> 
> > +menu "Serial port configuration"
> > +
> > +menu "Individual UART enable selections"
> > +
> > +config ARCH_LPC32XX_HSUART1_ENABLE
> > +	bool "Enable high speed UART1"
> > +	help
> > +	 Also enable LPC32xx high speed serial support in drivers/serial
> > +
> > +config ARCH_LPC32XX_HSUART2_ENABLE
> > +	bool "Enable high speed UART2"
> > +	help
> > +	 Also enable LPC32xx high speed serial support in drivers/serial
> > +
> > +config ARCH_LPC32XX_UART3_ENABLE
> > +	bool "Enable standard UART3"
> > +	help
> > +	 Also enable 8250 serial support in drivers/serial
> > +
> > +config ARCH_LPC32XX_UART4_ENABLE
> > +	bool "Enable standard UART4"
> > +	help
> > +	 Also enable 8250 serial support in drivers/serial
> > +
> > +config ARCH_LPC32XX_UART5_ENABLE
> > +	bool "Enable standard UART5"
> > +	default y
> > +	help
> > +	 Also enable 8250 serial support in drivers/serial
> > +
> > +config ARCH_LPC32XX_UART6_ENABLE
> > +	bool "Enable standard UART6"
> > +	help
> > +	 Also enable 8250 serial support in drivers/serial
> > +
> > +config ARCH_LPC32XX_HSUART7_ENABLE
> > +	bool "Enable high speed UART7"
> > +	help
> > +	 Also enable LPC32xx high speed serial support in drivers/serial
> > +
> > +endmenu
> IMHO "enable" is a bit misleading here.  Depending on the selection here
> the devices are defined or not.

I'm not sure what what you mean here. I'll look at the wording and try to
fix.

> > +choice
> > +	prompt "Kernel uncompress status output UART selection"
> > +	default ARCH_LPC32XX_UNCOMP_U5
> > +
> > +	config ARCH_LPC32XX_UNCOMP_HSU1
> > +		bool "High speed UART 1"
> > +		help
> > +		 Kernel uncompress output is on high speed UART 1
> > +
> > +	config ARCH_LPC32XX_UNCOMP_HSU2
> > +		bool "High speed UART 2"
> > +		help
> > +		 Kernel uncompress output is on high speed UART 2
> > +
> > +	config ARCH_LPC32XX_UNCOMP_U3
> > +		bool "Standard UART 3"
> > +		help
> > +		 Kernel uncompress output is on standard UART 3
> > +
> > +	config ARCH_LPC32XX_UNCOMP_U4
> > +		bool "Standard UART 4"
> > +		help
> > +		 Kernel uncompress output is on standard UART 4
> > +
> > +	config ARCH_LPC32XX_UNCOMP_U5
> > +		bool "Standard UART 5"
> > +		help
> > +		 Kernel uncompress output is on standard UART 5
> > +
> > +	config ARCH_LPC32XX_UNCOMP_U6
> > +		bool "Standard UART 6"
> > +		help
> > +		 Kernel uncompress output is on standard UART 6
> > +
> > +	config ARCH_LPC32XX_UNCOMP_HSU7
> > +		bool "High speed UART 7"
> > +		help
> > +		 Kernel uncompress output is on high speed UART 7
> > +
> > +endchoice
> Can you autodetect this?

This is the uncompress output prior to kernel startup. There are
7 UARTs on the device and different board manufacturers don't
always use the same UART. For the currently supported boards
(PHY3250, EA3250, and FDI3250 mach ids), this was the only way
I could get the UART selection into the config without changing
code. I suppose it's possible to put specific board checks in
the uncompress macros, but it would require changes to that file
for new boards. This seemed the best way to go.

> 
> > +choice
> > +	prompt "debug output (printascii) UART selection"
> > +	default ARCH_LPC32XX_DEBUGO_U5
> > +
> > +	config ARCH_LPC32XX_DEBUGO_U3
> > +		bool "Standard UART 3"
> > +		help
> > +		 printascii messages are output on standard UART 3
> > +
> > +	config ARCH_LPC32XX_DEBUGO_U4
> > +		bool "Standard UART 4"
> > +		help
> > +		 printascii messages are output on standard UART 4
> > +
> > +	config ARCH_LPC32XX_DEBUGO_U5
> > +		bool "Standard UART 5"
> > +		help
> > +		 printascii messages are output on standard UART 5
> > +
> > +	config ARCH_LPC32XX_DEBUGO_U6
> > +		bool "Standard UART 6"
> > +		help
> > +		 printascii messages are output on standard UART 6
> > +
> > +endchoice
> IMHO this isn't something that needs configuration via Kconfig.  It's
> enough to have this via #defines in debug-macro.S.

See comment about uncompress output above. Some developers prefer
printascii messages on a specific UART output (seperated from main
serial or console output). This handles that.

> 
> > +endmenu
> > +
> > +endmenu
> > +
> > +source "arch/arm/mach-lpc32xx/Kconfig.plat"
> > +
> > +endif
> > +
> > diff --git a/arch/arm/mach-lpc32xx/Kconfig.plat b/arch/arm/mach-
> lpc32xx/Kconfig.plat
> > new file mode 100644
> > index 0000000..a67d1ad
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc32xx/Kconfig.plat
> > @@ -0,0 +1,98 @@
> > +menu "LPC32XX platform choices"
> > +
> > +choice
> > +    prompt "Choose your board"
> > +    default MACH_PHY3250
> > +    help
> > +        This menu selects the LPC3250 board to support for this build
> > +
> > +    config MACH_PHY3250
> > +        bool "Phytec 3250 development board"
> > +	help
> > +	    Support for the Phytec 3250 development board
> > +
> > +endchoice
> Again, support more than one mach per kernel?

There are a minimum of 3 supported machs for this arch. To keep thing
simple, I wanted to release initially with just 1 mach. What is a good
approach for this? Should I break up the arch and plat areas into different
subdirectories under arch/arm similar to other platforms and remove
Kconfig.plat?

> 
> > +choice
> > +	prompt "Phytec LCD module revisions"
> > +	depends on MACH_PHY3250
> > +	default PHY3250_QVGA_PANEL_1307_1
> > +	help
> > +	  Select one of the supported LCD panel revisions
> > +
> > +config PHY3250_QVGA_PANEL_1307_0
> > +	bool "1307.0 QVGA panel (portrait mode RGB565)"
> > +	help
> > +	  Use LCD module version 1307.0
> > +
> > +config PHY3250_QVGA_PANEL_1307_1
> > +	bool "1307.1 QVGA panel (portrait mode RGB565)"
> > +	help
> > +	  Use LCD module version 1307.1
> > +
> > +endchoice
> autodetect?  kernel-parameter?
> 
> > +choice
> > +	prompt "Phytec CPU module revisions"
> > +	depends on MACH_PHY3250
> > +	default PHY3250_CPU_MODULE_1304_1
> > +	help
> > +	  Select one of the supported CPU module revisions
> > +
> > +config PHY3250_CPU_MODULE_1304_0
> > +	bool "1304.0 CPU module"
> > +	help
> > +	  Use CPU module version 1304.0
> > +
> > +config PHY3250_CPU_MODULE_1304_1
> > +	bool "1304.1 CPU module"
> > +	help
> > +	  Use CPU module version 1304.1
> > +
> > +endchoice
> ditto, autodetect?  kernel-parameter?
> 
> > +choice
> > +	prompt "Phytec Carrier board revisions"
> > +	depends on MACH_PHY3250
> > +	default PHY3250_CARRIER_1305_3
> > +	help
> > +	  Select one of the supported carrier board revisions
> > +
> > +config PHY3250_CARRIER_1305_01
> > +	bool "1305.0 or 1305.1 carrier board"
> > +	help
> > +	  Use carrier board version 1305.0 or 1305.1
> > +
> > +config PHY3250_CARRIER_1305_2
> > +	bool "1305.2 carrier board"
> > +	help
> > +	  Use carrier board version 1305.2
> > +
> > +config PHY3250_CARRIER_1305_3
> > +	bool "1305.3 carrier board"
> > +	help
> > +	  Use carrier board version 1305.3
> > +
> > +endchoice
> ditto

I can make these 3 kernel parameters, but not all of them are
autodetectable. Is this approach wrong?

> 
> > +choice
> > +	prompt "Internal IRAM use"
> > +	default MACH_LPC32XX_IRAM_RESERVED
> > +	depends on MACH_PHY3250
> > +
> > +config MACH_LPC32XX_IRAM_RESERVED
> > +	bool "IRAM is not used (reserved)"
> > +	help
> > +	  IRAM is not used for video or networking and can be used for
> > +	  other purposes or drivers
> > +
> > +config MACH_LPC32XX_IRAM_FOR_CLCD
> > +	bool "Use IRAM as a video frame buffer"
> > +	help
> > +	  IRAM will be used for the LCD frame buffer. If the required
> buffer
> > +	  size is larger than the size of IRAM, then SDRAM will be used
> > +	  instead.
> > +
> > +endchoice
> A request API would be nice here!?

I'm not sure what you mean here by a request API?. The IRAM also can
be used for network buffer storage (the option was purposely removed
for initial release). Can you please post an example?
