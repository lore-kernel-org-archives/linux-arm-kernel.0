From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 11:41:45 +0100
Subject: [PATCHv2 08/10] ARM: u300: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317206507-18867-9-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a generic IRQ handler for multiple VIC devices use it
for u300 to help building multi platform kernels.

Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-u300/include/mach/entry-macro.S |   24 ------------------------
 arch/arm/mach-u300/u300.c                     |    2 ++
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eb23c6e..6587e20 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -838,6 +838,7 @@ config ARCH_U300
 	select CLKDEV_LOOKUP
 	select HAVE_MACH_CLKDEV
 	select GENERIC_GPIO
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
diff --git a/arch/arm/mach-u300/include/mach/entry-macro.S b/arch/arm/mach-u300/include/mach/entry-macro.S
index 20731ae..7181d6a 100644
--- a/arch/arm/mach-u300/include/mach/entry-macro.S
+++ b/arch/arm/mach-u300/include/mach/entry-macro.S
@@ -8,33 +8,9 @@
  * Low-level IRQ helper macros for ST-Ericsson U300
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
-#include <mach/hardware.h>
-#include <asm/hardware/vic.h>
 
 	.macro	disable_fiq
 	.endm
 
-	.macro  get_irqnr_preamble, base, tmp
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr	\base, = U300_AHB_PER_VIRT_BASE-U300_AHB_PER_PHYS_BASE+U300_INTCON0_BASE
-	ldr	\irqstat, [\base, #VIC_IRQ_STATUS] @ get masked status
-	mov	\irqnr, #0
-	teq	\irqstat, #0
-	bne	1002f
-1001:	ldr	\base, = U300_AHB_PER_VIRT_BASE-U300_AHB_PER_PHYS_BASE+U300_INTCON1_BASE
-	ldr	\irqstat, [\base, #VIC_IRQ_STATUS] @ get masked status
-	mov	\irqnr, #32
-	teq	\irqstat, #0
-	beq	1003f
-1002:	tst	\irqstat, #1
-	bne	1003f
-	add	\irqnr, \irqnr, #1
-	movs	\irqstat, \irqstat, lsr #1
-	bne	1002b
-1003:		/* EQ will be set if no irqs pending */
-	.endm
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index 48b3b7f..6292920 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/memory.h>
@@ -65,6 +66,7 @@ MACHINE_START(U300, MACH_U300_STRING)
 	.map_io		= u300_map_io,
 	.reserve	= u300_reserve,
 	.init_irq	= u300_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &u300_timer,
 	.init_machine	= u300_init_machine,
 MACHINE_END
-- 
1.7.4.1
