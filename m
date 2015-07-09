From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 9 Jul 2015 16:31:25 +0800
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci backend
In-Reply-To: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
References: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436430685-2202-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements cpuidle_ops using psci. After this patch, we can
use cpuidle-arm.c with psci backend for both arm and arm64.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/Makefile       |  1 +
 arch/arm/kernel/psci_cpuidle.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm/kernel/psci_cpuidle.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 3b995f5..96383d8 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
 ifeq ($(CONFIG_ARM_PSCI),y)
 obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
+obj-$(CONFIG_CPU_IDLE)		+= psci_cpuidle.o
 endif
 
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/psci_cpuidle.c b/arch/arm/kernel/psci_cpuidle.c
new file mode 100644
index 0000000..e7146d2
--- /dev/null
+++ b/arch/arm/kernel/psci_cpuidle.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2015 Marvell Technology Group Ltd.
+ * Author: Jisheng Zhang <jszhang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/psci.h>
+
+#include <asm/cpuidle.h>
+
+static struct cpuidle_ops psci_cpuidle_ops __initdata = {
+	.suspend = cpu_psci_cpu_suspend,
+	.init = cpu_psci_cpu_init_idle,
+};
+CPUIDLE_METHOD_OF_DECLARE(psci_cpuidle, "psci", &psci_cpuidle_ops);
-- 
2.1.4
