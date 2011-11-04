From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:10:07 +0000
Subject: [PATCHv4 10/13] ARM: versatile: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1320369010-23428-11-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a generic IRQ handler for multiple VIC devices use it
for versatile to help building multi platform kernels.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-versatile/include/mach/entry-macro.S |   30 --------------------
 arch/arm/mach-versatile/versatile_ab.c             |    2 +
 arch/arm/mach-versatile/versatile_dt.c             |    2 +
 arch/arm/mach-versatile/versatile_pb.c             |    2 +
 5 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bb62f38..d1caaba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -294,6 +294,7 @@ config ARCH_VERSATILE
 	select PLAT_VERSATILE_CLCD
 	select PLAT_VERSATILE_FPGA_IRQ
 	select ARM_TIMER_SP804
+	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for ARM Ltd Versatile board.
 
diff --git a/arch/arm/mach-versatile/include/mach/entry-macro.S b/arch/arm/mach-versatile/include/mach/entry-macro.S
index e6f7c16..b6f0dbf 100644
--- a/arch/arm/mach-versatile/include/mach/entry-macro.S
+++ b/arch/arm/mach-versatile/include/mach/entry-macro.S
@@ -7,39 +7,9 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <mach/platform.h>
-#include <asm/hardware/vic.h>
 
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =IO_ADDRESS(VERSATILE_VIC_BASE)
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqstat, [\base, #VIC_IRQ_STATUS]	@ get masked status
-		mov	\irqnr, #0
-		teq	\irqstat, #0
-		beq	1003f
-
-1001:		tst	\irqstat, #15
-		bne	1002f
-		add	\irqnr, \irqnr, #4
-		movs	\irqstat, \irqstat, lsr #4
-		bne	1001b
-1002:		tst	\irqstat, #1
-		bne	1003f
-		add	\irqnr, \irqnr, #1
-		movs	\irqstat, \irqstat, lsr #1
-		bne	1002b
-1003:		/* EQ will be set if no irqs pending */
-
-@		clz	\irqnr, \irqstat
- at 1003:		/* EQ will be set if we reach MAXIRQNUM */
-		.endm
-
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
index fda4866..c83a1f3 100644
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ b/arch/arm/mach-versatile/versatile_ab.c
@@ -27,6 +27,7 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
@@ -39,6 +40,7 @@ MACHINE_START(VERSATILE_AB, "ARM-Versatile AB")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_init,
 MACHINE_END
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 54e037c..f4d1e0f 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -45,6 +46,7 @@ DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_dt_init,
 	.dt_compat	= versatile_dt_match,
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index feaf9cb..4d31eeb 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <asm/hardware/vic.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
@@ -107,6 +108,7 @@ MACHINE_START(VERSATILE_PB, "ARM-Versatile PB")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
+	.handle_irq	= vic_handle_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_pb_init,
 MACHINE_END
-- 
1.7.5.4
