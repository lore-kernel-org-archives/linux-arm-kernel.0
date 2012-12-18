From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Tue, 18 Dec 2012 18:02:09 +0530
Subject: [PATCH] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
Message-ID: <1355833929-25387-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

omap4_cminst_wait_module_ready() checks if register offset is NULL.

int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
				   u16 clkctrl_offs)
{
	int i = 0;

	if (!clkctrl_offs)
		return 0;

In case of AM33xx, not all clock domains have CLKSTCTRL at 0x00. An
example of this would be the RTC clock domain. In such cases the
module ready check is skipped which leads to a data abort during bootup
when RTC registers is accessed.

Since the actual base address is verified in
omap4_cminst_read_inst_reg(), this check here is not required at all
and hence can be removed.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
:100644 100644 7f9a464... 40545ff... M	arch/arm/mach-omap2/cminst44xx.c
 arch/arm/mach-omap2/cminst44xx.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 7f9a464..40545ff 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -271,9 +271,6 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
 {
 	int i = 0;
 
-	if (!clkctrl_offs)
-		return 0;
-
 	omap_test_timeout(_is_module_ready(part, inst, cdoffs, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
1.7.9.5
