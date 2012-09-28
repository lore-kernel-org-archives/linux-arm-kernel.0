From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 20:13:34 +0000
Subject: [PATCH 13/24] ARM: nomadik: use __iomem pointers for MMIO
In-Reply-To: <20120915113356.GA31284@mail.gnudd.com>
References: <1347658492-11608-14-git-send-email-arnd@arndb.de>
 <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <20120915113356.GA31284@mail.gnudd.com>
Message-ID: <201209282013.34638.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 September 2012, Alessandro Rubini wrote:
> > -     .options        = NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING \
> > -                     | NAND_NO_READRDY,
> > +     .options        = NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING,
> 
> This is not clear to me, and it looks unrelated. But I admit I haven't
> studied what happened to NAND_NO_READRDY lately.
> 
> If this hunk is desired and not just something else
> that slipped in, then
> 
>   Acked-by: Alessandro Rubini <rubini@unipv.it>

I've added the patch below to the next/fixes-non-critical branch now,
to avoid the build error in linux-next.

	Arnd

>From 06f8ab806e9e180966e812f6e47a0735bba638d8 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 23 Sep 2012 22:57:22 +0000
Subject: [PATCH] ARM: nomadik: remove NAND_NO_READRDY use

The nhk8815 board files uses NAND_NO_READRDY in its platform data, but
this macro is getting removed because it was not being used anywhere.

Without this patch, building nhk8815_defconfig results in:

arch/arm/mach-nomadik/board-nhk8815.c:118:6: error: 'NAND_NO_READRDY' undeclared here (not in a function)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 381c080..92a0026 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -112,8 +112,7 @@ static struct mtd_partition nhk8815_partitions[] = {
 static struct nomadik_nand_platform_data nhk8815_nand_data = {
 	.parts		= nhk8815_partitions,
 	.nparts		= ARRAY_SIZE(nhk8815_partitions),
-	.options	= NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING \
-			| NAND_NO_READRDY,
+	.options	= NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING,
 	.init		= nhk8815_nand_init,
 };
 
