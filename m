From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 19:56:44 +0100
Subject: [PATCH 05/13] ARM: LPC32XX: arch Kconfig, plat Kconfig, and
	makefiles
In-Reply-To: <083DF309106F364B939360100EC290F805C8B78779@eu1rdcrdc1wx030.exi.nxp.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-6-git-send-email-wellsk40@gmail.com>
	<20100203105152.GF11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B78779@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100203185644.GB20113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Kevin,

> > > +config ARCH_LPC32XX_HSUART7_ENABLE
> > > +	bool "Enable high speed UART7"
> > > +	help
> > > +	 Also enable LPC32xx high speed serial support in drivers/serial
> > > +
> > > +endmenu
> > IMHO "enable" is a bit misleading here.  Depending on the selection here
> > the devices are defined or not.
> 
> I'm not sure what what you mean here. I'll look at the wording and try to
> fix.
For me enable is something like

	clk_enable(...)

but not

	platform_device_register(...)

.  Does this make it clearer?

> > > +choice
> > > +	prompt "Kernel uncompress status output UART selection"
> > > +	default ARCH_LPC32XX_UNCOMP_U5
> > > +
> > > +	config ARCH_LPC32XX_UNCOMP_HSU1
> > > +		bool "High speed UART 1"
> > > +		help
> > > +		 Kernel uncompress output is on high speed UART 1
> > > +
> > > +	config ARCH_LPC32XX_UNCOMP_HSU2
> > > +		bool "High speed UART 2"
> > > +		help
> > > +		 Kernel uncompress output is on high speed UART 2
> > > +
> > > +	config ARCH_LPC32XX_UNCOMP_U3
> > > +		bool "Standard UART 3"
> > > +		help
> > > +		 Kernel uncompress output is on standard UART 3
> > > +
> > > +	config ARCH_LPC32XX_UNCOMP_U4
> > > +		bool "Standard UART 4"
> > > +		help
> > > +		 Kernel uncompress output is on standard UART 4
> > > +
> > > +	config ARCH_LPC32XX_UNCOMP_U5
> > > +		bool "Standard UART 5"
> > > +		help
> > > +		 Kernel uncompress output is on standard UART 5
> > > +
> > > +	config ARCH_LPC32XX_UNCOMP_U6
> > > +		bool "Standard UART 6"
> > > +		help
> > > +		 Kernel uncompress output is on standard UART 6
> > > +
> > > +	config ARCH_LPC32XX_UNCOMP_HSU7
> > > +		bool "High speed UART 7"
> > > +		help
> > > +		 Kernel uncompress output is on high speed UART 7
> > > +
> > > +endchoice
> > Can you autodetect this?
> 
> This is the uncompress output prior to kernel startup. There are
> 7 UARTs on the device and different board manufacturers don't
> always use the same UART. For the currently supported boards
> (PHY3250, EA3250, and FDI3250 mach ids), this was the only way
> I could get the UART selection into the config without changing
> code. I suppose it's possible to put specific board checks in
> the uncompress macros, but it would require changes to that file
> for new boards. This seemed the best way to go.
IMHO the best way is to do something like
arch/arm/plat-mxc/include/mach/uncompress.h or
arch/arm/mach-ns9xxx/include/mach/uncompress.h.  That is either (mxc)
make it depend on mach_id or (ns9xxx) check all available ports and use
the first that is enabled.
 
> > > +choice
> > > +	prompt "debug output (printascii) UART selection"
> > > +	default ARCH_LPC32XX_DEBUGO_U5
> > > +
> > > +	config ARCH_LPC32XX_DEBUGO_U3
> > > +		bool "Standard UART 3"
> > > +		help
> > > +		 printascii messages are output on standard UART 3
> > > +
> > > +	config ARCH_LPC32XX_DEBUGO_U4
> > > +		bool "Standard UART 4"
> > > +		help
> > > +		 printascii messages are output on standard UART 4
> > > +
> > > +	config ARCH_LPC32XX_DEBUGO_U5
> > > +		bool "Standard UART 5"
> > > +		help
> > > +		 printascii messages are output on standard UART 5
> > > +
> > > +	config ARCH_LPC32XX_DEBUGO_U6
> > > +		bool "Standard UART 6"
> > > +		help
> > > +		 printascii messages are output on standard UART 6
> > > +
> > > +endchoice
> > IMHO this isn't something that needs configuration via Kconfig.  It's
> > enough to have this via #defines in debug-macro.S.
> 
> See comment about uncompress output above. Some developers prefer
> printascii messages on a specific UART output (seperated from main
> serial or console output). This handles that.
No, printascii shouldn't be used but for debugging.  (So IMHO the
printascii that I saw somewhere in the series should go away.)
So if I want to debug something in early boot code then I check that
the cpp symbols are set up correctly for the board I'm currently using
and then I start adding printasciis and printhex8s.  When I found my
problem all these are removed again.  So don't expose it to your users.

