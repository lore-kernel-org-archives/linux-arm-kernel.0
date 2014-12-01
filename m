From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 1 Dec 2014 19:29:23 +0100
Subject: [PATCH v3 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <4214030.Z2iCEM6hVA@wuerfel>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417429647-3419-6-git-send-email-boris.brezillon@free-electrons.com>
 <4214030.Z2iCEM6hVA@wuerfel>
Message-ID: <20141201192923.6a85e52b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, 01 Dec 2014 17:26:27 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 01 December 2014 11:27:21 Boris Brezillon wrote:
> > The EBI (External Bus Interface) is used to access external peripherals
> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> > Each device is assigned a CS line and an address range and can have its
> > own configuration (timings, access mode, bus width, ...).
> > This driver provides a generic DT binding to configure a device according
> > to its requirements.
> > For specific device controllers (like the NAND one) the SMC timings
> > should be configured by the controller driver through the matrix and
> > smc syscon regmaps.
> 
> Nice!
> 
> > +
> > +#define AT91_EBICSA_REGFIELD(soc)			\
> > +	REG_FIELD(soc ## _MATRIX_EBICSA_OFF, 0,		\
> > +		  AT91_MATRIX_EBI_NUM_CS - 1)
> > +
> > +#define AT91_MULTI_EBICSA_REGFIELD(soc, n)		\
> > +	REG_FIELD(soc ## _MATRIX_EBI ## n ## CSA_OFF,	\
> > +		  0, AT91_MATRIX_EBI_NUM_CS - 1)
> 
> I don't like the use macros that concatenate symbol names like
> this. Why not do either
> 
> - open-code the macro contents in the few uses, to allow
>   grepping for them, or

I'm not sure to get this one, are you suggesting to do something like
this:

#define AT91_EBICSA_REGFIELD(off)			\
	REG_FIELD(ebicsa_off, AT91_MATRIX_EBI_NUM_CS - 1)

> 
> - put the register number in the syscon reference and look it
>   up from there (this would be slightly more complicated for the
>   second macro)

I've told several times not to encode register offsets or register ids
in the DT :-) (and if I'm not mistaken that's what you're suggesting
here).

> 
> > +
> > +	np = of_parse_phandle(pdev->dev.of_node, "atmel,smc", 0);
> > +	if (!np)
> > +		return -EINVAL;
> > +
> > +	ebi->smc = syscon_node_to_regmap(np);
> > +	if (IS_ERR(ebi->smc))
> > +		return PTR_ERR(ebi->smc);
> 
> I think this and the second instance of it can be shortened to
> 
> 	ebi->smc = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "atmel,smc");

Sure.

Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
