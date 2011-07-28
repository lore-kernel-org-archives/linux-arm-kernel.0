From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 28 Jul 2011 14:34:51 +0200
Subject: [PATCH 5/5] ARM: s3c64xx: Add support for synchronous clock
 operation.
Message-ID: <mailman.47.1311955663.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards based on S3C6410 use synchronous clocking, which means that HCLKx2
and other system clocks are generated from APLL instead of MPLL.

This patch adds support for such boards, by calculating hclk2 depending on
the status of S3C_OTHERS_SYNCMUXSEL_SYNC bit in S3C_OTHERS registers.

---
 arch/arm/mach-s3c64xx/clock.c                   |    8 +++++++-
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    4 ++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index fdfc4d5..56421ab 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -780,7 +780,13 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 	printk(KERN_INFO "S3C64XX: PLL settings, A=%ld, M=%ld, E=%ld\n",
 	       apll, mpll, epll);
 
-	hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+	if(__raw_readl(S3C_OTHERS) & S3C_OTHERS_SYNCMUXSEL_SYNC)
+		/* Synchronous mode */
+		hclk2 = apll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+	else
+		/* Asynchronous mode */
+		hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+
 	hclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK);
 	pclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_PCLK);
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
index 05332b9..ac2202f 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
@@ -35,6 +35,7 @@
 #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
 #define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
 #define S3C_MEM_SYS_CFG		S3C_CLKREG(0x120)
+#define S3C_OTHERS		S3C_CLKREG(0x900)
 
 /* CLKDIV0 */
 #define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
@@ -159,4 +160,7 @@
 #define MEM_SYS_CFG_INDEP_CF		0x4000
 #define MEM_SYS_CFG_EBI_FIX_PRI_CFCON	0x30
 
+/* OTHERS */
+#define S3C_OTHERS_SYNCMUXSEL_SYNC	(1<<6)
+
 #endif /* _PLAT_REGS_CLOCK_H */
-- 
1.7.6
