From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Jul 2011 08:59:36 -0600
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <BANLkTinkHcuXuWpCxq3tnU_10trPTjDucg@mail.gmail.com>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106292329.44447.arnd@arndb.de>
	<BANLkTinfKCMcutMDQ+mpdD4EUy9mCpZs+w@mail.gmail.com>
	<201106301236.25822.arnd@arndb.de>
	<BANLkTinkHcuXuWpCxq3tnU_10trPTjDucg@mail.gmail.com>
Message-ID: <20110704145936.GA31822@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 08:04:06AM +0800, Barry Song wrote:
> 2011/6/30 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 30 June 2011, Barry Song wrote:
> >
> >> > Is this really just one bus with a huge address space, or rather some
> >> > nested buses? I'd prefer to have the device tree representation as
> >> > close as possible to the actual layout.
> >>
> >> there are two AXI buses in prima2. AXI-1 connect to memory, AXI-2 is
> >> transferred to CSR self-defined IOBUS by CPUIF, then 1 intterupt
> >> controller and 9 IO bridges are connected to the IOBUS .
> >> The 9 IO bridges are SYSIOBG, PERIIOBG,CPURTCIOBG, UUSIOBG, GRAPHIOBG,
> >> MEDIAIOBG, DSPIOBG, DISPIOBG, MEMIOBG. Every iobrg connect to a group
> >> of controllers.
> >> For example, DISPIOBG connect to VPP and LCD, SYSIOBG connect to CLKC,
> >> RSTC, RSC and CPHIFBG, DSPIOBG connect to DSPIF, GPS and DSP.
> >> PERIIOBG connect to TIMER, NAND, AUDIO, UART0, UART1, UART2, USP0,
> >> USP1, USP2, SPI0, I2C0, I2C1, GPIO, *SYS2PCI* and so on. Then
> >> *SYS2PCI* connect to SD.
> >>
> >> The indendation descible the device hierarchy
> >> AXI-1
> >> ? ? ? ? ?Memory
> >> AXI-2
> >> ? ? ? ? ?interrupt controller
> >> ? ? ? ? ?IOBG...
> >> ? ? ? ? ? ? ? ? ? xxxx
> >> ? ? ? ? ?IOBG...
> >> ? ? ? ? ? ? ? ? ? xxxx
> >> ? ? ? ? ?IOBG...
> >> ? ? ? ? ? ? ? ? ? xxxx
> >> ? ? ? ? ?IOBG...
> >> ? ? ? ? ? ? ? ? ? xxxx
> >> ? ? ? ? ?IOBG...
> >> ? ? ? ? ? ? ? ? ? xxxx
> >> ? ? ? ? ?IOBG...
> >> ? ? ? ? ? ? ? ? ? SYS2PCI
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? SD
> >>
> >> i have get the IC guy Weizeng involved, maybe he can explain better than me :-)
> >
> > I think it would be good to represent the IOBG devices in the device tree then.
> > You don't need to represent AXI-1 because memory is special anyway, and I would
> > not bother to list SYS2PCI if the intention of that block was to hide the fact
> > that it's PCI behind it. Properly instantiating it as a PCI bridge would be
> > a lot of work that is probably not worth it.
> >
> > My usual plea to hardware developers: Please make the registers
> > autodiscoverable from software! On an AMBA bus, please use the PrimeCell
> > register layout. If you always have an IOBG device behind, they should
> > all have the same identifier for that kind of bus bridge.
> >
> > For the IOBG, it would be ideal to have a similar way of finding and
> > configuring the connected hardware, including:
> >
> > * unique identifier for each distinct IP block
> > * revision of that block
> > * MMIO ranges and sizes, relative to the bus
> > * interrupt numbers, relative to a local interrupt controller
> > * location identifier (like PCI bus/device/fn number) that can be
> > ?referred to by other devices
> > * clock management for that device
> > * power management for that device
> >
> > If your IODB infrastructure already has this, you should create a new
> > bus-type for this in Linux, which will let you detect all devices
> > in a consistent manner without having to list them in the device tree.
> >
> >> > I think the namespace for the compatible values is supposed to start with
> >> > the stock ticker name of the company making the device as a unique
> >> > identifier. This means you'd have to use
> >> > "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" as the value, instead
> >> > of starting with the product name. I don't know exactly how strictly
> >> > we apply that rule, but I've taken the devicetree-discuss at lists.ozlabs.org
> >> > mailing list on Cc, maybe someone can clarify.
> >>
> >> in fact, SiRF is a company name. it was merged into CSR 4 years ago.
> >> Due to history reason, now the SoC names are still headed by sirf.
> >> the logo in SiRFprimaII chip is CSR.
> >> So the "SiRF" of SiRFprimaII should mean two things: old company name,
> >> ?heritable CPU production-line. Anyway, "csr, sirf-intc" seems to make
> >> more senses than "sirf, intc".
> >>
> >> could we change "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" to
> >> "csr,sirf-intc", "csr,sirf-prima2-intc"?
> >
> > Not sure how strict we interpret the rules about stock ticker symbols.
> > 'CSR' on wallstreet is 'China Security & Surveillance Tech. Inc'. If they
> > ever decide to produce embedded Linux machines, we'd get a conflict, unless
> > they also use "csst" (their .com domain name) as a prefix.
> 
> Hi Arnd,
> 
> ha-ha.
> 
> except Wall St and stock, i really didn't realize CSR is something
> related with 'China Security & Surveillance Tech. Inc' . it seems CSR
> is much more extensively known as a company in Wireless Technology,
> Audio, Connectivity and GPS.
> if we lost this name, people might not know it came from *that* CSR
> focusing on Wireless/Audio/Connectivity/GPS. people will ask, what is
> CSRXF? if we really use stock sticker symbols, CSR.L is the more
> normal symbol in UK market. if we move to stock sticker symbol, could
> we use CSR.L?

Fine by me.  Make sure it stays in uppercase when using the stock
ticker symbol.

g.
