From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Fri, 3 Mar 2017 18:39:55 +0800
Subject: [PATCH 2/2] acpi: apei: handle SEI notification type for ARMv8
In-Reply-To: <1488537595-72161-1-git-send-email-xiexiuqi@huawei.com>
References: <1488537595-72161-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1488537595-72161-2-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM APEI extension proposal added SEI (asynchronous SError interrupt)
notification type for ARMv8.

Add a new GHES error source handling function for SEI. In firmware
first mode, if an error source's notification type is SEI. Then GHES
could parse and report the detail error information.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/arm64/kernel/traps.c |  5 ++++
 drivers/acpi/apei/Kconfig | 14 ++++++++++++
 drivers/acpi/apei/ghes.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/acpi/ghes.h       |  1 +
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7d47c2c..43f616d 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -44,6 +44,8 @@
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
 
+#include <acpi/ghes.h>
+
 static const char *handler[]= {
 	"Synchronous Abort",
 	"IRQ",
@@ -622,6 +624,9 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 		handler[reason], smp_processor_id(), esr,
 		esr_get_class_string(esr));
 
+	if (IS_ENABLED(ACPI_APEI_SEI) && ESR_ELx_EC(esr) == ESR_ELx_EC_SERROR)
+		ghes_notify_sei();
+
 	die("Oops - bad mode", regs, 0);
 	local_irq_disable();
 	panic("bad mode");
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 1122d7f..a32f046 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -18,6 +18,20 @@ config HAVE_ACPI_APEI_SEA
 	  option allows the OS to look for such hardware error record, and
 	  take appropriate action.
 
+config ACPI_APEI_SEI
+	bool "APEI Asynchronous SError Interrupt logging/recovering support"
+	depends on ARM64 && ACPI_APEI_GHES
+	help
+	  This option should be enabled if the system supports
+	  firmware first handling of SEI (asynchronous SError interrupt).
+
+	  SEI happens with invalid instruction access or asynchronous exceptions
+	  on ARMv8 systems. If a system supports firmware first handling of SEI,
+	  the platform analyzes and handles hardware error notifications from
+	  SEI, and it may then form a HW error record for the OS to parse and
+	  handle. This option allows the OS to look for such hardware error
+	  record, and take appropriate action.
+
 config ACPI_APEI
 	bool "ACPI Platform Error Interface (APEI)"
 	select MISC_FILESYSTEMS
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3e4ea1b..d084a09 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -850,6 +850,50 @@ static inline void ghes_sea_remove(struct ghes *ghes)
 }
 #endif /* CONFIG_HAVE_ACPI_APEI_SEA */
 
+#ifdef CONFIG_ACPI_APEI_SEI
+static LIST_HEAD(ghes_sei);
+
+void ghes_notify_sei(void)
+{
+	struct ghes *ghes;
+
+	/*
+	 * synchronize_rcu() will wait for nmi_exit(), so no need to
+	 * rcu_read_lock().
+	 */
+	list_for_each_entry_rcu(ghes, &ghes_sei, list) {
+		ghes_proc(ghes);
+	}
+}
+
+static void ghes_sei_add(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	list_add_rcu(&ghes->list, &ghes_sei);
+	mutex_unlock(&ghes_list_mutex);
+}
+
+static void ghes_sei_remove(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	list_del_rcu(&ghes->list);
+	mutex_unlock(&ghes_list_mutex);
+	synchronize_rcu();
+}
+#else /* CONFIG_ACPI_APEI_SEI */
+static inline void ghes_sei_add(struct ghes *ghes)
+{
+	pr_err(GHES_PFX "ID: %d, trying to add SEI notification which is not supported\n",
+	       ghes->generic->header.source_id);
+}
+
+static inline void ghes_sei_remove(struct ghes *ghes)
+{
+	pr_err(GHES_PFX "ID: %d, trying to remove SEI notification which is not supported\n",
+	       ghes->generic->header.source_id);
+}
+#endif /* CONFIG_HAVE_ACPI_APEI_SEI */
+
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
  * printk is not safe in NMI context.  So in NMI handler, we allocate
@@ -1099,6 +1143,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			goto err;
 		}
 		break;
+	case ACPI_HEST_NOTIFY_SEI:
+		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_SEI)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SEI is not supported!\n",
+				generic->header.source_id);
+			goto err;
+		}
+		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
 			pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
@@ -1111,7 +1162,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			   generic->header.source_id);
 		goto err;
 	case ACPI_HEST_NOTIFY_GPIO:
-	case ACPI_HEST_NOTIFY_SEI:
 	case ACPI_HEST_NOTIFY_GSIV:
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via notification type %u is not supported\n",
 			generic->header.source_id, generic->header.source_id);
@@ -1174,6 +1224,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_SEA:
 		ghes_sea_add(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_SEI:
+		ghes_sei_add(ghes);
+		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
 		break;
@@ -1219,6 +1272,9 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_SEA:
 		ghes_sea_remove(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_SEI:
+		ghes_sei_remove(ghes);
+		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_remove(ghes);
 		break;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 18bc935..7554658 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -100,5 +100,6 @@ static inline void *acpi_hest_generic_data_payload(struct acpi_hest_generic_data
 }
 
 void ghes_notify_sea(void);
+void ghes_notify_sei(void);
 
 #endif /* GHES_H */
-- 
1.8.3.1
