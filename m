From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:32:04 +0100
Subject: [PATCH 69/97] ARM: l2c: sti: convert to generic l2c initialisation
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerHY-0001YO-Hj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can remove the .init_machine as it becomes the generic version.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sti/board-dt.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index cf716ae10726..4924d2214be6 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -14,19 +14,6 @@
 
 #include "smp.h"
 
-void __init stih41x_l2x0_init(void)
-{
-	l2x0_of_init(L2C_AUX_CTRL_SHARED_OVERRIDE |
-		     L310_AUX_CTRL_DATA_PREFETCH |
-		     L310_AUX_CTRL_INSTR_PREFETCH, 0xc00f0fff);
-}
-
-static void __init stih41x_machine_init(void)
-{
-	stih41x_l2x0_init();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char *stih41x_dt_match[] __initdata = {
 	"st,stih415",
 	"st,stih416",
@@ -34,7 +21,10 @@ static const char *stih41x_dt_match[] __initdata = {
 };
 
 DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
-	.init_machine	= stih41x_machine_init,
-	.smp		= smp_ops(sti_smp_ops),
 	.dt_compat	= stih41x_dt_match,
+	.l2c_aux_val	= L2C_AUX_CTRL_SHARED_OVERRIDE |
+			  L310_AUX_CTRL_DATA_PREFETCH |
+			  L310_AUX_CTRL_INSTR_PREFETCH,
+	.l2c_aux_mask	= 0xc00f0fff,
+	.smp		= smp_ops(sti_smp_ops),
 MACHINE_END
-- 
1.8.3.1
