From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 26 Feb 2015 15:59:35 -0600
Subject: [PATCH 3/4] ARM: qcom: Prep scm code for move to drivers/firmware
In-Reply-To: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
References: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
Message-ID: <1424987976-14531-3-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add qcom prefix to functions, etc to create a unique name space for the
scm code as it gets ready to move out of qcom specific mach dir.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/mach-qcom/platsmp.c |   8 +--
 arch/arm/mach-qcom/scm.c     | 148 +++++++++++++++++++++----------------------
 arch/arm/mach-qcom/scm.h     |  24 +++----
 3 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 8f4962e..596e623 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -323,9 +323,9 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
 	unsigned int flags = 0;
 	static const int cold_boot_flags[] = {
 		0,
-		SCM_FLAG_COLDBOOT_CPU1,
-		SCM_FLAG_COLDBOOT_CPU2,
-		SCM_FLAG_COLDBOOT_CPU3,
+		QCOM_SCM_FLAG_COLDBOOT_CPU1,
+		QCOM_SCM_FLAG_COLDBOOT_CPU2,
+		QCOM_SCM_FLAG_COLDBOOT_CPU3,
 	};
 
 	for_each_present_cpu(cpu) {
@@ -337,7 +337,7 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
 		flags |= cold_boot_flags[map];
 	}
 
