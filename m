From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:10 -0500
Subject: [PATCH 22/35] arm: omap: irq: call set_handle_irq() from .init_irq
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-23-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the idea is that board-files won't need to set
.handle_irq on their machine_descs, which lets
us drop a little more pointless code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 587def4..994009c 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -284,16 +284,19 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 void __init omap2_init_irq(void)
 {
 	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 void __init omap3_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 void __init ti81xx_init_irq(void)
 {
 	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
+	set_handle_irq(omap2_intc_handle_irq);
 }
 
 static int __init intc_of_init(struct device_node *node,
-- 
2.0.1.563.g66f467c
