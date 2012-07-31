From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:13:09 +0800
Subject: [PATCH 2/7] gpio: pxa: add chain_eneter and chain_exit for irq handler
In-Reply-To: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
References: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343715194-25900-2-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 drivers/gpio/gpio-pxa.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 58a6a63..97ade14 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -26,6 +26,8 @@
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
+#include <asm/mach/irq.h>
+
 #include <mach/irqs.h>
 
 /*
@@ -379,6 +381,9 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 	struct pxa_gpio_chip *c;
 	int loop, gpio, gpio_base, n;
 	unsigned long gedr;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
 
 	do {
 		loop = 0;
@@ -398,6 +403,8 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 			}
 		}
 	} while (loop);
+
+	chained_irq_exit(chip, desc);
 }
 
 static void pxa_ack_muxed_gpio(struct irq_data *d)
-- 
1.7.0.4
