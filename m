From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 25 Apr 2016 18:08:43 -0500
Subject: [Patch v2 6/8] firmware: qcom: scm: Use atomic SCM for cold boot
In-Reply-To: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
References: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1461625725-32425-7-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the cold_set_boot_addr function to use atomic SCM
calls.  This removes the need for memory allocation and instead places
all arguments in registers.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm-32.c | 47 ++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 0d2a3f8..419df4d 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -294,34 +294,39 @@ out:
 				(n & 0xf))
 
 /**
- * qcom_scm_call_atomic1() - Send an atomic SCM command with one argument
+ * qcom_scm_call_atomic() - Send an atomic SCM command with one argument
  * @svc_id: service identifier
  * @cmd_id: command identifier
+ * @arglen: number of arguments
  * @arg1: first argument
+ * @arg2: second argument (optional - fill with 0 if unused)
  *
  * This shall only be used with commands that are guaranteed to be
  * uninterruptable, atomic and SMP safe.
  */
-static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
+static s32 qcom_scm_call_atomic(u32 svc, u32 cmd, u32 arglen, u32 arg1,
+				u32 arg2)
 {
 	int context_id;
 
-	register u32 r0 asm("r0") = SCM_ATOMIC(svc, cmd, 1);
+	register u32 r0 asm("r0") = SCM_ATOMIC(svc, cmd, arglen);
 	register u32 r1 asm("r1") = (u32)&context_id;
 	register u32 r2 asm("r2") = arg1;
+	register u32 r3 asm("r3") = arg2;
 
 	asm volatile(
 			__asmeq("%0", "r0")
 			__asmeq("%1", "r0")
 			__asmeq("%2", "r1")
 			__asmeq("%3", "r2")
+			__asmeq("%4", "r3")
 #ifdef REQUIRES_SEC
 			".arch_extension sec\n"
 #endif
 			"smc    #0      @ switch to secure world\n"
 			: "=r" (r0)
-			: "r" (r0), "r" (r1), "r" (r2)
-			: "r3");
+			: "r" (r0), "r" (r1), "r" (r2), "r" (r3)
+			);
 	return r0;
 }
 
@@ -361,22 +366,6 @@ u32 qcom_scm_get_version(void)
 }
 EXPORT_SYMBOL(qcom_scm_get_version);
 
-/*
- * Set the cold/warm boot address for one of the CPU cores.
- */
-static int qcom_scm_set_boot_addr(u32 addr, int flags)
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
-
 /**
  * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
  * @entry: Entry point function for the cpus
@@ -406,7 +395,8 @@ int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 			set_cpu_present(cpu, false);
 	}
 
-	return qcom_scm_set_boot_addr(virt_to_phys(entry), flags);
+	return qcom_scm_call_atomic(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR, 2,
+				    flags, virt_to_phys(entry));
 }
 
 /**
@@ -422,6 +412,10 @@ int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
 	int ret;
 	int flags = 0;
 	int cpu;
+	struct {
+		__le32 flags;
+		__le32 addr;
+	} cmd;
 
 	/*
 	 * Reassign only if we are switching from hotplug entry point
@@ -437,7 +431,10 @@ int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
 	if (!flags)
 		return 0;
 
-	ret = qcom_scm_set_boot_addr(virt_to_phys(entry), flags);
+	cmd.addr = cpu_to_le32(virt_to_phys(entry));
+	cmd.flags = cpu_to_le32(flags);
+	ret = qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
+			    &cmd, sizeof(cmd), NULL, 0);
 	if (!ret) {
 		for_each_cpu(cpu, cpus)
 			qcom_scm_wb[cpu].entry = entry;
@@ -456,8 +453,8 @@ int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
  */
 void __qcom_scm_cpu_power_down(u32 flags)
 {
-	qcom_scm_call_atomic1(QCOM_SCM_SVC_BOOT, QCOM_SCM_CMD_TERMINATE_PC,
-			flags & QCOM_SCM_FLUSH_FLAG_MASK);
+	qcom_scm_call_atomic(QCOM_SCM_SVC_BOOT, QCOM_SCM_CMD_TERMINATE_PC, 1,
+			flags & QCOM_SCM_FLUSH_FLAG_MASK, 0);
 }
 
 int __qcom_scm_is_call_available(u32 svc_id, u32 cmd_id)
-- 
1.9.1