> > > --- /dev/null
> > > +++ b/arch/arm/mach-lpc32xx/Kconfig.plat
> > > @@ -0,0 +1,98 @@
> > > +menu "LPC32XX platform choices"
> > > +
> > > +choice
> > > +    prompt "Choose your board"
> > > +    default MACH_PHY3250
> > > +    help
> > > +        This menu selects the LPC3250 board to support for this build
> > > +
> > > +    config MACH_PHY3250
> > > +        bool "Phytec 3250 development board"
> > > +	help
> > > +	    Support for the Phytec 3250 development board
> > > +
> > > +endchoice
> > Again, support more than one mach per kernel?
> 
> There are a minimum of 3 supported machs for this arch. To keep thing
> simple, I wanted to release initially with just 1 mach. What is a good
> approach for this? Should I break up the arch and plat areas into different
> subdirectories under arch/arm similar to other platforms and remove
> Kconfig.plat?
My comment was more about the "choice" than on the existance of only a
single board.  For now it doesn't matter, but later it would be nice if
you could have a kernel with

	[X] PHY3250
	[X] EA3250
	[X] FDI3250

and therefor you must not use

	choice
	    prompt ...

but e.g.

	comment "LPC32XX platforms:"
	config MACH_PHY3250
		bool ...
		...

	config MACH_EA3250
		bool ...
		...
	
> > > +choice
> > > +	prompt "Phytec Carrier board revisions"
> > > +	depends on MACH_PHY3250
> > > +	default PHY3250_CARRIER_1305_3
> > > +	help
> > > +	  Select one of the supported carrier board revisions
> > > +
> > > +config PHY3250_CARRIER_1305_01
> > > +	bool "1305.0 or 1305.1 carrier board"
> > > +	help
> > > +	  Use carrier board version 1305.0 or 1305.1
> > > +
> > > +config PHY3250_CARRIER_1305_2
> > > +	bool "1305.2 carrier board"
> > > +	help
> > > +	  Use carrier board version 1305.2
> > > +
> > > +config PHY3250_CARRIER_1305_3
> > > +	bool "1305.3 carrier board"
> > > +	help
> > > +	  Use carrier board version 1305.3
> > > +
> > > +endchoice
> > ditto
> 
> I can make these 3 kernel parameters, but not all of them are
> autodetectable. Is this approach wrong?
It's all about having one image for more than one machine.  Then the
autobuilder needs only build a single image for you and you don't have
to care about the exact revisions of all your hardware (assuming you can
autodetect it).
 
> > 
> > > +choice
> > > +	prompt "Internal IRAM use"
> > > +	default MACH_LPC32XX_IRAM_RESERVED
> > > +	depends on MACH_PHY3250
> > > +
> > > +config MACH_LPC32XX_IRAM_RESERVED
> > > +	bool "IRAM is not used (reserved)"
> > > +	help
> > > +	  IRAM is not used for video or networking and can be used for
> > > +	  other purposes or drivers
> > > +
> > > +config MACH_LPC32XX_IRAM_FOR_CLCD
> > > +	bool "Use IRAM as a video frame buffer"
> > > +	help
> > > +	  IRAM will be used for the LCD frame buffer. If the required
> > buffer
> > > +	  size is larger than the size of IRAM, then SDRAM will be used
> > > +	  instead.
> > > +
> > > +endchoice
> > A request API would be nice here!?
> 
> I'm not sure what you mean here by a request API?. The IRAM also can
> be used for network buffer storage (the option was purposely removed
> for initial release). Can you please post an example?
Something like request_mem_region.  This way the first driver who wants
to can use the IRAM, no need to fix it at compile time.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
