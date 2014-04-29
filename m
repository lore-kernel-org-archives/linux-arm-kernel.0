From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 29 Apr 2014 21:34:30 +0800
Subject: [PATCH v2] ARM: prima2: remove L2 cache size override
Message-ID: <1398778470-4689-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

L2 cache size has been read by l2x0_init(), it is useless to set
WAY_SIZE and ASSOCIATIVITY in prima2.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2: move l2x0_of_init to init_irq;
 drop UL and move to lower case

 arch/arm/boot/dts/marco.dtsi  |    2 +-
 arch/arm/boot/dts/prima2.dtsi |    2 +-
 arch/arm/mach-prima2/Makefile |    1 -
 arch/arm/mach-prima2/common.c |   15 ++++++++++--
 arch/arm/mach-prima2/l2x0.c   |   49 -----------------------------------------
 5 files changed, 14 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-prima2/l2x0.c

diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
index 0c9647d..fb35422 100644
--- a/arch/arm/boot/dts/marco.dtsi
+++ b/arch/arm/boot/dts/marco.dtsi
@@ -36,7 +36,7 @@
 		ranges = <0x40000000 0x40000000 0xa0000000>;
 
 		l2-cache-controller at c0030000 {
-			compatible = "sirf,marco-pl310-cache", "arm,pl310-cache";
+			compatible = "arm,pl310-cache";
 			reg = <0xc0030000 0x1000>;
 			interrupts = <0 59 0>;
 			arm,tag-latency = <1 1 1>;
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 1e82571..0d6588d 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -48,7 +48,7 @@
 		ranges = <0x40000000 0x40000000 0x80000000>;
 
 		l2-cache-controller at 80040000 {
-			compatible = "arm,pl310-cache", "sirf,prima2-pl310-cache";
+			compatible = "arm,pl310-cache";
 			reg = <0x80040000 0x1000>;
 			interrupts = <59>;
 			arm,tag-latency = <1 1 1>;
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index 7a6b4a3..8846e7d 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -2,7 +2,6 @@ obj-y += rstc.o
 obj-y += common.o
 obj-y += rtciobrg.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
-obj-$(CONFIG_CACHE_L2X0) += l2x0.o
 obj-$(CONFIG_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_SMP) += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)  += hotplug.o
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 47c7819..62ff2de 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -8,11 +8,11 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <asm/sizes.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/irqchip.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/arch.h>
 #include "common.h"
 
 static void __init sirfsoc_init_late(void)
@@ -26,6 +26,12 @@ static __init void sirfsoc_map_io(void)
 	sirfsoc_map_scu();
 }
 
+static __init void sirfsoc_init_irq(void)
+{
+	l2x0_of_init(0, 0xfdffffff);
+	irqchip_init();
+}
+
 #ifdef CONFIG_ARCH_ATLAS6
 static const char *atlas6_dt_match[] __initconst = {
 	"sirf,atlas6",
@@ -35,6 +41,7 @@ static const char *atlas6_dt_match[] __initconst = {
 DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_io,
+	.init_irq   = sirfsoc_init_irq,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
 MACHINE_END
@@ -50,6 +57,7 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_io,
 	.dma_zone_size	= SZ_256M,
+	.init_irq   = sirfsoc_init_irq,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2_dt_match,
 MACHINE_END
@@ -65,6 +73,7 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.smp            = smp_ops(sirfsoc_smp_ops),
 	.map_io         = sirfsoc_map_io,
+	.init_irq   = sirfsoc_init_irq,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
 MACHINE_END
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
deleted file mode 100644
index c710253..0000000
--- a/arch/arm/mach-prima2/l2x0.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * l2 cache initialization for CSR SiRFprimaII
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <asm/hardware/cache-l2x0.h>
-
-struct l2x0_aux {
-	u32 val;
-	u32 mask;
-};
-
-static const struct l2x0_aux prima2_l2x0_aux __initconst = {
-	.val = 2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT,
-	.mask =	0,
-};
-
-static const struct l2x0_aux marco_l2x0_aux __initconst = {
-	.val = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
-		(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
-	.mask = L2X0_AUX_CTRL_MASK,
-};
-
-static const struct of_device_id sirf_l2x0_ids[] __initconst = {
-	{ .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
-	{ .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
-	{},
-};
-
-static int __init sirfsoc_l2x0_init(void)
-{
-	struct device_node *np;
-	const struct l2x0_aux *aux;
-
-	np = of_find_matching_node(NULL, sirf_l2x0_ids);
-	if (np) {
-		aux = of_match_node(sirf_l2x0_ids, np)->data;
-		return l2x0_of_init(aux->val, aux->mask);
-	}
-
-	return 0;
-}
-early_initcall(sirfsoc_l2x0_init);
-- 
1.7.5.4
