From: dmitry_eremin@mentor.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Nov 2013 14:52:08 +0400
Subject: [PATCH 1/4] ARM: sa1100: add irq handler to prepare MULTI_IRQ_HANDLER
Message-ID: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sa1100_handle_irq implementating handle_irq for sa1100 platform.

Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
---
 arch/arm/mach-sa1100/generic.h |  1 +
 arch/arm/mach-sa1100/irq.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 0d92e11..a918ea5 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -12,6 +12,7 @@ extern void __init sa1100_init_irq(void);
 extern void __init sa1100_init_gpio(void);
 extern void sa11x0_restart(enum reboot_mode, const char *);
 extern void sa11x0_init_late(void);
+extern void sa1100_handle_irq(struct pt_regs *);
 
 #define SET_BANK(__nr,__start,__size) \
 	mi->bank[__nr].start = (__start), \
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 2124f1fc..2ec1f92 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -20,6 +20,7 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 
 #include "generic.h"
 
@@ -340,3 +341,19 @@ void __init sa1100_init_irq(void)
 
 	sa1100_init_gpio();
 }
+
+asmlinkage void __exception_irq_entry sa1100_handle_irq(struct pt_regs *regs)
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
-- 
1.8.4.rc3
