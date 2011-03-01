From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:08 +0530
Subject: [PATCH V6 08/10] ST SPEAr13xx: add L2 cache support
In-Reply-To: <cover.1298977719.git.viresh.kumar@st.com>
References: <cover.1298977719.git.viresh.kumar@st.com>
Message-ID: <bb253a7e1f4f0a5149a57038d9310ae57e11ead2.1298977719.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/spear13xx.c |   19 ++++++++++++++++++-
 arch/arm/mm/Kconfig                 |    2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 06f9abb..b5da555 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -18,6 +18,7 @@
 #include <asm/irq.h>
 #include <asm/localtimer.h>
 #include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_twd.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
@@ -40,7 +41,16 @@ struct amba_device spear13xx_uart_device = {
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
-	/* nothing to do for now */
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
 }
 
 /* This will initialize vic */
@@ -62,6 +72,13 @@ struct map_desc spear13xx_io_desc[] __initdata = {
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
index e4509ba..fff2d89 100644
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
