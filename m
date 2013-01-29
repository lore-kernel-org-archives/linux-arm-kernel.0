From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Jan 2013 16:18:36 +0000
Subject: [PATCH v2 1/4] arm: Move the set_handle_irq and handle_arch_irq
 declarations to asm/irq.h
In-Reply-To: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1359476319-23720-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prepares the removal of <asm/mach/irq.h> include in the
GIC and VIC irqchip drivers.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/irq.h      | 5 +++++
 arch/arm/include/asm/mach/irq.h | 5 -----
 drivers/irqchip/irq-vic.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 35c21c3..53c15de 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -30,6 +30,11 @@ extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+extern void (*handle_arch_irq)(struct pt_regs *);
+extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
+#endif
+
 #endif
 
 #endif
diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index 18c8830..749d505 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -20,11 +20,6 @@ struct seq_file;
 extern void init_FIQ(int);
 extern int show_fiq_list(struct seq_file *, int);
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-extern void (*handle_arch_irq)(struct pt_regs *);
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-#endif
-
 /*
  * This is for easy migration, but should be changed in the source
  */
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 3cf97aa..e38cb00 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -33,7 +33,7 @@
 #include <linux/irqchip/arm-vic.h>
 
 #include <asm/exception.h>
-#include <asm/mach/irq.h>
+#include <asm/irq.h>
 
 #include "irqchip.h"
 
