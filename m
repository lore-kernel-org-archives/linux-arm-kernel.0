From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Nov 2016 16:20:37 +0100
Subject: [PATCH] ARM: ux500: fix prcmu_is_cpu_in_wfi() calculation
Message-ID: <20161116152047.3336967-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function clearly never worked and always returns true,
as pointed out by gcc-7:

arch/arm/mach-ux500/pm.c: In function 'prcmu_is_cpu_in_wfi':
arch/arm/mach-ux500/pm.c:137:212: error: ?: using integer constants in boolean context, the expression will always evaluate to 'true' [-Werror=int-in-bool-context]

With the added braces, the condition actually makes sense.

Fixes: 34fe6f107eab ("mfd : Check if the other db8500 core is in WFI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index 8538910db202..a970e7fcba9e 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -134,8 +134,8 @@ bool prcmu_pending_irq(void)
  */
 bool prcmu_is_cpu_in_wfi(int cpu)
 {
-	return readl(PRCM_ARM_WFI_STANDBY) & cpu ? PRCM_ARM_WFI_STANDBY_WFI1 :
-		     PRCM_ARM_WFI_STANDBY_WFI0;
+	return readl(PRCM_ARM_WFI_STANDBY) &
+		(cpu ? PRCM_ARM_WFI_STANDBY_WFI1 : PRCM_ARM_WFI_STANDBY_WFI0);
 }
 
 /*
-- 
2.9.0
