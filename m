From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 11:41:40 +0100
Subject: [PATCHv2 03/10] ARM: ep93xx: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1317206507-18867-4-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a generic IRQ handler for multiple VIC devices use it
for ep93xx to help building multi platform kernels.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-ep93xx/adssphere.c                |    2 +
 arch/arm/mach-ep93xx/edb93xx.c                  |    9 +++++
 arch/arm/mach-ep93xx/gesbc9312.c                |    2 +
 arch/arm/mach-ep93xx/include/mach/entry-macro.S |   42 -----------------------
 arch/arm/mach-ep93xx/micro9.c                   |    5 +++
 arch/arm/mach-ep93xx/simone.c                   |    2 +
 arch/arm/mach-ep93xx/snappercl15.c              |    2 +
 arch/arm/mach-ep93xx/ts72xx.c                   |    2 +
 9 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ebc5d9..7facb7c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -377,6 +377,7 @@ config ARCH_EP93XX
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_USES_GETTIMEOFFSET
+	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 61b98ce..1c09d24 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -16,6 +16,7 @@
 
 #include <mach/hardware.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -36,6 +37,7 @@ MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= adssphere_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 9969bb1..d2f0609 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -38,6 +38,7 @@
 #include <mach/fb.h>
 #include <mach/ep93xx_spi.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -243,6 +244,7 @@ MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
@@ -254,6 +256,7 @@ MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
@@ -265,6 +268,7 @@ MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
@@ -276,6 +280,7 @@ MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
@@ -287,6 +292,7 @@ MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
@@ -298,6 +304,7 @@ MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
@@ -309,6 +316,7 @@ MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
@@ -320,6 +328,7 @@ MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 9bd3152..5e646b9 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -16,6 +16,7 @@
 
 #include <mach/hardware.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -36,6 +37,7 @@ MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= gesbc9312_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/include/mach/entry-macro.S b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
index 96b85e2..9be6edc 100644
--- a/arch/arm/mach-ep93xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-ep93xx/include/mach/entry-macro.S
@@ -9,51 +9,9 @@
  * the Free Software Foundation; either version 2 of the License, or (at
  * your option) any later version.
  */
-#include <mach/ep93xx-regs.h>
 
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =(EP93XX_AHB_VIRT_BASE)
-		orr	\base, \base, #0x000b0000
-		mov	\irqnr, #0
-		ldr	\irqstat, [\base]		@ lower 32 interrupts
-		cmp	\irqstat, #0
-		bne	1001f
-
-		eor	\base, \base, #0x00070000
-		ldr	\irqstat, [\base]		@ upper 32 interrupts
-		cmp	\irqstat, #0
-		beq	1002f
-		mov	\irqnr, #0x20
-
-1001:
-		movs	\tmp, \irqstat, lsl #16
-		movne	\irqstat, \tmp
-		addeq	\irqnr, \irqnr, #16
-
-		movs	\tmp, \irqstat, lsl #8
-		movne	\irqstat, \tmp
-		addeq	\irqnr, \irqnr, #8
-
-		movs	\tmp, \irqstat, lsl #4
-		movne	\irqstat, \tmp
-		addeq	\irqnr, \irqnr, #4
-
-		movs	\tmp, \irqstat, lsl #2
-		movne	\irqstat, \tmp
-		addeq	\irqnr, \irqnr, #2
-
-		movs	\tmp, \irqstat, lsl #1
-		addeq	\irqnr, \irqnr, #1
-		orrs	\base, \base, #1
-
-1002:
-		.endm
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 7adea62..5b882b4 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -18,6 +18,7 @@
 
 #include <mach/hardware.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -80,6 +81,7 @@ MACHINE_START(MICRO9, "Contec Micro9-High")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 MACHINE_END
@@ -91,6 +93,7 @@ MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 MACHINE_END
@@ -102,6 +105,7 @@ MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 MACHINE_END
@@ -113,6 +117,7 @@ MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 8392e95..cd5a263 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -25,6 +25,7 @@
 #include <mach/hardware.h>
 #include <mach/fb.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -69,6 +70,7 @@ MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= simone_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 2e9c614..8959764 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -31,6 +31,7 @@
 #include <mach/hardware.h>
 #include <mach/fb.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -166,6 +167,7 @@ MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer 		= &ep93xx_timer,
 	.init_machine	= snappercl15_init_machine,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index c2d2cf4..75e1249 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -23,6 +23,7 @@
 #include <mach/hardware.h>
 #include <mach/ts72xx.h>
 
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -260,6 +261,7 @@ MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= ts72xx_init_machine,
 MACHINE_END
-- 
1.7.4.1
