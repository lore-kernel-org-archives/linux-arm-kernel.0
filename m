From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 12 Jul 2016 12:50:34 -0500
Subject: [PATCH 4/4] ARM: OMAP4+: CM: Remove redundant checks for clkctrl_offs
 of zero
In-Reply-To: <20160712175034.743-1-d-gerlach@ti.com>
References: <20160712175034.743-1-d-gerlach@ti.com>
Message-ID: <20160712175034.743-5-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have moved the check for valid clkctrl_offs to the caller of
am33xx_cm_wait_module_ready/idle and omap4_cminst_wait_module_ready/idle
let's remove the now redundant check for clkctrl_offs from these functions.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c     | 6 ------
 arch/arm/mach-omap2/cminst44xx.c | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index c073fb57dd13..6f2d0aec0513 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -220,9 +220,6 @@ static int am33xx_cm_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
@@ -246,9 +243,6 @@ static int am33xx_cm_wait_module_idle(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout((_clkctrl_idlest(inst, clkctrl_offs) ==
 				CLKCTRL_IDLEST_DISABLED),
 				MAX_MODULE_READY_TIME, i);
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 2c0e07ed6b99..2ab27ade136a 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -278,9 +278,6 @@ static int omap4_cminst_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(part, inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
@@ -304,9 +301,6 @@ static int omap4_cminst_wait_module_idle(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout((_clkctrl_idlest(part, inst, clkctrl_offs) ==
 			   CLKCTRL_IDLEST_DISABLED),
 			  MAX_MODULE_DISABLE_TIME, i);
-- 
2.9.0
