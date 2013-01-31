From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Thu, 31 Jan 2013 19:55:27 +0530
Subject: [Patch v2 2/2] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL
 check" bug
In-Reply-To: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
References: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1359642327-5542-3-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

am33xx_cm_wait_module_ready() checks if register offset is NULL.

int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
{
	int i = 0;

	if (!clkctrl_offs)
		return 0;

In case of AM33xx, CLKCTRL register offset for different clock domains
are not uniformly placed. An example of this would be the RTC clock
domain with CLKCTRL offset at 0x00.
In such cases the module ready check is skipped which leads to a data
abort during boot-up when RTC registers is accessed.

Remove this check here to avoid checking module readiness for modules
with clkctrl register offset at 0x00.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
---
Change in v2:
	- No change

:100644 100644 058ce3c... 325a515... M	arch/arm/mach-omap2/cm33xx.c
 arch/arm/mach-omap2/cm33xx.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 058ce3c..325a515 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -241,9 +241,6 @@ int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(inst, cdoffs, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
1.7.9.5
