From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 5 Nov 2012 15:14:19 +0200
Subject: [PATCH 6/6] OMAP: board-generic: enable DSS for panda & sdp boards
In-Reply-To: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1352121259-5836-7-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the non-DT omapdss setup code from board-generic if the board is
omap4-panda or omap4-sdp. This will give us working omapdss for those
boards when using DT kernel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 601ecdf..8f5f21c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -21,6 +21,7 @@
 
 #include "common.h"
 #include "common-board-devices.h"
+#include "dss-common.h"
 
 #if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
 #define intc_of_init	NULL
@@ -40,6 +41,15 @@ static void __init omap_generic_init(void)
 	omap_sdrc_init(NULL, NULL);
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+
+	/*
+	 * HACK: call display setup code for selected boards to enable omapdss.
+	 * This will be removed when omapdss supports DT.
+	 */
+	if (of_machine_is_compatible("ti,omap4-panda"))
+		omap4_panda_display_init_of();
+	else if (of_machine_is_compatible("ti,omap4-sdp"))
+		omap_4430sdp_display_init_of();
 }
 
 #ifdef CONFIG_SOC_OMAP2420
-- 
1.7.10.4
