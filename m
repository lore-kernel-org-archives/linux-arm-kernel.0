From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 27 Sep 2017 20:50:20 +0800
Subject: [PATCH v4 4/4] arm64/ras: save error address from memory section for
 recovery
In-Reply-To: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1506516620-20033-5-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some platform, when SEA triggerred, physical address might be
reported by memory section, so we save it for error recovery later.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/arm64/kernel/ras.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
index c48503c..ff24181 100644
--- a/arch/arm64/kernel/ras.c
+++ b/arch/arm64/kernel/ras.c
@@ -140,3 +140,34 @@ void ghes_arm_process_error(struct ghes *ghes, struct cper_sec_proc_arm *err)
 	if (info_saved)
 		set_thread_flag(TIF_SEA_NOTIFY);
 }
+
+int ghes_mem_err_callback(struct notifier_block *nb, unsigned long val, void *data)
+{
+	bool info_saved = false;
+	struct ghes_mem_err *ghes_mem = (struct ghes_mem_err *)data;
+	struct cper_sec_mem_err *mem_err = ghes_mem->mem_err;
+
+	if ((ghes_mem->notify_type != ACPI_HEST_NOTIFY_SEA) ||
+	    (ghes_mem->severity != CPER_SEV_RECOVERABLE))
+		return 0;
+
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA)
+		info_saved = sea_save_info(mem_err->physical_addr);
+
+	if (info_saved)
+		set_thread_flag(TIF_SEA_NOTIFY);
+
+	return 0;
+}
+
+static struct notifier_block ghes_mem_err_nb = {
+	.notifier_call	= ghes_mem_err_callback,
+};
+
+static int arm64_err_recov_init(void)
+{
+	atomic_notifier_chain_register(&ghes_mem_err_chain, &ghes_mem_err_nb);
+	return 0;
+}
+
+late_initcall(arm64_err_recov_init);
-- 
1.8.3.1
