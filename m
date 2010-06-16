From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jun 2010 16:33:23 -0400
Subject: [PATCH 5/5] Stack protector: test module
In-Reply-To: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
References: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
Message-ID: <1276720403-27918-6-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This module creates a stack overflow and tests if the stack protector
actually catches it.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 samples/Kconfig                     |    8 +++
 samples/Makefile                    |    2 +-
 samples/tests/Makefile              |    5 ++
 samples/tests/test_stackprotector.c |   86 +++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletions(-)
 create mode 100644 samples/tests/Makefile
 create mode 100644 samples/tests/test_stackprotector.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 8924f72..13f0eb2 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -44,4 +44,12 @@ config SAMPLE_HW_BREAKPOINT
 	help
 	  This builds kernel hardware breakpoint example modules.
 
+config SAMPLE_TEST_STACKPROTECTOR
+	tristate "Build test module for the stack protector -- loadable modules only"
+	depends on CC_STACKPROTECTOR && m
+	help
+	  This build a test module which upon insertion will exercize
+	  the -fstack-protector buffer overflow detection feature.
+	  Beware that this test is destructive as it will panic the kernel. 
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 0f15e6d..69132eb 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,4 +1,4 @@
 # Makefile for Linux samples code
 
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ tracepoints/ trace_events/ \
-			   hw_breakpoint/
+			   hw_breakpoint/ tests/
diff --git a/samples/tests/Makefile b/samples/tests/Makefile
new file mode 100644
index 0000000..b174287
--- /dev/null
+++ b/samples/tests/Makefile
@@ -0,0 +1,5 @@
+# builds those example test modules, then to use one
+# (as root):insmod <module_name.ko>
+# Beware: those tests may be destructive!
+
+obj-$(CONFIG_SAMPLE_TEST_STACKPROTECTOR) += test_stackprotector.o
diff --git a/samples/tests/test_stackprotector.c b/samples/tests/test_stackprotector.c
new file mode 100644
index 0000000..1ea19a7
--- /dev/null
+++ b/samples/tests/test_stackprotector.c
@@ -0,0 +1,86 @@
+/*
+ * Sample test module to exercize the -fstack-protector buffer overflow
+ * detection feature.
+ *
+ * Author:	Nicolas Pitre
+ * Created:	June 7, 2010
+ * Copyright:	Canonical Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Beware: upon insertion of this module, the kernel should panic!
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static long (*test_fn)(long *);
+
+static long test_good(long *x)
+{
+	int i;
+	long v;
+
+	x[0] = 0;
+	x[1] = 1;
+	for (i = 2; i < 50; i++) {
+		v = x[i-1] + x[i-2];
+		x[i] = v;
+	}
+
+	return v;
+}
+
+static void test_bad_target(void)
+{
+	/* Execution should never get here. */
+	panic("*** FAIL: STACK OVERFLOW DETECTION DID NOT TRIGGER ***\n");
+}
+
+static long test_stack_attack(long *x)
+{
+	int i;
+
+	/*
+	 * Let's overwrite the stack to scrub over our caller's
+	 * own return address.
+	 */
+	for (i = 50; i < 70; i++)
+		x[i] = (long)&test_bad_target;
+
+	/*
+	 * And then pretend some normality.
+	 */
+	return test_good(x);
+}
+
+/* this is not marked "static" to make sure it is not inlined */
+long test_stackprotected_caller(long *x)
+{
+	long buffer[50];
+	return test_fn(buffer);
+}
+
+static int __init test_stackprotector_init(void)
+{
+	long dummy_buffer[20];
+
+	printk(KERN_CRIT "*** stack protector test module ***\n");
+
+	test_fn = &test_good;
+	printk(KERN_CRIT "... testing normal function call\n");
+	test_stackprotected_caller(dummy_buffer);
+
+	test_fn = &test_stack_attack;
+	printk(KERN_CRIT "... testing rogue function call\n");
+	test_stackprotected_caller(dummy_buffer);
+
+	/* the kernel should have panicked by now */
+	printk(KERN_CRIT "*** FAIL: stack overflow attempt did not work ***\n");
+	return -EINVAL;
+}
+
+module_init(test_stackprotector_init)
+MODULE_LICENSE("GPL");
-- 
1.7.1.337.gbd0bc
