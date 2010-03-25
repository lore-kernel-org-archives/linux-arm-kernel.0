From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 15:16:38 +0000
Subject: [PATCH 6/6] ARM: pxa: register PMU IRQs during board initialisation
In-Reply-To: <1269530198-19572-6-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
	<1269530198-19572-2-git-send-email-will.deacon@arm.com>
	<1269530198-19572-3-git-send-email-will.deacon@arm.com>
	<1269530198-19572-4-git-send-email-will.deacon@arm.com>
	<1269530198-19572-5-git-send-email-will.deacon@arm.com>
	<1269530198-19572-6-git-send-email-will.deacon@arm.com>
Message-ID: <1269530198-19572-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an initcall for the pxa platforms so that they
register their PMU IRQs with the PMU framework in the Kernel.

Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-pxa/Makefile |    2 +-
 arch/arm/plat-pxa/pmu.c    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-pxa/pmu.c

diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 0264bfb..f68da35 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -2,7 +2,7 @@
 # Makefile for code common across different PXA processor families
 #
 
-obj-y	:= dma.o
+obj-y	:= dma.o pmu.o
 
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_PXA3xx)		+= mfp.o
diff --git a/arch/arm/plat-pxa/pmu.c b/arch/arm/plat-pxa/pmu.c
new file mode 100644
index 0000000..267ceb6
--- /dev/null
+++ b/arch/arm/plat-pxa/pmu.c
@@ -0,0 +1,33 @@
+/*
+ * PMU IRQ registration for the PXA xscale PMU families.
+ * Copyright (C) 2010 Will Deacon, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <asm/pmu.h>
+#include <mach/irqs.h>
+
+static struct resource pmu_resource = {
+	.start	= IRQ_PMU,
+	.end	= IRQ_PMU,
+	.flags	= IORESOURCE_IRQ,
+};
+
+static struct platform_device pmu_device = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.resource	= &pmu_resource,
+	.num_resources	= 1,
+};
+
+static int __init pxa_pmu_init(void)
+{
+	platform_device_register(&pmu_device);
+	return 0;
+}
+arch_initcall(pxa_pmu_init);
-- 
1.6.3.3
