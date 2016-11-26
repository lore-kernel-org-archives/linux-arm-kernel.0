From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 26 Nov 2016 16:00:48 +0800
Subject: [PATCH v4 6/6] arm64: arch_timer: acpi: add hisi timer errata data
In-Reply-To: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
References: <1480147248-12828-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1480147248-12828-7-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Add hisi timer specific erratum fixes.

v3: add hisilicon erratum 161601 for ACPI mode.

v4: update some data structures.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d4f4a0d..649f7fe 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1078,10 +1078,28 @@ struct gtdt_arch_timer_fixup {
 	void *context;
 };
 
+#ifdef CONFIG_HISILICON_ERRATUM_161601
+static void __init erratum_workaround_enable(void *context)
+{
+	u64 erratum = (u64) context;
+
+	if (erratum & HISILICON_161601) {
+		timer_unstable_counter_workaround = &arch_timer_hisi_161601;
+		static_branch_enable(&arch_timer_read_ool_enabled);
+		pr_info("Enabling workaround for HISILICON ERRATUM 161601\n");
+	}
+}
+#endif
+
 /* note: this needs to be updated according to the doc of OEM ID
  * and TABLE ID for different board.
  */
 struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
+#ifdef CONFIG_HISILICON_ERRATUM_161601
+	{"HISI", "hip05", 0, &erratum_workaround_enable, (void *) HISILICON_161601},
+	{"HISI", "hip06", 0, &erratum_workaround_enable, (void *) HISILICON_161601},
+	{"HISI", "hip07", 0, &erratum_workaround_enable, (void *) HISILICON_161601},
+#endif
 };
 
 void __init arch_timer_acpi_quirks_handler(char *oem_id,
-- 
1.9.0
