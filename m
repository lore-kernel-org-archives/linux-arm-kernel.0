From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 17 Apr 2016 21:01:14 +0200
Subject: [PATCH 12/12] mtd: mtd: drop NAND_ECC_SOFT_BCH enum value
In-Reply-To: <CACna6rzjXrjrx1Wq3cngYmKgSFAME7ZYNoPBpbyO3VWnHgMBAg@mail.gmail.com>
References: <1460750052-16285-1-git-send-email-zajec5@gmail.com>
 <1460750052-16285-13-git-send-email-zajec5@gmail.com>
 <20160417190537.0b484bdd@bbrezillon>
 <CACna6rzjXrjrx1Wq3cngYmKgSFAME7ZYNoPBpbyO3VWnHgMBAg@mail.gmail.com>
Message-ID: <20160417210114.7895ae16@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 Apr 2016 19:10:11 +0200
Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> On 17 April 2016 at 19:05, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Fri, 15 Apr 2016 21:54:12 +0200
> > Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> >
> >> This value should not be part of nand_ecc_modes_t as it specifies
> >> algorithm not a mode. We successfully managed to introduce new "algo"
> >> field which is respected now.
> >>
> >> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> >> ---
> >>  drivers/mtd/nand/fsmc_nand.c   | 3 +--
> >>  drivers/mtd/nand/jz4780_nand.c | 1 -
> >>  drivers/mtd/nand/nand_base.c   | 2 --
> >>  drivers/mtd/nand/nandsim.c     | 2 +-
> >>  drivers/mtd/nand/sunxi_nand.c  | 2 --
> >>  include/linux/mtd/nand.h       | 1 -
> >>  6 files changed, 2 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
> >> index 0f8c63f..d4f454a 100644
> >> --- a/drivers/mtd/nand/fsmc_nand.c
> >> +++ b/drivers/mtd/nand/fsmc_nand.c
> >> @@ -959,7 +959,6 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
> >>                       break;
> >>
> >>               case NAND_ECC_SOFT:
> >> -             case NAND_ECC_SOFT_BCH:
> >>                       if (nand->ecc.algo == NAND_ECC_BCH) {
> >>                               dev_info(&pdev->dev, "Using 4-bit SW BCH ECC scheme\n");
> >>                               break;
> >> @@ -974,7 +973,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
> >>                * Don't set layout for BCH4 SW ECC. This will be
> >>                * generated later in nand_bch_init() later.
> >>                */
> >> -             if (nand->ecc.mode != NAND_ECC_SOFT_BCH) {
> >> +             if (nand->ecc.mode == NAND_ECC_HW) {
> >
> > This test is wrong, it should be
> >
> >                 if (nand->ecc.mode != NAND_ECC_SOFT ||
> >                     nand->ecc.algo != NAND_ECC_BCH)
> >
> > or
> >                 if (!(nand->ecc.mode == NAND_ECC_SOFT &&
> >                       nand->ecc.algo == NAND_ECC_BCH)
> 
> This driver supports only 2 modes (see switch above).

Indeed. Sorry, I didn't read the full context.

Thanks for the clarification.

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
