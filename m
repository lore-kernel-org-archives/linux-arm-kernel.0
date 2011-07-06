From: avorontsov@mvista.com (Anton Vorontsov)
Date: Wed, 6 Jul 2011 18:08:32 +0400
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
Message-ID: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNS3xxx SOCs have L310-compatible cache controller, so let's use it.

With this patch benchmarking with 'gzip' shows that performance is
doubled, and I'm still able to boot full-fledged userland over NFS
(using PCIe NIC), so the support should be pretty robust.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---

I'm going to apply it to linux-cns3xxx.git tree and push it (via Arnd)
for v3.1 , if there will be no complains, of course.

Thanks,

 arch/arm/mach-cns3xxx/cns3420vb.c |    2 +
 arch/arm/mach-cns3xxx/core.c      |   39 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-cns3xxx/core.h      |    1 +
 arch/arm/mm/Kconfig               |    2 +-
 4 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 08e5c87..4b804ba 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -170,6 +170,8 @@ static struct platform_device *cns3420_pdevs[] __initdata = {
 
 static void __init cns3420_init(void)
 {
+	cns3xxx_l2x0_init();
+
 	platform_add_devices(cns3420_pdevs, ARRAY_SIZE(cns3420_pdevs));
 
 	cns3xxx_ahci_init();
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index da30078..49f3a51 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -16,6 +16,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <mach/cns3xxx.h>
 #include "core.h"
 
@@ -244,3 +245,41 @@ static void __init cns3xxx_timer_init(void)
 struct sys_timer cns3xxx_timer = {
 	.init = cns3xxx_timer_init,
 };
+
+void __init cns3xxx_l2x0_init(void)
+{
+	void __iomem *base = ioremap(CNS3XXX_L2C_BASE, SZ_4K);
+	u32 val;
+
+	if (WARN_ON(!base))
+		return;
+
+	/*
+	 * Tag RAM Control register
+	 *
+	 * bit[10:8]	- 1 cycle of write accesses latency
+	 * bit[6:4]	- 1 cycle of read accesses latency
+	 * bit[3:0]	- 1 cycle of setup latency
+	 *
+	 * 1 cycle of latency for setup, read and write accesses
+	 */
+	val = readl(base + L2X0_TAG_LATENCY_CTRL);
+	val &= 0xfffff888;
+	writel(val, base + L2X0_TAG_LATENCY_CTRL);
+
+	/*
+	 * Data RAM Control register
+	 *
+	 * bit[10:8]	- 1 cycles of write accesses latency
+	 * bit[6:4]	- 1 cycles of read accesses latency
+	 * bit[3:0]	- 1 cycle of setup latency
+	 *
+	 * 1 cycle of setup latency, 2 cycles of read and write accesses latency
+	 */
+	val = readl(base + L2X0_DATA_LATENCY_CTRL);
+	val &= 0xfffff888;
+	writel(val, base + L2X0_DATA_LATENCY_CTRL);
+
+	/* 32 KiB, 8-way, parity disable */
+	l2x0_init(base, 0x00540000, 0xfe000fff);
+}
diff --git a/arch/arm/mach-cns3xxx/core.h b/arch/arm/mach-cns3xxx/core.h
index ffeb3a8..13635ca 100644
--- a/arch/arm/mach-cns3xxx/core.h
+++ b/arch/arm/mach-cns3xxx/core.h
@@ -14,6 +14,7 @@
 extern struct sys_timer cns3xxx_timer;
 
 void __init cns3xxx_map_io(void);
+void __init cns3xxx_l2x0_init(void);
 void __init cns3xxx_init_irq(void);
 void cns3xxx_power_off(void);
 
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 0074b8d..cb26d49 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -821,7 +821,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
+		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || ARCH_CNS3XXX
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.7.5.3
