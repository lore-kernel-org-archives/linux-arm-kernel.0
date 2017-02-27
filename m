From: shiju.jose@huawei.com (Shiju Jose)
Date: Mon, 27 Feb 2017 18:19:34 +0000
Subject: [RFC PATCH V1 v4.10-rc3 1/1] acpi: apei: handle GSIV notification type
Message-ID: <86258A5CC0A3704780874CF6004BA8A62DCAB57E@lhreml502-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new GHES error source handling function for
GSIV(Global System Interrupt Vector).
If an error source's notification type is GSIV,
then this handling function can be registered
into the GSIV handler and it can parse
and report error information when they occur.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 arch/arm64/Kconfig        |  1 +
 drivers/acpi/apei/Kconfig |  9 +++++++
 drivers/acpi/apei/ghes.c  | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1117421..e41fdcf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -53,6 +53,7 @@ config ARM64
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ACPI_APEI if (ACPI && EFI)
+	select HAVE_ACPI_APEI_GSIV if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index b0140c8..f45ddb5 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -1,6 +1,15 @@
 config HAVE_ACPI_APEI
 	bool
 
+config HAVE_ACPI_APEI_GSIV
+        bool "APEI GSIV(Global System Interrupt) logging/recovering support"
+        depends on ACPI_APEI && ACPI_APEI_GHES
+        help
+          This option should be enabled if the system supports
+          firmware first handling of GSIV (Global System Interrupt)
+	  for the hardware errors and allows OS to do error
+          recovery/logging.
+
 config HAVE_ACPI_APEI_NMI
 	bool
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e53bef6..e1611d2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -721,6 +721,58 @@ static struct notifier_block ghes_notifier_sci = {
 	.notifier_call = ghes_notify_sci,
 };
 
+#ifdef CONFIG_HAVE_ACPI_APEI_GSIV
+static LIST_HEAD(ghes_gsiv);
+
+static int ghes_notify_gsiv(struct notifier_block *this,
+				unsigned long event, void *data)
+{
+	struct ghes *ghes;
+	int ret = NOTIFY_DONE;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, &ghes_gsiv, list) {
+	if (!ghes_proc(ghes))
+		ret = NOTIFY_OK;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+static struct notifier_block ghes_notifier_gsiv = {
+	.notifier_call = ghes_notify_gsiv,
+};
+
+static void ghes_gsiv_add(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	if (list_empty(&ghes_gsiv))
+		register_acpi_hed_notifier(&ghes_notifier_gsiv);
+	list_add_rcu(&ghes->list, &ghes_gsiv);
+	mutex_unlock(&ghes_list_mutex);
+}
+
+static void ghes_gsiv_remove(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	list_del_rcu(&ghes->list);
+	if (list_empty(&ghes_gsiv))
+		unregister_acpi_hed_notifier(&ghes_notifier_gsiv);
+	mutex_unlock(&ghes_list_mutex);
+}
+#else /* CONFIG_HAVE_ACPI_APEI_GSIV */
+static inline void ghes_gsiv_add(struct ghes *ghes)
+{
+	pr_err(GHES_PFX "ID: %d, trying to add GSIV notification which is not supported\n",
+	       ghes->generic->header.source_id);
+}
+
+static inline void ghes_gsiv_remove(struct ghes *ghes)
+{
+	pr_err(GHES_PFX "ID: %d, trying to remove GSIV notification which is not supported\n",
+	       ghes->generic->header.source_id);
+}
+#endif /* CONFIG_HAVE_ACPI_APEI_GSIV */
+
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
  * printk is not safe in NMI context.  So in NMI handler, we allocate
@@ -973,6 +1025,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			goto err;
 		}
 		break;
+	case ACPI_HEST_NOTIFY_GSIV:
+		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_GSIV)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d notified via notification GSIV is not supported\n",
+				generic->header.source_id);
+			rc = -ENOTSUPP;
+			goto err;
+		}
+		break;
 	case ACPI_HEST_NOTIFY_LOCAL:
 		pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			   generic->header.source_id);
@@ -1034,6 +1094,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_GSIV:
+		ghes_gsiv_add(ghes);
+		break;
 	default:
 		BUG();
 	}
@@ -1076,6 +1139,9 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_remove(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_GSIV:
+		ghes_gsiv_remove(ghes);
+		break;
 	default:
 		BUG();
 		break;
-- 
2.1.4
