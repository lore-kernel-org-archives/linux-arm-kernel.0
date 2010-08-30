From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:16 +0530
Subject: [PATCH 53/74] ST SPEAr13xx: add l2 cache support
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <6cba9ad18feace456f25c764f4a60051ddb14991.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/spear1300_evb.c |   13 +++++++++++++
 arch/arm/mach-spear13xx/spear13xx.c     |    7 +++++++
 arch/arm/mm/Kconfig                     |    2 +-
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 5756a8c..95e25b7 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -26,6 +26,8 @@
 #include <plat/nand.h>
 #include <plat/smi.h>
 #include <plat/spi.h>
+#include <mach/hardware.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
 
@@ -132,6 +134,17 @@ static int spear1300_pcie_port_is_host(int port)
 
 static void __init spear1300_evb_init(void)
 {
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * 256KB (16KB/way), 16-way associativity, parity not
+	 * supported
+	 * TODO: 0x249, picked from nomadik, to be analyzed
+	 * Comment from nomadik:
+	 * At full speed latency must be >=2, so 0x249 in low bits
+	 */
+	l2x0_init(__io_address(SPEAR13XX_L2CC_BASE), 0x00260249, 0xfe00ffff);
+#endif
+
 	/* set keyboard plat data */
 	kbd_set_plat_data(&kbd_device, &kbd_data);
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 01cb76c..0f42522 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -538,6 +538,13 @@ struct map_desc spear13xx_io_desc[] __initdata = {
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
index 33c3f57..cb0a30e 100644
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
