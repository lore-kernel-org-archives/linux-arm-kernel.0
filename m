From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri,  4 May 2018 21:05:39 +0200
Subject: [PATCH v9 06/12] ARM: smp: Add initialization of CNTVOFF
In-Reply-To: <20180504190545.5114-1-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
Message-ID: <20180504190545.5114-7-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CNTVOFF register from arch timer is uninitialized.
It should be done by the bootloader but it is currently not the case,
even for boot CPU because this SoC is booting in secure mode.
It leads to an random offset value meaning that each CPU will have a
different time, which isn't working very well.

Add assembly code used for boot CPU and secondary CPU cores to make
sure that the CNTVOFF register is initialized. Because this code can
be used by different platforms, add this assembly file in ARM's common
folder.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/common/Makefile              |  1 +
 arch/arm/common/secure_cntvoff.S      | 31 +++++++++++++++++++++++++++++++
 arch/arm/include/asm/secure_cntvoff.h |  8 ++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm/common/secure_cntvoff.S
 create mode 100644 arch/arm/include/asm/secure_cntvoff.h

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 70b4a14ed993..1e9f7af8f70f 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
+obj-$(CONFIG_SMP)		+= secure_cntvoff.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
diff --git a/arch/arm/common/secure_cntvoff.S b/arch/arm/common/secure_cntvoff.S
new file mode 100644
index 000000000000..68a4a8344319
--- /dev/null
+++ b/arch/arm/common/secure_cntvoff.S
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ *
+ * Initialization of CNTVOFF register from secure mode
+ *
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+ENTRY(secure_cntvoff_init)
+	.arch	armv7-a
+	/*
+	 * CNTVOFF has to be initialized either from non-secure Hypervisor
+	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
+	 * then it should be handled by the secure code
+	 */
+	cps	#MON_MODE
+	mrc	p15, 0, r1, c1, c1, 0		/* Get Secure Config */
+	orr	r0, r1, #1
+	mcr	p15, 0, r0, c1, c1, 0		/* Set Non Secure bit */
+	isb
+	mov	r0, #0
+	mcrr	p15, 4, r0, r0, c14		/* CNTVOFF = 0 */
+	isb
+	mcr	p15, 0, r1, c1, c1, 0		/* Set Secure bit */
+	isb
+	cps	#SVC_MODE
+	ret	lr
+ENDPROC(secure_cntvoff_init)
diff --git a/arch/arm/include/asm/secure_cntvoff.h b/arch/arm/include/asm/secure_cntvoff.h
new file mode 100644
index 000000000000..1f93aee1f630
--- /dev/null
+++ b/arch/arm/include/asm/secure_cntvoff.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASMARM_ARCH_CNTVOFF_H
+#define __ASMARM_ARCH_CNTVOFF_H
+
+extern void secure_cntvoff_init(void);
+
+#endif
-- 
2.11.0
