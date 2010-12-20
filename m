From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 20 Dec 2010 13:56:03 +0530
Subject: [PATCH V3 43/63] ST SPEAr13xx: add L2 cache support
In-Reply-To: <cover.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
Message-ID: <6757a7a44dfe4836d2cd3fb09ec127e1aafc8378.1292833229.git.viresh.kumar@st.com>
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
index 2a37a0d..1bf8f12 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -22,6 +22,7 @@
 #include <asm/irq.h>
 #include <asm/localtimer.h>
 #include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_twd.h>
 #include <mach/irqs.h>
 #include <mach/generic.h>
@@ -413,6 +414,17 @@ struct platform_device spear13xx_sdhci_device = {
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
 
@@ -435,6 +447,13 @@ struct map_desc spear13xx_io_desc[] __initdata = {
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
index 4414a01..d853063 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -772,7 +772,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_S5PV310 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+		   ARCH_SPEAR13XX || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.7.2.2
