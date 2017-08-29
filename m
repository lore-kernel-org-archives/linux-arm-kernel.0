From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Aug 2017 10:29:57 -0700
Subject: [PATCH 2/6] ARM: OMAP3: Remove legacy IRQ for PRM
In-Reply-To: <20170829173001.20358-1-tony@atomide.com>
References: <20170829173001.20358-1-tony@atomide.com>
Message-ID: <20170829173001.20358-3-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have this coming from device tree and legacy booting is
no longer needed.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm3xxx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -704,12 +704,18 @@ static int omap3xxx_prm_late_init(void)
 			omap3430_pre_es3_1_reconfigure_io_chain;
 
 	np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
-	if (np) {
-		irq_num = of_irq_get(np, 0);
-		if (irq_num > 0)
-			omap3_prcm_irq_setup.irq = irq_num;
+	if (!np) {
+		pr_err("PRM: no device tree node for interrupt?\n");
+
+		return -ENODEV;
 	}
 
+	irq_num = of_irq_get(np, 0);
+	if (irq_num == -EPROBE_DEFER)
+		return irq_num;
+
+	omap3_prcm_irq_setup.irq = irq_num;
+
 	omap3xxx_prm_enable_io_wakeup();
 
 	return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
-- 
2.14.1
