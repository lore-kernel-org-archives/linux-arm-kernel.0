From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Tue,  8 Dec 2015 14:28:32 +0100
Subject: [PATCH v5 1/4] arm/arm64: add arm-smccc
In-Reply-To: <1449581315-14519-1-git-send-email-jens.wiklander@linaro.org>
References: <1449581315-14519-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1449581315-14519-2-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helpers to do SMC and HVC based on ARM SMC Calling Convention.
CONFIG_HAVE_ARM_SMCCC is enabled for architectures that may support the
SMC or HVC instruction. It's the responsibility of the caller to know if
the SMC instruction is supported by the platform.

This patch doesn't provide an implementation of the declared functions.
Later patches will bring in implementations and set
CONFIG_HAVE_ARM_SMCCC for ARM and ARM64 respectively.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/arm-smccc.h | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 init/Kconfig              |  3 ++
 2 files changed, 101 insertions(+)
 create mode 100644 include/linux/arm-smccc.h

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
new file mode 100644
index 0000000..dea68a9
--- /dev/null
+++ b/include/linux/arm-smccc.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef __LINUX_ARM_SMCCC_H
+#define __LINUX_ARM_SMCCC_H
+
+#include <linux/types.h>
+#include <linux/linkage.h>
+
+/*
+ * This file provides common defines for ARM SMC Calling Convention as
+ * specified in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+ */
+
+#define ARM_SMCCC_SMC_32		(0 << 30)
+#define ARM_SMCCC_SMC_64		(1 << 30)
+#define ARM_SMCCC_FAST_CALL		(1 << 31)
+#define ARM_SMCCC_STD_CALL		(0 << 31)
+
+#define ARM_SMCCC_OWNER_MASK		0x3F
+#define ARM_SMCCC_OWNER_SHIFT		24
+
+#define ARM_SMCCC_FUNC_MASK		0xFFFF
+
+#define ARM_SMCCC_IS_FAST_CALL(smc_val)	((smc_val) & ARM_SMCCC_FAST_CALL)
+#define ARM_SMCCC_IS_64(smc_val)	((smc_val) & ARM_SMCCC_SMC_64)
+#define ARM_SMCCC_FUNC_NUM(smc_val)	((smc_val) & ARM_SMCCC_FUNC_MASK)
+#define ARM_SMCCC_OWNER_NUM(smc_val) \
+	(((smc_val) >> ARM_SMCCC_OWNER_SHIFT) & ARM_SMCCC_OWNER_MASK)
+
+#define ARM_SMCCC_CALL_VAL(type, calling_convention, owner, func_num) \
+	((type) | (calling_convention) | \
+	(((owner) & ARM_SMCCC_OWNER_MASK) << ARM_SMCCC_OWNER_SHIFT) | \
+	((func_num) & ARM_SMCCC_FUNC_MASK))
+
+#define ARM_SMCCC_OWNER_ARCH		0
+#define ARM_SMCCC_OWNER_CPU		1
+#define ARM_SMCCC_OWNER_SIP		2
+#define ARM_SMCCC_OWNER_OEM		3
+#define ARM_SMCCC_OWNER_STANDARD	4
+#define ARM_SMCCC_OWNER_TRUSTED_APP	48
+#define ARM_SMCCC_OWNER_TRUSTED_APP_END	49
+#define ARM_SMCCC_OWNER_TRUSTED_OS	50
+#define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
+
+/**
+ * struct arm_smccc_res - Result from SMC/HVC call
+ * @a0-a3 result values from registers 0 to 3
+ */
+struct arm_smccc_res {
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+};
+
+/**
+ * arm_smccc_smc() - make SMC calls
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This function is used to make SMC calls following SMC Calling Convention.
+ * The content of the supplied param are copied to registers 0 to 7 prior
+ * to the SMC instruction. The return values are updated with the content
+ * from register 0 to 3 on return from the SMC instruction.
+ */
+asmlinkage void arm_smccc_smc(unsigned long a0, unsigned long a1,
+			unsigned long a2, unsigned long a3, unsigned long a4,
+			unsigned long a5, unsigned long a6, unsigned long a7,
+			struct arm_smccc_res *res);
+
+/**
+ * arm_smccc_hvc() - make HVC calls
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This function is used to make HVC calls following SMC Calling
+ * Convention.  The content of the supplied param are copied to registers 0
+ * to 7 prior to the HVC instruction. The return values are updated with
+ * the content from register 0 to 3 on return from the HVC instruction.
+ */
+asmlinkage void arm_smccc_hvc(unsigned long a0, unsigned long a1,
+			unsigned long a2, unsigned long a3, unsigned long a4,
+			unsigned long a5, unsigned long a6, unsigned long a7,
+			struct arm_smccc_res *res);
+
+#endif /*__LINUX_ARM_SMCCC_H*/
diff --git a/init/Kconfig b/init/Kconfig
index c24b6f7..8d5a7b0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2061,3 +2061,6 @@ config ASN1
 	  functions to call on what tags.
 
 source "kernel/Kconfig.locks"
+
+config HAVE_ARM_SMCCC
+	bool
-- 
1.9.1
