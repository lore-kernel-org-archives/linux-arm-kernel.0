From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 14 Jul 2011 21:10:53 +0400
Subject: [GIT PULL] ARM: Cavium CNS3xxx updates for 3.1
Message-ID: <20110714171053.GA8580@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull linux-cns3xxx.git tree to receive updates for CNS3xxx.
There are just two patches: the first patch corrects CPU type, and
the second adds L2 cache controller support, which doubles the
performance.

For the second patch, I fixed all the comments, plus added some
notes regarding why we don't want to select CACHE_PL310 for CNS3xxx.

For convenience' sake I inline the patches here, they're pretty
small.

Thanks!

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.infradead.org/users/cbou/linux-cns3xxx.git master

Anton Vorontsov (1):
      ARM: cns3xxx: Add support for L2 Cache Controller

Imre Kaloz (1):
      ARM: cns3xxx: Should select CPU_V6K

 arch/arm/Kconfig                  |    2 +-
 arch/arm/mach-cns3xxx/cns3420vb.c |    2 +
 arch/arm/mach-cns3xxx/core.c      |   43 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-cns3xxx/core.h      |    6 +++++
 arch/arm/mm/Kconfig               |    2 +-
 5 files changed, 53 insertions(+), 2 deletions(-)



commit 93e85d8e902e1a4468c6ade5c6ec3dd3055a489f
Author: Anton Vorontsov <avorontsov@mvista.com>
Date:   Wed Jul 6 16:45:09 2011 +0400

    ARM: cns3xxx: Add support for L2 Cache Controller
    
    CNS3xxx SOCs have L310-compatible cache controller, so let's use it.
    
    With this patch benchmarking with 'gzip' shows that performance is
    doubled, and I'm still able to boot full-fledged userland over NFS
    (using PCIe NIC), so the support should be pretty robust.
    
    p.s. While CNS3xxx reports that it has PL310, it still needs to wait
    on cache line operations, so we should not select 'CACHE_PL310',
    which is a micro-optimization that removes these waits for v7 CPUs.
    Someday we'd better rename CACHE_PL310 Kconfig option into
    NO_CACHE_WAIT or something less ambiguous.
    
    Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

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
index da30078..941a308 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -16,6 +16,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <mach/cns3xxx.h>
 #include "core.h"
 
@@ -244,3 +245,45 @@ static void __init cns3xxx_timer_init(void)
 struct sys_timer cns3xxx_timer = {
 	.init = cns3xxx_timer_init,
 };
+
+#ifdef CONFIG_CACHE_L2X0
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
+	 * 1 cycle of latency for setup, read and write accesses
+	 */
+	val = readl(base + L2X0_DATA_LATENCY_CTRL);
+	val &= 0xfffff888;
+	writel(val, base + L2X0_DATA_LATENCY_CTRL);
+
+	/* 32 KiB, 8-way, parity disable */
+	l2x0_init(base, 0x00540000, 0xfe000fff);
+}
+
+#endif /* CONFIG_CACHE_L2X0 */
diff --git a/arch/arm/mach-cns3xxx/core.h b/arch/arm/mach-cns3xxx/core.h
index ffeb3a8..fcd2253 100644
--- a/arch/arm/mach-cns3xxx/core.h
+++ b/arch/arm/mach-cns3xxx/core.h
@@ -13,6 +13,12 @@
 
 extern struct sys_timer cns3xxx_timer;
 
+#ifdef CONFIG_CACHE_L2X0
+void __init cns3xxx_l2x0_init(void);
+#else
+static inline void cns3xxx_l2x0_init(void) {}
+#endif /* CONFIG_CACHE_L2X0 */
+
 void __init cns3xxx_map_io(void);
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

commit 00d2711d700ae77b5bb66ea7c73eaa2cf155fa97
Author: Imre Kaloz <kaloz@openwrt.org>
Date:   Thu Jul 7 12:19:09 2011 +0200

    ARM: cns3xxx: Should select CPU_V6K
    
    CNS3XXX is based on MPCore, so select the right CPU option for it.
    
    Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
    Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..c2e5f3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -321,7 +321,7 @@ config ARCH_CLPS711X
 
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
-	select CPU_V6
+	select CPU_V6K
 	select GENERIC_CLOCKEVENTS
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
