From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:05 +0200
Subject: [PATCH v2 01/11] soc: qcom: Separate kryo l2 accessors from PMU driver
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-2-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver provides kernel level API for other drivers
to access the MSM8996 L2 cache registers.
Separating the L2 access code from the PMU driver and
making it public to allow other drivers use it.
The accesses must be separated with a single spinlock,
maintained in this driver.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 arch/arm64/Kconfig.platforms         |  7 ++++
 drivers/perf/qcom_l2_pmu.c           | 48 +--------------------------
 drivers/soc/qcom/Makefile            |  1 +
 drivers/soc/qcom/kryo-l2-accessors.c | 64 ++++++++++++++++++++++++++++++++++++
 include/soc/qcom/kryo-l2-accessors.h | 22 +++++++++++++
 5 files changed, 95 insertions(+), 47 deletions(-)
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2401373..a6a6504 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -144,6 +144,13 @@ config ARCH_REALTEK
 	  This enables support for the ARMv8 based Realtek chipsets,
 	  like the RTD1295.
 
+config ARCH_MSM8996
+    bool "Enable Support for Qualcomm Technologies, Inc. MSM8996"
+	depends on ARCH_QCOM
+	help
+	This enables support for the MSM8996 chipset. If you do not
+	wish to build a kernel that runs on this chipset, say 'N' here.
+
 config ARCH_ROCKCHIP
 	bool "Rockchip Platforms"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 4fdc848..ba5f241 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -30,7 +30,7 @@
 
 #include <asm/barrier.h>
 #include <asm/local64.h>
-#include <asm/sysreg.h>
+#include <soc/qcom/kryo-l2-accessors.h>
 
 #define MAX_L2_CTRS             9
 
@@ -87,9 +87,6 @@
 #define L2_COUNTER_RELOAD       BIT_ULL(31)
 #define L2_CYCLE_COUNTER_RELOAD BIT_ULL(63)
 
-#define L2CPUSRSELR_EL1         sys_reg(3, 3, 15, 0, 6)
-#define L2CPUSRDR_EL1           sys_reg(3, 3, 15, 0, 7)
-
 #define reg_idx(reg, i)         (((i) * IA_L2_REG_OFFSET) + reg##_BASE)
 
 /*
@@ -107,49 +104,6 @@
 #define L2_EVENT_STREX                     0x421
 #define L2_EVENT_CLREX                     0x422
 
-static DEFINE_RAW_SPINLOCK(l2_access_lock);
-
-/**
- * set_l2_indirect_reg: write value to an L2 register
- * @reg: Address of L2 register.
- * @value: Value to be written to register.
- *
- * Use architecturally required barriers for ordering between system register
- * accesses
- */
-static void set_l2_indirect_reg(u64 reg, u64 val)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&l2_access_lock, flags);
-	write_sysreg_s(reg, L2CPUSRSELR_EL1);
-	isb();
-	write_sysreg_s(val, L2CPUSRDR_EL1);
-	isb();
-	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
-}
-
-/**
- * get_l2_indirect_reg: read an L2 register value
- * @reg: Address of L2 register.
- *
- * Use architecturally required barriers for ordering between system register
- * accesses
- */
-static u64 get_l2_indirect_reg(u64 reg)
-{
-	u64 val;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&l2_access_lock, flags);
-	write_sysreg_s(reg, L2CPUSRSELR_EL1);
-	isb();
-	val = read_sysreg_s(L2CPUSRDR_EL1);
-	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
-
-	return val;
-}
-
 struct cluster_pmu;
 
 /*
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 40c56f6..2bf8d93 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
+obj-$(CONFIG_ARCH_MSM8996) +=	kryo-l2-accessors.o
diff --git a/drivers/soc/qcom/kryo-l2-accessors.c b/drivers/soc/qcom/kryo-l2-accessors.c
new file mode 100644
index 0000000..6743848
--- /dev/null
+++ b/drivers/soc/qcom/kryo-l2-accessors.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/spinlock.h>
+#include <asm/sysreg.h>
+#include <soc/qcom/kryo-l2-accessors.h>
+
+#define L2CPUSRSELR_EL1         sys_reg(3, 3, 15, 0, 6)
+#define L2CPUSRDR_EL1           sys_reg(3, 3, 15, 0, 7)
+
+static DEFINE_RAW_SPINLOCK(l2_access_lock);
+
+/**
+ * set_l2_indirect_reg: write value to an L2 register
+ * @reg: Address of L2 register.
+ * @value: Value to be written to register.
+ *
+ * Use architecturally required barriers for ordering between system register
+ * accesses, and system registers with respect to device memory
+ */
+void set_l2_indirect_reg(u64 reg, u64 val)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2_access_lock, flags);
+	write_sysreg_s(reg, L2CPUSRSELR_EL1);
+	isb();
+	write_sysreg_s(val, L2CPUSRDR_EL1);
+	isb();
+	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
+}
+EXPORT_SYMBOL(set_l2_indirect_reg);
+
+/**
+ * get_l2_indirect_reg: read an L2 register value
+ * @reg: Address of L2 register.
+ *
+ * Use architecturally required barriers for ordering between system register
+ * accesses, and system registers with respect to device memory
+ */
+u64 get_l2_indirect_reg(u64 reg)
+{
+	u64 val;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2_access_lock, flags);
+	write_sysreg_s(reg, L2CPUSRSELR_EL1);
+	isb();
+	val = read_sysreg_s(L2CPUSRDR_EL1);
+	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
+
+	return val;
+}
+EXPORT_SYMBOL(get_l2_indirect_reg);
diff --git a/include/soc/qcom/kryo-l2-accessors.h b/include/soc/qcom/kryo-l2-accessors.h
new file mode 100644
index 0000000..e9a5eab
--- /dev/null
+++ b/include/soc/qcom/kryo-l2-accessors.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_ARCH_MSM_MSM_KRYO_L2_ACCESSORS_H
+#define __ASM_ARCH_MSM_MSM_KRYO_L2_ACCESSORS_H
+
+#ifdef CONFIG_ARCH_QCOM
+void set_l2_indirect_reg(u64 reg_addr, u64 val);
+u64 get_l2_indirect_reg(u64 reg_addr);
+#endif
+
+#endif
-- 
1.9.1
