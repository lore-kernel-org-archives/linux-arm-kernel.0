From: dahuang@nvidia.com (Danny Huang)
Date: Tue, 12 Mar 2013 20:01:07 +0800
Subject: [PATCH v2] ARM: tegra: expose chip ID and revision
Message-ID: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose Tegra chip ID and revision in /sys/devices/soc for user mode
usage

Signed-off-by: Danny Huang <dahuang@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig  |  3 +++
 arch/arm/mach-tegra/common.c | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index d1c4893..b7abcfa 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -17,6 +17,7 @@ config ARCH_TEGRA_2x_SOC
 	select PINCTRL_TEGRA20
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_BUS
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
@@ -36,6 +37,7 @@ config ARCH_TEGRA_3x_SOC
 	select PINCTRL
 	select PINCTRL_TEGRA30
 	select PL310_ERRATA_769419 if CACHE_L2X0
+	select SOC_BUS
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
@@ -51,6 +53,7 @@ config ARCH_TEGRA_114_SOC
 	select CPU_V7
 	select PINCTRL
 	select PINCTRL_TEGRA114
+	select SOC_BUS
 	help
 	  Support for NVIDIA Tegra T114 processor family, based on the
 	  ARM CortexA15MP CPU
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index f0315c9..9547c59 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -23,6 +23,8 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/irqchip.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 #include <linux/clk/tegra.h>
 
 #include <asm/hardware/cache-l2x0.h>
@@ -94,6 +96,26 @@ static void __init tegra_init_cache(void)
 
 }
 
+void __init tegra_soc_device_init(void)
+{
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return;
+
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%d", tegra_chip_id);
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d", tegra_revision);
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Tegra");
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR_OR_NULL(soc_dev))
+		kfree(soc_dev_attr);
+
+	return;
+}
+
 void __init tegra_init_early(void)
 {
 	tegra_cpu_reset_handler_init();
@@ -108,4 +130,5 @@ void __init tegra_init_early(void)
 void __init tegra_init_late(void)
 {
 	tegra_powergate_debugfs_init();
+	tegra_soc_device_init();
 }
-- 
1.8.1.5
