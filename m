From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:32 +0200
Subject: [PATCH v2 05/11] ARM: at91: pm: Simplify at91rm9200_standby
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 2008, AT91_MC_SDRAMC_LPR is set to 0 at kernel initialization. There
is no use saving, changing and restoring it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index a35b1541b328..3d68d93c11c7 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -222,20 +222,15 @@ static void at91_pm_set_standby(void (*at91_standby)(void))
  */
 static void at91rm9200_standby(void)
 {
-	u32 lpr = at91_ramc_read(0, AT91_MC_SDRAMC_LPR);
-
 	asm volatile(
 		"b    1f\n\t"
 		".align    5\n\t"
 		"1:  mcr    p15, 0, %0, c7, c10, 4\n\t"
-		"    str    %0, [%1, %2]\n\t"
-		"    str    %3, [%1, %4]\n\t"
+		"    str    %2, [%1, %3]\n\t"
 		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
-		"    str    %5, [%1, %2]"
 		:
-		: "r" (0), "r" (pm_data.ramc[0]), "r" (AT91_MC_SDRAMC_LPR),
-		  "r" (1), "r" (AT91_MC_SDRAMC_SRR),
-		  "r" (lpr));
+		: "r" (0), "r" (pm_data.ramc[0]),
+		  "r" (1), "r" (AT91_MC_SDRAMC_SRR));
 }
 
 /* We manage both DDRAM/SDRAM controllers, we need more than one value to
-- 
2.11.0
