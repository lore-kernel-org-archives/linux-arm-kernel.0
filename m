From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 27 Sep 2017 20:50:19 +0800
Subject: [PATCH v4 3/4] GHES: add a notify chain for process memory section
In-Reply-To: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1506516620-20033-4-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a notify chain for process memory section, with
which other modules might do error recovery.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/acpi/apei/ghes.c | 10 ++++++++++
 include/acpi/ghes.h      |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2abf673..56b7336 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -108,6 +108,9 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 static LIST_HEAD(ghes_hed);
 static DEFINE_MUTEX(ghes_list_mutex);
 
+ATOMIC_NOTIFIER_HEAD(ghes_mem_err_chain);
+EXPORT_SYMBOL(ghes_mem_err_chain);
+
 /*
  * Because the memory area used to transfer hardware error information
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
@@ -485,6 +488,13 @@ static void ghes_do_proc(struct ghes *ghes,
 
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+			struct ghes_mem_err mem;
+
+			mem.notify_type = ghes->generic->notify.type;
+			mem.severity = gdata->error_severity;
+			mem.mem_err = mem_err;
+
+			atomic_notifier_call_chain(&ghes_mem_err_chain, 0, &mem);
 
 			ghes_edac_report_mem_error(ghes, sev, mem_err);
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8bcb8e5..ab51e40 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -123,4 +123,12 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
 extern void ghes_arm_process_error(struct ghes *ghes,
 				   struct cper_sec_proc_arm *err);
 
+struct ghes_mem_err {
+	int notify_type;
+	int severity;
+	struct cper_sec_mem_err *mem_err;
+};
+
+extern struct atomic_notifier_head ghes_mem_err_chain;
+
 #endif /* GHES_H */
-- 
1.8.3.1