-	if (scm_set_boot_addr(virt_to_phys(secondary_startup_arm), flags)) {
+	if (qcom_scm_set_boot_addr(virt_to_phys(secondary_startup_arm), flags)) {
 		for_each_present_cpu(cpu) {
 			if (cpu == smp_processor_id())
 				continue;
diff --git a/arch/arm/mach-qcom/scm.c b/arch/arm/mach-qcom/scm.c
index 5147666..3e0e334 100644
--- a/arch/arm/mach-qcom/scm.c
+++ b/arch/arm/mach-qcom/scm.c
@@ -27,40 +27,40 @@
 
 #include "scm.h"
 
-#define SCM_ENOMEM		-5
-#define SCM_EOPNOTSUPP		-4
-#define SCM_EINVAL_ADDR		-3
-#define SCM_EINVAL_ARG		-2
-#define SCM_ERROR		-1
-#define SCM_INTERRUPTED		1
+#define QCOM_SCM_ENOMEM		-5
+#define QCOM_SCM_EOPNOTSUPP	-4
+#define QCOM_SCM_EINVAL_ADDR	-3
+#define QCOM_SCM_EINVAL_ARG	-2
+#define QCOM_SCM_ERROR		-1
+#define QCOM_SCM_INTERRUPTED	1
 
-static DEFINE_MUTEX(scm_lock);
+static DEFINE_MUTEX(qcom_scm_lock);
 
 /**
- * struct scm_command - one SCM command buffer
+ * struct qcom_scm_command - one SCM command buffer
  * @len: total available memory for command and response
  * @buf_offset: start of command buffer
  * @resp_hdr_offset: start of response buffer
  * @id: command to be executed
- * @buf: buffer returned from scm_get_command_buffer()
+ * @buf: buffer returned from qcom_scm_get_command_buffer()
  *
  * An SCM command is laid out in memory as follows:
  *
- *	------------------- <--- struct scm_command
+ *	------------------- <--- struct qcom_scm_command
  *	| command header  |
- *	------------------- <--- scm_get_command_buffer()
+ *	------------------- <--- qcom_scm_get_command_buffer()
  *	| command buffer  |
- *	------------------- <--- struct scm_response and
- *	| response header |      scm_command_to_response()
- *	------------------- <--- scm_get_response_buffer()
+ *	------------------- <--- struct qcom_scm_response and
+ *	| response header |      qcom_scm_command_to_response()
+ *	------------------- <--- qcom_scm_get_response_buffer()
  *	| response buffer |
  *	-------------------
  *
  * There can be arbitrary padding between the headers and buffers so
- * you should always use the appropriate scm_get_*_buffer() routines
+ * you should always use the appropriate qcom_scm_get_*_buffer() routines
  * to access the buffers in a safe manner.
  */
-struct scm_command {
+struct qcom_scm_command {
 	__le32 len;
 	__le32 buf_offset;
 	__le32 resp_hdr_offset;
@@ -69,38 +69,38 @@ struct scm_command {
 };
 
 /**
- * struct scm_response - one SCM response buffer
+ * struct qcom_scm_response - one SCM response buffer
  * @len: total available memory for response
- * @buf_offset: start of response data relative to start of scm_response
+ * @buf_offset: start of response data relative to start of qcom_scm_response
  * @is_complete: indicates if the command has finished processing
  */
-struct scm_response {
+struct qcom_scm_response {
 	__le32 len;
 	__le32 buf_offset;
 	__le32 is_complete;
 };
 
 /**
- * alloc_scm_command() - Allocate an SCM command
+ * alloc_qcom_scm_command() - Allocate an SCM command
  * @cmd_size: size of the command buffer
  * @resp_size: size of the response buffer
  *
  * Allocate an SCM command, including enough room for the command
  * and response headers as well as the command and response buffers.
  *
- * Returns a valid &scm_command on success or %NULL if the allocation fails.
+ * Returns a valid &qcom_scm_command on success or %NULL if the allocation fails.
  */
-static struct scm_command *alloc_scm_command(size_t cmd_size, size_t resp_size)
+static struct qcom_scm_command *alloc_qcom_scm_command(size_t cmd_size, size_t resp_size)
 {
-	struct scm_command *cmd;
-	size_t len = sizeof(*cmd) + sizeof(struct scm_response) + cmd_size +
+	struct qcom_scm_command *cmd;
+	size_t len = sizeof(*cmd) + sizeof(struct qcom_scm_response) + cmd_size +
 		resp_size;
 	u32 offset;
 
 	cmd = kzalloc(PAGE_ALIGN(len), GFP_KERNEL);
 	if (cmd) {
 		cmd->len = cpu_to_le32(len);
-		offset = offsetof(struct scm_command, buf);
+		offset = offsetof(struct qcom_scm_command, buf);
 		cmd->buf_offset = cpu_to_le32(offset);
 		cmd->resp_hdr_offset = cpu_to_le32(offset + cmd_size);
 	}
@@ -108,62 +108,62 @@ static struct scm_command *alloc_scm_command(size_t cmd_size, size_t resp_size)
 }
 
 /**
- * free_scm_command() - Free an SCM command
+ * free_qcom_scm_command() - Free an SCM command
  * @cmd: command to free
  *
  * Free an SCM command.
  */
-static inline void free_scm_command(struct scm_command *cmd)
+static inline void free_qcom_scm_command(struct qcom_scm_command *cmd)
 {
 	kfree(cmd);
 }
 
 /**
- * scm_command_to_response() - Get a pointer to a scm_response
+ * qcom_scm_command_to_response() - Get a pointer to a qcom_scm_response
  * @cmd: command
  *
  * Returns a pointer to a response for a command.
  */
-static inline struct scm_response *scm_command_to_response(
-		const struct scm_command *cmd)
+static inline struct qcom_scm_response *qcom_scm_command_to_response(
+		const struct qcom_scm_command *cmd)
 {
 	return (void *)cmd + le32_to_cpu(cmd->resp_hdr_offset);
 }
 
 /**
- * scm_get_command_buffer() - Get a pointer to a command buffer
+ * qcom_scm_get_command_buffer() - Get a pointer to a command buffer
  * @cmd: command
  *
  * Returns a pointer to the command buffer of a command.
  */
-static inline void *scm_get_command_buffer(const struct scm_command *cmd)
+static inline void *qcom_scm_get_command_buffer(const struct qcom_scm_command *cmd)
 {
 	return (void *)cmd->buf;
 }
 
 /**
- * scm_get_response_buffer() - Get a pointer to a response buffer
+ * qcom_scm_get_response_buffer() - Get a pointer to a response buffer
  * @rsp: response
  *
  * Returns a pointer to a response buffer of a response.
  */
-static inline void *scm_get_response_buffer(const struct scm_response *rsp)
+static inline void *qcom_scm_get_response_buffer(const struct qcom_scm_response *rsp)
 {
 	return (void *)rsp + le32_to_cpu(rsp->buf_offset);
 }
 
-static int scm_remap_error(int err)
+static int qcom_scm_remap_error(int err)
 {
-	pr_err("scm_call failed with error code %d\n", err);
+	pr_err("qcom_scm_call failed with error code %d\n", err);
 	switch (err) {
-	case SCM_ERROR:
+	case QCOM_SCM_ERROR:
 		return -EIO;
-	case SCM_EINVAL_ADDR:
-	case SCM_EINVAL_ARG:
+	case QCOM_SCM_EINVAL_ADDR:
+	case QCOM_SCM_EINVAL_ARG:
 		return -EINVAL;
-	case SCM_EOPNOTSUPP:
+	case QCOM_SCM_EOPNOTSUPP:
 		return -EOPNOTSUPP;
-	case SCM_ENOMEM:
+	case QCOM_SCM_ENOMEM:
 		return -ENOMEM;
 	}
 	return -EINVAL;
@@ -188,12 +188,12 @@ static u32 smc(u32 cmd_addr)
 			: "=r" (r0)
 			: "r" (r0), "r" (r1), "r" (r2)
 			: "r3");
-	} while (r0 == SCM_INTERRUPTED);
+	} while (r0 == QCOM_SCM_INTERRUPTED);
 
 	return r0;
 }
 
-static int __scm_call(const struct scm_command *cmd)
+static int __qcom_scm_call(const struct qcom_scm_command *cmd)
 {
 	int ret;
 	u32 cmd_addr = virt_to_phys(cmd);
@@ -207,12 +207,12 @@ static int __scm_call(const struct scm_command *cmd)
 
 	ret = smc(cmd_addr);
 	if (ret < 0)
-		ret = scm_remap_error(ret);
+		ret = qcom_scm_remap_error(ret);
 
 	return ret;
 }
 
-static void scm_inv_range(unsigned long start, unsigned long end)
+static void qcom_scm_inv_range(unsigned long start, unsigned long end)
 {
 	u32 cacheline_size, ctr;
 
@@ -232,7 +232,7 @@ static void scm_inv_range(unsigned long start, unsigned long end)
 }
 
 /**
- * scm_call() - Send an SCM command
+ * qcom_scm_call() - Send an SCM command
  * @svc_id: service identifier
  * @cmd_id: command identifier
  * @cmd_buf: command buffer
@@ -244,51 +244,51 @@ static void scm_inv_range(unsigned long start, unsigned long end)
  *
  * A note on cache maintenance:
  * Note that any buffers that are expected to be accessed by the secure world
- * must be flushed before invoking scm_call and invalidated in the cache
- * immediately after scm_call returns. Cache maintenance on the command and
- * response buffers is taken care of by scm_call; however, callers are
+ * must be flushed before invoking qcom_scm_call and invalidated in the cache
+ * immediately after qcom_scm_call returns. Cache maintenance on the command
+ * and response buffers is taken care of by qcom_scm_call; however, callers are
  * responsible for any other cached buffers passed over to the secure world.
  */
-static int scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf, size_t cmd_len,
-			void *resp_buf, size_t resp_len)
+static int qcom_scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf,
+			size_t cmd_len, void *resp_buf, size_t resp_len)
 {
 	int ret;
-	struct scm_command *cmd;
-	struct scm_response *rsp;
+	struct qcom_scm_command *cmd;
+	struct qcom_scm_response *rsp;
 	unsigned long start, end;
 
-	cmd = alloc_scm_command(cmd_len, resp_len);
+	cmd = alloc_qcom_scm_command(cmd_len, resp_len);
 	if (!cmd)
 		return -ENOMEM;
 
 	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
 	if (cmd_buf)
-		memcpy(scm_get_command_buffer(cmd), cmd_buf, cmd_len);
+		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf, cmd_len);
 
-	mutex_lock(&scm_lock);
-	ret = __scm_call(cmd);
-	mutex_unlock(&scm_lock);
+	mutex_lock(&qcom_scm_lock);
+	ret = __qcom_scm_call(cmd);
+	mutex_unlock(&qcom_scm_lock);
 	if (ret)
 		goto out;
 
-	rsp = scm_command_to_response(cmd);
+	rsp = qcom_scm_command_to_response(cmd);
 	start = (unsigned long)rsp;
 
 	do {
-		scm_inv_range(start, start + sizeof(*rsp));
+		qcom_scm_inv_range(start, start + sizeof(*rsp));
 	} while (!rsp->is_complete);
 
-	end = (unsigned long)scm_get_response_buffer(rsp) + resp_len;
-	scm_inv_range(start, end);
+	end = (unsigned long)qcom_scm_get_response_buffer(rsp) + resp_len;
+	qcom_scm_inv_range(start, end);
 
 	if (resp_buf)
-		memcpy(resp_buf, scm_get_response_buffer(rsp), resp_len);
+		memcpy(resp_buf, qcom_scm_get_response_buffer(rsp), resp_len);
 out:
-	free_scm_command(cmd);
+	free_qcom_scm_command(cmd);
 	return ret;
 }
 
