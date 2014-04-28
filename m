From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 17:58:48 +0100
Subject: [PATCH 12/16] ARM: l2c: convert imx vf610 to generic l2c
 initialisation
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeotE-0002Q8-4p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the .init_irq method only calls irqchip_init, we can remove that
too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-imx/mach-vf610.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index 6288a9690e78..c44602758120 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -20,19 +20,14 @@ static void __init vf610_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static void __init vf610_init_irq(void)
-{
-	l2x0_of_init(0, ~0);
-	irqchip_init();
-}
-
 static const char *vf610_dt_compat[] __initconst = {
 	"fsl,vf610",
 	NULL,
 };
 
 DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF610 (Device Tree)")
-	.init_irq	= vf610_init_irq,
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.init_machine   = vf610_init_machine,
 	.dt_compat	= vf610_dt_compat,
 	.restart	= mxc_restart,
-- 
1.8.3.1
