From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 1 Dec 2014 21:28:20 +0100
Subject: [PATCH v3 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <2476626.8iiXDzb2Te@wuerfel>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <4214030.Z2iCEM6hVA@wuerfel> <20141201192923.6a85e52b@bbrezillon>
 <2476626.8iiXDzb2Te@wuerfel>
Message-ID: <20141201212820.6a7fc4b0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Dec 2014 20:43:31 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 01 December 2014 19:29:23 Boris Brezillon wrote:
> > Hi Arnd,
> > 
> > On Mon, 01 Dec 2014 17:26:27 +0100
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > On Monday 01 December 2014 11:27:21 Boris Brezillon wrote:
> > > > The EBI (External Bus Interface) is used to access external peripherals
> > > > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> > > > Each device is assigned a CS line and an address range and can have its
> > > > own configuration (timings, access mode, bus width, ...).
> > > > This driver provides a generic DT binding to configure a device according
> > > > to its requirements.
> > > > For specific device controllers (like the NAND one) the SMC timings
> > > > should be configured by the controller driver through the matrix and
> > > > smc syscon regmaps.
> > > 
> > > Nice!
> > > 
> > > > +
> > > > +#define AT91_EBICSA_REGFIELD(soc)			\
> > > > +	REG_FIELD(soc ## _MATRIX_EBICSA_OFF, 0,		\
> > > > +		  AT91_MATRIX_EBI_NUM_CS - 1)
> > > > +
> > > > +#define AT91_MULTI_EBICSA_REGFIELD(soc, n)		\
> > > > +	REG_FIELD(soc ## _MATRIX_EBI ## n ## CSA_OFF,	\
> > > > +		  0, AT91_MATRIX_EBI_NUM_CS - 1)
> > > 
> > > I don't like the use macros that concatenate symbol names like
> > > this. Why not do either
> > > 
> > > - open-code the macro contents in the few uses, to allow
> > >   grepping for them, or
> > 
> > I'm not sure to get this one, are you suggesting to do something like
> > this:
> > 
> > #define AT91_EBICSA_REGFIELD(off)			\
> > 	REG_FIELD(ebicsa_off, AT91_MATRIX_EBI_NUM_CS - 1)
> > 
> 
> That would be acceptable too, but what I really meant is one step further:
> 
> static const struct reg_field at91sam9260_ebi_csa = 
> 	REG_FIELD(AT91SAM9260_MATRIX_EBICSA_OFF, 0, AT91_MATRIX_EBI_NUM_CS - 1);

That's what I did in the first place (in a version I didn't submitted),
and I guess I'll go for that one unless you really prefer the
alternative (I ran into a lot of trouble with DT bindings ABI
stability, and I'd prefer to keep DT bindings as simple as
possible).

> 
> > > - put the register number in the syscon reference and look it
> > >   up from there (this would be slightly more complicated for the
> > >   second macro)
> > 
> > I've told several times not to encode register offsets or register ids

    ^ "I've been told" :-).

> > in the DT :-) (and if I'm not mistaken that's what you're suggesting
> > here).
> 
> I think it's actually fine for syscon references, although in general
> I would agree with that. The difference in my opinion is that syscon
> by nature is a set of registers.

Okay, good to know.



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
