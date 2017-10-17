From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Tue, 17 Oct 2017 16:02:21 +0800
Subject: [PATCH v5 2/2] acpi: apei: Add SEI notification type support for ARMv8
In-Reply-To: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1508227341-15651-2-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.2 requires implementation of the RAS extension, in
this extension it adds SEI(SError Interrupt) notification
type, this patch adds new GHES error source SEI handling
functions. Because this error source parsing and handling
methods are similar with the SEA. So share some SEA handling
functions with the SEI

Expose one API ghes_notify_abort() to external users. External
modules can call this exposed API to parse and handle the
SEA or SEI.

Note: For the SEI(SError Interrupt), it is asynchronous external
abort, the error address recorded by firmware may be not accurate.
If not accurate, EL3 firmware needs to identify the address to a
invalid value.

Cc: Borislav Petkov <bp@suse.de>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Tested-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 arch/arm64/mm/fault.c     |  4 +--
 drivers/acpi/apei/Kconfig | 15 ++++++++++
 drivers/acpi/apei/ghes.c  | 71 ++++++++++++++++++++++++++++++++++-------------
 include/acpi/ghes.h       |  2 +-
 4 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2509e4f..c98c1b3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -585,7 +585,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		if (interrupts_enabled(regs))
 			nmi_enter();
 
-		ret = ghes_notify_sea();
+		ret = ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
 
 		if (interrupts_enabled(regs))
 			nmi_exit();
@@ -682,7 +682,7 @@ int handle_guest_sea(phys_addr_t addr, unsigned int esr)
 	int ret = -ENOENT;
 
 	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
-		ret = ghes_notify_sea();
+		ret = ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
 
 	return ret;
 }
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index de14d49..47fcb0c 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -54,6 +54,21 @@ config ACPI_APEI_SEA
 	  option allows the OS to look for such hardware error record, and
 	  take appropriate action.
 
+config ACPI_APEI_SEI
+	bool "APEI Asynchronous SError Interrupt logging/recovering support"
+	depends on ARM64 && ACPI_APEI_GHES
+	default y
+	help
+	  This option should be enabled if the system supports
+	  firmware first handling of SEI (asynchronous SError interrupt).
+
+	  SEI happens with asynchronous external abort for errors on device
+	  memory reads on ARMv8 systems. If a system supports firmware first
+	  handling of SEI, the platform analyzes and handles hardware error
+	  notifications from SEI, and it may then form a HW error record for
+	  the OS to parse and handle. This option allows the OS to look for
+	  such hardware error record, and take appropriate action.
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3eee30a..24b4233 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -815,43 +815,67 @@ static struct notifier_block ghes_notifier_hed = {
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
+#endif
+
+#ifdef CONFIG_ACPI_APEI_SEI
+static LIST_HEAD(ghes_sei);
+#endif
 
+#if defined(CONFIG_ACPI_APEI_SEA) || defined(CONFIG_ACPI_APEI_SEI)
 /*
- * Return 0 only if one of the SEA error sources successfully reported an error
- * record sent from the firmware.
+ * Return 0 only if one of the SEA or SEI error sources successfully
+ * reported an error record sent from the firmware.
  */
-int ghes_notify_sea(void)
+int ghes_notify_abort(u8 type)
 {
 	struct ghes *ghes;
+	struct list_head *head = NULL;
 	int ret = -ENOENT;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
-		if (!ghes_proc(ghes))
-			ret = 0;
+	if (type == ACPI_HEST_NOTIFY_SEA)
+		head = &ghes_sea;
+	else if (type == ACPI_HEST_NOTIFY_SEI)
+		head = &ghes_sei;
+
+	if (head) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(ghes, head, list) {
+			if (!ghes_proc(ghes))
+				ret = 0;
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 	return ret;
 }
 
-static void ghes_sea_add(struct ghes *ghes)
+static void ghes_abort_add(struct ghes *ghes)
 {
-	mutex_lock(&ghes_list_mutex);
-	list_add_rcu(&ghes->list, &ghes_sea);
-	mutex_unlock(&ghes_list_mutex);
+	struct list_head *head = NULL;
+	u8 notify_type = ghes->generic->notify.type;
+
+	if (notify_type == ACPI_HEST_NOTIFY_SEA)
+		head = &ghes_sea;
+	else if (notify_type == ACPI_HEST_NOTIFY_SEI)
+		head = &ghes_sei;
+
+	if (head) {
+		mutex_lock(&ghes_list_mutex);
+		list_add_rcu(&ghes->list, head);
+		mutex_unlock(&ghes_list_mutex);
+	}
 }
 
-static void ghes_sea_remove(struct ghes *ghes)
+static void ghes_abort_remove(struct ghes *ghes)
 {
 	mutex_lock(&ghes_list_mutex);
 	list_del_rcu(&ghes->list);
 	mutex_unlock(&ghes_list_mutex);
 	synchronize_rcu();
 }
-#else /* CONFIG_ACPI_APEI_SEA */
-static inline void ghes_sea_add(struct ghes *ghes) { }
-static inline void ghes_sea_remove(struct ghes *ghes) { }
-#endif /* CONFIG_ACPI_APEI_SEA */
+#else
+static inline void ghes_abort_add(struct ghes *ghes) { }
+static inline void ghes_abort_remove(struct ghes *ghes) { }
+#endif
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
@@ -1084,6 +1108,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			goto err;
 		}
 		break;
+	case ACPI_HEST_NOTIFY_SEI:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SEI is not supported!\n",
+				generic->header.source_id);
+		goto err;
+	}
+	break;
 	case ACPI_HEST_NOTIFY_NMI:
 		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
 			pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
@@ -1153,7 +1184,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		break;
 
 	case ACPI_HEST_NOTIFY_SEA:
-		ghes_sea_add(ghes);
+	case ACPI_HEST_NOTIFY_SEI:
+		ghes_abort_add(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
@@ -1206,7 +1238,8 @@ static int ghes_remove(struct platform_device *ghes_dev)
 		break;
 
 	case ACPI_HEST_NOTIFY_SEA:
-		ghes_sea_remove(ghes);
+	case ACPI_HEST_NOTIFY_SEI:
+		ghes_abort_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_remove(ghes);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 9061c5c..ec6f4ba 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -118,6 +118,6 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
 	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
 	     section = acpi_hest_get_next(section))
 
-int ghes_notify_sea(void);
+int ghes_notify_abort(u8 type);
 
 #endif /* GHES_H */
-- 
2.10.1
