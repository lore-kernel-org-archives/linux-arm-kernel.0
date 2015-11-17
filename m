From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 Nov 2015 10:05:03 +0100 (CET)
Subject: [PATCH 14/27] mtd: nand: use the mtd instance embedded in struct
 nand_chip
In-Reply-To: <20151117093836.052c86b5@bbrezillon>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447681080-31232-15-git-send-email-boris.brezillon@free-electrons.com>
 <20151117030019.GY8456@google.com> <20151117093836.052c86b5@bbrezillon>
Message-ID: <alpine.DEB.2.10.1511170957100.2455@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > (This isn't the worst one, but it just happens to be one of the first.)
> > There are many cases where the typical style would be to declare a new
> > variable at the top of the function, where you perform the
> > macro/function-call to convert from one abstraction to another. Like
> >
> > static int nfc_set_sram_bank(struct atmel_nand_host *host, unsigned int bank)
> > {
> > 	struct mtd_info *mtd = nand_to_mtd(&hot->nand_chip);
> > 	...
> >
> > and then use it later. Can that be done very easily?
> >
> > >  			return -EINVAL;
> > >  		nfc_writel(host->nfc->hsmc_regs, BANK, ATMEL_HSMC_NFC_BANK1);
> > >  	} else {
> >
> > ...
>
> Honestly, I don't know how to do that with a coccinelle script, and it
> will probably take me more time to find how to do it than addressing
> those problems manually.
>
> Julia, could you give us some hint?

Probably something like the following would be easiest.  You can just run
it after your other transformations:

@r exists@
identifier f;
expression e;
@@

f(...) { <+...  nand_to_mtd(e) ...+> }

@@
identifier r.f;
expression r.e;
@@

f(...) {
+ struct mtd_info *mtd = nand_to_mtd(e);
...
}

This won't work if there is more than one possible value of e.  If that is
likely, then I could come up with something more complex.  It also assumes
that you want to convert all such calls.  If you only want to convert calls
that occur in a particular context, eg a field reference, then you could
enhance the pattern inside the <+... ...+> in the first rule.

julia
