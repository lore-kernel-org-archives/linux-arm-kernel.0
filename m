From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 11:50:53 +0300
Subject: [PATCH 7/8] arm: kdump: add support for elfcorehdr= parameter
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <50990b5fa34f02e0451f49f658d30dfd389c4905.1271752135.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This parameter is used by primary kernel to pass address of vmcore header to the
dump capture kernel.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/setup.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 076454f..25a1664 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
+#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -711,6 +712,30 @@ static void __init reserve_crashkernel(void)
 static inline void reserve_crashkernel(void) {}
 #endif /* CONFIG_KEXEC */
 
+/*
+ * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by
+ * is_kdump_kernel() to determine if we are booting after a panic. Hence
+ * ifdef it under CONFIG_CRASH_DUMP and not CONFIG_PROC_VMCORE.
+ */
+
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * elfcorehdr= specifies the location of elf core header stored by the crashed
+ * kernel. This option will be passed by kexec loader to the capture kernel.
+ */
+static int __init setup_elfcorehdr(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+
+	elfcorehdr_addr = memparse(arg, &end);
+	return end > arg ? 0 : -EINVAL;
+}
+early_param("elfcorehdr", setup_elfcorehdr);
+#endif /* CONFIG_CRASH_DUMP */
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
-- 
1.5.6.5
