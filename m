From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 8 Mar 2017 12:09:40 +0800
Subject: [PATCH v2 2/3] acpi: apei: handle SEI notification type for ARMv8
In-Reply-To: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
References: <1488946181-130774-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1488946181-130774-3-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM APEI extension proposal added SEI (asynchronous SError interrupt)
notification type for ARMv8.

Add a new GHES error source handling function for SEI. In firmware
first mode, if an error source's notification type is SEI. Then GHES
could parse and report the detail error information.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/arm64/kernel/traps.c | 13 +++++++++++
 drivers/acpi/apei/Kconfig | 14 ++++++++++++
 drivers/acpi/apei/ghes.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/acpi/ghes.h       |  1 +
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e52be6a..65dbfa9 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -47,6 +47,8 @@
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
 
+#include <acpi/ghes.h>
+
 static const char *handler[]= {
 	"Synchronous Abort",
 	"IRQ",
@@ -625,6 +627,17 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 		handler[reason], smp_processor_id(), esr,
 		esr_get_class_string(esr));
 
+	/*
+	 * Synchronous aborts may interrupt code which had interrupts masked.
+	 * Before calling out into the wider kernel tell the interested
+	 * subsystems.
+	 */
+	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI) && ESR_ELx_EC(esr) == ESR_ELx_EC_SERROR) {
+		nmi_enter();
+		ghes_notify_sei();
+		nmi_exit();
+	}
+
 	die("Oops - bad mode", regs, 0);
 	local_irq_disable();
 	panic("bad mode");
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 8ff0518..277deb8 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -55,6 +55,20 @@ config ACPI_APEI_SEA
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
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ea5b118..251d7e0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -851,6 +851,50 @@ static inline void ghes_sea_remove(struct ghes *ghes)
 }
 #endif /* CONFIG_ACPI_APEI_SEA */
 
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
@@ -1100,6 +1144,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
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
@@ -1112,7 +1163,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			   generic->header.source_id);
 		goto err;
 	case ACPI_HEST_NOTIFY_GPIO:
-	case ACPI_HEST_NOTIFY_SEI:
 	case ACPI_HEST_NOTIFY_GSIV:
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via notification type %u is not supported\n",
 			generic->header.source_id, generic->header.source_id);
@@ -1175,6 +1225,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_SEA:
 		ghes_sea_add(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_SEI:
+		ghes_sei_add(ghes);
+		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
 		break;
@@ -1220,6 +1273,9 @@ static int ghes_remove(struct platform_device *ghes_dev)
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
