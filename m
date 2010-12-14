From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 14 Dec 2010 22:55:57 +0100
Subject: [PATCH 3/3] ARM: plat-samsung: some GENERIC_HARDIRQS_NO_DEPRECATED build fixes.
In-Reply-To: <929a34e7a1cc775b36e3196b3e10d8cf591a7c03.1292364161.git.buytenh@wantstofly.org>
References: <929a34e7a1cc775b36e3196b3e10d8cf591a7c03.1292364161.git.buytenh@wantstofly.org>
Message-ID: <bcd60eb67245ab2b5c8dc4e5b2cf9bfb5af68b42.1292364161.git.buytenh@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When GENERIC_HARDIRQS_NO_DEPRECATED is enabled, a number of struct
irq_desc members stop being directly accessible, and need to be
accessed via the irq_data struct instead -- this patch fixes up the
plat-samsung sites that still access those members directly.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/plat-samsung/irq-uart.c      |    6 +++---
 arch/arm/plat-samsung/irq-vic-timer.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-uart.c
index da31d78..4e77035 100644
--- a/arch/arm/plat-samsung/irq-uart.c
+++ b/arch/arm/plat-samsung/irq-uart.c
@@ -30,7 +30,7 @@
 
 static inline void __iomem *s3c_irq_uart_base(struct irq_data *data)
 {
-	struct s3c_uart_irq *uirq = data->chip_data;
+	struct s3c_uart_irq *uirq = irq_data_get_irq_chip_data(data);
 	return uirq->regs;
 }
 
@@ -83,7 +83,7 @@ static void s3c_irq_uart_ack(struct irq_data *data)
 
 static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
 {
-	struct s3c_uart_irq *uirq = desc->handler_data;
+	struct s3c_uart_irq *uirq = desc->irq_data.handler_data;
 	u32 pend = __raw_readl(uirq->regs + S3C64XX_UINTP);
 	int base = uirq->base_irq;
 
@@ -124,7 +124,7 @@ static void __init s3c_init_uart_irq(struct s3c_uart_irq *uirq)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
-	desc->handler_data = uirq;
+	desc->irq_data.handler_data = uirq;
 	set_irq_chained_handler(uirq->parent_irq, s3c_irq_demux_uart);
 }
 
diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index 7ce77dd..dd8692a 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -24,7 +24,7 @@
 
 static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
 {
-	generic_handle_irq((int)desc->handler_data);
+	generic_handle_irq((int)desc->irq_data.handler_data);
 }
 
 /* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
@@ -86,5 +86,5 @@ void __init s3c_init_vic_timer_irq(unsigned int parent_irq,
 	set_irq_handler(timer_irq, handle_level_irq);
 	set_irq_flags(timer_irq, IRQF_VALID);
 
-	desc->handler_data = (void *)timer_irq;
+	desc->irq_data.handler_data = (void *)timer_irq;
 }
-- 
1.7.1


--IS0zKkzwUGydFO0o--
