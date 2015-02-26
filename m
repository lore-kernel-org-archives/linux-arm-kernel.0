From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 26 Feb 2015 15:59:36 -0600
Subject: [PATCH 4/4] firmware: qcom: scm: Move the scm driver to
 drivers/firmware
In-Reply-To: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
References: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
Message-ID: <1424987976-14531-4-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architectural changes in the ARM Linux kernel tree mandate the eventual
removal of the mach-* directories. Move the scm driver to
drivers/firmware and the scm header to include/linux to support that
removal.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 MAINTAINERS                  |   1 +
 arch/arm/mach-qcom/Kconfig   |   3 -
 arch/arm/mach-qcom/Makefile  |   3 -
 arch/arm/mach-qcom/platsmp.c |   2 +-
 arch/arm/mach-qcom/scm.c     | 344 -------------------------------------------
 arch/arm/mach-qcom/scm.h     |  29 ----
 drivers/firmware/Kconfig     |   4 +
 drivers/firmware/Makefile    |   2 +
 drivers/firmware/qcom_scm.c  | 344 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/qcom_scm.h     |  29 ++++
 10 files changed, 381 insertions(+), 380 deletions(-)
 delete mode 100644 arch/arm/mach-qcom/scm.c
 delete mode 100644 arch/arm/mach-qcom/scm.h
 create mode 100644 drivers/firmware/qcom_scm.c
 create mode 100644 include/linux/qcom_scm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5a8c..beb8aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1317,6 +1317,7 @@ L:	linux-soc at vger.kernel.org
 S:	Maintained
 F:	arch/arm/mach-qcom/
 F:	drivers/soc/qcom/
+F:	drivers/firmware/qcom_scm.c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 48003ea..2256cd1 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -22,7 +22,4 @@ config ARCH_MSM8974
 	bool "Enable support for MSM8974"
 	select HAVE_ARM_ARCH_TIMER
 
-config QCOM_SCM
-	bool
-
 endif
diff --git a/arch/arm/mach-qcom/Makefile b/arch/arm/mach-qcom/Makefile
index 10b6841..e324375 100644
--- a/arch/arm/mach-qcom/Makefile
+++ b/arch/arm/mach-qcom/Makefile
@@ -1,5 +1,2 @@
 obj-y			:= board.o
 obj-$(CONFIG_SMP)	+= platsmp.o
-obj-$(CONFIG_QCOM_SCM)	+= scm.o
-
-CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 596e623..4b67e56 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -17,10 +17,10 @@
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/qcom_scm.h>
 
 #include <asm/smp_plat.h>
 
-#include "scm.h"
 
 #define VDD_SC1_ARRAY_CLAMP_GFS_CTL	0x35a0
 #define SCSS_CPU1CORE_RESET		0x2d80
