From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 11 May 2016 09:15:53 -0500
Subject: [Patch v4 3/8] firmware: qcom: scm: Use atomic SCM for cold boot
In-Reply-To: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
References: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1462976158-26016-4-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the cold_set_boot_addr function to use atomic SCM
calls.  cold_set_boot_addr required adding qcom_scm_call_atomic2 to
support the two arguments going to the smc call.  Using atomic removes
the need for memory allocation and instead places all arguments in
registers.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm-32.c | 63 ++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 0883292..5be6a12 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -342,6 +342,41 @@ static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
 	return r0;
 }
 
+/**
+ * qcom_scm_call_atomic2() - Send an atomic SCM command with two arguments
+ * @svc_id:	service identifier
+ * @cmd_id:	command identifier
+ * @arg1:	first argument
+ * @arg2:	second argument
+ *
+ * This shall only be used with commands that are guaranteed to be
+ * uninterruptable, atomic and SMP safe.
+ */
+static s32 qcom_scm_call_atomic2(u32 svc, u32 cmd, u32 arg1, u32 arg2)
+{
+	int context_id;
+
+	register u32 r0 asm("r0") = SCM_ATOMIC(svc, cmd, 2);
+	register u32 r1 asm("r1") = (u32)&context_id;
+	register u32 r2 asm("r2") = arg1;
+	register u32 r3 asm("r3") = arg2;
+
+	asm volatile(
+			__asmeq("%0", "r0")
+			__asmeq("%1", "r0")
+			__asmeq("%2", "r1")
+			__asmeq("%3", "r2")
+			__asmeq("%4", "r3")
+#ifdef REQUIRES_SEC
+			".arch_extension sec\n"
+#endif
+			"smc    #0      @ switch to secure world\n"
+			: "=r" (r0)
+			: "r" (r0), "r" (r1), "r" (r2), "r" (r3)
+			);
+	return r0;
+}
+
 u32 qcom_scm_get_version(void)
 {
 	int context_id;
@@ -378,22 +413,6 @@ u32 qcom_scm_get_version(void)
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
@@ -423,7 +442,8 @@ int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 			set_cpu_present(cpu, false);
 	}
 
-	return qcom_scm_set_boot_addr(virt_to_phys(entry), flags);
+	return qcom_scm_call_atomic2(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
+				    flags, virt_to_phys(entry));
 }
 
 /**
@@ -439,6 +459,10 @@ int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
 	int ret;
 	int flags = 0;
 	int cpu;
+	struct {
+		__le32 flags;
+		__le32 addr;
+	} cmd;
 
 	/*
 	 * Reassign only if we are switching from hotplug entry point
@@ -454,7 +478,10 @@ int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
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
-- 
1.9.1
