From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 22:29:57 +0900
Subject: [PATCH 2/3] ARM: shmobile: Use POSIX "$((..))" instead of
 bashism "$[...]"
In-Reply-To: <1371129052-31506-3-git-send-email-geert@linux-m68k.org>
References: <1371129052-31506-1-git-send-email-geert@linux-m68k.org>
 <1371129052-31506-3-git-send-email-geert@linux-m68k.org>
Message-ID: <20130613132957.GA22787@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 03:10:51PM +0200, Geert Uytterhoeven wrote:
> According to the bash 4.1 manpage, "$[...]" is deprecated, and will be
> removed in upcoming versions of bash.
> Hence replace the bash-specific "$[...]" by POSIX "$((..))" for arithmetic
> expansion, which also allows to drop the forced use of bash.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/arm/mach-shmobile/Makefile.boot |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
> index 95ebc7c..75a55e1 100644
> --- a/arch/arm/mach-shmobile/Makefile.boot
> +++ b/arch/arm/mach-shmobile/Makefile.boot
> @@ -1,5 +1,5 @@
> -__ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
> -		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
> +__ZRELADDR	:= $(shell printf "0x%08x" \
> +		     $$(($(CONFIG_MEMORY_START) + 0x8000)))
>  
>     zreladdr-y   += $(__ZRELADDR)

This code was (very) recently changed by a patch that I
have queued up for v3.11 in the cleanup-boot branch of my renesas tree
on kernel.org. I believe that patch removes the instance of $[..]].


commit 12dca809ef785e451263351325d4806198040b40
Author: Magnus Damm <damm@opensource.se>
Date:   Mon Jun 10 18:28:57 2013 +0900

    ARM: shmobile: uImage load address rework
    
    This is V2 of the mach-shmobile uImage load address rework patch.
    
    Rework the mach-shmobile uImage load address calculation by storing
    the per-board load addresses in Makefile.boot. This removes the
    CONFIG_MEMORY_START dependency from Makefile.boot, and it also makes
    it possible to create safe kernel images that boot on multiple boards.
    
    This is one of several series of code that reworks code not to rely on
    CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.
    
    Signed-off-by: Magnus Damm <damm@opensource.se>
    Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 498efd9..6b147ea 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,6 +1,22 @@
-__ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
-		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
+# per-board load address for uImage
+loadaddr-y	:=
+loadaddr-$(CONFIG_MACH_AG5EVM) += 0x40008000
+loadaddr-$(CONFIG_MACH_AP4EVB) += 0x40008000
+loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
+loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
+loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
+loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
+loadaddr-$(CONFIG_MACH_BONITO) += 0x40008000
+loadaddr-$(CONFIG_MACH_KOTA2) += 0x41008000
+loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
+loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
+loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
+loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
+loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
+loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
+loadaddr-$(CONFIG_MACH_MARZEN_REFERENCE) += 0x60008000
 
+__ZRELADDR	:= $(sort $(loadaddr-y))
    zreladdr-y   += $(__ZRELADDR)
 
 # Unsupported legacy stuff
