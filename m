From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Tue, 27 May 2014 16:29:59 -0400
Subject: [RFC 2/2] PCC Test driver
In-Reply-To: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1401222599-12416-3-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Opens a node in /proc/pcc_test.

Echo 0 for PCC read
Echo 1 for PCC write
Echo 2 for read base addr of PCC channel

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/pcc-test.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/pcc-test.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d8aa613..f7bbbe9 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -74,7 +74,7 @@ obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
-obj-$(CONFIG_ACPI_PCC)		+= pcc.o
+obj-$(CONFIG_ACPI_PCC)		+= pcc.o pcc-test.o
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
 processor-y			+= processor_idle.o processor_thermal.o
diff --git a/drivers/acpi/pcc-test.c b/drivers/acpi/pcc-test.c
new file mode 100644
index 0000000..cb6ee10
--- /dev/null
+++ b/drivers/acpi/pcc-test.c
@@ -0,0 +1,172 @@
+/*
+ *	Copyright (C) 2014 Linaro Ltd.
+ *	Author:	Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <asm/uaccess.h>
+
+#include <acpi/actbl.h>
+
+static u64 pcc_comm_base_addr;	/* Returned by the Subspace structure */
+static u64 *comm_base_addr; 	/* For use after ioremap */
+
+extern int get_pcc_comm_channel(u32 ss_idx, u64* addr, int *len);
+extern u16 send_pcc_cmd(u8 cmd, u8 sci, u32 ss_idx, u64 * __iomem base_addr);
+
+/* XXX: The PCC Subspace id is hard coded here only for test purposes.
+ * In reality it should be parsed from the PCC package as described
+ * in the PCC client table. e.g. CPC for CPPC 
+ */
+#define PCC_SUBSPACE_IDX 	0
+#define CMD_COMPLETE    	1
+
+enum ppc_cmds {
+	CMD_READ,
+	CMD_WRITE,
+	RESERVED,
+};
+
+static u64 reg1, reg2;
+
+static void run_pcc_test_read(void)
+{
+	u16 pcc_status;
+	u64 reg1_addr = comm_base_addr + 8;
+	u64 reg2_addr = comm_base_addr + 16;
+
+	/* READ part of the test */
+	pr_info("Sending PCC read req from Channel base addr: %llx\n", pcc_comm_base_addr);
+	pcc_status = send_pcc_cmd(CMD_READ, 0, PCC_SUBSPACE_IDX, &pcc_comm_base_addr);
+	if (pcc_status & CMD_COMPLETE) {
+		pr_info("Read updated values from Platform.\n");
+		reg1 = iorea32(&reg1_addr);
+		reg2 = ioread32(&reg2_addr);
+		pr_info("updated value of reg1:%llx\n", reg1);
+		pr_info("updated value of reg2:%llx\n", reg2);
+	} else
+		pr_err("Failed to read PCC parameters\n");
+}
+
+static void run_pcc_test_write(void)
+{
+	u16 pcc_status;
+	u64 reg1_addr = comm_base_addr + 8;
+	u64 reg2_addr = comm_base_addr + 16;
+
+	/* WRITE part of the test */
+	reg1++;
+	reg2++;
+
+	iowrite32(reg1,  &reg1_addr);
+	iowrite32(reg2,  &reg2_addr);
+
+	pr_info("Sending PCC write req from Channel base addr: %p\n", comm_base_addr);
+	pcc_status = send_pcc_cmd(CMD_WRITE, 0, PCC_SUBSPACE_IDX, comm_base_addr);
+	if (pcc_status & CMD_COMPLETE)
+		pr_info("OSPM successfully sent PCC read cmd to platform\n");
+	else
+		pr_err("Failed to write PCC parameters. \n");
+}
+
+void get_pcc_comm(void)
+{
+	int ret, len;
+
+	ret = get_pcc_comm_channel(PCC_SUBSPACE_IDX, &pcc_comm_base_addr, &len);
+
+	if (ret) {
+		pr_err("No PCC Communication channel found\n");
+		goto out_err;
+	}
+
+	comm_base_addr = ioremap_nocache(pcc_comm_base_addr, len);
+
+	if (!comm_base_addr)
+		pr_err("Could not map PCC communicate channel\n");
+
+	pr_info("Acquired PCC comm channel base addr: %llx\n", pcc_comm_base_addr);
+
+out_err:
+	return;
+}
+
+static ssize_t pcc_test_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *offs)
+{
+	char ctl[2];
+
+	if (count != 2 || *offs)
+		return -EINVAL;
+
+	if (copy_from_user(ctl, buf, count))
+		return -EFAULT;
+
+	switch (ctl[0]) {
+		case '0':
+			/* PCC read */
+			run_pcc_test_read();
+			break;
+		case '1':
+			/* PCC write */
+			run_pcc_test_write();
+			break;
+		case '2':
+			/* Get PCC channel */
+			get_pcc_comm();
+			break;
+		default:
+			pr_err("Unknown val\n");
+			break;
+	}
+
+	return count;
+}
+
+static int pcc_test_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int pcc_test_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static const struct file_operations pcc_test_fops = {
+	.open		= pcc_test_open,
+//	.read		= seq_read,
+	.write		= pcc_test_write,
+	.release	= pcc_test_release,
+};
+
+static int __init pcc_test(void)
+{
+	struct proc_dir_entry *pe;
+
+	pe = proc_create("pcc_test", 0644, NULL, &pcc_test_fops);
+
+	if (!pe)
+		return -ENOMEM;
+
+	return 0;
+}
+
+late_initcall(pcc_test);
-- 
1.8.3.2
