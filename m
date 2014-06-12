From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 12 Jun 2014 12:48:12 -0400
Subject: [RFC v2 3/3] PCC test driver
In-Reply-To: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1402591692-7736-4-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A simple test driver to register as a PCC mailbox client and
send PCC reads/writes via the PCC mailbox controller.

echo 2 > /proc/pcc_test to register client.

echo 1 > /proc/pcc_test for PCC writes.

echo 0 > /proc/pcc_test for PCC reads.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/pcc-test.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 1 deletion(-)
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
index 0000000..4ba8c1f
--- /dev/null
+++ b/drivers/acpi/pcc-test.c
@@ -0,0 +1,208 @@
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
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+
+#include <asm/uaccess.h>
+
+#include <acpi/actbl.h>
+
+static void __iomem *comm_base_addr; 	/* For use after ioremap */
+
+extern int mbox_controller_register(struct mbox_controller *mbox);
+extern struct mbox_chan *mbox_request_channel(struct mbox_client *cl);
+extern int mbox_send_message(struct mbox_chan *chan, void *mssg);
+
+
+/* XXX: The PCC Subspace id is hard coded here only for test purposes.
+ * In reality it should be parsed from the PCC package as described
+ * in the PCC client table. e.g. CPC for CPPC 
+ */
+#define PCC_SUBSPACE_IDX 	0
+#define CMD_COMPLETE    	1
+
+struct mbox_chan *pcc_test_chan;
+enum ppc_cmds {
+	CMD_READ,
+	CMD_WRITE,
+	RESERVED,
+};
+
+static u32 reg1, reg2;
+
+static void run_pcc_test_read(void)
+{
+	u32 reg1_addr = (u32)comm_base_addr + 0x100;
+	u32 reg2_addr = (u32)comm_base_addr + 0x110;
+	char mssg[2];
+	int ret;
+
+	/* READ part of the test */
+	pr_info("Sending PCC read req from Channel base addr: %x\n", (u32)comm_base_addr);
+
+	snprintf(mssg, sizeof(short), "%d", CMD_READ);
+	ret = mbox_send_message(pcc_test_chan, &mssg);
+	if (ret >= 0) {
+		pr_info("Read updated values from Platform.\n");
+		reg1 = ioread32((void*)reg1_addr);
+		reg2 = ioread32((void*)reg2_addr);
+		pr_info("updated value of reg1:%x\n", reg1);
+		pr_info("updated value of reg2:%x\n", reg2);
+	} else
+		pr_err("Failed to read PCC parameters: ret=%d\n", ret);
+}
+
+static void run_pcc_test_write(void)
+{
+	u32 reg1_addr = (u32)comm_base_addr + 0x100;
+	u32 reg2_addr = (u32)comm_base_addr + 0x110;
+	char mssg[2];
+	int ret;
+
+	/* WRITE part of the test */
+	reg1++;
+	reg2++;
+
+	iowrite32(reg1, (void *)reg1_addr);
+	iowrite32(reg2, (void *)reg2_addr);
+
+	pr_info("Sending PCC write req from Channel base addr: %x\n", (u32)comm_base_addr);
+	snprintf(mssg, sizeof(short), "%d", CMD_WRITE);
+
+	ret = mbox_send_message(pcc_test_chan, &mssg);
+
+	if (ret >= 0)
+		pr_info("OSPM successfully sent PCC write cmd to platform\n");
+	else
+		pr_err("Failed to write PCC parameters. ret= %d\n", ret);
+}
+
+static void pcc_chan_tx_done(struct mbox_client *cl, void *mssg, enum mbox_result r)
+{
+	if (r == MBOX_OK)
+		pr_info("PCC channel TX successfully completed. CMD sent = %s\n", (char*)mssg);
+	else
+		pr_warn("PCC channel TX did not complete: CMD sent = %s\n", (char*)mssg);
+}
+
+struct mbox_client pcc_mbox_cl = {
+	.chan_name	=	"0",
+	.ctrl_name	=	"PCCT",
+	.tx_done	=	pcc_chan_tx_done,
+};
+
+void get_pcc_comm(void)
+{
+	u32 base_addr;
+	u32 len;
+	struct acpi_pcct_subspace *pcc_ss;
+
+	pcc_test_chan = mbox_request_channel(&pcc_mbox_cl);
+
+	if (!pcc_test_chan) {
+		pr_err("PCC Channel not found!\n");
+		return;
+	}
+
+	pcc_ss = pcc_test_chan->con_priv;
+
+	base_addr = pcc_ss->base_address;
+	len = pcc_ss->length;
+
+	pr_info("ioremapping: %x, len: %x\n", base_addr, len);
+
+	comm_base_addr = ioremap_nocache(base_addr, len);
+
+	if (!comm_base_addr) {
+		pr_err("Could not ioremap channel\n");
+		return;
+	}
+
+	pcc_ss->base_address = (u32)comm_base_addr;
+
+	pr_info("Comm_base_addr: %x\n", (u32)comm_base_addr);
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
