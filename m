From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Sep 2011 12:02:28 +0100
Subject: [PATCH v2 09/16] ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317034955-1029-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the tegra2 platforms to be using the gic_handle_irq
function as their primary interrupt handler.

Tested on harmony.

Cc: Colin Cross <ccross@android.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/Kconfig                    |    1 +
 arch/arm/mach-tegra/board-dt.c                 |    2 ++
 arch/arm/mach-tegra/board-harmony.c            |    2 ++
 arch/arm/mach-tegra/board-paz00.c              |    2 ++
 arch/arm/mach-tegra/board-seaboard.c           |    4 ++++
 arch/arm/mach-tegra/board-trimslice.c          |    2 ++
 arch/arm/mach-tegra/include/mach/entry-macro.S |   22 ++--------------------
 7 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index d82ebab..ba0ac3f 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -13,6 +13,7 @@ config ARCH_TEGRA_2x_SOC
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index 0b3f937..cfa39c5 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -32,6 +32,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-tegra.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -115,6 +116,7 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra (Flattened Device Tree)")
 	.soc		= &tegra_soc_desc,
 	.init_early	= tegra_init_early,
 	.init_irq	= tegra_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_timer,
 	.init_machine	= tegra_dt_init,
 	.dt_compat	= tegra_dt_board_compat,
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index f2ef94f..eb65d68 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -31,6 +31,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
 #include <asm/setup.h>
 
 #include <mach/tegra_wm8903_pdata.h>
@@ -189,6 +190,7 @@ MACHINE_START(HARMONY, "harmony")
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
 	.init_irq       = tegra_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_harmony_init,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 63595f0..fc7831f 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -28,6 +28,7 @@
 #include <linux/i2c.h>
 #include <linux/rfkill-gpio.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -192,6 +193,7 @@ MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
 	.init_irq       = tegra_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_paz00_init,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index dfd9c95..7fd71cf 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -34,6 +34,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 
 #include "board.h"
 #include "board-seaboard.h"
@@ -286,6 +287,7 @@ MACHINE_START(SEABOARD, "seaboard")
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_seaboard_init,
 MACHINE_END
@@ -296,6 +298,7 @@ MACHINE_START(KAEN, "kaen")
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_kaen_init,
 MACHINE_END
@@ -306,6 +309,7 @@ MACHINE_START(WARIO, "wario")
 	.map_io         = tegra_map_common_io,
 	.init_early     = tegra_init_early,
 	.init_irq       = tegra_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_wario_init,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 16cfc39..c5aa9df 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -26,6 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/setup.h>
@@ -179,6 +180,7 @@ MACHINE_START(TRIMSLICE, "trimslice")
 	.map_io         = tegra_map_common_io,
 	.init_early	= tegra_init_early,
 	.init_irq       = tegra_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_trimslice_init,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/include/mach/entry-macro.S b/arch/arm/mach-tegra/include/mach/entry-macro.S
index dd165c5..ac11262 100644
--- a/arch/arm/mach-tegra/include/mach/entry-macro.S
+++ b/arch/arm/mach-tegra/include/mach/entry-macro.S
@@ -12,30 +12,15 @@
  * GNU General Public License for more details.
  *
  */
-#include <mach/iomap.h>
-#include <mach/io.h>
-
-#if defined(CONFIG_ARM_GIC)
-#define HAVE_GET_IRQNR_PREAMBLE
-#include <asm/hardware/entry-macro-gic.S>
-
-	/* Uses the GIC interrupt controller built into the cpu */
-#define ICTRL_BASE (IO_CPU_VIRT + 0x100)
 
 	.macro	disable_fiq
 	.endm
 
-	.macro	get_irqnr_preamble, base, tmp
-	movw \base, #(ICTRL_BASE & 0x0000ffff)
-	movt \base, #((ICTRL_BASE & 0xffff0000) >> 16)
+	.macro	arch_ret_to_user, tmp1, tmp2
 	.endm
 
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-#else
+#if !defined(CONFIG_ARM_GIC)
 	/* legacy interrupt controller for AP16 */
-	.macro	disable_fiq
-	.endm
 
 	.macro	get_irqnr_preamble, base, tmp
 	@ enable imprecise aborts
@@ -46,9 +31,6 @@
 	orr \base, #0x0000f000
 	.endm
 
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr \irqnr, [\base, #0x20]	@ EVT_IRQ_STS
 	cmp \irqnr, #0x80
-- 
1.7.0.4
