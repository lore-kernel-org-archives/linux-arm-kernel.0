From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:29 -0400
Subject: [PATCH 13/13] ARM: bL_switcher: add a simple /dev user interface for
 debugging purposes
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-14-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the basic call to aid debugging.

*** NOT FOR PRODUCTION ***

Usage:

	echo <cpuid>,<clusterid> > /dev/b.L_switcher

where <cpuid> is the logical CPU number, and <clusterid> is 0 for the
first cluster and 1 for the second cluster.

Signed-off-by: nicolas Pitre <nico@linaro.org>
---
 arch/arm/Kconfig                       |  8 ++++
 arch/arm/common/Makefile               |  1 +
 arch/arm/common/bL_switcher_dummy_if.c | 71 ++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 arch/arm/common/bL_switcher_dummy_if.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c9e5bf734..ccc5b39594 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1555,6 +1555,14 @@ config BL_SWITCHER
 	  transparently handle transition between a cluster of A15's
 	  and a cluster of A7's in a big.LITTLE system.
 
+config BL_SWITCHER_DUMMY_IF
+	tristate "Simple big.LITTLE switcher user interface"
+	depends on BL_SWITCHER && DEBUG_KERNEL
+	help
+	  This is a simple and dummy char dev interface to control
+	  the big.LITTLE switcher core code.  It is meant for
+	  debugging purposes only.
+
 choice
 	prompt "Memory split"
 	default VMSPLIT_3G
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 2586240d5a..5c8584c494 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -18,3 +18,4 @@ AFLAGS_mcpm_head.o		:= -march=armv7-a
 AFLAGS_vlock.o			:= -march=armv7-a
 obj-$(CONFIG_TI_PRIV_EDMA)	+= edma.o
 obj-$(CONFIG_BL_SWITCHER)	+= bL_switcher.o
+obj-$(CONFIG_BL_SWITCHER_DUMMY_IF) += bL_switcher_dummy_if.o
diff --git a/arch/arm/common/bL_switcher_dummy_if.c b/arch/arm/common/bL_switcher_dummy_if.c
new file mode 100644
index 0000000000..3f47f1203c
--- /dev/null
+++ b/arch/arm/common/bL_switcher_dummy_if.c
@@ -0,0 +1,71 @@
+/*
+ * arch/arm/common/bL_switcher_dummy_if.c -- b.L switcher dummy interface
+ *
+ * Created by:	Nicolas Pitre, November 2012
+ * Copyright:	(C) 2012-2013  Linaro Limited
+ *
+ * Dummy interface to user space for debugging purpose only.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <asm/uaccess.h>
+#include <asm/bL_switcher.h>
+
+static ssize_t bL_switcher_write(struct file *file, const char __user *buf,
+			size_t len, loff_t *pos)
+{
+	unsigned char val[3];
+	unsigned int cpu, cluster;
+	int ret;
+
+	pr_debug("%s\n", __func__);
+
+	if (len < 3)
+		return -EINVAL;
+
+	if (copy_from_user(val, buf, 3))
+		return -EFAULT;
+
+	/* format: <cpu#>,<cluster#> */
+	if (val[0] < '0' || val[0] > '9' ||
+	    val[1] != ',' ||
+	    val[2] < '0' || val[2] > '1')
+		return -EINVAL;
+
+	cpu = val[0] - '0';
+	cluster = val[2] - '0';
+	ret = bL_switch_request(cpu, cluster);
+
+	return ret ? : len;
+}
+
+static const struct file_operations bL_switcher_fops = {
+	.write		= bL_switcher_write,
+	.owner	= THIS_MODULE,
+};
+
+static struct miscdevice bL_switcher_device = {
+	MISC_DYNAMIC_MINOR,
+	"b.L_switcher",
+	&bL_switcher_fops
+};
+
+static int __init bL_switcher_dummy_if_init(void)
+{
+	return misc_register(&bL_switcher_device);
+}
+
+static void __exit bL_switcher_dummy_if_exit(void)
+{
+	misc_deregister(&bL_switcher_device);
+}
+
+module_init(bL_switcher_dummy_if_init);
+module_exit(bL_switcher_dummy_if_exit);
-- 
1.8.1.2
