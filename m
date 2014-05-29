From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:12 -0500
Subject: [PATCH v2 02/11] irqchip: versatile-fpga: Add IRQCHIP_DECLARE support
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add support for initialization using IRQCHIP_DECLARE. This also requires
that the controller initialization set the handle_irq function pointer
itself when it is a primary controller.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
v2:
- New patch

 drivers/irqchip/irq-versatile-fpga.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 3ae2bb8..8e0bb56 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -14,6 +14,8 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
+#include "irqchip.h"
+
 #define IRQ_STATUS		0x00
 #define IRQ_RAW_STATUS		0x04
 #define IRQ_ENABLE_SET		0x08
@@ -201,8 +203,10 @@ int __init fpga_irq_of_init(struct device_node *node,
 
 	/* Some chips are cascaded from a parent IRQ */
 	parent_irq = irq_of_parse_and_map(node, 0);
-	if (!parent_irq)
+	if (!parent_irq) {
+		set_handle_irq(fpga_handle_irq);
 		parent_irq = -1;
+	}
 
 	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
 
@@ -211,4 +215,5 @@ int __init fpga_irq_of_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(arm_fpga, "arm,versatile-fpga-irq", fpga_irq_of_init);
 #endif
-- 
1.9.1
