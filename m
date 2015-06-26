From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 26 Jun 2015 13:52:36 -0500
Subject: [PATCH 3/3] [v2] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
References: <1435344756-20901-1-git-send-email-timur@codeaurora.org>
Message-ID: <1435344756-20901-3-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhimanyu Kapur <abhimany@codeaurora.org>

Add support for debug communications channel based
hvc console for arm64 cpus.

Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/include/asm/dcc.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig      |  2 +-
 drivers/tty/hvc/hvc_dcc.c    | 11 ++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/dcc.h

diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
new file mode 100644
index 0000000..d550173
--- /dev/null
+++ b/arch/arm64/include/asm/dcc.h
@@ -0,0 +1,52 @@
+/* Copyright (c) 2014 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * A call to __dcc_getchar() or __dcc_putchar() is typically followed by
+ * a call to __dcc_getstatus().  We want to make sure that the CPU does
+ * not speculative read the DCC status before executing the read or write
+ * instruction.  That's what the ISBs are for.
+ *
+ * The 'volatile' ensures that the compiler does not cache the status bits,
+ * and instead reads the DCC register every time.
+ */
+#ifndef __ASM_DCC_H
+#define __ASM_DCC_H
+
+#include <asm/barrier.h>
+
+static inline u32 __dcc_getstatus(void)
+{
+	u32 ret;
+
+	asm volatile("mrs %0, mdccsr_el0" : "=r" (ret));
+
+	return ret;
+}
+
+static inline char __dcc_getchar(void)
+{
+	char c;
+
+	asm volatile("mrs %0, dbgdtrrx_el0" : "=r" (c));
+	isb();
+
+	return c;
+}
+
+static inline void __dcc_putchar(char c)
+{
+	asm volatile("msr dbgdtrtx_el0, %0"
+			: /* No output register */
+			: "r" (c));
+	isb();
+}
+
+#endif
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 2c6883c..9a60d18 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -88,7 +88,7 @@ config HVC_UDBG
 
 config HVC_DCC
        bool "ARM JTAG DCC console"
-       depends on ARM
+       depends on ARM || ARM64
        select HVC_DRIVER
        help
          This console uses the JTAG DCC on ARM to create a console under the HVC
diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index f8b8cf2..d4c7073 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -226,11 +226,22 @@ static const struct hv_ops hvc_dcc_get_put_ops = {
 static int __init hvc_dcc_console_init(void)
 {
 	int ret;
+#ifdef CONFIG_ARM64
+	u32 val;
+#endif
 
 	/* This always runs on boot core */
 	if (!hvc_dcc_check())
 		return -ENODEV;
 
+#ifdef CONFIG_ARM64
+	/* Disable user-space access to DCC */
+	asm("msr mdscr_el1, %0    "
+		"orr %0, %0, #4096    " /* TDCC */
+		"msr %0, mdscr_el1    "
+		: "=r" (val));
+#endif
+
 	/* Returns -1 if error */
 	ret = hvc_instantiate(0, 0, &hvc_dcc_get_put_ops);
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
