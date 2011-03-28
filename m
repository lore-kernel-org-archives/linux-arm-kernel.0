From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 28 Mar 2011 14:52:18 +0530
Subject: [pm-core][PATCH v3 02/21] OMAP4: Use WARN_ON() instead of BUG_ON()
	with graceful exit
In-Reply-To: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1301304157-2466-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP L2X0 and GIC initialisation code uses BUG_ON() for the
ioremap() failure scenarios.

Use WARN_ON() instead and allow graceful function exits.

This was suggsted by Kevin Hilman <khilman@ti.com> during
OMAP4 PM code review.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 559d227..8f9b97d 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -36,11 +36,13 @@ void __init gic_init_irq(void)
 
 	/* Static mapping, never released */
 	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
-	BUG_ON(!gic_dist_base_addr);
+	if (WARN_ON(!gic_dist_base_addr))
+		return;
 
 	/* Static mapping, never released */
 	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
-	BUG_ON(!gic_cpu_base);
+	if (WARN_ON(!gic_cpu_base))
+		return;
 
 	omap_wakeupgen_init();
 
@@ -68,7 +70,8 @@ static int __init omap_l2_cache_init(void)
 
 	/* Static mapping, never released */
 	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
-	BUG_ON(!l2cache_base);
+	if (WARN_ON(!l2cache_base))
+		return -ENODEV;
 
 	/*
 	 * 16-way associativity, parity disabled
-- 
1.6.0.4
