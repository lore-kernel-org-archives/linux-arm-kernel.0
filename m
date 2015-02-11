From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 11 Feb 2015 17:27:02 +0100
Subject: [PATCH 5/9] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <20150208220633.5d2c7008@bbrezillon>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
 <20150208220633.5d2c7008@bbrezillon>
Message-ID: <20150211162702.GF11169@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Sun, Feb 08, 2015 at 10:06:33PM +0100, Boris Brezillon wrote:
> On Tue, 27 Jan 2015 15:10:12 +0100
> Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
> > +
> > +#define BERLIN_NAND_CMD_RNDOUT		0x3000
> 
> Your specific RNDOUT command looks like a regular READ0 (0x0) +
> READSTART (0x30) sequence, I think this is why you need to do a RNDOUT
> to read your page ;-).

You're right :)

> 
> > +#define BERLIN_NAND_CMD_ERASE1		0xd060
> 
> Ditto, it's a regular ERASE command sequence: ERASE1 (0x60) + ERASE2
> (0xd0).

Yep, I'll update.

> >  
> >  static struct pxa3xx_nand_timing timing[] = {
> > -	{ 40, 80, 60, 100, 80, 100, 90000, 400, 40, },
> > -	{ 10,  0, 20,  40, 30,  40, 11123, 110, 10, },
> > -	{ 10, 25, 15,  25, 15,  30, 25000,  60, 10, },
> > -	{ 10, 35, 15,  25, 15,  25, 25000,  60, 10, },
> > +	{ 40, 80, 60, 100, 80, 100,  90000, 400, 40, },
> > +	{ 10,  0, 20,  40, 30,  40,  11123, 110, 10, },
> > +	{ 10, 25, 15,  25, 15,  30,  25000,  60, 10, },
> > +	{ 10, 35, 15,  25, 15,  25,  25000,  60, 10, },
> > +	{  5, 20, 10,  12, 10,  12,  60000,  60, 10, },
> > +	{  5, 20, 10,  12, 10,  12, 200000, 120, 10, },
> > +	{  5, 15, 10,  15, 10,  15,  60000,  60, 10, },
> >  };
> >  
> >  static struct pxa3xx_nand_flash builtin_flash_types[] = {
> > @@ -260,6 +273,20 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
> >  { "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2] },
> >  { "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2] },
> >  { "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
> > +{ },
> > +};
> > +
> > +static struct pxa3xx_nand_flash berlin_builtin_flash_types[] = {
> > +{ "2GiB 8-bit",    0xd5ec, 128, 8192,  8,  8, 2048, &timing[4] },
> > +{ "2GiB 8-bit",    0xd598, 128, 8192,  8,  8, 2048, &timing[5] },
> > +{ "2GiB 8-bit",    0x482c, 256, 4096,  8,  8, 2048, &timing[6] },
> > +{ "4GiB 8-bit",    0xd7ec, 128, 8192,  8,  8, 4096, &timing[5] },
> > +{ "8GiB 8-bit",    0xdeec, 128, 8192,  8,  8, 4096, &timing[5] },
> > +{ "4GiB 8-bit",    0xd7ad, 256, 8192,  8,  8, 2048, &timing[5] },
> > +{ "4GiB 8-bit",    0x682c, 256, 4096,  8,  8, 4096, &timing[6] },
> > +{ "8GiB 8-bit",    0x882c, 256, 8192,  8,  8, 4096, &timing[6] },
> > +{ "8GiB 8-bit",    0xdead, 256, 8192,  8,  8, 4096, &timing[6] },
> > +{ },
> >  };
> 
> As already stated by Brian and Ezequiel, this should be handled with
> the new API for timing retrieval.
> However, IMHO, this should be part of another series reworking the pxa
> driver, and I know you plan to do that, so I don't mind if this
> table is added to support your IP (as long as you're taking care of
> reworking that ;-)).

Yep, that's the plan.

> >  
> > +static struct nand_ecclayout ecc_layout_oob_128 = {
> > +        .eccbytes = 48,
> > +        .eccpos = {
> > +                   80, 81, 82, 83, 84, 85, 86, 87,
> > +                   88, 89, 90, 91, 92, 93, 94, 95,
> > +                   96, 97, 98, 99, 100, 101, 102, 103,
> > +                   104, 105, 106, 107, 108, 109, 110, 111,
> > +                   112, 113, 114, 115, 116, 117, 118, 119,
> > +                   120, 121, 122, 123, 124, 125, 126, 127},
> > +        .oobfree = { {.offset = 2, .length = 78} }
> > +};
> > +
> 
> Okay, this is only my opinion, but I think all the ECC layouts defined
> in this driver should be built dynamically (depending on the requested
> ECC strength/block-size).
> Take a look at the sunxi driver if you need an example.
> 
> Again, these are mid term changes, and I won't ask you to change that
> in this series.

Also part of the plan :)

> >  
> > +	/* Berlin specific */
> > +	if (info->variant == PXA3XX_NAND_VARIANT_BERLIN2) {
> > +		if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB)
> > +			exec_cmd = 0;
> > +
> > +		if (command == NAND_CMD_SEQIN)
> > +			command = NAND_CMD_READ0;
> > +		else if (command == NAND_CMD_RNDOUT)
> > +			command = BERLIN_NAND_CMD_RNDOUT;
> 
> As stated above your BERLIN_NAND_CMD_RNDOUT is just a regular READ0 +
> READSTART command, are there any differences between a RNDOUT and a
> regular READ in your driver ?

There isn't and I'll update to use the regular READ0 command.

> >  
> >  	case NAND_CMD_ERASE1:
> > +	case BERLIN_NAND_CMD_ERASE1:
> >  		info->ndcb0 |= NDCB0_CMD_TYPE(2)
> >  				| NDCB0_AUTO_RS
> >  				| NDCB0_ADDR_CYC(3)
> >  				| NDCB0_DBC
> > -				| (NAND_CMD_ERASE2 << 8)
> > -				| NAND_CMD_ERASE1;
> > +				| command;
> >  		info->ndcb1 = page_addr;
> >  		info->ndcb2 = 0;
> >  
> > +		if (command == NAND_CMD_ERASE1)
> > +			info->ndcb0 |= (NAND_CMD_ERASE2 << 8);
> > +
> 
> I don't see any difference with the old version:
> you previously set command to BERLIN_NAND_CMD_ERASE1, which, according
> to your definition, is equal to
> (NAND_CMD_ERASE1 | (NAND_CMD_ERASE2 << 8))
> 
> Right ?
> 
> Am I missing something obvious ?

Nope, I'll fix this.

> 
> That's all for now :-).

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
