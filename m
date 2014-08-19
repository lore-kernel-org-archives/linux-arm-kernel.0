From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 19 Aug 2014 16:31:15 +0400
Subject: [PATCH 3/3] ARM: clps711x: Add SOC BUS support
In-Reply-To: <1408451475-1140-1-git-send-email-shc_work@mail.ru>
References: <1408451475-1140-1-git-send-email-shc_work@mail.ru>
Message-ID: <1408451475-1140-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SOC BUS support with CPU family, machine name and unique ID.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                 |  1 +
 arch/arm/mach-clps711x/devices.c | 52 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32cbbd5..27a5c5b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -387,6 +387,7 @@ config ARCH_CLPS711X
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
 	select MFD_SYSCON
+	select SOC_BUS
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
 
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 0c689d3..77a9617 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -1,7 +1,7 @@
 /*
  *  CLPS711X common devices definitions
  *
- *  Author: Alexander Shiyan <shc_work@mail.ru>, 2013
+ *  Author: Alexander Shiyan <shc_work@mail.ru>, 2013-2014
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -9,8 +9,15 @@
  * (at your option) any later version.
  */
 
+#include <linux/io.h>
+#include <linux/of_fdt.h>
 #include <linux/platform_device.h>
+#include <linux/random.h>
 #include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#include <asm/system_info.h>
 
 #include <mach/hardware.h>
 
@@ -90,10 +97,53 @@ static void __init clps711x_add_uart(void)
 					ARRAY_SIZE(clps711x_uart2_res));
 };
 
+static void __init clps711x_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	void __iomem *base;
+	u32 id[5];
+
+	base = ioremap(CLPS711X_PHYS_BASE, SZ_32K);
+	if (!base)
+		return;
+
+	id[0] = readl(base + UNIQID);
+	id[1] = readl(base + RANDID0);
+	id[2] = readl(base + RANDID1);
+	id[3] = readl(base + RANDID2);
+	id[4] = readl(base + RANDID3);
+	system_rev = SYSFLG1_VERID(readl(base + SYSFLG1));
+
+	add_device_randomness(id, sizeof(id));
+
+	system_serial_low = id[0];
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		goto out_unmap;
+
+	soc_dev_attr->machine = of_flat_dt_get_machine_name();
+	soc_dev_attr->family = "Cirrus Logic CLPS711X";
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u", system_rev);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%08x", id[0]);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+	}
+
+out_unmap:
+	iounmap(base);
+}
+
 void __init clps711x_devices_init(void)
 {
 	clps711x_add_cpuidle();
 	clps711x_add_gpio();
 	clps711x_add_syscon();
 	clps711x_add_uart();
+	clps711x_soc_init();
 }
-- 
1.8.5.5
