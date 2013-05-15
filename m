From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 14 May 2013 21:58:02 -0500
Subject: [RFC PATCH] ARM: SOCFPGA: Enable PMU through the CTI
Message-ID: <1368586682-19848-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

SOCFPGA has a PMU(Performance Measurement Unit) that has its
IRQs routed through Coresight using the CTI(Cross-Trigger Interface).

This patch enables the PMU and initializes the CTI for usage by
oprofile/perfmon.

A lot of the code/idea was taken from this:
https://patchwork.kernel.org/patch/1432541/

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Ming Lei <ming.lei@canonical.com>
CC: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Pavel Machek <pavel@denx.de>
---
 arch/arm/boot/dts/socfpga.dtsi      |   18 +++++
 arch/arm/include/asm/pmu.h          |    3 +
 arch/arm/kernel/perf_event.c        |   16 +++++
 arch/arm/mach-socfpga/Makefile      |    1 +
 arch/arm/mach-socfpga/socfpga.c     |   21 +++++-
 arch/arm/mach-socfpga/socfpga_cti.c |  125 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga_cti.h |   16 +++++
 7 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-socfpga/socfpga_cti.c
 create mode 100644 arch/arm/mach-socfpga/socfpga_cti.h

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 16a6e13..0f10a0a 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -255,6 +255,24 @@
 			cache-level = <2>;
 		};
 
+		pmu {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "arm,cortex-a9-pmu";
+			interrupts = <0 176 4>, <0 177 4>;
+			ranges;
+
+			cti0: cti0 at ff118000 {
+				compatible = "arm,coresight-cti";
+				reg = <0xff118000 0x100>;
+			};
+
+			cti1: cti1 at ff119000 {
+				compatible = "arm,coresight-cti";
+				reg = <0xff119000 0x100>;
+			};
+		};
+
 		/* Local timer */
 		timer at fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index f24edad..60324b3 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -38,6 +38,9 @@ struct arm_pmu_platdata {
 				  irq_handler_t pmu_handler);
 	int (*runtime_resume)(struct device *dev);
 	int (*runtime_suspend)(struct device *dev);
+	int (*init)(struct platform_device *pdev);
+	int (*start)(struct platform_device *pdev);
+	int (*stop)(struct platform_device *pdev);
 };
 
 #ifdef CONFIG_HW_PERF_EVENTS
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 8c3094d..66e9206 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -305,6 +305,11 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 static void
 armpmu_release_hardware(struct arm_pmu *armpmu)
 {
+	struct platform_device *plat_device = armpmu->plat_device;
+	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
+
+	if (plat->stop)
+		plat->stop(plat_device);
 	armpmu->free_irq(armpmu);
 	pm_runtime_put_sync(&armpmu->plat_device->dev);
 }
@@ -314,6 +319,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 {
 	int err;
 	struct platform_device *pmu_device = armpmu->plat_device;
+	struct arm_pmu_platdata *plat = dev_get_platdata(&pmu_device->dev);
 
 	if (!pmu_device)
 		return -ENODEV;
@@ -324,6 +330,8 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 		armpmu_release_hardware(armpmu);
 		return err;
 	}
+	if (plat->start)
+		plat->start(pmu_device);
 
 	return 0;
 }
@@ -506,10 +514,18 @@ static void armpmu_init(struct arm_pmu *armpmu)
 
 int armpmu_register(struct arm_pmu *armpmu, int type)
 {
+	struct platform_device *plat_device = armpmu->plat_device;
+	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
+
 	armpmu_init(armpmu);
 	pm_runtime_enable(&armpmu->plat_device->dev);
 	pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
+
+	/* Platform specific initialization. ie. CTI enable */
+	if (plat->init)
+		plat->init(plat_device);
+
 	return perf_pmu_register(&armpmu->pmu, armpmu->name, type);
 }
 
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 6dd7a93..c7401d3 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -4,3 +4,4 @@
 
 obj-y					:= socfpga.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
+obj-$(CONFIG_HW_PERF_EVENTS) += socfpga_cti.o
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 46a0513..64f90a5 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -24,8 +24,10 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/pmu.h>
 
 #include "core.h"
+#include "socfpga_cti.h"
 
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
@@ -33,6 +35,22 @@ void __iomem *rst_manager_base_addr;
 void __iomem *clk_mgr_base_addr;
 unsigned long cpu1start_addr;
 
+#ifdef CONFIG_HW_PERF_EVENTS
+static struct arm_pmu_platdata socfpga_pmu_platdata = {
+	.handle_irq = socfpga_pmu_handler,
+	.init = socfpga_init_cti,
+	.start = socfpga_start_cti,
+	.stop = socfpga_stop_cti,
+};
+#endif
+
+static const struct of_dev_auxdata socfpga_auxdata_lookup[] __initconst = {
+#ifdef CONFIG_HW_PERF_EVENTS
+	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &socfpga_pmu_platdata),
+#endif
+	{ /* sentinel */ }
+};
+
 static struct map_desc scu_io_desc __initdata = {
 	.virtual	= SOCFPGA_SCU_VIRT_BASE,
 	.pfn		= 0, /* run-time */
@@ -106,7 +124,8 @@ static void socfpga_cyclone5_restart(char mode, const char *cmd)
 static void __init socfpga_cyclone5_init(void)
 {
 	l2x0_of_init(0, ~0UL);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			socfpga_auxdata_lookup, NULL);
 	of_clk_init(NULL);
 	socfpga_init_clocks();
 }
