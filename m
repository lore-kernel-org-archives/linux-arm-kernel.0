From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Mar 2015 08:40:37 +0000
Subject: [PATCH 2/2] ARM: imx6: Allow GPC interrupts affinity to be changed
In-Reply-To: <1426149637-22062-1-git-send-email-marc.zyngier@arm.com>
References: <1426149637-22062-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426149637-22062-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While converting the GPC code to a stacked irqchip, we lost the
possibility to change the CPU affinity of an interrupt routed
through the GPC.

This patch restore the expected behaviour by forwarding the
affinity setup to the underlying irqchip (GIC).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-imx/gpc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index db89c35..24525e3 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -148,12 +148,15 @@ static void imx_gpc_irq_mask(struct irq_data *d)
 }
 
 static struct irq_chip imx_gpc_chip = {
-	.name		= "GPC",
-	.irq_eoi	= irq_chip_eoi_parent,
-	.irq_mask	= imx_gpc_irq_mask,
-	.irq_unmask	= imx_gpc_irq_unmask,
-	.irq_retrigger	= irq_chip_retrigger_hierarchy,
-	.irq_set_wake	= imx_gpc_irq_set_wake,
+	.name			= "GPC",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= imx_gpc_irq_mask,
+	.irq_unmask		= imx_gpc_irq_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_wake		= imx_gpc_irq_set_wake,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
 };
 
 static int imx_gpc_domain_xlate(struct irq_domain *domain,
-- 
2.1.4
