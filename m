From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 18 Feb 2013 17:08:09 +0530
Subject: [PATCH, RFC 6/8] ARM: OMAP2+: am43: basic dt support
In-Reply-To: <cover.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
Message-ID: <64d18c5a07bf7680b8299f3ef98303e60522e738.1361186097.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe minimal DT boot machine details for AM43 based SoC's. AM43
family of SoC's are ARM Cortex-A9 based with one core in SMP
configuration. Low level debug could be achieved by selecting
DEBUG_AM33XXUART1. To boot AM43 SoC, this change is sufficient w.r.t
Kernel (considering the fact that strictly speaking DT sources does
not classify as a part of Kernel). Here private timer of the one and
only core is being used as clock event (as well as, as time source).

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 0274ff7..e083f08 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,7 +15,10 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip.h>
 
+#include <asm/mach/map.h>
+#include <asm/smp_twd.h>
 #include <asm/mach/arch.h>
 
 #include "common.h"
@@ -182,3 +185,18 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
 	.restart	= omap44xx_restart,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_SOC_AM43
+static const char *am43_boards_compat[] __initdata = {
+	"ti,am43",
+	NULL,
+};
+
+DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
+	.map_io		= debug_ll_io_init,
+	.init_irq	= irqchip_init,
+	.init_machine	= omap_generic_init,
+	.init_time	= twd_local_timer_of_register,
+	.dt_compat	= am43_boards_compat,
+MACHINE_END
+#endif
-- 
1.7.12
