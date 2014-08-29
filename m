From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 29 Aug 2014 10:58:45 -0700
Subject: [PATCH 1/3] gpio: zynq: Mask non-wakeup GPIO interrupts on suspend
In-Reply-To: <1409335127-26712-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409335127-26712-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1409335127-26712-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezra Savard <ezra.savard@xilinx.com>

Added flag to the GPIO chip so that IRQ from non-wakeup GPIO will
not wake the system.

Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/gpio/gpio-zynq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index dccadea9d830..d80d722529ad 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -451,7 +451,8 @@ static struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
-	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED,
+	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+			  IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static struct irq_chip zynq_gpio_edge_irqchip = {
@@ -462,6 +463,7 @@ static struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static void zynq_gpio_handle_bank_irq(struct zynq_gpio *gpio,
-- 
2.1.0.1.g27b9230
