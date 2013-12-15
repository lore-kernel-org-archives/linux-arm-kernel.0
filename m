From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 15 Dec 2013 08:28:08 +0400
Subject: [PATCH v3 01/10] ARM: sa1100: switch to MULTI_IRQ_HANDLER
In-Reply-To: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
References: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1387081697-21841-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sa1100_handle_irq implementating handle_irq for sa1100 platform.
It is more or less a translation of old assembly code from assembler to
plain C. Alsi install this irq handler from sa1100_init_irq().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig           |  1 +
 arch/arm/mach-sa1100/irq.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7e..14e907e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -693,6 +693,7 @@ config ARCH_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
 	select ISA
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 2124f1fc..68e8f9d 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -20,6 +20,7 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 
 #include "generic.h"
 
@@ -291,6 +292,23 @@ static int __init sa1100irq_init_devicefs(void)
 
 device_initcall(sa1100irq_init_devicefs);
 
+static asmlinkage void __exception_irq_entry
+sa1100_handle_irq(struct pt_regs *regs)
+{
+	uint32_t icip, icmr, mask;
+
+	do {
+		icip = (ICIP);
+		icmr = (ICMR);
+		mask = icip & icmr;
+
+		if (mask == 0)
+			break;
+
+		handle_IRQ(fls(mask) - 1, regs);
+	} while (1);
+}
+
 void __init sa1100_init_irq(void)
 {
 	unsigned int irq;
@@ -338,5 +356,7 @@ void __init sa1100_init_irq(void)
 	irq_set_chip(IRQ_GPIO11_27, &sa1100_normal_chip);
 	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
 
+	set_handle_irq(sa1100_handle_irq);
+
 	sa1100_init_gpio();
 }
-- 
1.8.5.1
