From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 24 Jan 2017 18:39:50 +0800
Subject: [PATCH 1/2] arm64: arch_timer: acpi: Introduce a generic aquirk
 framework for erratum
In-Reply-To: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1485254391-51551-2-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Introduce a general quirk framework for arch timer erratum in ACPI,
which use the oem information in GTDT table for platform specific
erratums. The struct gtdt_arch_timer_fixup is introduced to record
the oem information to match the quirk and handle the erratum.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2dc571d..80d6f76 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1146,6 +1146,39 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI_GTDT
+struct gtdt_arch_timer_fixup {
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+
+	/* quirk handler for arch timer erratum */
+	void (*handler)(void *context);
+	void *context;
+};
+
+/* note: this needs to be updated according to the doc of OEM ID
+ * and TABLE ID for different board.
+ */
+static struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
+};
+
+static void __init arch_timer_acpi_quirks_handler(char *oem_id,
+						  char *oem_table_id,
+						  u32 oem_revision)
+{
+	struct gtdt_arch_timer_fixup *quirks = arch_timer_quirks;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(arch_timer_quirks); i++, quirks++) {
+		if (!memcmp(quirks->oem_id, oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(quirks->oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    quirks->oem_revision == oem_revision) {
+			if (quirks->handler && quirks->context)
+				quirks->handler(quirks->context);
+		}
+	}
+}
+
 static int __init arch_timer_mem_acpi_init(int platform_timer_count)
 {
 	struct arch_timer_mem *timer_mem;
@@ -1182,6 +1215,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		return -EINVAL;
 	}
 
+	arch_timer_acpi_quirks_handler(table->oem_id, table->oem_table_id,
+				       table->oem_revision);
+
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
 	ret = acpi_gtdt_init(table, &platform_timer_count);
-- 
1.7.12.4
