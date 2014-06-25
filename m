From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:20 +0900
Subject: [PATCH 08/14] ARM: shmobile: Add shared R-Car Gen2 CMA reservation
 code
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
Message-ID: <f8e819352d12f1b7d109d846e9bf1c07e006469a.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add R-Car Gen2 CMA memory reservation code that can be
shared between multiple SoCs and boards. At this point
r8a7790 and r8a7791 are supported.

The top 256MiB of the legacy 32-bit physical memory space
is assigned to a separate CMA area that may be assigned
to various devices later on.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
[horms+renesas at verge.net.au: rebased]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/rcar-gen2.h       | 1 +
 arch/arm/mach-shmobile/setup-r8a7790.c   | 1 +
 arch/arm/mach-shmobile/setup-r8a7791.c   | 1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/rcar-gen2.h b/arch/arm/mach-shmobile/rcar-gen2.h
index 43f606e..ce53cb5 100644
--- a/arch/arm/mach-shmobile/rcar-gen2.h
+++ b/arch/arm/mach-shmobile/rcar-gen2.h
@@ -4,5 +4,6 @@
 void rcar_gen2_timer_init(void);
 #define MD(nr) BIT(nr)
 u32 rcar_gen2_read_mode_pins(void);
+void rcar_gen2_reserve(void);
 
 #endif /* __ASM_RCAR_GEN2_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 516b4e4..e190768 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -327,6 +327,7 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.init_early	= r8a7790_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 9e16b1d..7e970d0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -218,6 +218,7 @@ DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index fdc714e..544b9bf 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -20,8 +20,11 @@
 
 #include <linux/clk/shmobile.h>
 #include <linux/clocksource.h>
+#include <linux/device.h>
+#include <linux/dma-contiguous.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of_fdt.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "rcar-gen2.h"
-- 
2.0.0.rc2
