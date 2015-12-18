From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 18 Dec 2015 14:03:40 -0800
Subject: [PATCH v4 00/58] mtd: nand: refactor the NAND subsystem (part 1)
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151218220340.GP10460@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 10, 2015 at 08:59:44AM +0100, Boris Brezillon wrote:
> Hello,
> 
> This huge series aims at clarifying the relationship between the mtd and
> nand_chip structures and hiding NAND framework internals to NAND
> controller drivers.
> 
> The first part of the series (patch 1 to 4) is a set of fixes/simple
> reworks easing the migration to mtd_to_nand().
> 
> The second part of the series embeds the mtd structure into the nand_chip
> one so that NAND controller drivers don't have to bother allocating the
> MTD device and linking it with the NAND chip.
> 
> The last part of the series hides accesses to the chip->priv field behind
> two helper functions.
> 
> This allows removal of some of the boilerplate code done in all NAND
> controller drivers, but most importantly, it unifies a bit the way NAND
> chip structures are instantiated (even though we still have two different
> kinds of drivers: those embedding the nand_chip struct into their private
> nand chip representation, and those allocating two different structures
> and linking them together with the chip->priv field).
> 
> As said in the title, this refactoring is only the first step. I plan to
> rework the NAND controller / NAND chip separation for pretty much the same
> reasons: clarifying the separation between the two concepts, and getting
> rid of more boilerplate code in NAND controller drivers.
> 
> Stay tuned ;-).
> 
> Best Regards,
> 
> Boris

Thanks a lot for all the work here! Nice cleanups. I think I've pushed
everything correctly to l2-mtd.git. Please verify that things look sane
to you, if possible. There were a few v5's thrown in after the fact, as
well as other cleanups that required apply-conflicts.

I'll summarize below anything I remember that's changed since the cover
letter, for posterity.

> Changes since v3:
> - fix some bugs introduced when migrating to nand_to_mtd()
> - split the huge commit switching all drivers to nand_to_mtd() into several
>   commits (one per driver) to ease review and integration
> - add a simple fixes/reworks at the beginning of the series (mainly to
>   ease migration to nand_to_mtd())
> - drop already applied patches.
> 
> Changes since v2:
> - fix some build warnings/erros
> 
> Changes since v1:
> - dropped already applied patches
> - fixed some typos
> - manually fixed some modifications omitted by the coccinelle scripts
> - manually reworked modifactions done by coccinelle scripts to improve
>   readability and fix coding style issues
> 
> *** BLURB HERE ***

Nice blurb :)

> 
> Boris Brezillon (58):
>   mtd: nand: denali: add missing nand_release() call in denali_remove()

You sent v5 of this, and I added in the comment that was
written/requested afterward. That caused some small conflicts later.

>   mtd: nand: fsmc: create and use mtd_to_fsmc()
>   mtd: nand: nuc900: create and use mtd_to_nuc900()
>   mtd: nand: omap2: create and use mtd_to_omap()
>   mtd: nand: ams-delta: use the mtd instance embedded in struct
>     nand_chip
>   mtd: nand: atmel: use the mtd instance embedded in struct nand_chip
>   mtd: nand: au1550nd: use the mtd instance embedded in struct nand_chip
>   mtd: nand: bcm47xx: use the mtd instance embedded in struct nand_chip
>   mtd: nand: bf5xx: use the mtd instance embedded in struct nand_chip
>   mtd: nand: brcm: use the mtd instance embedded in struct nand_chip
>   mtd: nand: cafe: use the mtd instance embedded in struct nand_chip
>   mtd: nand: cmx270: use the mtd instance embedded in struct nand_chip

^^ I dropped one comment in this one

>   mtd: nand: cs553x: use the mtd instance embedded in struct nand_chip
>   mtd: nand: davinci: use the mtd instance embedded in struct nand_chip
>   mtd: nand: denali: use the mtd instance embedded in struct nand_chip

You sent v5, but there were still trivial conflicts.

>   mtd: nand: diskonchip: use the mtd instance embedded in struct
>     nand_chip
>   mtd: nand: docg4: use the mtd instance embedded in struct nand_chip

