From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Thu,  2 Aug 2018 16:49:50 -0400
Subject: [RFC PATCH] edac: armv8_edac: Add ARMv8 EDAC driver
Message-ID: <1533242990-12828-1-git-send-email-tbaicar@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARMv8 EDAC driver to detect and report errors that are reported
through the ARMv8.2 RAS extensions.

This is by no means complete hence the RFC. At minimum, this should
also have support to check the SRs of each CPU during boot time to
check for anything pending. Also, the SEI code flow could be improved
to separate the check for uncontained errors and panic ASAP before
doing any of this reporting.

This is also limited to SR based RAS extension nodes. There is not
currently a way to detect memory mapped RAS extension nodes. The
initialization which prints the FR registers only does so for a
single CPU, so the assumption is that all CPUs are identical from
a RAS extension node perspective.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 arch/arm64/include/asm/ras.h | 26 +++++++++++++++++++
 arch/arm64/kernel/Makefile   |  1 +
 arch/arm64/kernel/ras.c      | 54 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c    |  4 +++
 arch/arm64/mm/fault.c        |  4 +++
 drivers/edac/Kconfig         |  9 +++++++
 drivers/edac/Makefile        |  2 ++
 drivers/edac/armv8_edac.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/armv8_edac.h   | 20 +++++++++++++++
 9 files changed, 179 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c
 create mode 100644 drivers/edac/armv8_edac.c
 create mode 100644 include/linux/armv8_edac.h

diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 0000000..29b30e8
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#ifndef ARM64_RAS_H
+#define ARM64_RAS_H
+
+bool arch_cpu_has_ras_extensions(void);
+
+u64 arch_cpu_num_ras_nodes(void);
+
+void arch_report_ras_error_on_node(unsigned int cpu_num, unsigned int i);
+
+void arch_ras_node_setup(unsigned int i);
+
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 0025f869..c7998f4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -55,6 +55,7 @@ arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
 arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
+arm64-obj-$(CONFIG_EDAC_ARMV8)		+= ras.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
new file mode 100644
index 0000000..2cb0265
--- /dev/null
+++ b/arch/arm64/kernel/ras.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#include <linux/kernel.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+
+#include <asm/ras.h>
+
+bool arch_cpu_has_ras_extensions(void)
+{
+	return this_cpu_has_cap(ARM64_HAS_RAS_EXTN);
+}
+
+u64 arch_cpu_num_ras_nodes(void)
+{
+	return read_sysreg_s(SYS_ERRIDR_EL1);
+}
+
+void arch_report_ras_error_on_node(unsigned int cpu_num, unsigned int i)
+{
+	u64 status;
+
+	write_sysreg_s(i, SYS_ERRSELR_EL1);
+	status = read_sysreg_s(SYS_ERXSTATUS_EL1);
+	if (status) {
+		pr_err("cpu #%u: ERR%uSTATUS = 0x%llx\n", cpu_num, i, status);
+		pr_err("cpu #%u: ERR%uCTLR   = 0x%llx\n",
+			cpu_num, i, read_sysreg_s(SYS_ERXCTLR_EL1));
+		pr_err("cpu #%u: ERR%uADDR   = 0x%llx\n",
+			cpu_num, i, read_sysreg_s(SYS_ERXADDR_EL1));
+		pr_err("cpu #%u: ERR%uMISC0  = 0x%llx\n",
+			cpu_num, i, read_sysreg_s(SYS_ERXMISC0_EL1));
+		pr_err("cpu #%u: ERR%uMISC1  = 0x%llx\n",
+			cpu_num, i, read_sysreg_s(SYS_ERXMISC1_EL1));
+	}
+}
+
+void arch_ras_node_setup(unsigned int i)
+{
+	write_sysreg_s(i, SYS_ERRSELR_EL1);
+	pr_info("ERR%uFR = 0x%llx\n", i, read_sysreg_s(SYS_ERXFR_EL1));
+}
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d45..53ed974 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -35,6 +35,7 @@
 #include <linux/sizes.h>
 #include <linux/syscalls.h>
 #include <linux/mm_types.h>
+#include <linux/armv8_edac.h>
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
@@ -731,6 +732,9 @@ asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
 	nmi_enter();
 
+	if (IS_ENABLED(CONFIG_EDAC_ARMV8))
+		armv8_edac_report_error();
+
 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7..49debe7 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/armv8_edac.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -641,6 +642,9 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 
 		ghes_notify_sea();
 
+		if (IS_ENABLED(CONFIG_EDAC_ARMV8))
+			armv8_edac_report_error();
+
 		if (interrupts_enabled(regs))
 			nmi_exit();
 	}
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..da0281d 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -74,6 +74,15 @@ config EDAC_GHES
 
 	  In doubt, say 'Y'.
 
+config EDAC_ARMV8
+	bool "ARMv8 RAS extension based error reporting"
+	depends on (EDAC=y) && ARM64_RAS_EXTN
+	default y
+	help
+	  Support for error reporting through the ARMv8.2 RAS extension. The
+	  ARMv8.2 RAS extension provides an architected way of reporting
+	  hardware errors on ARM systems.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 02b43a7..001820d 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -50,6 +50,8 @@ amd64_edac_mod-$(CONFIG_EDAC_AMD64_ERROR_INJECTION) += amd64_edac_inj.o
 
 obj-$(CONFIG_EDAC_AMD64)		+= amd64_edac_mod.o
 
+obj-$(CONFIG_EDAC_ARMV8)		+= armv8_edac.o
+
 obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
 
 mpc85xx_edac_mod-y			:= fsl_ddr_edac.o mpc85xx_edac.o
diff --git a/drivers/edac/armv8_edac.c b/drivers/edac/armv8_edac.c
new file mode 100644
index 0000000..9df3dd8
--- /dev/null
+++ b/drivers/edac/armv8_edac.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#include <linux/armv8_edac.h>
+#include <linux/kernel.h>
+#include <linux/edac.h>
+
+#include <asm/ras.h>
+
+void armv8_edac_report_error(void)
+{
+	unsigned int cpu_num, i;
+	u64 num_nodes;
+
+	cpu_num = get_cpu();
+	if (!arch_cpu_has_ras_extensions())
+		return;
+
+	num_nodes = arch_cpu_num_ras_nodes();
+
+	for (i = 0; i < num_nodes; i++)
+		arch_report_ras_error_on_node(cpu_num, i);
+	put_cpu();
+}
+
+static int __init armv8_edac_init(void)
+{
+	unsigned int i;
+	u64 num_nodes;
+
+	get_cpu();
+	if (!arch_cpu_has_ras_extensions()) {
+		put_cpu();
+		return -ENOTSUPP;
+	}
+
+	pr_err("CPU has RAS extension\n");
+	num_nodes = arch_cpu_num_ras_nodes();
+
+	for (i = 0; i < num_nodes; i++) {
+		arch_ras_node_setup(i);
+	}
+
+	put_cpu();
+	return 0;
+}
+
+early_initcall(armv8_edac_init);
diff --git a/include/linux/armv8_edac.h b/include/linux/armv8_edac.h
new file mode 100644
index 0000000..222f7ea
--- /dev/null
+++ b/include/linux/armv8_edac.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#ifndef LINUX_ARMV8_EDAC_H
+#define LINUX_ARMV8_EDAC_H
+
+void armv8_edac_report_error(void);
+
+#endif
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
