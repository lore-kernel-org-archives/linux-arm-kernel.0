From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 5 Nov 2013 20:40:56 -0300
Subject: [PATCH v3 13/28] mtd: nand: pxa3xx: Add bad block handling
In-Reply-To: <20131105182301.GN20061@ld-irv-0074.broadcom.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-14-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105182301.GN20061@ld-irv-0074.broadcom.com>
Message-ID: <20131105234055.GE11759@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:23:01AM -0800, Brian Norris wrote:
> Hi Ezequiel,
> 
> I wrote up some comments on your v2 series while on a plane Sunday, but
> I didn't make time to send them out until now. Oh well.
> 

No problem. I just wanted to push a new version with the minor fixes
from Huang to prevent from stalling.

> On Tue, Nov 05, 2013 at 09:55:20AM -0300, Ezequiel Garcia wrote:
> > --- a/drivers/mtd/nand/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
> > @@ -1128,6 +1152,14 @@ KEEP_CONFIG:
> >  
> >  	if (nand_scan_ident(mtd, 1, def))
> >  		return -ENODEV;
> > +
> > +	if (pdata->flash_bbt) {
> > +		chip->bbt_options |= NAND_BBT_USE_FLASH |
> > +				     NAND_BBT_NO_OOB_BBM;
> 
> You're using NAND_BBT_NO_OOB_BBM? So you are unable to write bad block
> markers to flash at all? Is this related to your independent patch for
> trying to scan BBM from the data area?

Yes.

> Could you instead write a
> nand_chip.block_markbad() callback routine that would program BBM to the
> appropriate data area?
> 

No :-)

> Or, if you really want to avoid programming new BBMs, then you should
> probably describe this decision in the patch description more clearly.
> 

Right.

I'll have to describe a bunch of stuff about the controller so this
NO_OOB_BBM makes sense. Please bare with me and keep reading :)

The central issue and the main difficulty is the "splitted"
data/oob/data/oob way of regarding a page.

This is intrinsic to the hardware and we must learn to deal with it.
So, let's suppose we have 4K pages, and the manufacturer marks a block at
offset 4096 (the 'x' is offset 4096).

-----------------------------------------------
|                    Data           |x  OOB   |
-----------------------------------------------

When this same page is 'viewed' by the driver, and because of the
splitted layout, the data and OOB regions are now at different
locations. It would be something like this:

-----------------------------------------------
|      Data      | OOB |      Data   x  | OOB |
-----------------------------------------------

The offset *in the data region* depends in the controller configuration,
but considering we have a 32B and 30B ECC, the calculation would give:

 2048 + 2048 - 32 - 30 = 4034.

So, if I use nanddump to dump a page, I would have to look at offset
4034 to find the factory bad block marker.

For this reason, why need to use a customize bad block scanning.

In addition, this means under regular usage we will write such position
(since it belongs to the data region) and every used block is likely
to be marked as bad.

So, there's no point in marking a block as bad, because good blocks
are *also* mark as bad. We need to rely in the bad block table, and only
perform the scan in on the very first time (when the device is unused).

We're aware this sounds kind of crappy since we'll get completely screwed
in case the bad block table is somehow lost or corrupted, but we don't
care about such case.

Still, I'd like to know:

1. Do you think the bad block table could be corrupted or is this not
likely to ever happen?

2. Do you have any ideas to 'avoid' writing to the marker? or maybe to
otherwise scan the factory markers the first time, but then use some
other position for the kernel in-flash BB marker?

> > +		chip->bbt_td = &bbt_main_descr;
> > +		chip->bbt_md = &bbt_mirror_descr;
> > +	}
> > +
> >  	/* calculate addressing information */
> >  	if (mtd->writesize >= 2048)
> >  		host->col_addr_cycles = 2;
> > @@ -1323,6 +1355,7 @@ static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
> >  	if (of_get_property(np, "marvell,nand-keep-config", NULL))
> >  		pdata->keep_config = 1;
> >  	of_property_read_u32(np, "num-cs", &pdata->num_cs);
> > +	pdata->flash_bbt = of_get_nand_on_flash_bbt(np);
> 
> Now that you're using the "nand-on-flash-bbt" property, you should
> document it in Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> like the other drivers do. (It's already documented generically in
> Documentation/.../nand.txt, but I think it's good practice to explicitly
> note which drivers support the binding, since nand_base doesn't do this
> generically for all NAND drivers.)
>

Yeah, good idea.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