diff --git a/arch/arm/mach-qcom/scm.c b/arch/arm/mach-qcom/scm.c
deleted file mode 100644
index 3e0e334..0000000
--- a/arch/arm/mach-qcom/scm.c
+++ /dev/null
@@ -1,344 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-
-#include <asm/outercache.h>
-#include <asm/cacheflush.h>
-
-#include "scm.h"
-
-#define QCOM_SCM_ENOMEM		-5
-#define QCOM_SCM_EOPNOTSUPP	-4
-#define QCOM_SCM_EINVAL_ADDR	-3
-#define QCOM_SCM_EINVAL_ARG	-2
-#define QCOM_SCM_ERROR		-1
-#define QCOM_SCM_INTERRUPTED	1
-
-static DEFINE_MUTEX(qcom_scm_lock);
-
-/**
- * struct qcom_scm_command - one SCM command buffer
- * @len: total available memory for command and response
- * @buf_offset: start of command buffer
- * @resp_hdr_offset: start of response buffer
- * @id: command to be executed
- * @buf: buffer returned from qcom_scm_get_command_buffer()
- *
- * An SCM command is laid out in memory as follows:
- *
- *	------------------- <--- struct qcom_scm_command
- *	| command header  |
- *	------------------- <--- qcom_scm_get_command_buffer()
- *	| command buffer  |
- *	------------------- <--- struct qcom_scm_response and
- *	| response header |      qcom_scm_command_to_response()
- *	------------------- <--- qcom_scm_get_response_buffer()
- *	| response buffer |
- *	-------------------
- *
- * There can be arbitrary padding between the headers and buffers so
- * you should always use the appropriate qcom_scm_get_*_buffer() routines
- * to access the buffers in a safe manner.
- */
-struct qcom_scm_command {
-	__le32 len;
-	__le32 buf_offset;
-	__le32 resp_hdr_offset;
-	__le32 id;
-	__le32 buf[0];
-};
-
-/**
- * struct qcom_scm_response - one SCM response buffer
- * @len: total available memory for response
- * @buf_offset: start of response data relative to start of qcom_scm_response
- * @is_complete: indicates if the command has finished processing
- */
-struct qcom_scm_response {
-	__le32 len;
-	__le32 buf_offset;
-	__le32 is_complete;
-};
-
-/**
- * alloc_qcom_scm_command() - Allocate an SCM command
- * @cmd_size: size of the command buffer
- * @resp_size: size of the response buffer
- *
- * Allocate an SCM command, including enough room for the command
- * and response headers as well as the command and response buffers.
- *
- * Returns a valid &qcom_scm_command on success or %NULL if the allocation fails.
- */
-static struct qcom_scm_command *alloc_qcom_scm_command(size_t cmd_size, size_t resp_size)
-{
-	struct qcom_scm_command *cmd;
-	size_t len = sizeof(*cmd) + sizeof(struct qcom_scm_response) + cmd_size +
-		resp_size;
-	u32 offset;
-
-	cmd = kzalloc(PAGE_ALIGN(len), GFP_KERNEL);
-	if (cmd) {
-		cmd->len = cpu_to_le32(len);
-		offset = offsetof(struct qcom_scm_command, buf);
-		cmd->buf_offset = cpu_to_le32(offset);
-		cmd->resp_hdr_offset = cpu_to_le32(offset + cmd_size);
-	}
-	return cmd;
-}
-
-/**
- * free_qcom_scm_command() - Free an SCM command
- * @cmd: command to free
- *
- * Free an SCM command.
- */
-static inline void free_qcom_scm_command(struct qcom_scm_command *cmd)
-{
-	kfree(cmd);
-}
-
-/**
- * qcom_scm_command_to_response() - Get a pointer to a qcom_scm_response
- * @cmd: command
- *
- * Returns a pointer to a response for a command.
- */
-static inline struct qcom_scm_response *qcom_scm_command_to_response(
-		const struct qcom_scm_command *cmd)
-{
-	return (void *)cmd + le32_to_cpu(cmd->resp_hdr_offset);
-}
-
-/**
- * qcom_scm_get_command_buffer() - Get a pointer to a command buffer
- * @cmd: command
- *
- * Returns a pointer to the command buffer of a command.
- */
-static inline void *qcom_scm_get_command_buffer(const struct qcom_scm_command *cmd)
-{
-	return (void *)cmd->buf;
-}
-
-/**
- * qcom_scm_get_response_buffer() - Get a pointer to a response buffer
- * @rsp: response
- *
- * Returns a pointer to a response buffer of a response.
- */
-static inline void *qcom_scm_get_response_buffer(const struct qcom_scm_response *rsp)
-{
-	return (void *)rsp + le32_to_cpu(rsp->buf_offset);
-}
-
-static int qcom_scm_remap_error(int err)
-{
-	pr_err("qcom_scm_call failed with error code %d\n", err);
-	switch (err) {
-	case QCOM_SCM_ERROR:
-		return -EIO;
-	case QCOM_SCM_EINVAL_ADDR:
-	case QCOM_SCM_EINVAL_ARG:
-		return -EINVAL;
-	case QCOM_SCM_EOPNOTSUPP:
-		return -EOPNOTSUPP;
-	case QCOM_SCM_ENOMEM:
-		return -ENOMEM;
-	}
-	return -EINVAL;
-}
-
-static u32 smc(u32 cmd_addr)
-{
-	int context_id;
-	register u32 r0 asm("r0") = 1;
-	register u32 r1 asm("r1") = (u32)&context_id;
-	register u32 r2 asm("r2") = cmd_addr;
-	do {
-		asm volatile(
-			__asmeq("%0", "r0")
-			__asmeq("%1", "r0")
-			__asmeq("%2", "r1")
-			__asmeq("%3", "r2")
-#ifdef REQUIRES_SEC
-			".arch_extension sec\n"
-#endif
-			"smc	#0	@ switch to secure world\n"
-			: "=r" (r0)
-			: "r" (r0), "r" (r1), "r" (r2)
-			: "r3");
-	} while (r0 == QCOM_SCM_INTERRUPTED);
-
-	return r0;
-}
-
-static int __qcom_scm_call(const struct qcom_scm_command *cmd)
-{
-	int ret;
-	u32 cmd_addr = virt_to_phys(cmd);
-
-	/*
-	 * Flush the command buffer so that the secure world sees
-	 * the correct data.
-	 */
-	__cpuc_flush_dcache_area((void *)cmd, cmd->len);
-	outer_flush_range(cmd_addr, cmd_addr + cmd->len);
-
-	ret = smc(cmd_addr);
-	if (ret < 0)
-		ret = qcom_scm_remap_error(ret);
-
-	return ret;
-}
-
-static void qcom_scm_inv_range(unsigned long start, unsigned long end)
-{
-	u32 cacheline_size, ctr;
-
-	asm volatile("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
-	cacheline_size = 4 << ((ctr >> 16) & 0xf);
-
-	start = round_down(start, cacheline_size);
-	end = round_up(end, cacheline_size);
-	outer_inv_range(start, end);
-	while (start < end) {
-		asm ("mcr p15, 0, %0, c7, c6, 1" : : "r" (start)
-		     : "memory");
-		start += cacheline_size;
-	}
-	dsb();
-	isb();
-}
-
-/**
- * qcom_scm_call() - Send an SCM command
- * @svc_id: service identifier
- * @cmd_id: command identifier
- * @cmd_buf: command buffer
- * @cmd_len: length of the command buffer
- * @resp_buf: response buffer
- * @resp_len: length of the response buffer
- *
- * Sends a command to the SCM and waits for the command to finish processing.
- *
- * A note on cache maintenance:
- * Note that any buffers that are expected to be accessed by the secure world
- * must be flushed before invoking qcom_scm_call and invalidated in the cache
- * immediately after qcom_scm_call returns. Cache maintenance on the command
- * and response buffers is taken care of by qcom_scm_call; however, callers are
- * responsible for any other cached buffers passed over to the secure world.
- */
-static int qcom_scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf,
-			size_t cmd_len, void *resp_buf, size_t resp_len)
-{
-	int ret;
-	struct qcom_scm_command *cmd;
-	struct qcom_scm_response *rsp;
-	unsigned long start, end;
-
-	cmd = alloc_qcom_scm_command(cmd_len, resp_len);
-	if (!cmd)
-		return -ENOMEM;
-
-	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
-	if (cmd_buf)
-		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf, cmd_len);
-
-	mutex_lock(&qcom_scm_lock);
-	ret = __qcom_scm_call(cmd);
-	mutex_unlock(&qcom_scm_lock);
-	if (ret)
-		goto out;
-
-	rsp = qcom_scm_command_to_response(cmd);
-	start = (unsigned long)rsp;
-
-	do {
-		qcom_scm_inv_range(start, start + sizeof(*rsp));
-	} while (!rsp->is_complete);
-
-	end = (unsigned long)qcom_scm_get_response_buffer(rsp) + resp_len;
-	qcom_scm_inv_range(start, end);
-
-	if (resp_buf)
-		memcpy(resp_buf, qcom_scm_get_response_buffer(rsp), resp_len);
-out:
-	free_qcom_scm_command(cmd);
-	return ret;
-}
-
-u32 qcom_scm_get_version(void)
-{
-	int context_id;
-	static u32 version = -1;
-	register u32 r0 asm("r0");
-	register u32 r1 asm("r1");
-
-	if (version != -1)
-		return version;
-
-	mutex_lock(&qcom_scm_lock);
-
-	r0 = 0x1 << 8;
-	r1 = (u32)&context_id;
-	do {
-		asm volatile(
-			__asmeq("%0", "r0")
-			__asmeq("%1", "r1")
-			__asmeq("%2", "r0")
-			__asmeq("%3", "r1")
-#ifdef REQUIRES_SEC
-			".arch_extension sec\n"
-#endif
-			"smc	#0	@ switch to secure world\n"
-			: "=r" (r0), "=r" (r1)
-			: "r" (r0), "r" (r1)
-			: "r2", "r3");
-	} while (r0 == QCOM_SCM_INTERRUPTED);
-
-	version = r1;
-	mutex_unlock(&qcom_scm_lock);
-
-	return version;
-}
-EXPORT_SYMBOL(qcom_scm_get_version);
-
-#define QCOM_SCM_SVC_BOOT			0x1
-#define QCOM_SCM_BOOT_ADDR			0x1
-/*
- * Set the cold/warm boot address for one of the CPU cores.
- */
-int qcom_scm_set_boot_addr(u32 addr, int flags)
-{
-	struct {
-		__le32 flags;
-		__le32 addr;
-	} cmd;
-
-	cmd.addr = cpu_to_le32(addr);
-	cmd.flags = cpu_to_le32(flags);
-	return qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
-			&cmd, sizeof(cmd), NULL, 0);
-}
-EXPORT_SYMBOL(qcom_scm_set_boot_addr);
diff --git a/arch/arm/mach-qcom/scm.h b/arch/arm/mach-qcom/scm.h
deleted file mode 100644
index 6bb84cf..0000000
--- a/arch/arm/mach-qcom/scm.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __QCOM_SCM_H
-#define __QCOM_SCM_H
-
-#define QCOM_SCM_FLAG_COLDBOOT_CPU1		0x01
-#define QCOM_SCM_FLAG_COLDBOOT_CPU2		0x08
-#define QCOM_SCM_FLAG_COLDBOOT_CPU3		0x20
-#define QCOM_SCM_FLAG_WARMBOOT_CPU0		0x04
-#define QCOM_SCM_FLAG_WARMBOOT_CPU1		0x02
-#define QCOM_SCM_FLAG_WARMBOOT_CPU2		0x10
-#define QCOM_SCM_FLAG_WARMBOOT_CPU3		0x40
-
-extern int qcom_scm_set_boot_addr(u32 addr, int flags);
-
-#define QCOM_SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
-
-extern u32 qcom_scm_get_version(void);
-
-#endif
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 41983883..6517132 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -132,6 +132,10 @@ config ISCSI_IBFT
 	  detect iSCSI boot parameters dynamically during system boot, say Y.
 	  Otherwise, say N.
 
