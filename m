From: somasundaram.a@hpe.com (Arunachalam, Somasundaram)
Date: Thu, 2 Mar 2017 07:44:57 +0000
Subject: FW: [PATCH] ACPI:RASF- Adding support for RASF PCC interfaces.
References: <1477094344-14816-1-git-send-email-somasundaram.a@hpe.com>  
Message-ID: <AT5PR84MB0036BBCCB2655AE11D521E3884280@AT5PR84MB0036.NAMPRD84.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

Can you pls help review. The below email bounced as html mails not accepted. So sending as plain text.

Thanks,
Som.

_____________________________________________
From: Arunachalam, Somasundaram 
Sent: Thursday, March 02, 2017 12:26 PM
To: 'linux-acpi at vger.kernel.org' <linux-acpi@vger.kernel.org>; 'linux-arm-kernel at lists.infradead.org' <linux-arm-kernel@lists.infradead.org>
Subject: FW: [PATCH] ACPI:RASF- Adding support for RASF PCC interfaces.


Hi, 

I submitted this patch for review quite a while ago. I haven't received any reply so far, can you kindly reply with some inputs.

With Best Regards,
Som.
(A.Somasundaram)

-----Original Message-----
From: A, Somasundaram 
Sent: Saturday, October 22, 2016 5:29 AM
To: linux-acpi at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Cc: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>; A, Somasundaram <somasundaram.a@hpe.com>
Subject: [PATCH] ACPI:RASF- Adding support for RASF PCC interfaces.

From: A Somasundaram <somasundaram.a@hpe.com>

These files contains pcc interfaces for rasf table, and basic rasf init, as per ACPI 5.1 & upwards revision. section 5.2.20, chapter 14 Platform communication channel are references for this implementation.
This module uses  pcc interfaces to talk to ACPI HW. This version has PCC interfaces ready.
The functions to send RASF commands to be used by OSPM is planned for future revision of the file(rasf_acpi.c).

Signed-off-by:somasundaram.a at hpe.com
---
 drivers/acpi/Kconfig            |  15 ++
 drivers/acpi/Makefile           |   1 +
 drivers/acpi/processor_driver.c |   6 +-
 drivers/acpi/rasf_acpi.c        | 330 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/rasf_acpi.h        |  58 +++++++
 5 files changed, 409 insertions(+), 1 deletion(-)  create mode 100644 drivers/acpi/rasf_acpi.c  create mode 100644 include/acpi/rasf_acpi.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index 445ce28..3a1b24fd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -238,6 +238,21 @@ config ACPI_CPPC_LIB
 	  If your platform does not support CPPC in firmware,
 	  leave this option disabled.
 
+config ACPI_RASF_LIB
+	bool
+	depends on ACPI_PROCESSOR
+	select MAILBOX
+	select PCC
+	default y
+	help
+          The files corresponding to this option implements pcc interfaces
+          (platform communication channel) to talk to RASF(RAS Feature table)
+          in the ACPI Complaint hardware platform. The first revision(current one)
+          contains basic init of RASF(extraction of RASF Table, from OS system table) 
+          and, pcc interfaces.
+          Subsequent revision will contain OSPM interfaces to send RASF
+          Memory patrol scrub commands to the ACPI hardware.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || IA64 || ARM64
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile index 5ae9d85..0bbf0d8 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
+obj-$(CONFIG_ACPI_RASF_LIB)	+= rasf_acpi.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 
 # processor has its own "processor." module_param namespace diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c index 0553aee..c7aea1a 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -32,7 +32,7 @@
 #include <linux/cpuidle.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
-
+#include<acpi/rasf_acpi.h>
 #include <acpi/processor.h>
 
 #include "internal.h"
@@ -66,6 +66,8 @@ static struct device_driver acpi_processor_driver = {
 	.remove = acpi_processor_stop,
 };
 
+extern RASF_STATUS rasf_acpi_init(void );
+
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)  {
 	struct acpi_device *device = data;
@@ -257,6 +259,8 @@ static int __acpi_processor_start(struct acpi_device *device)
 
 	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
 					     acpi_processor_notify, device);
+         rasf_acpi_init();
+        pr_info("rasf init called \n");
 	if (ACPI_SUCCESS(status))
 		return 0;
 
