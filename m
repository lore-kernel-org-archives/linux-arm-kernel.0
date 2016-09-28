From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 29 Sep 2016 02:17:17 +0800
Subject: [PATCH v14 9/9] acpi/arm64: Add SBSA Generic Watchdog support in GTDT
 driver
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1475086637-1914-10-git-send-email-fu.wei@linaro.org>
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
---
 drivers/acpi/arm64/gtdt.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/watchdog/Kconfig  |  1 +
 2 files changed, 88 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index b6021db..6d9fdd3 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 
 #include <clocksource/arm_arch_timer.h>
 
@@ -220,3 +221,89 @@ int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
 
 	return index;
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
+	int no_irq = 1;
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
+	if (!wd->timer_interrupt)
+		pr_warn(FW_BUG "failed to get the Watchdog interrupt.\n");
+	else if (irq <= 0)
+		pr_warn("failed to map the Watchdog interrupt.\n");
+	else
+		no_irq = 0;
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
+	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
+	 * info below by matching this name.
+	 */
+	pdev = platform_device_register_simple("sbsa-gwdt", index, res,
+					       ARRAY_SIZE(res) - no_irq);
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
+	struct acpi_table_header *table;
+	void *platform_timer;
+	int index = 0;
+	int ret;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+		return -EINVAL;
+
+	ret = acpi_gtdt_init(table);
+	if (ret <= 0)
+		return ret;
+
+	for_each_platform_timer(platform_timer) {
+		if (!is_watchdog(platform_timer))
+			continue;
+		ret = gtdt_import_sbsa_gwdt(platform_timer, index);
+		if (ret)
+			break;
+		index++;
+	}
+
+	if (index)
+		pr_info("found %d SBSA generic Watchdog(s).\n", index);
+
+	return ret;
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1bffe00..341964a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -205,6 +205,7 @@ config ARM_SBSA_WATCHDOG
 	tristate "ARM SBSA Generic Watchdog"
 	depends on ARM64
 	depends on ARM_ARCH_TIMER
+	depends on ACPI_GTDT || !ACPI
 	select WATCHDOG_CORE
 	help
 	  ARM SBSA Generic Watchdog has two stage timeouts:
-- 
2.7.4
