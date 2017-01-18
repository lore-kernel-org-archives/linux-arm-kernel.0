From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 18 Jan 2017 20:54:57 +0800
Subject: [PATCH v8 07/15] irqchip: gicv3-its: platform-msi: scan MADT to
 create platform msi domain
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1484744105-53140-8-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

With the introduction of its_pmsi_init_one(), we can add some code
on top for ACPI support of platform MSI.

We are scanning the MADT table to get the ITS entry(ies), then use
the information to create the platform msi domain for devices connect
to it, just like the PCI MSI for ITS did.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 3d9efd1..e4ba9f4 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -103,6 +104,41 @@ static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static int __init
+its_pmsi_parse_madt(struct acpi_subtable_header *header,
+			const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *domain_handle;
+	const char *node_name;
+	int err = -ENXIO;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	node_name = kasprintf(GFP_KERNEL, "ITS at 0x%lx",
+			      (long)its_entry->base_address);
+	domain_handle = iort_find_domain_token(its_entry->translation_id);
+	if (!domain_handle) {
+		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
+		goto out;
+	}
+
+	err = its_pmsi_init_one(domain_handle, node_name);
+
+out:
+	kfree(node_name);
+	return err;
+}
+
+static void __init its_pmsi_acpi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_pmsi_parse_madt, 0);
+}
+#else
+static inline void its_pmsi_acpi_init(void) { }
+#endif
+
 static void __init its_pmsi_of_init(void)
 {
 	struct device_node *np;
@@ -119,6 +155,7 @@ static void __init its_pmsi_of_init(void)
 static int __init its_pmsi_init(void)
 {
 	its_pmsi_of_init();
+	its_pmsi_acpi_init();
 	return 0;
 }
 early_initcall(its_pmsi_init);
-- 
1.7.12.4
