From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:42:08 +0530
Subject: [PATCH V4 41/62] ST SPEAr13xx: add L2 cache support
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <ac9479e372e85867307dd545e6d07d2450350bee.1295333959.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/spear13xx.c |   19 +++++++++++++++++++
 arch/arm/mm/Kconfig                 |    2 +-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 8cdb37e..b6936c5 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -21,6 +21,7 @@
 #include <asm/irq.h>
 #include <asm/localtimer.h>
 #include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_twd.h>
 #include <mach/irqs.h>
 #include <mach/generic.h>
@@ -393,6 +394,17 @@ struct platform_device spear13xx_sdhci_device = {
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * 512KB (64KB/way), 8-way associativity, parity supported
+	 *
+	 * TODO: 0x249, picked from nomadik, to be analyzed
+	 * Comment from nomadik:
+	 * At full speed latency must be >=2, so 0x249 in low bits
+	 */
+	l2x0_init(__io_address(SPEAR13XX_L2CC_BASE), 0x00260249, 0xfe00ffff);
+#endif
+
 	sdhci_enable();
 }
 
@@ -415,6 +427,13 @@ struct map_desc spear13xx_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(SPEAR13XX_A9SM_PERIP_BASE),
 		.length		= SZ_8K,
 		.type		= MT_DEVICE
+#ifdef CONFIG_CACHE_L2X0
+	}, {
+		.virtual	= IO_ADDRESS(SPEAR13XX_L2CC_BASE),
+		.pfn		= __phys_to_pfn(SPEAR13XX_L2CC_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+#endif
 	}, {
 		.virtual	= IO_ADDRESS(SPEAR13XX_MISC_BASE),
 		.pfn		= __phys_to_pfn(SPEAR13XX_MISC_BASE),
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9d30c6f..d4d967b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -813,7 +813,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_S5PV310 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
+		   ARCH_SPEAR13XX || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.7.2.2
