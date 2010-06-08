From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 Jun 2010 12:55:52 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTinWCRIKyMUseSpkRfEC0Cba4JRGBiUwb_jD_MkZ@mail.gmail.com>
References: <4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080839240.30664@xanadu.home>
	<20100608125053.GD25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080857390.30664@xanadu.home>
	<20100608131319.GF25370@n2100.arm.linux.org.uk>
	<AANLkTinWCRIKyMUseSpkRfEC0Cba4JRGBiUwb_jD_MkZ@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006081213190.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Jun 2010, Eric Miao wrote:

> On Tue, Jun 8, 2010 at 9:13 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jun 08, 2010 at 09:01:35AM -0400, Nicolas Pitre wrote:
> >> I wouldn't give up on that option just yet though. ?I don't think he
> >> fully understood your idea, and without an actual patch it might be hard
> >> to understand as well, especially for people who are not used to deal
> >> with the target varieties we have on ARM. ?Linus is also known to change
> >> his mind when presented with evidences.
> >
> > The two ideas are very close to each other - and can be generated
> > together.
> >
> > If we create something like Linus' preferred solution, we can then do
> > in the main arch/arm/Kconfig:
> >
> > config STD_CONFIG
> > ? ? ? ?bool "blah"
> >
> > if STD_CONFIG
> >
> > if MACH_WHATEVER
> > include arch/arm/config/Kconfig.whatever
> > endif
> >
> > if MACH_BLAH
> > include arch/arm/config/Kconfig.blah
> > endif
> >
> > endif
> >
> > which should work as per my idea.
> >
> 
> Anyway, we might need a tool to analyze those common config options across all
> boards, and those not. Attached is a script used when updating debian kernel
> configs, which I found might be useful. The result is still a _big_
> mess to sort out
> though.

I doubt this can be automated.  The idea is to have something human 
readable, and the only information we really care about is the set of 
drivers each individual target needs.

For example, let's have a look at the SheevaPlug target which is quite 
simple.

config MACH_SHEEVAPLUG
	bool "blah"
	if BASE_STUFF=y
	    select MTD_PARTITIONS
	    select MTD_NAND_ORION
	    select MV643XX_ETH
	    select SERIAL_8250_CONSOLE
	    select USB_EHCI_HCD
	    select MMC_MVSDIO
	    select LEDS_GPIO_PLATFORM
	    select RTC_DRV_MV
	    select MV_XOR
	    select CRYPTO_DEV_MV_CESA
	endif

So the idea is really to describe the built-in hardware and 
automatically selects the _minimum_ set of options (including the 
options they depend on) for all that built-in hardware to work properly.  
All the rest is arbitrary and should probably not be encoded in the 
kernel tree.  The rule of thumb here is to specify any driver set that 
otherwise requires the target's data sheet and/or schematics for a 
proper selection.  All the rest such as filesystems, network protocols, 
USB devices and so on are optional stuff that need no particular 
information from that target and therefore need not to be explicitly 
selected here.

Hence with the above you immediately get a sense of what this particular 
hardware target needs in a fairly human readable form without having to 
dig and guess through all the Kconfig options.  And having that 
information next to the very Kconfig entry concerned is also much easier 
to maintain rather than having that located in a separate file.

Yet in this example, it would probably make sense to move RTC_DRV_MV, 
MV_XOR and CRYPTO_DEV_MV_CESA to where CONFIG_ARCH_KIRKWOOD is selected 
instead of repeating those for every Kirkwood target, as those are 
always available since they're built into the SOC and require no 
external wiring.


Nicolas
