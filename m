From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 24 Jan 2017 18:39:51 +0800
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Add hisilicon timer specific erratum fixes.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 80d6f76..3e62a09 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1156,10 +1156,32 @@ struct gtdt_arch_timer_fixup {
 	void *context;
 };
 
+#ifdef CONFIG_HISILICON_ERRATUM_161010101
+static void __init hisi_erratum_workaroud_enable(void *context)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
+		if (!strcmp(context, ool_workarounds[i].id)) {
+			timer_unstable_counter_workaround = &ool_workarounds[i];
+			static_branch_enable(&arch_timer_read_ool_enabled);
+			pr_info("arch_timer: Enabling workaround for %s\n",
+				timer_unstable_counter_workaround->id);
+			break;
+		}
+	}
+}
+#endif
+
 /* note: this needs to be updated according to the doc of OEM ID
  * and TABLE ID for different board.
  */
 static struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
+#ifdef CONFIG_HISILICON_ERRATUM_161010101
+	{"HISI  ", "HIP05   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
+	{"HISI  ", "HIP06   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
+	{"HISI  ", "HIP07   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
+#endif
 };
 
 static void __init arch_timer_acpi_quirks_handler(char *oem_id,
-- 
1.7.12.4
