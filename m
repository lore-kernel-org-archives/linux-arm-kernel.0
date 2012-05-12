From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Sat, 12 May 2012 10:53:56 +0200
Subject: [PATCH 3/5] ARM: at91: disable specific soc clock init functions
In-Reply-To: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
References: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
Message-ID: <1336812838-3649-4-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-at91/at91sam9260.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index a27bbec..94eae4f 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -25,13 +25,17 @@
 
 #include "soc.h"
 #include "generic.h"
+#ifndef CONFIG_COMMON_CLK
 #include "clock.h"
+#else
+#include <linux/clk.h>
+#endif
 #include "sam9_smc.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
  * -------------------------------------------------------------------- */
-
+#ifndef CONFIG_COMMON_CLK
 /*
  * The peripheral clocks.
  */
@@ -267,6 +271,7 @@ static void __init at91sam9260_register_clocks(void)
 	clk_register(&pck0);
 	clk_register(&pck1);
 }
+#endif
 
 /* --------------------------------------------------------------------
  *  GPIO
@@ -382,6 +387,8 @@ struct at91_init_soc __initdata at91sam9260_soc = {
 	.map_io = at91sam9260_map_io,
 	.default_irq_priority = at91sam9260_default_irq_priority,
 	.ioremap_registers = at91sam9260_ioremap_registers,
+#ifndef CONFIG_COMMON_CLK
 	.register_clocks = at91sam9260_register_clocks,
+#endif
 	.init = at91sam9260_initialize,
 };
-- 
1.7.9.5
