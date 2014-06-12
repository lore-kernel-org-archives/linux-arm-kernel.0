From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 12 Jun 2014 12:48:11 -0400
Subject: [RFC v2 2/3] ACPI: Add support for Platform Communication Channel
In-Reply-To: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1402591692-7736-3-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI 5.0a+ spec defines a generic mode of communication
between the OS and a platform such as the BMC. This medium
(PCC) is typically used by CPPC (ACPI CPU Performance management),
RAS (ACPI reliability protocol) and MPST (ACPI Memory power
states).

This patch adds initial support for PCC as a mailbox controller.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/pcc.c      | 225 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mailbox/Kconfig |  11 +++
 3 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/pcc.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index fc133d4..d8aa613 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -74,7 +74,7 @@ obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
-
+obj-$(CONFIG_ACPI_PCC)		+= pcc.o
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
 processor-y			+= processor_idle.o processor_thermal.o
diff --git a/drivers/acpi/pcc.c b/drivers/acpi/pcc.c
new file mode 100644
index 0000000..b93a8e7
--- /dev/null
+++ b/drivers/acpi/pcc.c
@@ -0,0 +1,225 @@
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
+#include <linux/delay.h>
+#include <linux/ioctl.h>
+#include <linux/vmalloc.h>
+#include <linux/mailbox_controller.h>
+
+#include <acpi/actbl.h>
+
+#define MAX_PCC_SUBSPACES	256
+#define PCCS_SS_SIG_MAGIC	0x50434300
+#define PCC_CMD_COMPLETE	0x1
+#define PCC_VERSION			"0.1"
+
+struct mbox_chan pcc_mbox_chan[MAX_PCC_SUBSPACES];
+
+static bool pcc_tx_done(struct mbox_chan *chan)
+{
+	struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
+	struct acpi_pcct_shared_memory *generic_comm_base =
+		(struct acpi_pcct_shared_memory *) pcct_ss->base_address;
+	u16 cmd_delay = pcct_ss->min_turnaround_time;
+
+	/* Wait for Platform to consume. */
+	while (!(ioread16(&generic_comm_base->status) & PCC_CMD_COMPLETE))
+		udelay(cmd_delay);
+
+	return true;
+}
+
+/* Channel lock is already held by mbox controller code. */
+static int pcc_send_data(struct mbox_chan *chan, void *data)
+{
+	struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
+	struct acpi_pcct_shared_memory *generic_comm_base =
+		(struct acpi_pcct_shared_memory *) pcct_ss->base_address;
+	struct acpi_generic_address doorbell;
+	u64 doorbell_preserve;
+	u64 doorbell_val;
+	u64 doorbell_write;
+	u16 cmd = 0;
+	u16 ss_idx = 0;
+	int ret = 0;
+
+	/*
+	 * Min time in usec that OSPM is expected to wait
+	 * before sending the next PCC cmd.
+	 */
+	u16 cmd_delay = pcct_ss->min_turnaround_time;
+
+	/* Get PCC CMD */
+	ret = kstrtou16((char*)data, 0, &cmd);
+	if (ret < 0) {
+		pr_err("Err while converting PCC CMD to u16: %d\n", ret);
+		goto out_err;
+	}
+
+	/* Get PCC Subspace ID */
+	ret = kstrtou16(chan->name, 0, &ss_idx);
+	if (ret < 0) {
+		pr_err("Err while converting PCC ss_idx to u16: %d\n", ret);
+		goto out_err;
+	}
+
+	doorbell = pcct_ss->doorbell_register;
+	doorbell_preserve = pcct_ss->preserve_mask;
+	doorbell_write = pcct_ss->write_mask;
+
+	/* Loop until CMD complete bit is set. For prev cmds. */
+	while (!(ioread16(&generic_comm_base->status) & PCC_CMD_COMPLETE))
+		udelay(cmd_delay);
+
+	/* Write to the shared comm region. */
+	iowrite16(cmd, &generic_comm_base->command);
+
+	/* Write Subspace MAGIC value so platform can identify destination. */
+	iowrite32((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
+
+	/* Flip CMD COMPLETE bit */
+	iowrite16(0, &generic_comm_base->status);
+
+	/* Sync notification from OSPM to Platform. */
+	acpi_read(&doorbell_val, &doorbell);
+	acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
+			&doorbell);
+
+out_err:
+	return ret;
+}
+
+static int pcc_chan_startup(struct mbox_chan *chan)
+{
+	return 0;
+}
+
+static void pcc_chan_shutdown(struct mbox_chan *chan)
+{
+	return;
+}
+
+static struct mbox_controller pcc_mbox_ctrl = {};
+
+static struct mbox_chan_ops pcc_chan_ops = {
+	.send_data	=	pcc_send_data,
+	.startup	=	pcc_chan_startup,
+	.shutdown	=	pcc_chan_shutdown,
+	.last_tx_done	=	pcc_tx_done,
+};
+
+static int parse_pcc_subspace(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_pcct_subspace *pcct_ss;
+	char *chan_name;
+
+	if (pcc_mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
+		pcct_ss = (struct acpi_pcct_subspace *) header;
+
+		if (pcct_ss->header.type != ACPI_PCCT_TYPE_GENERIC_SUBSPACE) {
+			pr_err("Incorrect PCC Subspace type detected\n");
+			return -EINVAL;
+		}
+
+		/* New mbox channel entry for each PCC subspace detected. */
+		pcc_mbox_chan[pcc_mbox_ctrl.num_chans].con_priv = pcct_ss;
+
+		/* Use the PCC subspace ID as the channel name. */
+		chan_name = (char *)kmalloc(sizeof(short), GFP_KERNEL);
+		if (!chan_name) {
+			pr_err("No mem for channel name\n");
+			return -ENOSPC;
+		}
+
+		pcc_mbox_chan[pcc_mbox_ctrl.num_chans].name = chan_name;
+		snprintf(pcc_mbox_chan[pcc_mbox_ctrl.num_chans].name,
+				sizeof(short), "%d", pcc_mbox_ctrl.num_chans);
+
+		pcc_mbox_ctrl.num_chans++;
+
+	} else {
+		pr_err("No more space for PCC subspaces.\n");
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static int __init pcc_probe(void)
+{
+	acpi_status status = AE_OK;
+	acpi_size pcct_tbl_header_size;
+	struct acpi_table_pcct *pcct_tbl;
+
+	/* Search for PCCT */
+	status = acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
+			(struct acpi_table_header **)&pcct_tbl,
+			&pcct_tbl_header_size);
+
+	if (ACPI_SUCCESS(status) && !pcct_tbl) {
+		pr_warn("PCCT header not found.\n");
+		status = AE_NOT_FOUND;
+		goto out_err;
+	}
+
+	status = acpi_table_parse_entries(ACPI_SIG_PCCT,
+			sizeof(struct acpi_table_pcct),
+			ACPI_PCCT_TYPE_GENERIC_SUBSPACE,
+			parse_pcc_subspace, MAX_PCC_SUBSPACES);
+
+	if (ACPI_SUCCESS(status))
+		pr_err("Error parsing PCC subspaces from PCCT\n");
+
+	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
+
+	pcc_mbox_ctrl.chans = pcc_mbox_chan;
+	pcc_mbox_ctrl.ops = &pcc_chan_ops;
+	pcc_mbox_ctrl.name = "PCCT";
+	pcc_mbox_ctrl.txdone_poll = true;
+	pcc_mbox_ctrl.txpoll_period = 1;
+
+	pr_info("Registering PCC driver as mbox controller\n");
+	mbox_controller_register(&pcc_mbox_ctrl);
+
+out_err:
+	return ACPI_SUCCESS(status) ? 1 : 0;
+}
+
+static int __init pcc_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* Check if PCC support is available. */
+	ret = pcc_probe();
+
+	if (ret) {
+		pr_debug("PCC probe failed.\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+device_initcall(pcc_init);
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c8b5c13..7aea896 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -50,4 +50,15 @@ config OMAP_MBOX_KFIFO_SIZE
 	  Specify the default size of mailbox's kfifo buffers (bytes).
 	  This can also be changed at runtime (via the mbox_kfifo_size
 	  module parameter).
+
+config ACPI_PCC
+	bool "ACPI Platform Communication Channel"
+	def_bool n
+	depends on ACPI
+	help
+	Enable this option if your platform supports PCC as defined in the
+	ACPI spec 5.0a+. PCC is a generic mechanism for the OS to communicate
+	with a platform such as a BMC. PCC is typically used by CPPC, RAS
+	and MPST.
+
 endif
-- 
1.8.3.2
