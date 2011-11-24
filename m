From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 20:34:43 +0000
Subject: [PATCH] arm/tegra: Fix build error with tegra_assert_system_reset
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6CC@HQMAIL01.nvidia.com>
References: <1322009631-711-1-git-send-email-swarren@nvidia.com>
 <20111123095009.GG9581@n2100.arm.linux.org.uk>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C6CC@HQMAIL01.nvidia.com>
Message-ID: <20111124203443.GU9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 08:59:48AM -0800, Stephen Warren wrote:
> OK, I tested that and it works too.

Great.  Here's the final patch - could I have an ack for it please?

Thanks.

8<======
ARM: restart: tegra: use new restart hook

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-tegra/board-dt.c            |    1 +
 arch/arm/mach-tegra/board-harmony.c       |    1 +
 arch/arm/mach-tegra/board-paz00.c         |    1 +
 arch/arm/mach-tegra/board-seaboard.c      |    3 +++
 arch/arm/mach-tegra/board-trimslice.c     |    1 +
 arch/arm/mach-tegra/common.c              |    2 --
 arch/arm/mach-tegra/include/mach/system.h |    6 +++---
 7 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index d368f8d..a00713c 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -131,5 +131,6 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra (Flattened Device Tree)")
 	.init_irq	= tegra_init_irq,
 	.timer		= &tegra_timer,
 	.init_machine	= tegra_dt_init,
+	.restart	= tegra_assert_system_reset,
 	.dt_compat	= tegra_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index f0bdc5e..7eaa52d 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -189,4 +189,5 @@ MACHINE_START(HARMONY, "harmony")
 	.init_irq       = tegra_init_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_harmony_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 55c55ba..28c97e3 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -192,4 +192,5 @@ MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.init_irq       = tegra_init_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_paz00_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index bf13ea3..9b2eca1 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -286,6 +286,7 @@ MACHINE_START(SEABOARD, "seaboard")
 	.init_irq       = tegra_init_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_seaboard_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
 
 MACHINE_START(KAEN, "kaen")
@@ -295,6 +296,7 @@ MACHINE_START(KAEN, "kaen")
 	.init_irq       = tegra_init_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_kaen_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
 
 MACHINE_START(WARIO, "wario")
@@ -304,4 +306,5 @@ MACHINE_START(WARIO, "wario")
 	.init_irq       = tegra_init_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_wario_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index 1a6617b..1fa9e48 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -178,4 +178,5 @@ MACHINE_START(TRIMSLICE, "trimslice")
 	.init_irq       = tegra_init_irq,
 	.timer          = &tegra_timer,
 	.init_machine   = tegra_trimslice_init,
+	.restart	= tegra_assert_system_reset,
 MACHINE_END
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 690b888..20f396d 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -31,8 +31,6 @@
 #include "clock.h"
 #include "fuse.h"
 
-void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
-
 void tegra_assert_system_reset(char mode, const char *cmd)
 {
 	void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
index 027c421..b87b8a4 100644
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -21,9 +21,9 @@
 #ifndef __MACH_TEGRA_SYSTEM_H
 #define __MACH_TEGRA_SYSTEM_H
 
-#include <mach/iomap.h>
-
-extern void (*arch_reset)(char mode, const char *cmd);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 static inline void arch_idle(void)
 {
-- 
1.7.4.4
