From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 12 Aug 2013 20:46:55 +0200
Subject: [PATCH 9/9] ARM: dove: remove legacy pcie and clock init
In-Reply-To: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1376333215-12885-10-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT support for PCIe controllers on Dove, we can now remove the
legacy pcie init and the last remaining clock workaround for its clocks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-dove/board-dt.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 1efbe1d..9a116d7 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -23,28 +23,6 @@
 #include <plat/irq.h>
 #include "common.h"
 
-/*
- * There are still devices that doesn't even know about DT,
- * get clock gates here and add a clock lookup.
- */
-static void __init dove_legacy_clk_init(void)
-{
-	struct device_node *np = of_find_compatible_node(NULL, NULL,
-					 "marvell,dove-gating-clock");
-	struct of_phandle_args clkspec;
-
-	clkspec.np = np;
-	clkspec.args_count = 1;
-
-	clkspec.args[0] = CLOCK_GATING_BIT_PCIE0;
-	orion_clkdev_add("0", "pcie",
-			 of_clk_get_from_provider(&clkspec));
-
-	clkspec.args[0] = CLOCK_GATING_BIT_PCIE1;
-	orion_clkdev_add("1", "pcie",
-			 of_clk_get_from_provider(&clkspec));
-}
-
 static void __init dove_dt_time_init(void)
 {
 	of_clk_init(NULL);
@@ -59,13 +37,6 @@ static void __init dove_dt_init(void)
 	tauros2_init(0);
 #endif
 	BUG_ON(mvebu_mbus_dt_init());
-
-	/* Setup clocks for legacy devices */
-	dove_legacy_clk_init();
-
-	/* Internal devices not ported to DT yet */
-	dove_pcie_init(1, 1);
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.10.4
