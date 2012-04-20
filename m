From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 20 Apr 2012 18:09:21 +0530
Subject: [PATCH v2 2/4] ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
In-Reply-To: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an API to get main clock name associated with a given @oh.
This will avoid the need to construct fclk names during early
initialization in order to get fclk handle using clk_get().

Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   15 +++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2c27fdb..2c6214d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2775,3 +2775,18 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
 
 	return 0;
 }
+
+/**
+ * omap_hwmod_get_main_clk - get pointer to main clock name
+ * @oh: struct omap_hwmod *
+ *
+ * Returns the main clock name assocated with @oh upon success,
+ * or NULL if @oh is NULL.
+ */
+const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return NULL;
+
+	return oh->main_clk;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8070145..f3c0697 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -608,6 +608,8 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 
 int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx);
 
+const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
-- 
1.7.0.4
