From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:10:03 +0000
Subject: [PATCHv4 06/13] ARM: nomadik: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1320369010-23428-7-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a generic IRQ handler for multiple VIC devices use it
for nomadik to help building multi platform kernels.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                 |    1 +
 arch/arm/mach-nomadik/board-nhk8815.c            |    2 +
 arch/arm/mach-nomadik/include/mach/entry-macro.S |   30 ----------------------
 3 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d90b09d..149fd45 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -918,6 +918,7 @@ config ARCH_NOMADIK
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 0cbb74c..f98259c 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -21,6 +21,7 @@
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
+#include <asm/hardware/vic.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -280,6 +281,7 @@ MACHINE_START(NOMADIK, "NHK8815")
 	.atag_offset	= 0x100,
 	.map_io		= cpu8815_map_io,
 	.init_irq	= cpu8815_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &nomadik_timer,
 	.init_machine	= nhk8815_platform_init,
 MACHINE_END
diff --git a/arch/arm/mach-nomadik/include/mach/entry-macro.S b/arch/arm/mach-nomadik/include/mach/entry-macro.S
index 49f1aa3..98ea1c1 100644
--- a/arch/arm/mach-nomadik/include/mach/entry-macro.S
+++ b/arch/arm/mach-nomadik/include/mach/entry-macro.S
@@ -6,38 +6,8 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-
 	.macro	disable_fiq
 	.endm
 
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =IO_ADDRESS(NOMADIK_IC_BASE)
-	.endm
-
 	.macro	arch_ret_to_user, tmp1, tmp2
 	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	/* This stanza gets the irq mask from one of two status registers */
-	mov	\irqnr, #0
-	ldr	\irqstat, [\base, #VIC_REG_IRQSR0]	@ get masked status
-	cmp	\irqstat, #0
-	bne	1001f
-	add	\irqnr, \irqnr, #32
-	ldr	\irqstat, [\base, #VIC_REG_IRQSR1]	@ get masked status
-
-1001:	tst	\irqstat, #15
-	bne	1002f
-	add	\irqnr, \irqnr, #4
-	movs	\irqstat, \irqstat, lsr #4
-	bne	1001b
-1002:	tst	\irqstat, #1
-	bne	1003f
-	add	\irqnr, \irqnr, #1
-	movs	\irqstat, \irqstat, lsr #1
-	bne	1002b
-1003:	/* EQ will be set if no irqs pending */
-	.endm
-- 
1.7.5.4
