From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 22 Mar 2017 00:31:22 +0800
Subject: [PATCH v22 11/11] acpi/arm64: Add SBSA Generic Watchdog support in
 GTDT driver
In-Reply-To: <20170321163122.9183-1-fu.wei@linaro.org>
References: <20170321163122.9183-1-fu.wei@linaro.org>
Message-ID: <20170321163122.9183-12-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing SBSA Generic Watchdog timer
in GTDT, parse all info in SBSA Generic Watchdog Structure in GTDT,
and creating a platform device with that information.

This allows the operating system to obtain device data from the
resource of platform device. The platform device named "sbsa-gwdt"
can be used by the ARM SBSA Generic Watchdog driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/arm64/gtdt.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index f471873..5d167f0 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 
 #include <clocksource/arm_arch_timer.h>
 
@@ -59,6 +60,17 @@ static inline bool is_timer_block(void *platform_timer)
 	return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
 }
 
+static inline bool is_non_secure_watchdog(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+	struct acpi_gtdt_watchdog *wd = platform_timer;
+
+	if (gh->type != ACPI_GTDT_TYPE_WATCHDOG)
+		return false;
+
+	return !(wd->timer_flags & ACPI_GTDT_WATCHDOG_SECURE);
+}
+
 static int __init map_gt_gsi(u32 interrupt, u32 flags)
 {
 	int trigger, polarity;
@@ -285,3 +297,85 @@ int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
 
 	return 0;
 }
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ */
+static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
+					int index)
+{
+	struct platform_device *pdev;
+	int irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
+
+	/*
+	 * According to SBSA specification the size of refresh and control
+	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 ? 0xFFF).
+	 */
+	struct resource res[] = {
+		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
+		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
+		DEFINE_RES_IRQ(irq),
+	};
+	int nr_res = ARRAY_SIZE(res);
+
+	pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
+		 wd->refresh_frame_address, wd->control_frame_address,
+		 wd->timer_interrupt, wd->timer_flags);
+
+	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
+		pr_err(FW_BUG "failed to get the Watchdog base address.\n");
+		return -EINVAL;
+	}
+
+	if (irq <= 0) {
+		pr_warn("failed to map the Watchdog interrupt.\n");
+		nr_res--;
+	}
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
+	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
+	 * info below by matching this name.
+	 */
+	pdev = platform_device_register_simple("sbsa-gwdt", index, res, nr_res);
+	if (IS_ERR(pdev)) {
+		acpi_unregister_gsi(wd->timer_interrupt);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+static int __init gtdt_sbsa_gwdt_init(void)
+{
+	int ret, i = 0;
+	void *platform_timer;
+	struct acpi_table_header *table;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+		return -EINVAL;
+
+	ret = acpi_gtdt_init(table, NULL);
+	if (ret)
+		return ret;
+
+	for_each_platform_timer(platform_timer) {
+		if (is_non_secure_watchdog(platform_timer)) {
+			ret = gtdt_import_sbsa_gwdt(platform_timer, i);
+			if (ret)
+				break;
+			i++;
+		}
+	}
+
+	if (i)
+		pr_info("found %d SBSA generic Watchdog(s).\n", i);
+
+	return ret;
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
-- 
2.9.3
