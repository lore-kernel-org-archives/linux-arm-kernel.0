From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:23 -0500
Subject: [PATCH 35/35] irq: intc: enable IP protection
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-36-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When PROTECTION bit in enabled in PROTECTION
register, INTC's registers are only accessible
from privileged mode.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 371ff5e..28c8b6d 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -52,6 +52,8 @@
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
 
+#define INTC_PROTECTION_ENABLE	(1 << 0)
+
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
  * controller is identified as its own "bank". Register definitions are
@@ -291,12 +293,28 @@ static int __init omap_init_irq_legacy(u32 base)
 	return 0;
 }
 
+static void __init omap_irq_enable_protection(void)
+{
+	u32 reg;
+
+	reg = intc_readl(INTC_PROTECTION);
+	reg |= INTC_PROTECTION_ENABLE;
+	intc_writel(INTC_PROTECTION, reg);
+}
+
 static int __init omap_init_irq(u32 base, struct device_node *node)
 {
+	int ret;
+
 	if (node)
-		return omap_init_irq_of(node);
+		ret = omap_init_irq_of(node);
 	else
-		return omap_init_irq_legacy(base);
+		ret = omap_init_irq_legacy(base);
+
+	if (ret == 0)
+		omap_irq_enable_protection();
+
+	return ret;
 }
 
 static asmlinkage void __exception_irq_entry
-- 
2.0.1.563.g66f467c