diff --git a/arch/arm/mach-socfpga/socfpga_cti.c b/arch/arm/mach-socfpga/socfpga_cti.c
new file mode 100644
index 0000000..10072c8
--- /dev/null
+++ b/arch/arm/mach-socfpga/socfpga_cti.c
@@ -0,0 +1,125 @@
+/*
+ *  Copyright (C) 2013 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <asm/mach/map.h>
+#include <asm/cti.h>
+#include <asm/pmu.h>
+
+#include "core.h"
+#include "socfpga_cti.h"
+
+#define SOCFPGA_NUM_CTI	2
+
+struct cti socfpga_cti_data[SOCFPGA_NUM_CTI];
+
+irqreturn_t socfpga_pmu_handler(int irq, void *dev, irq_handler_t handler)
+{
+	unsigned int handled = 0;
+	int i;
+
+	for (i = 0; i < SOCFPGA_NUM_CTI; i++)
+		if (irq == socfpga_cti_data[i].irq) {
+			cti_irq_ack(&socfpga_cti_data[i]);
+			handled = handler(irq, dev);
+		}
+
+	return IRQ_RETVAL(handled);
+}
+
+int socfpga_init_cti(struct platform_device *pdev)
+{
+	struct device_node *np, *np2;
+	void __iomem *cti0_addr;
+	void __iomem *cti1_addr;
+	u32 irq0, irq1;
+
+	np = pdev->dev.of_node;
+	np2 = of_find_compatible_node(np, NULL, "arm,coresight-cti");
+	if (!np2) {
+		dev_err(&pdev->dev, "PMU: Unable to find coresight-cti\n");
+		return -1;
+	}
+	cti0_addr = of_iomap(np2, 0);
+	if (!cti0_addr) {
+		dev_err(&pdev->dev, "PMU: ioremap for CTI failed\n");
+		return -1;
+	}
+
+	irq0 = platform_get_irq(pdev, 0);
+	if (irq0 < 0)
+		goto free_irq0;
+
+	np2 = of_find_compatible_node(np2, NULL, "arm,coresight-cti");
+	if (!np2) {
+		dev_err(&pdev->dev, "PMU: Unable to find coresight-cti\n");
+		goto err_iounmap;
+	}
+	cti1_addr = of_iomap(np2, 0);
+	if (!cti1_addr)
+		goto err_iounmap;
+
+	irq1 = platform_get_irq(pdev, 1);
+	if (irq1 < 0)
+		goto free_irq1;
+
+	/*configure CTI0 for pmu irq routing*/
+	cti_init(&socfpga_cti_data[0], cti0_addr,
+		irq0, CTI_MPU_IRQ_TRIG_OUT);
+	cti_unlock(&socfpga_cti_data[0]);
+	cti_map_trigger(&socfpga_cti_data[0],
+		CTI_MPU_IRQ_TRIG_IN, CTI_MPU_IRQ_TRIG_OUT, PMU_CHANNEL_0);
+
+	/*configure CTI1 for pmu irq routing*/
+	cti_init(&socfpga_cti_data[1], cti1_addr,
+		irq1, CTI_MPU_IRQ_TRIG_OUT);
+	cti_unlock(&socfpga_cti_data[1]);
+	cti_map_trigger(&socfpga_cti_data[1],
+		CTI_MPU_IRQ_TRIG_IN, CTI_MPU_IRQ_TRIG_OUT, PMU_CHANNEL_1);
+
+	dev_info(&pdev->dev, "PMU:CTI successfully enabled\n");
+	return 0;
+
+free_irq1:
+	iounmap(cti1_addr);
+err_iounmap:
+	free_irq(irq0, pdev);
+free_irq0:
+	iounmap(cti0_addr);
+	return -1;
+}
+
+int socfpga_start_cti(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < SOCFPGA_NUM_CTI; i++)
+		cti_enable(&socfpga_cti_data[i]);
+
+	return 0;
+}
+
+int socfpga_stop_cti(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < SOCFPGA_NUM_CTI; i++)
+		cti_disable(&socfpga_cti_data[i]);
+
+	return 0;
+}
+
diff --git a/arch/arm/mach-socfpga/socfpga_cti.h b/arch/arm/mach-socfpga/socfpga_cti.h
new file mode 100644
index 0000000..cbeb063
--- /dev/null
+++ b/arch/arm/mach-socfpga/socfpga_cti.h
@@ -0,0 +1,16 @@
+#ifndef __SOCFPGA_CTI_H
+#define __SOCFPGA_CTI_H
+
+#define CTI_MPU_IRQ_TRIG_IN	1
+#define CTI_MPU_IRQ_TRIG_OUT	6
+
+#define PMU_CHANNEL_0	0
+#define PMU_CHANNEL_1	1
+
+#ifdef CONFIG_HW_PERF_EVENTS
+extern irqreturn_t socfpga_pmu_handler(int irq, void *dev, irq_handler_t handler);
+extern int socfpga_init_cti(struct platform_device *pdev);
+extern int socfpga_start_cti(struct platform_device *pdev);
+extern int socfpga_stop_cti(struct platform_device *pdev);
+#endif
+#endif /* __SOCFPGA_CTI_H */
-- 
1.7.9.5