+config QCOM_SCM
+	bool
+	depends on ARM || ARM64
+
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 5373dc5..3fdd391 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_DMIID)		+= dmi-id.o
 obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
+obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
+CFLAGS_qcom_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
 
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
new file mode 100644
index 0000000..6e7a72b
--- /dev/null
+++ b/drivers/firmware/qcom_scm.c
@@ -0,0 +1,344 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/qcom_scm.h>
+
+#include <asm/outercache.h>
+#include <asm/cacheflush.h>
+
+
+#define QCOM_SCM_ENOMEM		-5
+#define QCOM_SCM_EOPNOTSUPP	-4
+#define QCOM_SCM_EINVAL_ADDR	-3
+#define QCOM_SCM_EINVAL_ARG	-2
+#define QCOM_SCM_ERROR		-1
+#define QCOM_SCM_INTERRUPTED	1
+
+static DEFINE_MUTEX(qcom_scm_lock);
+
+/**
+ * struct qcom_scm_command - one SCM command buffer
+ * @len: total available memory for command and response
+ * @buf_offset: start of command buffer
+ * @resp_hdr_offset: start of response buffer
+ * @id: command to be executed
+ * @buf: buffer returned from qcom_scm_get_command_buffer()
+ *
+ * An SCM command is laid out in memory as follows:
+ *
+ *	------------------- <--- struct qcom_scm_command
+ *	| command header  |
+ *	------------------- <--- qcom_scm_get_command_buffer()
+ *	| command buffer  |
+ *	------------------- <--- struct qcom_scm_response and
+ *	| response header |      qcom_scm_command_to_response()
+ *	------------------- <--- qcom_scm_get_response_buffer()
+ *	| response buffer |
+ *	-------------------
+ *
+ * There can be arbitrary padding between the headers and buffers so
+ * you should always use the appropriate qcom_scm_get_*_buffer() routines
+ * to access the buffers in a safe manner.
+ */
+struct qcom_scm_command {
+	__le32 len;
+	__le32 buf_offset;
+	__le32 resp_hdr_offset;
+	__le32 id;
+	__le32 buf[0];
+};
+
+/**
+ * struct qcom_scm_response - one SCM response buffer
+ * @len: total available memory for response
+ * @buf_offset: start of response data relative to start of qcom_scm_response
+ * @is_complete: indicates if the command has finished processing
+ */
+struct qcom_scm_response {
+	__le32 len;
+	__le32 buf_offset;
+	__le32 is_complete;
+};
+
+/**
+ * alloc_qcom_scm_command() - Allocate an SCM command
+ * @cmd_size: size of the command buffer
+ * @resp_size: size of the response buffer
+ *
+ * Allocate an SCM command, including enough room for the command
+ * and response headers as well as the command and response buffers.
+ *
+ * Returns a valid &qcom_scm_command on success or %NULL if the allocation fails.
+ */
+static struct qcom_scm_command *alloc_qcom_scm_command(size_t cmd_size, size_t resp_size)
+{
+	struct qcom_scm_command *cmd;
+	size_t len = sizeof(*cmd) + sizeof(struct qcom_scm_response) + cmd_size +
+		resp_size;
+	u32 offset;
+
+	cmd = kzalloc(PAGE_ALIGN(len), GFP_KERNEL);
+	if (cmd) {
+		cmd->len = cpu_to_le32(len);
+		offset = offsetof(struct qcom_scm_command, buf);
+		cmd->buf_offset = cpu_to_le32(offset);
+		cmd->resp_hdr_offset = cpu_to_le32(offset + cmd_size);
+	}
+	return cmd;
+}
+
+/**
+ * free_qcom_scm_command() - Free an SCM command
+ * @cmd: command to free
+ *
+ * Free an SCM command.
+ */
+static inline void free_qcom_scm_command(struct qcom_scm_command *cmd)
+{
+	kfree(cmd);
+}
+
+/**
+ * qcom_scm_command_to_response() - Get a pointer to a qcom_scm_response
+ * @cmd: command
+ *
+ * Returns a pointer to a response for a command.
+ */
+static inline struct qcom_scm_response *qcom_scm_command_to_response(
+		const struct qcom_scm_command *cmd)
+{
+	return (void *)cmd + le32_to_cpu(cmd->resp_hdr_offset);
+}
+
+/**
+ * qcom_scm_get_command_buffer() - Get a pointer to a command buffer
+ * @cmd: command
+ *
+ * Returns a pointer to the command buffer of a command.
+ */
+static inline void *qcom_scm_get_command_buffer(const struct qcom_scm_command *cmd)
+{
+	return (void *)cmd->buf;
+}
+
+/**
+ * qcom_scm_get_response_buffer() - Get a pointer to a response buffer
+ * @rsp: response
+ *
+ * Returns a pointer to a response buffer of a response.
+ */
+static inline void *qcom_scm_get_response_buffer(const struct qcom_scm_response *rsp)
+{
+	return (void *)rsp + le32_to_cpu(rsp->buf_offset);
+}
+
+static int qcom_scm_remap_error(int err)
+{
+	pr_err("qcom_scm_call failed with error code %d\n", err);
+	switch (err) {
+	case QCOM_SCM_ERROR:
+		return -EIO;
+	case QCOM_SCM_EINVAL_ADDR:
+	case QCOM_SCM_EINVAL_ARG:
+		return -EINVAL;
+	case QCOM_SCM_EOPNOTSUPP:
+		return -EOPNOTSUPP;
+	case QCOM_SCM_ENOMEM:
+		return -ENOMEM;
+	}
+	return -EINVAL;
+}
+
+static u32 smc(u32 cmd_addr)
+{
+	int context_id;
+	register u32 r0 asm("r0") = 1;
+	register u32 r1 asm("r1") = (u32)&context_id;
+	register u32 r2 asm("r2") = cmd_addr;
+	do {
+		asm volatile(
+			__asmeq("%0", "r0")
+			__asmeq("%1", "r0")
+			__asmeq("%2", "r1")
+			__asmeq("%3", "r2")
+#ifdef REQUIRES_SEC
+			".arch_extension sec\n"
+#endif
+			"smc	#0	@ switch to secure world\n"
+			: "=r" (r0)
+			: "r" (r0), "r" (r1), "r" (r2)
+			: "r3");
+	} while (r0 == QCOM_SCM_INTERRUPTED);
+
+	return r0;
+}
+
+static int __qcom_scm_call(const struct qcom_scm_command *cmd)
+{
+	int ret;
+	u32 cmd_addr = virt_to_phys(cmd);
+
+	/*
+	 * Flush the command buffer so that the secure world sees
+	 * the correct data.
+	 */
+	__cpuc_flush_dcache_area((void *)cmd, cmd->len);
+	outer_flush_range(cmd_addr, cmd_addr + cmd->len);
+
+	ret = smc(cmd_addr);
+	if (ret < 0)
+		ret = qcom_scm_remap_error(ret);
+
+	return ret;
+}
+
+static void qcom_scm_inv_range(unsigned long start, unsigned long end)
+{
+	u32 cacheline_size, ctr;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
+	cacheline_size = 4 << ((ctr >> 16) & 0xf);
+
+	start = round_down(start, cacheline_size);
+	end = round_up(end, cacheline_size);
+	outer_inv_range(start, end);
+	while (start < end) {
+		asm ("mcr p15, 0, %0, c7, c6, 1" : : "r" (start)
+		     : "memory");
+		start += cacheline_size;
+	}
+	dsb();
+	isb();
+}
+
+/**
+ * qcom_scm_call() - Send an SCM command
+ * @svc_id: service identifier
+ * @cmd_id: command identifier
+ * @cmd_buf: command buffer
+ * @cmd_len: length of the command buffer
+ * @resp_buf: response buffer
+ * @resp_len: length of the response buffer
+ *
+ * Sends a command to the SCM and waits for the command to finish processing.
+ *
+ * A note on cache maintenance:
+ * Note that any buffers that are expected to be accessed by the secure world
+ * must be flushed before invoking qcom_scm_call and invalidated in the cache
+ * immediately after qcom_scm_call returns. Cache maintenance on the command
+ * and response buffers is taken care of by qcom_scm_call; however, callers are
+ * responsible for any other cached buffers passed over to the secure world.
+ */
+static int qcom_scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf,
+			size_t cmd_len, void *resp_buf, size_t resp_len)
+{
+	int ret;
+	struct qcom_scm_command *cmd;
+	struct qcom_scm_response *rsp;
+	unsigned long start, end;
+
+	cmd = alloc_qcom_scm_command(cmd_len, resp_len);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
+	if (cmd_buf)
+		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf, cmd_len);
+
+	mutex_lock(&qcom_scm_lock);
+	ret = __qcom_scm_call(cmd);
+	mutex_unlock(&qcom_scm_lock);
+	if (ret)
+		goto out;
+
+	rsp = qcom_scm_command_to_response(cmd);
+	start = (unsigned long)rsp;
+
+	do {
+		qcom_scm_inv_range(start, start + sizeof(*rsp));
+	} while (!rsp->is_complete);
+
+	end = (unsigned long)qcom_scm_get_response_buffer(rsp) + resp_len;
+	qcom_scm_inv_range(start, end);
+
+	if (resp_buf)
+		memcpy(resp_buf, qcom_scm_get_response_buffer(rsp), resp_len);
+out:
+	free_qcom_scm_command(cmd);
+	return ret;
+}
+
+u32 qcom_scm_get_version(void)
+{
+	int context_id;
+	static u32 version = -1;
+	register u32 r0 asm("r0");
+	register u32 r1 asm("r1");
+
+	if (version != -1)
+		return version;
+
+	mutex_lock(&qcom_scm_lock);
+
+	r0 = 0x1 << 8;
+	r1 = (u32)&context_id;
+	do {
+		asm volatile(
+			__asmeq("%0", "r0")
+			__asmeq("%1", "r1")
+			__asmeq("%2", "r0")
+			__asmeq("%3", "r1")
+#ifdef REQUIRES_SEC
+			".arch_extension sec\n"
+#endif
+			"smc	#0	@ switch to secure world\n"
+			: "=r" (r0), "=r" (r1)
+			: "r" (r0), "r" (r1)
+			: "r2", "r3");
+	} while (r0 == QCOM_SCM_INTERRUPTED);
+
+	version = r1;
+	mutex_unlock(&qcom_scm_lock);
+
+	return version;
+}
+EXPORT_SYMBOL(qcom_scm_get_version);
+
+#define QCOM_SCM_SVC_BOOT			0x1
+#define QCOM_SCM_BOOT_ADDR			0x1
+/*
+ * Set the cold/warm boot address for one of the CPU cores.
+ */
+int qcom_scm_set_boot_addr(u32 addr, int flags)
+{
+	struct {
+		__le32 flags;
+		__le32 addr;
+	} cmd;
+
+	cmd.addr = cpu_to_le32(addr);
+	cmd.flags = cpu_to_le32(flags);
+	return qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
+			&cmd, sizeof(cmd), NULL, 0);
+}
+EXPORT_SYMBOL(qcom_scm_set_boot_addr);
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
new file mode 100644
index 0000000..6bb84cf
--- /dev/null
+++ b/include/linux/qcom_scm.h
@@ -0,0 +1,29 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __QCOM_SCM_H
+#define __QCOM_SCM_H
+
+#define QCOM_SCM_FLAG_COLDBOOT_CPU1		0x01
+#define QCOM_SCM_FLAG_COLDBOOT_CPU2		0x08
+#define QCOM_SCM_FLAG_COLDBOOT_CPU3		0x20
+#define QCOM_SCM_FLAG_WARMBOOT_CPU0		0x04
+#define QCOM_SCM_FLAG_WARMBOOT_CPU1		0x02
+#define QCOM_SCM_FLAG_WARMBOOT_CPU2		0x10
+#define QCOM_SCM_FLAG_WARMBOOT_CPU3		0x40
+
+extern int qcom_scm_set_boot_addr(u32 addr, int flags);
+
+#define QCOM_SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
+
+extern u32 qcom_scm_get_version(void);
+
+#endif
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
