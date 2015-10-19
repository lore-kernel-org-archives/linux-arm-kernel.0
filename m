From: b20788@freescale.com (Anson Huang)
Date: Tue, 20 Oct 2015 01:02:12 +0800
Subject: [PATCH] ARM: imx: support edge irq trigger for gpc
Message-ID: <1445274132-12253-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPC irq domain is a child domain of GIC, now all of
platform irqs are inside GPC domain, during the module
populate, all devices irq should have correct type
setting in GIC, however, there is no .irq_set_type
callback setting in GPC, so the irq_set_type will be
skipped and cause edge raising type of irq work
abnormally after kernel boot up.

Since GPC has no irq type, so just tell kernel to
use irq_chip_set_type_parent instead.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/gpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 10bf715..b3a7a74 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -176,6 +176,7 @@ static struct irq_chip imx_gpc_chip = {
 	.irq_unmask		= imx_gpc_irq_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_wake		= imx_gpc_irq_set_wake,
+	.irq_set_type           = irq_chip_set_type_parent,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
-- 
1.9.1
