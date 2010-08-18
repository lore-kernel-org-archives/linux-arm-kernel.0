From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:00:14 +0900
Subject: [PATCH] ARM: S5PV310: Add CMU for S5PV310 Clock
Message-ID: <1282140014-10230-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CMU block for easily handling S5PV310 clock.
(CMU: Clock Management Unit)
Of course, changed current clock addresses for it.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c                     |    7 ++-
 arch/arm/mach-s5pv310/include/mach/map.h        |    2 +
 arch/arm/mach-s5pv310/include/mach/regs-clock.h |   59 +++++++++++------------
 arch/arm/plat-s5p/include/plat/map-s5p.h        |    1 +
 4 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index 196c9f1..2b74295 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -45,7 +45,12 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S5PV310_PA_L2CC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
-	},
+	}, {
+		.virtual	= (unsigned long)S5P_VA_CMU,
+		.pfn		= __phys_to_pfn(S5PV310_PA_CMU),
+		.length		= SZ_128K,
+		.type		= MT_DEVICE,
+	}
 };
 
 static void s5pv310_idle(void)
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 87697c9..5aa89eb 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -29,6 +29,8 @@
 #define S5PV310_PA_SYSCON		(0x10020000)
 #define S5P_PA_SYSCON			S5PV310_PA_SYSCON
 
+#define S5PV310_PA_CMU			(0x10030000)
+
 #define S5PV310_PA_WATCHDOG		(0x10060000)
 
 #define S5PV310_PA_COMBINER		(0x10448000)
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-clock.h b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
index 59e3a7e..7727b45 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
@@ -15,48 +15,47 @@
 
 #include <mach/map.h>
 
-#define S5P_CLKREG(x)			(S3C_VA_SYS + (x))
+#define S5P_CLKREG(x)			(S5P_VA_CMU + (x))
 
 #define S5P_INFORM0			S5P_CLKREG(0x800)
 
-#define S5P_EPLL_CON0			S5P_CLKREG(0x1C110)
-#define S5P_EPLL_CON1			S5P_CLKREG(0x1C114)
-#define S5P_VPLL_CON0			S5P_CLKREG(0x1C120)
-#define S5P_VPLL_CON1			S5P_CLKREG(0x1C124)
+#define S5P_EPLL_CON0			S5P_CLKREG(0x0C110)
+#define S5P_EPLL_CON1			S5P_CLKREG(0x0C114)
+#define S5P_VPLL_CON0			S5P_CLKREG(0x0C120)
+#define S5P_VPLL_CON1			S5P_CLKREG(0x0C124)
 
-#define S5P_CLKSRC_TOP0			S5P_CLKREG(0x1C210)
-#define S5P_CLKSRC_TOP1			S5P_CLKREG(0x1C214)
+#define S5P_CLKSRC_TOP0			S5P_CLKREG(0x0C210)
+#define S5P_CLKSRC_TOP1			S5P_CLKREG(0x0C214)
 
-#define S5P_CLKSRC_PERIL0		S5P_CLKREG(0x1C250)
+#define S5P_CLKSRC_PERIL0		S5P_CLKREG(0x0C250)
 
-#define S5P_CLKDIV_TOP			S5P_CLKREG(0x1C510)
+#define S5P_CLKDIV_TOP			S5P_CLKREG(0x0C510)
 
-#define S5P_CLKDIV_PERIL0		S5P_CLKREG(0x1C550)
-#define S5P_CLKDIV_PERIL1		S5P_CLKREG(0x1C554)
-#define S5P_CLKDIV_PERIL2		S5P_CLKREG(0x1C558)
-#define S5P_CLKDIV_PERIL3		S5P_CLKREG(0x1C55C)
-#define S5P_CLKDIV_PERIL4		S5P_CLKREG(0x1C560)
-#define S5P_CLKDIV_PERIL5		S5P_CLKREG(0x1C564)
+#define S5P_CLKDIV_PERIL0		S5P_CLKREG(0x0C550)
+#define S5P_CLKDIV_PERIL1		S5P_CLKREG(0x0C554)
+#define S5P_CLKDIV_PERIL2		S5P_CLKREG(0x0C558)
+#define S5P_CLKDIV_PERIL3		S5P_CLKREG(0x0C55C)
+#define S5P_CLKDIV_PERIL4		S5P_CLKREG(0x0C560)
+#define S5P_CLKDIV_PERIL5		S5P_CLKREG(0x0C564)
 
-#define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x1C950)
+#define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x0C950)
 
-#define S5P_CLKSRC_CORE			S5P_CLKREG(0x20200)
+#define S5P_CLKSRC_CORE			S5P_CLKREG(0x10200)
+#define S5P_CLKDIV_CORE0		S5P_CLKREG(0x10500)
 
-#define S5P_CLKDIV_CORE0		S5P_CLKREG(0x20500)
+#define S5P_APLL_LOCK			S5P_CLKREG(0x14000)
+#define S5P_MPLL_LOCK			S5P_CLKREG(0x14004)
+#define S5P_APLL_CON0			S5P_CLKREG(0x14100)
+#define S5P_APLL_CON1			S5P_CLKREG(0x14104)
+#define S5P_MPLL_CON0			S5P_CLKREG(0x14108)
+#define S5P_MPLL_CON1			S5P_CLKREG(0x1410C)
 
-#define S5P_APLL_LOCK			S5P_CLKREG(0x24000)
-#define S5P_MPLL_LOCK			S5P_CLKREG(0x24004)
-#define S5P_APLL_CON0			S5P_CLKREG(0x24100)
-#define S5P_APLL_CON1			S5P_CLKREG(0x24104)
-#define S5P_MPLL_CON0			S5P_CLKREG(0x24108)
-#define S5P_MPLL_CON1			S5P_CLKREG(0x2410C)
+#define S5P_CLKSRC_CPU			S5P_CLKREG(0x14200)
+#define S5P_CLKMUX_STATCPU		S5P_CLKREG(0x14400)
 
-#define S5P_CLKSRC_CPU			S5P_CLKREG(0x24200)
-#define S5P_CLKMUX_STATCPU		S5P_CLKREG(0x24400)
+#define S5P_CLKDIV_CPU			S5P_CLKREG(0x14500)
+#define S5P_CLKDIV_STATCPU		S5P_CLKREG(0x14600)
 
-#define S5P_CLKDIV_CPU			S5P_CLKREG(0x24500)
-#define S5P_CLKDIV_STATCPU		S5P_CLKREG(0x24600)
-
-#define S5P_CLKGATE_SCLKCPU		S5P_CLKREG(0x24800)
+#define S5P_CLKGATE_SCLKCPU		S5P_CLKREG(0x14800)
 
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 54e9fb9..5897792 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -29,6 +29,7 @@
 #define S5P_VA_GIC_DIST		S5P_VA_COREPERI(0x1000)
 
 #define S5P_VA_L2CC		S3C_ADDR(0x00900000)
+#define S5P_VA_CMU		S3C_ADDR(0x00920000)
 
 #define S5P_VA_UART(x)		(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 #define S5P_VA_UART0		S5P_VA_UART(0)
-- 
1.6.2.5
