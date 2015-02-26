From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:44 +0900
Subject: [PATCH 4/5] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
In-Reply-To: <cover.1424931398.git.horms+renesas@verge.net.au>
References: <cover.1424931398.git.horms+renesas@verge.net.au>
Message-ID: <3a8e2822e1351c0ef8f9dd1c3e81cd5bfeb319e5.1424931398.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This provides information through SOC_BUS to sysfs.
And this moves all on-SoC devices from /sys/devices/platform to
/sys/devices/socX/.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig           |  1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 38 ++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2f36c85..a7f5ab5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -19,6 +19,7 @@ config ARCH_RCAR_GEN2
 	bool
 	select PM_RCAR if PM || SMP
 	select RENESAS_IRQC
+	select SOC_BUS
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
 
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 6f290a8..9cc2a90 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -26,6 +26,8 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 #include <asm/system_info.h>
 #include <asm/mach/arch.h>
 #include "common.h"
@@ -206,19 +208,47 @@ void __init rcar_gen2_reserve(void)
 }
 
 #define PRR 0xFF000044
-static unsigned int __init rcar_gen2_get_cut(void)
+static u32 __init rcar_gen2_get_prr(void)
 {
 	void __iomem *addr = ioremap_nocache(PRR, 4);
 	u32 data = ioread32(addr);
 
 	iounmap(addr);
 
-	return (data & 0xFF) + 0x10;
+	return data;
 }
 
 void __init rcar_gen2_init_machine(void)
 {
-	system_rev = rcar_gen2_get_cut();
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device *parent = NULL;
+	u32 prr;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		goto out;
+
+	prr = rcar_gen2_get_prr();
+	system_rev = (prr & 0xFF) + 0x10;
+
+	soc_dev_attr->machine = of_flat_dt_get_machine_name();
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Renesas R-Car Gen2");
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u.%u",
+					   system_rev >> 4, system_rev & 0xF);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%04x",
+					 (prr & 0x7F00) >> 8);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+		goto out;
+	}
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	parent = soc_device_to_device(soc_dev);
+out:
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 }
-- 
2.1.4
