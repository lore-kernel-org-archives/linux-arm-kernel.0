From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Oct 2013 13:15:52 +0200
Subject: [PATCH 1/2] at91: add rtt irq fixup
Message-ID: <1381490153-9706-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the irq can still be on after a reset or power on as the IP are
powered by the backup power. This could lead to an interrupt dead lock
when the kernel boot. So disable them before booting.

Handle it in C as the DT may not provide or enable the RTC node but we still
need the fixup.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-at91/Makefile      |  2 +-
 arch/arm/mach-at91/at91sam9260.c |  1 +
 arch/arm/mach-at91/at91sam9261.c |  1 +
 arch/arm/mach-at91/at91sam9263.c |  2 ++
 arch/arm/mach-at91/at91sam9g45.c |  1 +
 arch/arm/mach-at91/at91sam9rl.c  |  1 +
 arch/arm/mach-at91/generic.h     |  1 +
 arch/arm/mach-at91/irq_fixup.c   | 33 +++++++++++++++++++++++++++++++++
 8 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-at91/irq_fixup.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 3b0a953..1c8101c 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= irq.o gpio.o setup.o
+obj-y		:= irq.o gpio.o setup.o irq_fixup.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 5de6074..ad637c7 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -346,6 +346,7 @@ static void __init at91sam9260_ioremap_registers(void)
 
 static void __init at91sam9260_initialize(void)
 {
+	at91_rtt_irq_fixup(AT91SAM9260_BASE_RTT);
 	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 0e07932..772af58 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -288,6 +288,7 @@ static void __init at91sam9261_ioremap_registers(void)
 
 static void __init at91sam9261_initialize(void)
 {
+	at91_rtt_irq_fixup(AT91SAM9261_BASE_RTT);
 	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 6ce7d18..e2c0bfb 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -325,6 +325,8 @@ static void __init at91sam9263_ioremap_registers(void)
 
 static void __init at91sam9263_initialize(void)
 {
+	at91_rtt_irq_fixup(AT91SAM9263_BASE_RTT0);
+	at91_rtt_irq_fixup(AT91SAM9263_BASE_RTT1);
 	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 474ee04..b3e2693 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -374,6 +374,7 @@ static void __init at91sam9g45_ioremap_registers(void)
 
 static void __init at91sam9g45_initialize(void)
 {
+	at91_rtt_irq_fixup(AT91SAM9G45_BASE_RTT);
 	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9g45_restart;
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d4ec0d9..01feae9 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -291,6 +291,7 @@ static void __init at91sam9rl_ioremap_registers(void)
 
 static void __init at91sam9rl_initialize(void)
 {
+	at91_rtt_irq_fixup(AT91SAM9RL_BASE_RTT);
 	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index dc6e2f5..c7ad514 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -35,6 +35,7 @@ extern int  __init at91_aic_of_init(struct device_node *node,
 extern int  __init at91_aic5_of_init(struct device_node *node,
 				    struct device_node *parent);
 
+void at91_rtt_irq_fixup(uint32_t addr);
 
  /* Timer */
 extern void at91rm9200_ioremap_st(u32 addr);
diff --git a/arch/arm/mach-at91/irq_fixup.c b/arch/arm/mach-at91/irq_fixup.c
new file mode 100644
index 0000000..a93588f
--- /dev/null
+++ b/arch/arm/mach-at91/irq_fixup.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2 only
+ */
+
+#include <linux/io.h>
+#include <mach/at91_rtt.h>
+
+#include "generic.h"
+
+/*
+ * As the RTT is powered by the backup power so if the interrupt
+ * is still on when the kernel start, the kernel will end up with
+ * dead lock interrupt that it can not clear. Because the interrupt line is
+ * shared with the basic timer (PIT) on AT91_ID_SYS.
+ */
+void at91_rtt_irq_fixup(uint32_t addr)
+{
+	void __iomem *reg;
+	void __iomem *base;
+	u32 mr;
+
+	base = ioremap(addr, 16);
+	if (!base)
+		return;
+
+	reg = base + AT91_RTT_MR;
+	mr = readl(reg);
+
+	writel(mr &~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN), reg);
+	iounmap(base);
+}
-- 
1.8.4.rc3
