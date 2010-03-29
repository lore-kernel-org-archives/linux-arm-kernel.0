From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:34 +0300
Subject: [RFC 08/10] arm: kdump: add support for elfcorehdr= parameter
In-Reply-To: <01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<49c5365fe4f794390ca2a4de75365953e211ab3f.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <4973ec4f4071a967bcb4f8d72bbe950204fcc83a.1269854500.git.ext-mika.1.westerberg@nokia.com>
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
