From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 9 Dec 2015 09:15:18 +0100
Subject: [PATCH v2 00/25] mtd: nand: refactor the NAND subsystem (part 1)
In-Reply-To: <20151209003624.GU120110@google.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <20151209003624.GU120110@google.com>
Message-ID: <20151209091518.18e2203d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Tue, 8 Dec 2015 16:36:24 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> Hi,
> 
> On Tue, Dec 01, 2015 at 12:02:57PM +0100, Boris Brezillon wrote:
> > Hello,
> > 
> > This huge series aims at clarifying the relationship between the mtd and
> > nand_chip structures and hiding NAND framework internals to NAND
> > controller drivers.
> > 
> > The first part of the series provide an mtd_to_nand() helper to hide the
> > way mtd and nand_chip are linked together.
> > 
> > The second part of the series embeds the mtd structure into the nand_chip
> > one so that NAND controller drivers don't have to bother allocating the
> > MTD device and linking it with the NAND chip.
> > 
> > The last part of the series hides accesses to the chip->priv field behind
> > two helper functions.
> > 
> > This allows removal of some of the boilerplate code done in all NAND
> > controller drivers, but most importantly, it unifies a bit the way NAND
> > chip structures are instantiated (even though we still have two different
> > kinds of drivers: those embedding the nand_chip struct into their private
> > nand chip representation, and those allocating two different structures
> > and linking them together with the chip->priv field).
> > 
> > As said in the title, this refactoring is only the first step. I plan to
> > rework the NAND controller / NAND chip separation for pretty much the same
> > reasons: clarifying the separation between the two concepts, and getting
> > rid of more boilerplate code in NAND controller drivers.
> > 
> > Stay tuned ;-).
> > 
> > Best Regards,
> > 
> > Boris
> > 
> > Changes since v1:
> > - dropped already applied patches
> > - fixed some typos
> > - manually fixed some modifications omitted by the coccinelle scripts
> > - manually reworked modifactions done by coccinelle scripts to improve
> >   readability and fix coding style issues
> > 
> > Boris Brezillon (25):
> >   ARM: nand: make use of mtd_to_nand() where appropriate
> 
> I've sent this (+ the introduction of mtd_to_nand()) in a pull request
> to arm-soc, as well as to l2-mtd.git.
> 
> >   blackfin: nand: make use of mtd_to_nand() where appropriate
> >   cris: nand: make use of mtd_to_nand() where appropriate
> >   mips: nand: make use of mtd_to_nand() where appropriate
> 
> I've based these on v4.4-rc1 and brought them into l2-mtd.git, in case
> any arch/{blackfin,cris,mips}/ people want to pull them in too.
> 
> >   sh: nand: make use of mtd_to_nand() where appropriate
> >   mtd: nand: make use of mtd_to_nand() in NAND core code
> >   mtd: nand: make use of mtd_to_nand() in NAND drivers
> >   staging: mt29f_spinand: make use of mtd_to_nand()
> >   mtd: nand: embed an mtd_info structure into nand_chip
> >   mtd: nand: add nand_to_mtd() helper
> 
> Pulled the rest up to here into l2-mtd.git.

Okay, thanks.

> 
> >   coccinelle: nand: detect and correct drivers embedding an mtd_info
> >     object
> 
> I believe Julia had comments on this. That probably would go through the
> kbuild tree in the end anyway (?).

Julia proposed to generate this script using sgen, so I guess this will
come later through a different tree.

> 
> >   mtd: nand: use the mtd instance embedded in struct nand_chip
> 
> There's still at least one problem in this patch (commented on the
> patch). It touches a lot of drivers, so any extra review would be great.

Yep, I think I'll resend the series and split the modification so that
you can pick changes independently (as you suggested a few days ago).

Anyway, reviews from other people would be much appreciated. As I said,
most of changes have been automated with coccinelle, but some of them
have been made manually done, and this is the case for all drivers using
the following pattern:

var = kzalloc(sizeof(struct mtd_info) +
	      sizeof(struct nand_chip) + ... ,...);

because I failed to find a pattern common enough to match the cases I
had, and manually fixing them was easier for me...

> 
> >   mtd: nand: update the documentation to reflect framework changes
> >   staging: mt29f_spinand: use the mtd instance embedded in struct
> >     nand_chip
> >   cris: nand: use the mtd instance embedded in struct nand_chip
> >   mtd: nand: update mtd_to_nand()
> >   mtd: nand: remove useless mtd->priv = chip assignments
> >   cris: nand: remove useless mtd->priv = chip assignments
> >   staging: mt29f_spinand: remove useless mtd->priv = chip assignment
> >   mtd: nand: simplify nand_dt_init() usage
> >   mtd: nand: kill the chip->flash_node field
> >   mtd: nand: add helpers to access ->priv
> >   ARM: make use of nand_set/get_controller_data() helpers
> >   mtd: nand: make use of nand_set/get_controller_data() helpers
> >   staging: mt29f_spinand: make use of nand_set/get_controller_data()
> >     helpers
> 
> All the rest look good to me. I'll wait until I get a good copy of patch
> 12 before taking them.

Sure.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