-u32 scm_get_version(void)
+u32 qcom_scm_get_version(void)
 {
 	int context_id;
 	static u32 version = -1;
@@ -298,7 +298,7 @@ u32 scm_get_version(void)
 	if (version != -1)
 		return version;
 
-	mutex_lock(&scm_lock);
+	mutex_lock(&qcom_scm_lock);
 
 	r0 = 0x1 << 8;
 	r1 = (u32)&context_id;
@@ -315,21 +315,21 @@ u32 scm_get_version(void)
 			: "=r" (r0), "=r" (r1)
 			: "r" (r0), "r" (r1)
 			: "r2", "r3");
-	} while (r0 == SCM_INTERRUPTED);
+	} while (r0 == QCOM_SCM_INTERRUPTED);
 
 	version = r1;
-	mutex_unlock(&scm_lock);
+	mutex_unlock(&qcom_scm_lock);
 
 	return version;
 }
-EXPORT_SYMBOL(scm_get_version);
+EXPORT_SYMBOL(qcom_scm_get_version);
 
-#define SCM_SVC_BOOT			0x1
-#define SCM_BOOT_ADDR			0x1
+#define QCOM_SCM_SVC_BOOT			0x1
+#define QCOM_SCM_BOOT_ADDR			0x1
 /*
  * Set the cold/warm boot address for one of the CPU cores.
  */
