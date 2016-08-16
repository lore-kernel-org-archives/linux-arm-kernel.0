From: nleeder@codeaurora.org (Neil Leeder)
Date: Tue, 16 Aug 2016 15:11:42 -0400
Subject: [PATCH v3 1/2] soc: qcom: provide mechanism for drivers to access L2
 registers
In-Reply-To: <1471374703-8109-1-git-send-email-nleeder@codeaurora.org>
References: <1471374703-8109-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <1471374703-8109-2-git-send-email-nleeder@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

L2 registers are accessed using a select register and data
register pair. To prevent multiple concurrent writes to the
select register by independent drivers, the write to the
select register and the associated access of the data register
are protected with a lock. All drivers accessing the L2
registers use the set and get functions provided by
l2-accessors to ensure correct reads and writes to L2 registers.

Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
---
 drivers/soc/qcom/Kconfig              |  6 ++++
 drivers/soc/qcom/Makefile             |  1 +
 drivers/soc/qcom/l2-accessors.c       | 63 +++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/l2-accessors.h | 20 +++++++++++
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/soc/qcom/l2-accessors.c
 create mode 100644 include/linux/soc/qcom/l2-accessors.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 461b387..ddd6b71 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -10,6 +10,12 @@ config QCOM_GSBI
           functions for connecting the underlying serial UART, SPI, and I2C
           devices to the output pins.
 
+config QCOM_L2_ACCESSORS
+	bool
+	help
+	  Provides support for accessing registers in the L2 cache
+	  for Qualcomm Technologies ARM64 chips.
+
 config QCOM_PM
 	bool "Qualcomm Power Management"
 	depends on ARCH_QCOM && !ARM64
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index fdd664e..6ef29b9 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
+obj-$(CONFIG_QCOM_L2_ACCESSORS) += l2-accessors.o
 obj-$(CONFIG_QCOM_PM)	+=	spm.o
 obj-$(CONFIG_QCOM_SMD) +=	smd.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
diff --git a/drivers/soc/qcom/l2-accessors.c b/drivers/soc/qcom/l2-accessors.c
new file mode 100644
index 0000000..2625d33
--- /dev/null
+++ b/drivers/soc/qcom/l2-accessors.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2014-2016 The Linux Foundation. All rights reserved.
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
+#include <linux/soc/qcom/l2-accessors.h>
+#include <asm/cputype.h>
+#include <asm/sysreg.h>
+
+#define	L2CPUSRSELR_EL1	S3_3_c15_c0_6
+#define	L2CPUSRDR_EL1	S3_3_c15_c0_7
+
+static DEFINE_RAW_SPINLOCK(l2_access_lock);
+
+/**
+ * set_l2_indirect_reg: write value to an L2 register
+ * @reg: Address of L2 register.
+ * @value: Value to be written to register.
+ *
+ * Use architecturally required barriers for ordering between system register
+ * accesses
+ */
+void set_l2_indirect_reg(u64 reg, u64 val)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2_access_lock, flags);
+	write_sysreg(reg, L2CPUSRSELR_EL1);
+	isb();
+	write_sysreg(val, L2CPUSRDR_EL1);
+	isb();
+	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
+}
+
+/**
+ * get_l2_indirect_reg: read an L2 register value
+ * @reg: Address of L2 register.
+ *
+ * Use architecturally required barriers for ordering between system register
+ * accesses
+ */
+u64 get_l2_indirect_reg(u64 reg)
+{
+	u64 val;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2_access_lock, flags);
+	write_sysreg(reg, L2CPUSRSELR_EL1);
+	isb();
+	val = read_sysreg(L2CPUSRDR_EL1);
+	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
+
+	return val;
+}
diff --git a/include/linux/soc/qcom/l2-accessors.h b/include/linux/soc/qcom/l2-accessors.h
new file mode 100644
index 0000000..e51b72a
--- /dev/null
+++ b/include/linux/soc/qcom/l2-accessors.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (c) 2011-2016 The Linux Foundation. All rights reserved.
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
+#ifndef __QCOM_L2_ACCESSORS_H
+#define __QCOM_L2_ACCESSORS_H
+
+void set_l2_indirect_reg(u64 reg_addr, u64 val);
+u64 get_l2_indirect_reg(u64 reg_addr);
+
+#endif
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