diff --git a/drivers/acpi/rasf_acpi.c b/drivers/acpi/rasf_acpi.c new file mode 100644 index 0000000..1d378cf
--- /dev/null
+++ b/drivers/acpi/rasf_acpi.c
@@ -0,0 +1,330 @@
+/*
+ * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises.
+ * A.Somasundaram, email: somasundaram.a at hpe.com
+ * This file contains
+ * RASF - ACPI 6.1 Specification, section 5.2.20
+ * PCC(Platform Communications Channel) - ACPI 6.1 Specification , 
+chapter 14
+ * This file contains PCC(Platform communication channel) interfaces, 
+and basic RASF Init, which extracts the RASF table and
+ *  Registers the PCC channel for communicating with the ACPI compliant 
+platform that contains RASF command support in hardware
+ *
+ *Next revision of this file will contain functions for sending RASF 
+commands for memory patrol scrubbing. This version contains
+ * core framework of PCC communication and RASF Init.
+ *
+ */
+
+#define pr_fmt(fmt)	"ACPI RASF: " fmt
+#include<linux/export.h>
+#include<acpi/rasf_acpi.h>
+#include <linux/delay.h>
+#include <linux/ktime.h>
+#include<acpi/acpixf.h>
+
+#ifdef NEXT_REV
+/*
+ * Lock to provide mutually exclusive access to pcc channel, this is for next version.
+ * when functions for RASF command send/recv are implemented.
+ */
+static DEFINE_SPINLOCK(rasf_lock);
+#endif
+
+
+/* Data structure for pcc communication  and rasf table */
+
+static struct mbox_chan *pcc_channel;
+static void __iomem *pcc_comm_addr;
+static u64 comm_base_addr;
+static int pcc_subspace_idx = -1;
+static bool pcc_channel_acquired;
+static ktime_t deadline;
+static unsigned int pcc_mpar, pcc_mrtt; static struct acpi_table_rasf 
+*pRasfTable = NULL; RASF_STATUS rasf_acpi_init(void );
+
+#ifdef NEXT_REV
+/* pcc mapped address + header size + offset within PCC subspace
+ * This will be useful in next revision, when functions for RASF Command send/recv are implemented. 
+ */
+#define RASF_VADDR(offs) (pcc_comm_addr + 0x8 + (offs)) #endif
+
+/*
+ * Arbitrary Retries for pcc commands.
+ */
+#define NUM_RETRIES 600
+
+/*
+ *This function checks the pcc channel availability
+ *
+ *
+ */
+static int rasf_check_pcc_chan(void)
+{
+	int ret = -EIO;
+	
+        struct acpi_rasf_shared_memory  __iomem *generic_comm_base = pcc_comm_addr;
+	ktime_t next_deadline = ktime_add(ktime_get(), deadline);
+
+	while (!ktime_after(ktime_get(), next_deadline)) {
+		/*
+		 * As per ACPI spec, the PCC space wil be initialized by
+		 * platform and should have set the command completion bit when
+		 * PCC can be used by OSPM
+		 */
+		if (readw_relaxed(&generic_comm_base->status) & RASF_PCC_CMD_COMPLETE) {
+			ret = 0;
+			break;
+		}
+		/*
+		 * Reducing the bus traffic in case this loop takes longer than
+		 * a few retries.
+		 */
+		udelay(3);
+	}
+
+	return ret;
+}
+
+static int rasf_send_pcc_cmd(u16 cmd)
+{
+	int ret = -EIO;
+
+        struct acpi_rasf_shared_memory  *generic_comm_base =
+		(struct acpi_rasf_shared_memory *) pcc_comm_addr;
+	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
+	static int mpar_count;
+	unsigned int time_delta;
+
+	/*
+	 * For CMD_WRITE we know for a fact the caller should have checked
+	 * the channel before writing to PCC space
+	 */
+	if (cmd == RASF_CMD_READ) {
+		ret = rasf_check_pcc_chan();
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Handle the Minimum Request Turnaround Time(MRTT)
+	 * "The minimum amount of time that OSPM must wait after the completion
+	 * of a command before issuing the next command, in microseconds"
+	 */
+	if (pcc_mrtt) {
+		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
+		if (pcc_mrtt > time_delta)
+			udelay(pcc_mrtt - time_delta);
+	}
+
+	/*
+	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
+	 * "The maximum number of periodic requests that the subspace channel can
+	 * support, reported in commands per minute. 0 indicates no limitation."
+	 *
+	 * This parameter should be ideally zero or large enough so that it can
+	 * handle maximum number of requests that all the cores in the system can
+	 * collectively generate. If it is not, we will follow the spec and just
+	 * not send the request to the platform after hitting the MPAR limit in
+	 * any 60s window
+	 */
+	if (pcc_mpar) {
+		if (mpar_count == 0) {
+			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
+			if (time_delta < 60 * MSEC_PER_SEC) {
+				pr_debug("PCC cmd not sent due to MPAR limit");
+				return -EIO;
+			}
+			last_mpar_reset = ktime_get();
+			mpar_count = pcc_mpar;
+		}
+		mpar_count--;
+	}
+
+	/* Write to the shared comm region. */
+	writew_relaxed(cmd, &generic_comm_base->command);
+
+	/* Flip CMD COMPLETE bit */
+	writew_relaxed(0, &generic_comm_base->status);
+
+	/* Ring doorbell */
+	ret = mbox_send_message(pcc_channel, &cmd);
+	if (ret < 0) {
+		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
+				cmd, ret);
+		return ret;
+	}
+
+	/*
+	 * For READs we need to ensure the cmd completed to ensure
+	 * the ensuing read()s can proceed. For WRITEs we dont care
+	 * because the actual write()s are done before coming here
+	 * and the next READ or WRITE will check if the channel
+	 * is busy/free@the entry of this call.
+	 *
+	 * If Minimum Request Turnaround Time is non-zero, we need
+	 * to record the completion time of both READ and WRITE
+	 * command for proper handling of MRTT, so we need to check
+	 * for pcc_mrtt in addition to CMD_READ
+	 */
+	if (cmd == RASF_CMD_READ || pcc_mrtt) {
+		ret = rasf_check_pcc_chan();
+		if (pcc_mrtt)
+			last_cmd_cmpl_time = ktime_get();
+	}
+
+	mbox_client_txdone(pcc_channel, ret);
+	return ret;
+}
+
+static void rasf_chan_tx_done(struct mbox_client *cl, void *msg, int 
+ret) {
+	if (ret < 0)
+		pr_debug("TX did not complete: CMD sent:%x, ret:%d\n",
+				*(u16 *)msg, ret);
+	else
+		pr_debug("TX completed. CMD sent:%x, ret:%d\n",
+				*(u16 *)msg, ret);
+}
+
+struct mbox_client rasf_mbox_cl = {
+	.tx_done = rasf_chan_tx_done,
+	.knows_txdone = true,
+};
+
+
+
+static int rasf_register_pcc_channel(int pcc_subspace_idx) {
+	struct acpi_pcct_hw_reduced *rasf_ss;
+	unsigned int len;
+	u64 usecs_lat;
+
+	if (pcc_subspace_idx >= 0) {
+		pcc_channel = pcc_mbox_request_channel(&rasf_mbox_cl,
+				pcc_subspace_idx);
+
+		if (IS_ERR(pcc_channel)) {
+			pr_err("Failed to find PCC communication channel\n");
+			return -ENODEV;
+		}
+
+		/*
+		 * The PCC mailbox controller driver should
+		 * have parsed the PCCT (global table of all
+		 * PCC channels) and stored pointers to the
+		 * subspace communication region in con_priv.
+		 */
+		rasf_ss = pcc_channel->con_priv;
+
+		if (!rasf_ss) {
+			pr_err("No PCC subspace found for CPPC\n");
+			return -ENODEV;
+		}
+
+		/*
+		 * This is the shared communication region
+		 * for the OS and Platform to communicate over.
+		 */
+		comm_base_addr = rasf_ss->base_address;
+		len = rasf_ss->length;
+
+		/*
+		 * rasf_ss->latency is just a Nominal value. In reality
+		 * the remote processor could be much slower to reply.
+		 * So add an arbitrary amount of wait on top of Nominal.
+		 */
+		usecs_lat = NUM_RETRIES * rasf_ss->latency;
+		deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
+		pcc_mrtt = rasf_ss->min_turnaround_time;
+		pcc_mpar = rasf_ss->max_access_rate;
+
+		pcc_comm_addr = acpi_os_ioremap(comm_base_addr, len);
+		if (!pcc_comm_addr) {
+			pr_err("Failed to ioremap PCC comm region mem\n");
+			return -ENOMEM;
+		}
+
+		/* Set flag so that we dont come here for each CPU. */
+		pcc_channel_acquired = true;
+	}
+
+	return 0;
+}
+
+#ifdef NEXT_REV
+
+/* The next revision of this file will contain the implementation of 
+the following functions
+ *
+ *These functions are used for processing/sending RASF Commands.
+ *
+ */
+/*
+ * The below functions are exposed to OSPM, to query and, initiate memory range patrol.
+ *
+ *
+ */
+bool DoPatrolScrub(....)
+{
+}
+
+bool IsPatrolScrubExposedtoSw(...)
+{
+/* send command, for read */
+
+}
+
+bool GetPatrolParams(...)
+{
+}
+
+bool SetPatrolParams(...)
+{
+/*    start patrol
+    stop patrol
+*/
+}
+#endif
+
+RASF_STATUS rasf_acpi_init(void )
+{
+   struct acpi_table_header *pAcpiTable = NULL;
+   acpi_size irasf_size = 0;
+   acpi_status status = AE_OK;
+   
+   
+   status = acpi_get_table_with_size("RASF", 0, &pAcpiTable, 
+ &irasf_size);
+
+   if (ACPI_FAILURE(status)) 
+   {
+       
+	pr_err("rasf driver failed to initialize, get table failed\n");
+
+         pr_info("RASF Init failed \n");
+       return(RASF_FAILURE);
+   }
+   
+   pRasfTable = kmalloc(sizeof(struct acpi_table_header), GFP_KERNEL);
+
+
+    if(NULL == pRasfTable)
+    {
+         pr_err("ptr to RasfTable, kmalloc failed \n");
+
+         pr_info("RASF Init failed \n");
+         /* error debug print */
+          return(RASF_FAILURE);
+    }
+    memcpy(pRasfTable, pAcpiTable, irasf_size);
+
+/* extract the pcc subspace channel id from the table */
+     pRasfTable = (struct acpi_table_rasf *)pAcpiTable;
+     memcpy(&pcc_subspace_idx, &pRasfTable->channel_id,12);
+     rasf_register_pcc_channel(pcc_subspace_idx);
+     pr_info("RASF Init Success \n");
+     return(RASF_SUCCESS);
+
+
+}
+EXPORT_SYMBOL_GPL(rasf_acpi_init);
+
+
+
diff --git a/include/acpi/rasf_acpi.h b/include/acpi/rasf_acpi.h new file mode 100644 index 0000000..2f28ad3
--- /dev/null
+++ b/include/acpi/rasf_acpi.h
@@ -0,0 +1,58 @@
+/*
+ * RASF(feature for patrol scrubbing of memory ranges , if exposed to 
+software)
+ * RASF Diagnostic driver header file
+ *
+ * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
+ * Author: A.Somasundaram (somasundaram.a at hpe.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#ifndef _RASF_ACPI_H
+#define _RASF_ACPI_H
+
+#include <linux/acpi.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+#include <linux/types.h>
+
+typedef int RASF_STATUS;
+
+#define RASF_NUM_ENT	21
+#define RASF_REV	2
+
+#define RASF_PCC_CMD_COMPLETE 1
+
+/* CPPC specific PCC commands. */
+#define	RASF_CMD_READ 0
+#define	RASF_CMD_WRITE 1
+
+#define RASF_FAILURE 0
+#define RASF_SUCCESS 1
+
+/* Each register has the folowing format. */ struct rasf_reg {
+	u8 descriptor;
+	u16 length;
+	u8 space_id;
+	u8 bit_width;
+	u8 bit_offset;
+	u8 access_width;
+	u64 __iomem address;
+} __packed;
+
+struct rasf_register_resource {
+	acpi_object_type type;
+	union {
+		struct rasf_reg reg;
+		u64 int_value;
+	} rasf_entry;
+};
+/* Methods to interact with the PCC mailbox controller. */ extern 
+struct mbox_chan *
+	pcc_mbox_request_channel(struct mbox_client *, unsigned int);
+
+#endif /* _CPPC_ACPI_H*/
--
1.9.1