-int scm_set_boot_addr(u32 addr, int flags)
+int qcom_scm_set_boot_addr(u32 addr, int flags)
 {
 	struct {
 		__le32 flags;
@@ -338,7 +338,7 @@ int scm_set_boot_addr(u32 addr, int flags)
 
 	cmd.addr = cpu_to_le32(addr);
 	cmd.flags = cpu_to_le32(flags);
-	return scm_call(SCM_SVC_BOOT, SCM_BOOT_ADDR,
+	return qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
 			&cmd, sizeof(cmd), NULL, 0);
 }
-EXPORT_SYMBOL(scm_set_boot_addr);
+EXPORT_SYMBOL(qcom_scm_set_boot_addr);
diff --git a/arch/arm/mach-qcom/scm.h b/arch/arm/mach-qcom/scm.h
index d73c378..6bb84cf 100644
--- a/arch/arm/mach-qcom/scm.h
+++ b/arch/arm/mach-qcom/scm.h
@@ -9,21 +9,21 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#ifndef __MACH_SCM_H
-#define __MACH_SCM_H
+#ifndef __QCOM_SCM_H
+#define __QCOM_SCM_H
 
-#define SCM_FLAG_COLDBOOT_CPU1		0x01
-#define SCM_FLAG_COLDBOOT_CPU2		0x08
-#define SCM_FLAG_COLDBOOT_CPU3		0x20
-#define SCM_FLAG_WARMBOOT_CPU0		0x04
-#define SCM_FLAG_WARMBOOT_CPU1		0x02
-#define SCM_FLAG_WARMBOOT_CPU2		0x10
-#define SCM_FLAG_WARMBOOT_CPU3		0x40
+#define QCOM_SCM_FLAG_COLDBOOT_CPU1		0x01
+#define QCOM_SCM_FLAG_COLDBOOT_CPU2		0x08
+#define QCOM_SCM_FLAG_COLDBOOT_CPU3		0x20
+#define QCOM_SCM_FLAG_WARMBOOT_CPU0		0x04
+#define QCOM_SCM_FLAG_WARMBOOT_CPU1		0x02
+#define QCOM_SCM_FLAG_WARMBOOT_CPU2		0x10
+#define QCOM_SCM_FLAG_WARMBOOT_CPU3		0x40
 
-extern int scm_set_boot_addr(u32 addr, int flags);
+extern int qcom_scm_set_boot_addr(u32 addr, int flags);
 
-#define SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
+#define QCOM_SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
 
-extern u32 scm_get_version(void);
+extern u32 qcom_scm_get_version(void);
 
 #endif
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
