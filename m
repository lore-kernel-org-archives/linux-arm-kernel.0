From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Fri, 1 Sep 2017 18:32:00 +0800
Subject: [RFC PATCH v1 2/3] apei: add ghes param for arch_apei_report_mem_error
In-Reply-To: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
References: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1504261921-39308-3-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ghes param for arch_apei_report_mem_error, with which
we could do more arch-specific processing.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/x86/kernel/acpi/apei.c   | 2 +-
 drivers/acpi/apei/apei-base.c | 4 +++-
 drivers/acpi/apei/ghes.c      | 2 +-
 include/acpi/apei.h           | 4 +++-
 include/acpi/ghes.h           | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index ea3046e..1bf1c9b 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -46,7 +46,7 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
 	return 1;
 }
 
-void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
+void arch_apei_report_mem_error(struct ghes *ghes, int sev, struct cper_sec_mem_err *mem_err)
 {
 #ifdef CONFIG_X86_MCE
 	apei_mce_report_mem_error(sev, mem_err);
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index da370e1..317169b 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -38,6 +38,8 @@
 #include <linux/debugfs.h>
 #include <asm/unaligned.h>
 
+#include <acpi/ghes.h>
+
 #include "apei-internal.h"
 
 #define APEI_PFX "APEI: "
@@ -770,7 +772,7 @@ int __weak arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr,
 }
 EXPORT_SYMBOL_GPL(arch_apei_enable_cmcff);
 
-void __weak arch_apei_report_mem_error(int sev,
+void __weak arch_apei_report_mem_error(struct ghes *ghes, int sev,
 				       struct cper_sec_mem_err *mem_err)
 {
 }
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fa9400d..996d16c4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -483,7 +483,7 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			ghes_edac_report_mem_error(ghes, sev, mem_err);
 
-			arch_apei_report_mem_error(sev, mem_err);
+			arch_apei_report_mem_error(ghes, sev, mem_err);
 			ghes_handle_memory_failure(gdata, sev);
 		}
 #ifdef CONFIG_ACPI_APEI_PCIEAER
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 76284bb..586dfb0 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -9,6 +9,8 @@
 #include <linux/cper.h>
 #include <asm/ioctls.h>
 
+#include <acpi/ghes.h>
+
 #define APEI_ERST_INVALID_RECORD_ID	0xffffffffffffffffULL
 
 #define APEI_ERST_CLEAR_RECORD		_IOW('E', 1, u64)
@@ -43,7 +45,7 @@ ssize_t erst_read(u64 record_id, struct cper_record_header *record,
 int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
-void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+void arch_apei_report_mem_error(struct ghes *ghes, int sev, struct cper_sec_mem_err *mem_err);
 void arch_apei_flush_tlb_one(unsigned long addr);
 
 #endif
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 9f26e01..3100791 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -1,7 +1,8 @@
 #ifndef GHES_H
 #define GHES_H
 
-#include <acpi/apei.h>
+#include <linux/acpi.h>
+#include <linux/cper.h>
 #include <acpi/hed.h>
 
 /*
-- 
1.8.3.1
