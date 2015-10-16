From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 18:24:21 +0200
Subject: [PATCH v2 2/4] mtd: nand: Allow MTD_NAND_BRCMNAND to be selected
 for ARM64
In-Reply-To: <1444986537-28387-3-git-send-email-anup.patel@broadcom.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
 <1444986537-28387-3-git-send-email-anup.patel@broadcom.com>
Message-ID: <5673177.0QYFhMPCBq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 October 2015 14:38:55 Anup Patel wrote:
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 3324281..a1b5819 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -393,7 +393,7 @@ config MTD_NAND_GPMI_NAND
>  
>  config MTD_NAND_BRCMNAND
>         tristate "Broadcom STB NAND controller"
> -       depends on ARM || MIPS
> +       depends on ARM || ARM64 || MIPS
>         help
>           Enables the Broadcom NAND controller driver. The controller was
>           originally designed for Set-Top Box but is used on various BCM7xxx,
> -- 
> 

I think you also need this one:

8<-----------
>From 0ab7b2d32921b3f3da15274d8c3982ba1d54660f Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 4 Jun 2015 09:25:59 +0200
Subject: [PATCH] mtd: brcmnand depends on MTD_NAND

MTD_NAND_BRCMNAND uses the generic nand functions, but is currently allowed
to be built without CONFIG_MTD_NAND, which results in a link error:

drivers/built-in.o: In function `brcmnand_remove':
coresight-replicator.c:(.text+0x17ae6c): undefined reference to `nand_release'
drivers/built-in.o: In function `brcmnand_probe':
coresight-replicator.c:(.text+0x17d4b4): undefined reference to `nand_scan_ident'
coresight-replicator.c:(.text+0x17d948): undefined reference to `nand_scan_tail'

This adds an explicit Kconfig dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 289664089cf3..4b7e853ce35d 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -393,6 +393,7 @@ config MTD_NAND_GPMI_NAND
 
 config MTD_NAND_BRCMNAND
 	tristate "Broadcom STB NAND controller"
+	depends on MTD_NAND
 	depends on ARM || ARM64 || MIPS
 	help
 	  Enables the Broadcom NAND controller driver. The controller was
