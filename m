From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 21 Sep 2013 16:45:40 +0300
Subject: [PATCH 1/3] ARM: OMAP2: HACK: hardcode hsmmc2 input clock source for
 N950/N9
In-Reply-To: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
References: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <1379771142-29087-2-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this the eMMC (root file system) cannot be used on N950/N9.
Any ideas for a proper solution?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/board-generic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 39c7838..8be49b3 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -20,6 +20,7 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
+#include "control.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
 
@@ -51,12 +52,26 @@ static void __init legacy_init_ehci_clk(char *clkname)
 	}
 }
 
+static void __init hsmmc2_input_clk(void)
+{
+	u32 reg;
+
+	reg = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
+	reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
+}
+
 static void __init omap_generic_init(void)
 {
 	omap_sdrc_init(NULL, NULL);
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 
+	/* HACK: Configure the MMC input clock source on N950/N9. */
+	if (of_machine_is_compatible("nokia,omap3-n950") ||
+	    of_machine_is_compatible("nokia,omap3-n9"))
+		hsmmc2_input_clk();
+
 	/*
 	 * HACK: call display setup code for selected boards to enable omapdss.
 	 * This will be removed when omapdss supports DT.
-- 
1.8.4.rc3
