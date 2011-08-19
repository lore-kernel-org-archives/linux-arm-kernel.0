From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 19 Aug 2011 11:54:31 +0200
Subject: [PATCH 4/4 v3] ARM: s3c64xx: Add support for synchronous clock operation.
Message-ID: <mailman.97.1314096054.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards based on S3C6410 use synchronous clocking, which means that HCLKx2
and other system clocks are generated from APLL instead of MPLL.

This patch adds support for such boards, by calculating hclk2 depending on
the status of S3C_OTHERS_SYNCMUXSEL bit in S3C64XX_OTHERS regist

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c                 |    8 +++++++-
 arch/arm/mach-s3c64xx/include/mach/regs-sys.h |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index fdfc4d5..a7dab43 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -780,7 +780,13 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
 	printk(KERN_INFO "S3C64XX: PLL settings, A=%ld, M=%ld, E=%ld\n",
 	       apll, mpll, epll);
 
-	hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+	if(__raw_readl(S3C64XX_OTHERS) & S3C64XX_OTHERS_SYNCMUXSEL)
+		/* Synchronous mode */
+		hclk2 = apll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+	else
+		/* Asynchronous mode */
+		hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+
 	hclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK);
 	pclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_PCLK);
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
index 774e0de..b91e020 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
@@ -26,5 +26,6 @@
 #define S3C64XX_OTHERS		S3C_SYSREG(0x900)
 
 #define S3C64XX_OTHERS_USBMASK	(1 << 16)
+#define S3C64XX_OTHERS_SYNCMUXSEL	(1 << 6)
 
 #endif /* _PLAT_REGS_SYS_H */
-- 
1.7.6
