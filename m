From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 15 Mar 2018 16:19:51 +0100
Subject: [PATCH 00/52] Allow dynamic allocations during NAND chip
 identification phase
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180315161951.58f91857@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Fri,  2 Mar 2018 18:03:08 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hello,
> 
> This series make a quite deep change in the NAND framework. Until now,
> the NAND chip identification phase could be done in two manners from the
> controller driver perspective:
> 
> 1/ Call nand_scan()
> 
>   or
> 
> 1/ Call nand_scan_ident()
> 2/ Do some controller-dependent configuration
> 3/ Call nand_scan_tail().
> 
> The fact that the identifaction could be split in two operations
> involved that in the NAND framework, it was not possible to do any
> dynamic allocation without risking a memory leak.

Well, it's not entirely true. We could have a nand_scan_ident_cleanup()
function, but that means patching all the drivers anyway to make them
call this function when something fails between nand_scan_ident() and
nand_scan_tail().

> What if the core
> allocates a structure, then the driver between nand_scan_ident() and
> nand_scan_tail() decides it cannot handle the chip and errors out?
> The structure allocated by the core is lost: it is a memory leak.
> 
> To avoid this situation, we migrate all drivers to use nand_scan(). But
> because drivers need to do some configuration before nand_scan_tail(), a
> first hook is offered, embedded in the nand_ecc_ctrl structure, called
> ->attach_chip().
> Drivers that need to tweak their configuration after  
> nand_scan_ident() should implement it. Any dynamically allocated space
> in ->attach_chip() must be freed in the second hook: ->detach_chip().

As already discussed privately, I don't think these hooks belongs in
nand_ecc_ctrl. It's more something that is controller-related, so how
about adding them to the nand_hw_ctrl struct?

> 
> The ->detach_chip() does not have to be called upon error in the
> controller driver probe function. The nand_realease() helper already
> exists for that and will do the call if needed.

nand_release() is not exactly the opposite of nand_scan() because it
also takes care of the mtd dev unregistration. I think what you're
looking for is nand_cleanup().

> Of course, this helper
> must be called on error after a successful nand_scan(), just like
> before.
> 
> Once all drivers not using nand_scan() (yet) are migrated,
> nand_scan_ident() and nand_scan_tail() are unexported and only available
> internally.
> 
> A previous work [1] removed the ONFI/JEDEC parameter pages and instead
> allocated a nand_parameters structure in nand_chip, embedding both
> generic entries and ONFI-related ones. The deal was, once dynamic
> allocation possible, allocate in nand_scan_ident() the ONFI strcuture
> only if actually needed. This is done in the last patches.
> 
> All these changes have been tested with the GPMI driver and tested by
> the 0-day robot.
> 
> Thank you,
> Miqu?l
> 
> [1] http://lists.infradead.org/pipermail/linux-mtd/2018-March/079456.html
> 
> 
> Miquel Raynal (52):
>   mtd: rawnand: add hooks that may be called during nand_scan()
>   mtd: rawnand: bf5xx: fix probe function error path
>   mtd: rawnand: bf5xx: convert driver to nand_scan()
>   mtd: rawnand: brcmnand: fix probe function error path
>   mtd: rawnand: brcmnand: convert driver to nand_scan()
>   mtd: rawnand: cafe: fix probe function error path
>   mtd: rawnand: cafe: convert driver to nand_scan()
>   mtd: rawnand: davinci: fix probe function error path
>   mtd: rawnand: davinci: convert driver to nand_scan()
>   mtd: rawnand: denali: fix probe function error path
>   mtd: rawnand: denali: convert to nand_scan()
>   mtd: rawnand: fsl_elbc: fix probe function error path
>   mtd: rawnand: fsl_elbc: convert driver to nand_scan()
>   mtd: rawnand: fsl_ifc: fix probe function error path
>   mtd: rawnand: fsl_ifc: convert driver to nand_scan()
>   mtd: rawnand: fsmc: fix probe function error path
>   mtd: rawnand: fsmc: convert driver to nand_scan()
>   mtd: rawnand: gpmi: convert driver to nand_scan()
>   mtd: rawnand: hisi504: enhance the probe function error path
>   mtd: rawnand: hisi504: convert driver to nand_scan()
>   mtd: rawnand: jz4780: convert driver to nand_scan()
>   mtd: rawnand: lpc32xx_mlc: enhance the probe function error path
>   mtd: rawnand: lpc32xx_mlc: convert driver to nand_scan()
>   mtd: rawnand: lpc32xx_slc: enhance the probe function error
>   mtd: rawnand: lpc32xx_slc: convert driver to nand_scan()
>   mtd: rawnand: marvell: convert driver to nand_scan()
>   mtd: rawnand: mtk: convert driver to nand_scan()
>   mtd: rawnand: mxc: fix probe function error path
>   mtd: rawnand: mxc: convert driver to nand_scan()
>   mtd: rawnand: nandsim: convert driver to nand_scan()
>   mtd: rawnand: omap2: fix the probe function error path
>   mtd: rawnand: omap2: convert driver to nand_scan()
>   mtd: rawnand: s3c2410: enhance the probe function error path
>   mtd: rawnand: s3c2410: convert driver to nand_scan()
>   mtd: rawnand: sh_flctl: move all NAND chip related setup in one
>     function
>   mtd: rawnand: sh_flctl: fix the probe function error path
>   mtd: rawnand: sh_flctl: convert driver to nand_scan()
>   mtd: rawnand: sunxi: convert driver to nand_scan()
>   mtd: rawnand: tango: fix probe function error path
>   mtd: rawnand: tango: convert driver to nand_scan()
>   mtd: rawnand: txx9ndfmc: convert driver to nand_scan()
>   mtd: rawnand: vf610: convert driver to nand_scan()
>   mtd: rawnand: atmel: convert driver to nand_scan()
>   mtd: rawnand: add a field in nand_chip to fill an array of IDs
>   mtd: rawnand: sm_common: make use of the new flash_ids table entry
>   mtd: rawnand: sm_common: convert driver to nand_scan()
>   mtd: rawnand: docg4: fix the probe function error path
>   mtd: rawnand: docg4: convert driver to nand_scan()
>   mtd: rawnand: qcom: convert driver to nand_scan()
>   mtd: rawnand: jz4740: convert driver to nand_scan()
>   mtd: rawnand: do not export nand_scan_[ident|tail]() anymore
>   mtd: rawnand: allocate dynamically ONFI parameters during detection

Can we try to do this progressively instead of sending a new
version of a 50+ patch series? How about we first try to fix all
drivers that do not call nand_cleanup() when something fails after
nand_scan_tail()?

Once we have that fixed, I'd be happy to review the other patches ;-).

Anyway, thanks for working on that. The 'no dynamic allocation in
nand_scan_ident()' has been a painful limitation, and I'm glad to see
it disappear.

Regards,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