I cleaned some things up after this one, causing more trivial conflicts
later in the controller_data accessor patches.

>   mtd: nand: fsl_elbc: use the mtd instance embedded in struct nand_chip
>   mtd: nand: fsl_ifc: use the mtd instance embedded in struct nand_chip
>   mtd: nand: fsl_upm: use the mtd instance embedded in struct nand_chip
>   mtd: nand: fsmc: use the mtd instance embedded in struct nand_chip
>   mtd: nand: gpio: use the mtd instance embedded in struct nand_chip
>   mtd: nand: gpmi: use the mtd instance embedded in struct nand_chip
>   mtd: nand: hisi504: use the mtd instance embedded in struct nand_chip
>   mtd: nand: jz4740: use the mtd instance embedded in struct nand_chip
>   mtd: nand: lpc32xx: use the mtd instance embedded in struct nand_chip
>   mtd: nand: mpc5121: use the mtd instance embedded in struct nand_chip
>   mtd: nand: mxc: use the mtd instance embedded in struct nand_chip
>   mtd: nand: nandsim: use the mtd instance embedded in struct nand_chip
>   mtd: nand: ndfc: use the mtd instance embedded in struct nand_chip
>   mtd: nand: nuc900: use the mtd instance embedded in struct nand_chip
>   mtd: nand: omap2: use the mtd instance embedded in struct nand_chip
>   mtd: nand: orion: use the mtd instance embedded in struct nand_chip
>   mtd: nand: pasemi: use the mtd instance embedded in struct nand_chip
>   mtd: nand: plat: use the mtd instance embedded in struct nand_chip
>   mtd: nand: pxa3xx: use the mtd instance embedded in struct nand_chip
>   mtd: nand: r852: use the mtd instance embedded in struct nand_chip
>   mtd: nand: s3c2410: use the mtd instance embedded in struct nand_chip
>   mtd: nand: sh_flctl: use the mtd instance embedded in struct nand_chip
>   mtd: nand: sharpsl: use the mtd instance embedded in struct nand_chip
>   mtd: nand: socrates: use the mtd instance embedded in struct nand_chip
>   mtd: nand: sunxi: use the mtd instance embedded in struct nand_chip
>   mtd: nand: tmio: use the mtd instance embedded in struct nand_chip
>   mtd: nand: txx9ndfmc: use the mtd instance embedded in struct
>     nand_chip
>   mtd: nand: vf610: use the mtd instance embedded in struct nand_chip
>   mtd: nand: update the documentation to reflect framework changes
>   staging: mt29f_spinand: use the mtd instance embedded in struct
>     nand_chip
>   cris: nand: use the mtd instance embedded in struct nand_chip
>   mtd: nand: update mtd_to_nand()
>   mtd: nand: remove useless mtd->priv = chip assignments
>   cris: nand: remove useless mtd->priv = chip assignments
>   staging: mt29f_spinand: remove useless mtd->priv = chip assignment
>   mtd: nand: simplify nand_dt_init() usage
>   mtd: nand: kill the chip->flash_node field
>   mtd: nand: add helpers to access ->priv

I have some comments on this one, so I'm not pushing the last 4 patches
for now.

>   ARM: make use of nand_set/get_controller_data() helpers

BTW, I see that plat_nand.c and arch/arm/mach-ixp4xx/ixdp425-setup.c are
making conflicting use of the ->priv field. You've essentially fixed the
conflict in:

  [PATCH] mtd: nand: remove unused and buggy get_platform_nandchip() helper function
  http://lists.infradead.org/pipermail/linux-mtd/2015-December/064409.html

But really, that's a pretty big hack still... I don't care to fix it
myself right now. Just whining :)

>   mtd: nand: make use of nand_set/get_controller_data() helpers
>   staging: mt29f_spinand: make use of nand_set/get_controller_data()
>     helpers

[...]

So, this has passed all my build tests and LGTM. Pushed patches 1 - 54
to l2-mtd.git!

Much thanks,
Brian
