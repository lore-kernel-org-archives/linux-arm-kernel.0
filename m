From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu,  3 Apr 2014 09:01:04 +0800
Subject: [PATCH v2 1/2] ARM: hisi: enable L2 driver
In-Reply-To: <20140402170034.GK7528@n2100.arm.linux.org.uk>
References: <20140402170034.GK7528@n2100.arm.linux.org.uk>
Message-ID: <1396486864-13813-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

l2x0_of_init() is necessary to enable PL310 L2 cache controller.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/hisilicon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 741faf3..5877e7d 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/proc-fns.h>
 
 #include <asm/mach/arch.h>
@@ -51,6 +52,12 @@ static void __init hi3620_map_io(void)
 	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
 }
 
+static void __init hi3xxx_init(void)
+{
+	l2x0_of_init(0, ~0);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static void hi3xxx_restart(enum reboot_mode mode, const char *cmd)
 {
 	struct device_node *np;
@@ -86,5 +93,6 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.map_io		= hi3620_map_io,
 	.dt_compat	= hi3xxx_compat,
 	.smp		= smp_ops(hi3xxx_smp_ops),
+	.init_machine	= hi3xxx_init,
 	.restart	= hi3xxx_restart,
 MACHINE_END
-- 
1.8.3.2
