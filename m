From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 18 May 2015 17:44:07 +0300
Subject: [RESEND][PATCH 5/5] ARM: sa1100: properly split irqchip driver
In-Reply-To: <1431960247-32646-1-git-send-email-dbaryshkov@gmail.com>
References: <1431960247-32646-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1431960247-32646-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally properly split the irq driver into generic init code and irqchip
driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/generic.c     | 13 +++++++++++++
 drivers/irqchip/irq-sa11x0.c       | 18 ++++--------------
 include/linux/irqchip/irq-sa11x0.h | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/irqchip/irq-sa11x0.h

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index c651f6e..345e63f 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/irqchip/irq-sa11x0.h>
 
 #include <video/sa1100fb.h>
 
@@ -377,6 +378,18 @@ void __init sa1100_timer_init(void)
 	pxa_timer_nodt_init(IRQ_OST0, io_p2v(0x90000000), 3686400);
 }
 
+static struct resource irq_resource =
+	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
+
+void __init sa1100_init_irq(void)
+{
+	request_resource(&iomem_resource, &irq_resource);
+
+	sa11x0_init_irq_nodt(IRQ_GPIO0_SC, irq_resource.start);
+
+	sa1100_init_gpio();
+}
+
 /*
  * Disable the memory bus request/grant signals on the SA1110 to
  * ensure that we don't receive spurious memory requests.  We set
diff --git a/drivers/irqchip/irq-sa11x0.c b/drivers/irqchip/irq-sa11x0.c
index a5e1a54..76b8c1d 100644
--- a/drivers/irqchip/irq-sa11x0.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -15,16 +15,13 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/ioport.h>
 #include <linux/syscore_ops.h>
+#include <linux/irqchip/irq-sa11x0.h>
 
 #include <soc/sa1100/pwer.h>
 
-#include <mach/irqs.h>
 #include <asm/exception.h>
 
-#include "../../arch/arm/mach-sa1100/generic.h"
-
 #define ICIP	0x00  /* IC IRQ Pending reg. */
 #define ICMR	0x04  /* IC Mask Reg.        */
 #define ICLR	0x08  /* IC Level Reg.       */
@@ -86,9 +83,6 @@ static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
 
 static struct irq_domain *sa1100_normal_irqdomain;
 
-static struct resource irq_resource =
-	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
-
 static struct sa1100irq_state {
 	unsigned int	saved;
 	unsigned int	icmr;
@@ -156,11 +150,9 @@ sa1100_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-void __init sa1100_init_irq(void)
+void __init sa11x0_init_irq_nodt(int irq_start, resource_size_t io_start)
 {
-	request_resource(&iomem_resource, &irq_resource);
-
-	iobase = ioremap(irq_resource.start, SZ_64K);
+	iobase = ioremap(io_start, SZ_64K);
 	if (WARN_ON(!iobase))
 		return;
 
@@ -177,10 +169,8 @@ void __init sa1100_init_irq(void)
 	writel_relaxed(1, iobase + ICCR);
 
 	sa1100_normal_irqdomain = irq_domain_add_simple(NULL,
-			32, IRQ_GPIO0_SC,
+			32, irq_start,
 			&sa1100_normal_irqdomain_ops, NULL);
 
 	set_handle_irq(sa1100_handle_irq);
-
-	sa1100_init_gpio();
 }
diff --git a/include/linux/irqchip/irq-sa11x0.h b/include/linux/irqchip/irq-sa11x0.h
new file mode 100644
index 0000000..2f66eca
--- /dev/null
+++ b/include/linux/irqchip/irq-sa11x0.h
@@ -0,0 +1,16 @@
+/*
+ * Generic IRQ handling for the SA11x0.
+ *
+ * Copyright (C) 1999-2001 Nicolas Pitre
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __INCLUDE_LINUX_IRQCHIP_IRQ_SA11x0_H
+#define __INCLUDE_LINUX_IRQCHIP_IRQ_SA11x0_H
+
+void __init sa11x0_init_irq_nodt(int irq_start, resource_size_t io_start);
+
+#endif
-- 
2.1.4
