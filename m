From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 06 Aug 2017 16:38:50 +0300
Subject: [PATCH 1/2] ARM: OMAP3: PRM: fix of_irq_get() result check
Message-ID: <20170806134539.404484506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_get() may return 0 as well as a nagative error number on failure
(and never on success), however omap3xxx_prm_late_init() regards 0 as a
valid IRQ -- fix this.

Fixes: 1e037794f7f ("ARM: OMAP3+: PRM: register interrupt information from DT")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-omap2/prm3xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/prm3xxx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prm3xxx.c
+++ linux-omap/arch/arm/mach-omap2/prm3xxx.c
@@ -706,7 +706,7 @@ static int omap3xxx_prm_late_init(void)
 		np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
 		if (np) {
 			irq_num = of_irq_get(np, 0);
-			if (irq_num >= 0)
+			if (irq_num > 0)
 				omap3_prcm_irq_setup.irq = irq_num;
 		}
 	}
