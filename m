From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Fri, 20 Jan 2012 13:59:16 +0100
Subject: [PATCH] ARM: ux500: Initialize irq affinity
Message-ID: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_set_affinity() to initialize the kernel view of irq affinity
when programming the GIC registers.

Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
---
 arch/arm/mach-ux500/cpu.c                      |    7 +++++++
 arch/arm/mach-ux500/include/mach/irqs-db8500.h |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index f418574..164347f 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -28,6 +28,7 @@ void __init ux500_init_irq(void)
 {
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
+	int i;
 
 	if (cpu_is_u5500()) {
 		dist_base = __io_address(U5500_GIC_DIST_BASE);
@@ -40,6 +41,12 @@ void __init ux500_init_irq(void)
 
 	gic_init(0, 29, dist_base, cpu_base);
 
+	for (i = IRQ_SHPI_START; i <= IRQ_SHPI_END; i++) {
+		if (i >= IRQ_MODEM_START && i <= IRQ_MODEM_END)
+			continue;
+		irq_set_affinity(i, cpumask_of(0));
+	}
+
 	/*
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
diff --git a/arch/arm/mach-ux500/include/mach/irqs-db8500.h b/arch/arm/mach-ux500/include/mach/irqs-db8500.h
index 68bc149..3279b0e 100644
--- a/arch/arm/mach-ux500/include/mach/irqs-db8500.h
+++ b/arch/arm/mach-ux500/include/mach/irqs-db8500.h
@@ -8,6 +8,10 @@
 #ifndef __MACH_IRQS_DB8500_H
 #define __MACH_IRQS_DB8500_H
 
+#define IRQ_SHPI_END (IRQ_SHPI_START + 127)
+#define IRQ_MODEM_START (IRQ_SHPI_START + 64)
+#define IRQ_MODEM_END (IRQ_SHPI_START + 83)
+
 #define IRQ_DB8500_MTU0			(IRQ_SHPI_START + 4)
 #define IRQ_DB8500_SPI2			(IRQ_SHPI_START + 6)
 #define IRQ_DB8500_PMU			(IRQ_SHPI_START + 7)
-- 
1.7.8.3
