From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 26 Nov 2016 16:00:47 +0800
Subject: [PATCH v4 5/6] arm64: arch_timer: apci: Introduce a generic aquirk
 framework for erratum
In-Reply-To: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
References: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1480147248-12828-6-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Introduce a general quirk framework for each timer erratum in ACPI,
which use the oem information in GTDT table for platform specific erratums.
The struct gtdt_arch_timer_fixup is introduced to record the oem
information to match the quirk and handle the erratum.

v3: Introduce a generic aquick framework for erratum in ACPI mode.

v4: rename the quirk handler parameter to make it more generic, and
    avoid break loop when handling the quirk becasue it need to
    support multi quirks handler.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3d59af1..d4f4a0d 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1068,6 +1068,39 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		       arch_timer_mem_init);
 
 #ifdef CONFIG_ACPI
+struct gtdt_arch_timer_fixup {
+	char oem_id[ACPI_OEM_ID_SIZE];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
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
+struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
+};
+
+void __init arch_timer_acpi_quirks_handler(char *oem_id,
+					   char *oem_table_id,
+					   u32 oem_revision)
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
 static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 {
 	int trigger, polarity;
@@ -1094,6 +1127,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		return -EINVAL;
 	}
 
+	arch_timer_acpi_quirks_handler(table->oem_id, table->oem_table_id,
+				       table->oem_revision);
+
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 
 	arch_timers_present |= ARCH_CP15_TIMER;
-- 
1.9.0
