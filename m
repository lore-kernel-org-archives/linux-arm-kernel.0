From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 20 Jun 2011 16:34:18 +0900
Subject: [PATCH 7/7] ARM: EXYNOS4: Add chained enrty/exit function to uart
	interrupt handler
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1308555258-4322-8-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds chained IRQ enter/exit functions to uart
interrupt handler in order to function correctly on primary
controllers with different methods of flow control.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/plat-samsung/irq-uart.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-uart.c
index 32582c0..8960eaf 100644
--- a/arch/arm/plat-samsung/irq-uart.c
+++ b/arch/arm/plat-samsung/irq-uart.c
@@ -19,6 +19,8 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <asm/mach/irq.h>
+
 #include <mach/map.h>
 #include <plat/irq-uart.h>
 #include <plat/regs-serial.h>
@@ -30,9 +32,12 @@
 static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
 {
 	struct s3c_uart_irq *uirq = desc->irq_data.handler_data;
+	struct irq_chip *chip = irq_get_chip(irq);
 	u32 pend = __raw_readl(uirq->regs + S3C64XX_UINTP);
 	int base = uirq->base_irq;
 
+	chained_irq_enter(chip, desc);
+
 	if (pend & (1 << 0))
 		generic_handle_irq(base);
 	if (pend & (1 << 1))
@@ -41,6 +46,8 @@ static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(base + 2);
 	if (pend & (1 << 3))
 		generic_handle_irq(base + 3);
+
+	chained_irq_exit(chip, desc);
 }
 
 static void __init s3c_init_uart_irq(struct s3c_uart_irq *uirq)
-- 
1.7.1
