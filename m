From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 24 Sep 2011 11:44:21 +0530
Subject: [PATCH v2 01/24] OMAP4: Use WARN_ON() instead of BUG_ON() with
	graceful exit
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1316844884-21700-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 L2X0 initialisation code uses BUG_ON() for the ioremap()
failure scenarios.

Use WARN_ON() instead and allow graceful function exits.

This was suggsted by Kevin Hilman <khilman@ti.com> during
OMAP4 PM code review.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 35ac3e5..a6c33e4 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -71,7 +71,8 @@ static int __init omap_l2_cache_init(void)
 
 	/* Static mapping, never released */
 	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
-	BUG_ON(!l2cache_base);
+	if (WARN_ON(!l2cache_base))
+		return -ENOMEM;
 
 	/*
 	 * 16-way associativity, parity disabled
-- 
1.7.4.1
