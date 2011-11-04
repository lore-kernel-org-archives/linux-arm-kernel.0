From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Nov 2011 16:57:45 +0000
Subject: [PATCH v3 11/17] ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1320425871-30564-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ux500 platforms to be using the gic_handle_irq
function as their primary interrupt handler.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Kconfig                    |    1 +
 arch/arm/mach-ux500/board-mop500.c             |    4 ++++
 arch/arm/mach-ux500/board-u5500.c              |    2 ++
 arch/arm/mach-ux500/include/mach/entry-macro.S |    2 --
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index a3e0c86..bb2b52b 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -7,6 +7,7 @@ config UX500_SOC_COMMON
 	select HAS_MTU
 	select ARM_ERRATA_753970
 	select ARM_ERRATA_754322
+	select MULTI_IRQ_HANDLER
 
 menu "Ux500 SoC"
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index f0b1a00..2539b0b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -33,6 +33,7 @@
 #include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 
 #include <plat/i2c.h>
 #include <plat/ste_dma40.h>
@@ -696,6 +697,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= mop500_init_machine,
 MACHINE_END
 
@@ -705,6 +707,7 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= hrefv60_init_machine,
 MACHINE_END
 
@@ -715,5 +718,6 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= snowball_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index aeb125a..2141658 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/mfd/ab5500/ab5500.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -150,5 +151,6 @@ MACHINE_START(U5500, "ST-Ericsson U5500 Platform")
 	.map_io		= u5500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= u5500_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
index 071bba9..e16299e 100644
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -10,8 +10,6 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <asm/hardware/entry-macro-gic.S>
 
 		.macro	disable_fiq
 		.endm
-- 
1.7.0.4
