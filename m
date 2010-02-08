From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 8 Feb 2010 18:55:22 +0530
Subject: [PATCH] ux500: fix DEBUG_LL/earlyprintk
Message-ID: <1265635522-25842-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a static mapping for the UART and correct its virtual address in
debug-macro.S, to make DEBUG_LL/earlyprintk work.

Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/cpu-u8500.c                |    1 +
 arch/arm/mach-ux500/include/mach/debug-macro.S |    9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 5f05e58..397bc1f 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -33,6 +33,7 @@ static struct platform_device *platform_devs[] __initdata = {
 
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index 8f21b6a..8de225e 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -8,12 +8,13 @@
  * published by the Free Software Foundation.
  *
  */
+#include <mach/hardware.h>
+
 	.macro	addruart,rx
 	mrc	p15, 0, \rx, c1, c0
-	tst	\rx, #1			@MMU enabled?
-	moveq	\rx, #0x80000000	@MMU off, Physical address
-	movne	\rx, #0xF0000000	@MMU on, Virtual address
-	orr	\rx, \rx, #0x7000
+	tst	\rx, #1					@ MMU enabled?
+	ldreq	\rx, =U8500_UART2_BASE			@ no, physical address
+	ldrne	\rx, =IO_ADDRESS(U8500_UART2_BASE)	@ yes, virtual address
 	.endm
 
 #include <asm/hardware/debug-pl01x.S>
-- 
1.6.5.3
