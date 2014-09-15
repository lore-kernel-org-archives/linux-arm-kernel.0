From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Sep 2014 16:15:07 -0500
Subject: [PATCH 7/9] irqchip: omap-intc: enable TURBO idle mode
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Message-ID: <1410815709-462-8-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When TURBO bit is set in the INTC_IDLE register,
the input synchronizer clock will be autogated
based on activity on the INTC.

Because this idle mode increases the interrupt
latency by 2 clock cycles, we're only enabling
it during suspend.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Tony, let me know if you want TURBO to be set unconditionally. That's likely
going to shave off a few extra microwatts, although I don't have a good way to
measure it.

 drivers/irqchip/irq-omap-intc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 7681b13..dfa2d9d 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -51,6 +51,9 @@
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
 
+#define INTC_IDLE_FUNCIDLE	(1 << 0)
+#define INTC_IDLE_TURBO		(1 << 1)
+
 #define INTC_PROTECTION_ENABLE	(1 << 0)
 
 /*
@@ -134,12 +137,14 @@ void omap3_intc_prepare_idle(void)
 	 * cf. errata ID i540 for 3430 (all revisions up to 3.1.x)
 	 */
 	intc_writel(INTC_SYSCONFIG, 0);
+	intc_writel(INTC_IDLE, INTC_IDLE_TURBO);
 }
 
 void omap3_intc_resume_idle(void)
 {
 	/* Re-enable autoidle */
 	intc_writel(INTC_SYSCONFIG, 1);
+	intc_writel(INTC_IDLE, 0);
 }
 
 /* XXX: FIQ and additional INTC support (only MPU@the moment) */
-- 
2.0.1.563.g66f467c
