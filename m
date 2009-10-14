From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 14 Oct 2009 11:42:19 +0300
Subject: [PATCH 1/2] Update ts72xx to use generic platform nand driver
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7E59@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
	<1255260621.16942.38.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7E59@mi8nycmail19.Mi8.com>
Message-ID: <1255509739.32489.123.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2009-10-11 at 17:19 -0400, H Hartley Sweeten wrote:
> Update the ts72xx platform's nand driver support.
>  
> This changes the ts72xx platform from using a custom nand driver
> (ts7250.c) to the generic platform nand driver (plat_nand.c).
>  
> Tested on TS-7250 with 32MB NAND.
>  
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Matthieu Crapet <mcrapet@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-mtd@lists.infradead.org>
> 
> ---
> 
> V2 - rebased to current mtd tree (Artem Bityutskiy)
> 
>  arch/arm/mach-ep93xx/ts72xx.c |  177 +++++++++++++++++++++++++++++------------
>  1 files changed, 125 insertions(+), 52 deletions(-)

Ok, I've tried this patch on both mtd-2.6 and linux-2.6 git trees, and
it does not apply cleanly.

[dedekind at eru mtd-2.6]$ git am ../l2-mtd-2.6.git/sweeten1
Applying: RE: [PATCH 1/2] Update ts72xx to use generic platform nand driver
error: patch failed: arch/arm/mach-ep93xx/ts72xx.c:54
error: arch/arm/mach-ep93xx/ts72xx.c: patch does not apply
Patch failed at 0001 RE: [PATCH 1/2] Update ts72xx to use generic platform nand driver
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
[dedekind at eru mtd-2.6]$ patch -p1  < .git/rebase-apply/patch
patching file arch/arm/mach-ep93xx/ts72xx.c
Hunk #2 succeeded at 56 with fuzz 1.

Ok, I can do things manually:

[dedekind at eru mtd-2.6]$ git update-index arch/arm/mach-ep93xx/ts72xx.c
[dedekind at eru mtd-2.6]$ git am --resolved
Applying: RE: [PATCH 1/2] Update ts72xx to use generic platform nand driver

But then the second patch does not apply anyway:

[dedekind at eru mtd-2.6]$ git am ../l2-mtd-2.6.git/sweeten2
Applying: RE: [PATCH 2/2] Remove now-defunct ts7250 nand driver
error: patch failed: drivers/mtd/nand/ts7250.c:1
error: drivers/mtd/nand/ts7250.c: patch does not apply
Patch failed at 0001 RE: [PATCH 2/2] Remove now-defunct ts7250 nand driver
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
[dedekind at eru mtd-2.6]$ patch -p1 < .git/rebase-apply/patch
patching file arch/arm/mach-ep93xx/include/mach/ts72xx.h
patching file drivers/mtd/nand/Kconfig
patching file drivers/mtd/nand/Makefile
patching file drivers/mtd/nand/ts7250.c
Reversed (or previously applied) patch detected!  Assume -R? [n] ^C

This is where I'm in the mtd-2.6.git tree, for reference.

[dedekind at eru mtd-2.6]$ git show
commit e4af3bf6334341435740fce9ff236ba814686b99
Author: Claudio Scordino <claudio@evidence.eu.com>
Date:   Wed Oct 7 14:27:07 2009 +0200

    mtd: atmel_nand: unused variable removed

    Unused variable "eccpos" removed from atmel_nand driver.

    Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
    Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/drivers/mtd/nand/atmel_nand.c
b/drivers/mtd/nand/atmel_nand.c
index f8e9975..4f62d20 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -192,7 +192,6 @@ static int atmel_nand_calculate(struct mtd_info
*mtd,
 {
        struct nand_chip *nand_chip = mtd->priv;
        struct atmel_nand_host *host = nand_chip->priv;
-       uint32_t *eccpos = nand_chip->ecc.layout->eccpos;
        unsigned int ecc_value;

        /* get the first 2 ECC bytes */

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
