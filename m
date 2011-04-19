From: chaos.youn@samsung.com (Changhwan Youn)
Date: Tue, 19 Apr 2011 10:45:25 +0900
Subject: [PATCH 2/3] ARM: SAMSUNG: add entry and exit functions for pwm
	interrupt chained handler
In-Reply-To: <1303177526-11744-1-git-send-email-chaos.youn@samsung.com>
References: <1303177526-11744-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1303177526-11744-3-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This functions are added for properly controlling primary controller
in pwm interrupt chained handler.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/plat-samsung/irq-vic-timer.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index dd8692a..7db0a58 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -21,10 +21,15 @@
 #include <mach/map.h>
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-timer.h>
+#include <asm/mach/irq.h>
 
 static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_chip(irq);
+
+	chained_irq_enter(chip, desc);
 	generic_handle_irq((int)desc->irq_data.handler_data);
+	chained_irq_exit(chip, desc);
 }
 
 /* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
-- 
1.7.1
