From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 15:16:37 +0000
Subject: [PATCH 5/6] ARM: iop3xx: register PMU IRQs during board initialisation
In-Reply-To: <1269530198-19572-5-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
	<1269530198-19572-2-git-send-email-will.deacon@arm.com>
	<1269530198-19572-3-git-send-email-will.deacon@arm.com>
	<1269530198-19572-4-git-send-email-will.deacon@arm.com>
	<1269530198-19572-5-git-send-email-will.deacon@arm.com>
Message-ID: <1269530198-19572-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an initcall for the iop3xx platforms so that they
register their PMU IRQS with the PMU framework in the Kernel.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-iop/Makefile |    2 ++
 arch/arm/plat-iop/pmu.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-iop/pmu.c

diff --git a/arch/arm/plat-iop/Makefile b/arch/arm/plat-iop/Makefile
index 36bff03..69b09c1 100644
--- a/arch/arm/plat-iop/Makefile
+++ b/arch/arm/plat-iop/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARCH_IOP32X) += time.o
 obj-$(CONFIG_ARCH_IOP32X) += io.o
 obj-$(CONFIG_ARCH_IOP32X) += cp6.o
 obj-$(CONFIG_ARCH_IOP32X) += adma.o
+obj-$(CONFIG_ARCH_IOP32X) += pmu.o
 
 # IOP33X
 obj-$(CONFIG_ARCH_IOP33X) += gpio.o
@@ -23,6 +24,7 @@ obj-$(CONFIG_ARCH_IOP33X) += time.o
 obj-$(CONFIG_ARCH_IOP33X) += io.o
 obj-$(CONFIG_ARCH_IOP33X) += cp6.o
 obj-$(CONFIG_ARCH_IOP33X) += adma.o
+obj-$(CONFIG_ARCH_IOP33X) += pmu.o
 
 # IOP13XX
 obj-$(CONFIG_ARCH_IOP13XX) += cp6.o
diff --git a/arch/arm/plat-iop/pmu.c b/arch/arm/plat-iop/pmu.c
new file mode 100644
index 0000000..a2024b8
--- /dev/null
+++ b/arch/arm/plat-iop/pmu.c
@@ -0,0 +1,40 @@
+/*
+ * PMU IRQ registration for the iop3xx xscale PMU families.
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
+#ifdef CONFIG_ARCH_IOP32X
+	.start	= IRQ_IOP32X_CORE_PMU,
+	.end	= IRQ_IOP32X_CORE_PMU,
+#endif
+#ifdef CONFIG_ARCH_IOP33X
+	.start	= IRQ_IOP33X_CORE_PMU,
+	.end	= IRQ_IOP33X_CORE_PMU,
+#endif
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
+static int __init iop3xx_pmu_init(void)
+{
+	platform_device_register(&pmu_device);
+	return 0;
+}
+
+arch_initcall(iop3xx_pmu_init);
-- 
1.6.3.3
