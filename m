From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 12 Nov 2012 14:48:37 +0100
Subject: [RFC PATCH 2/4] irqchip: s3c24xx: add irq_domains for the interrupt
 registers
In-Reply-To: <201211121446.30167.heiko@sntech.de>
References: <201211121446.30167.heiko@sntech.de>
Message-ID: <201211121448.39953.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irqdomains for the three register sets in use for base, external
and sub-interrupts. This also pouplates the hwirq value for further
improvements.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/irqchip/Kconfig       |    1 +
 drivers/irqchip/irq-s3c24xx.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 860d45d..e30feca 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -1,5 +1,6 @@
 config S3C24XX_IRQ
 	bool
+	select IRQ_DOMAIN
 
 config VERSATILE_FPGA_IRQ
 	bool
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index fe57bbb..cf9d04d 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -25,6 +25,8 @@
 #include <linux/device.h>
 #include <linux/syscore_ops.h>
 
+#include <linux/irqdomain.h>
+
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
@@ -667,6 +669,18 @@ void __init s3c24xx_init_irq(void)
 		set_irq_flags(irqno, IRQF_VALID);
 	}
 
+	/* basic interrupt register */
+	irq_domain_add_legacy(NULL, 32, IRQ_EINT0, 0, &irq_domain_simple_ops,
+			      NULL);
+
+	/* extint register, irqs begin at bit4 */
+	irq_domain_add_legacy(NULL, 20, IRQ_EINT4, 4, &irq_domain_simple_ops,
+			      NULL);
+
+	/* subint register, 29 to fit subints of all SoCs */
+	irq_domain_add_legacy(NULL, 29, IRQ_S3CUART_RX0, 0,
+			      &irq_domain_simple_ops, NULL);
+
 	irqdbf("s3c2410: registered interrupt handlers\n");
 }
 
-- 
1.7.2.3
