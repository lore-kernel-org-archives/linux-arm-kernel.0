From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  4 Jul 2017 11:10:41 +0200
Subject: [PATCH 3/3] irqchip/atmel-aic: Remove root argument from ->fixup()
 prototype
In-Reply-To: <1499159441-29801-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1499159441-29801-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1499159441-29801-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are no longer using the root argument passed to the ->fixup() hooks.
Remove it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/irqchip/irq-atmel-aic-common.c |  8 ++++----
 drivers/irqchip/irq-atmel-aic-common.h |  4 ++--
 drivers/irqchip/irq-atmel-aic.c        | 14 +++++++-------
 drivers/irqchip/irq-atmel-aic5.c       |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 056507099725..072bd227b6c6 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -137,7 +137,7 @@ static void __init aic_common_ext_irq_of_init(struct irq_domain *domain)
 #define AT91_RTC_IMR           0x28
 #define AT91_RTC_IRQ_MASK      0x1f
 
-void __init aic_common_rtc_irq_fixup(struct device_node *root)
+void __init aic_common_rtc_irq_fixup(void)
 {
 	struct device_node *np;
 	void __iomem *regs;
@@ -165,7 +165,7 @@ void __init aic_common_rtc_irq_fixup(struct device_node *root)
 #define AT91_RTT_ALMIEN		(1 << 16)		/* Alarm Interrupt Enable */
 #define AT91_RTT_RTTINCIEN	(1 << 17)		/* Real Time Timer Increment Interrupt Enable */
 
-void __init aic_common_rtt_irq_fixup(struct device_node *root)
+void __init aic_common_rtt_irq_fixup(void)
 {
 	struct device_node *np;
 	void __iomem *regs;
@@ -198,8 +198,8 @@ static void __init aic_common_irq_fixup(const struct of_device_id *matches)
 	match = of_match_node(matches, root);
 
 	if (match) {
-		void (*fixup)(struct device_node *) = match->data;
-		fixup(root);
+		void (*fixup)(void) = match->data;
+		fixup();
 	}
 
 	of_node_put(root);
diff --git a/drivers/irqchip/irq-atmel-aic-common.h b/drivers/irqchip/irq-atmel-aic-common.h
index af60376d50de..242e62c1851e 100644
--- a/drivers/irqchip/irq-atmel-aic-common.h
+++ b/drivers/irqchip/irq-atmel-aic-common.h
@@ -33,8 +33,8 @@ struct irq_domain *__init aic_common_of_init(struct device_node *node,
 					     const char *name, int nirqs,
 					     const struct of_device_id *matches);
 
-void __init aic_common_rtc_irq_fixup(struct device_node *root);
+void __init aic_common_rtc_irq_fixup(void);
 
-void __init aic_common_rtt_irq_fixup(struct device_node *root);
+void __init aic_common_rtt_irq_fixup(void);
 
 #endif /* __IRQ_ATMEL_AIC_COMMON_H */
diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 37f952dd9fc9..bb1ad451392f 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -209,20 +209,20 @@ static const struct irq_domain_ops aic_irq_ops = {
 	.xlate	= aic_irq_domain_xlate,
 };
 
-static void __init at91rm9200_aic_irq_fixup(struct device_node *root)
+static void __init at91rm9200_aic_irq_fixup(void)
 {
-	aic_common_rtc_irq_fixup(root);
+	aic_common_rtc_irq_fixup();
 }
 
-static void __init at91sam9260_aic_irq_fixup(struct device_node *root)
+static void __init at91sam9260_aic_irq_fixup(void)
 {
-	aic_common_rtt_irq_fixup(root);
+	aic_common_rtt_irq_fixup();
 }
 
-static void __init at91sam9g45_aic_irq_fixup(struct device_node *root)
+static void __init at91sam9g45_aic_irq_fixup(void)
 {
-	aic_common_rtc_irq_fixup(root);
-	aic_common_rtt_irq_fixup(root);
+	aic_common_rtc_irq_fixup();
+	aic_common_rtt_irq_fixup();
 }
 
 static const struct of_device_id aic_irq_fixups[] __initconst = {
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index c04ee9a23d09..6acad2ea0fb3 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -305,9 +305,9 @@ static const struct irq_domain_ops aic5_irq_ops = {
 	.xlate	= aic5_irq_domain_xlate,
 };
 
-static void __init sama5d3_aic_irq_fixup(struct device_node *root)
+static void __init sama5d3_aic_irq_fixup(void)
 {
-	aic_common_rtc_irq_fixup(root);
+	aic_common_rtc_irq_fixup();
 }
 
 static const struct of_device_id aic5_irq_fixups[] __initconst = {
-- 
2.7.4
