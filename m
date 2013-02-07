From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Feb 2013 13:04:36 +0800
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <5112A933.4090108@wwwdotorg.org>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
 <20130204160133.GH17786@n2100.arm.linux.org.uk>
 <20130206093236.GD17833@n2100.arm.linux.org.uk>
 <5112A933.4090108@wwwdotorg.org>
Message-ID: <20130207050434.GA7697@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 12:04:19PM -0700, Stephen Warren wrote:
> On 02/06/2013 02:32 AM, Russell King - ARM Linux wrote:
> > On Mon, Feb 04, 2013 at 04:01:33PM +0000, Russell King - ARM Linux wrote:
> >> On Fri, Jan 18, 2013 at 10:45:20AM +0800, Shawn Guo wrote:
> >>> Instead of giving zero support of uncompress debug for multiplatform
> >>> build, the patch turns uncompress debug into one part of DEBUG_LL
> >>> support.  When DEBUG_LL is turned on for a particular platform,
> >>> uncompress debug works too for that platform.
> >>>
> >>> It reuses the platform DEBUG_LL macros by creating a simple
> >>> arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
> >>> included there, and implements a generic putc() using those macros.
> >>
> >> Ok, I've applied this on the previso that _no one_ in future whinges if
> >> the debug infrastructure doesn't quite meet their expectation.  The
> >> debug infrastructure remains first and foremost that: a simple debug
> >> infrastructure suitable for use in the early assembly and the like.
> >>
> >> That is its primary concern and trumps any requirements from consoles,
> >> early printk, decompressor output, and the like.
> > 
> > ... and now I've dropped the two patches because it causes build failures
> > for all OMAP and PXA platforms.
> 
> It also breaks tegra_defconfig. For reference, the (or perhaps just a)
> reason here is that arch/arm/include/debug/tegra.S references symbol
> tegra_uart_config, which is declared in arch/arm/mach-tegra/common.c,
> which isn't part of the decompressor build. Tegra's uncompress.h doesn't
> touch this symbol, hence avoids this problem.
> 
Thanks for the info, Stephen.

>From what I see, the patch breaks omap, pxa and tegra build by
different causes.

=== omap ===

  AS      arch/arm/boot/compressed/debug.o
  LD      arch/arm/boot/compressed/vmlinux
`.data' referenced in section `.text' of arch/arm/boot/compressed/debug.o: defined in discarded section `.data' of arch/arm/boot/compressed/debug.o
make[3]: *** [arch/arm/boot/compressed/vmlinux] Error 1

The following change moving the variables out of stack section seems
fixing the failure, but I'm not quite sure if it works.

8<---
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug
index cfaed13..7b2877e 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -17,11 +17,9 @@

 #define UART_OFFSET(addr)      ((addr) & 0x00ffffff)

-               .pushsection .data
 omap_uart_phys:        .word   0
 omap_uart_virt:        .word   0
 omap_uart_lsr: .word   0
-               .popsection

                /*
                 * Note that this code won't work if the bootloader passes

--->8

=== pxa/mmp ===

  AS      arch/arm/boot/compressed/debug.o
arch/arm/boot/compressed/debug.S: Assembler messages:
arch/arm/boot/compressed/debug.S:8: Error: garbage following instruction -- `ldr r2,=IOMEM(0xfe000000)'
make[3]: *** [arch/arm/boot/compressed/debug.o] Error 1

This is fairly easy to fix with the following change.

8<---
diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
index bdb0e25..6e8382d 100644
--- a/arch/arm/boot/compressed/debug.S
+++ b/arch/arm/boot/compressed/debug.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm/assembler.h>

 #include CONFIG_DEBUG_LL_INCLUDE

--->8

=== tegra ===

  LD      arch/arm/boot/compressed/vmlinux
arch/arm/boot/compressed/debug.o: In function `putc':
arch/arm/boot/compressed/debug.S:7: undefined reference to `tegra_uart_config'
make[3]: *** [arch/arm/boot/compressed/vmlinux] Error 1

You have explained the cause clearly.

> I'd guess OMAP is broken for similar reasons, since when I created the
> tegra_uart_config symbol I was inspired by the OMAP DEBUG_LL code.
> 
> Perhaps the patch can be re-cast to only affect multi-platform kernels,
> and leave unconverted platforms using uncompress.h (at least, I assume
> that must be the problem).

Indeed.  The arch/arm/boot/compressed/debug.S shouldn't be part of
traditional build but only multiplatform.  Let's force that with the
change below.

8<---
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index c9865f6..13bdd10 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,9 +24,11 @@ endif
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD   = head.o
 OBJS   += misc.o decompress.o
+ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
 ifeq ($(CONFIG_DEBUG_LL),y)
 OBJS   += debug.o
 endif
+endif
 FONTC  = $(srctree)/drivers/video/console/font_acorn_8x8.c

 # string library code (-Os is enforced to keep it much smaller)
--->8

Shawn
