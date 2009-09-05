From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 05 Sep 2009 08:33:11 +0000 (GMT)
Subject: [PATCH 3/3] s3c64xx: Add SYNCMUX codes for selection source of HCLKx2
Message-ID: <18082112.529381252139591299.JavaMail.weblogic@epml18>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SYNCMUX codes for selection source of HCLKx2.
According to 'Fig 3-2. The block diagram of clock generator' of 6400/6410 UM,
the source of HCLKx2 is DOUT_APLL or MOUT_MPLL that is decided by SYNCMUX.
If synchronous mode, it is DOUT_APLL and if asynchronous mode, it is MOUT_MPLL.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    4 ++++
 arch/arm/plat-s3c64xx/s3c6400-clock.c           |    8 +++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
index ff46e7f..2c3224c 100644
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
@@ -33,6 +33,7 @@
 #define S3C_PCLK_GATE          S3C_CLKREG(0x34)
 #define S3C_SCLK_GATE          S3C_CLKREG(0x38)
 #define S3C_MEM0_GATE          S3C_CLKREG(0x3C)
+#define S3C_OTHERS             S3C_CLKREG(0x900)

 /* CLKDIV0 */
 #define S3C6400_CLKDIV0_MFC_MASK       (0xf << 28)
@@ -182,6 +183,9 @@
 #define S3C_CLKCON_SCLK_CAM            (1<<2)
 #define S3C_CLKCON_SCLK_JPEG           (1<<1)

+/* OTHERS */
+#define S3C_OTHERS_SYNCMUXSEL_SYNC     (1<<6)
+
 /* CLKSRC */

 #define S3C6400_CLKSRC_APLL_MOUT       (1 << 0)
diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index a898325..0da2781 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -689,7 +689,13 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
        printk(KERN_INFO "S3C64XX: PLL settings, A=%ld, M=%ld, E=%ld\n",
               apll, mpll, epll);

-       hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+       if (__raw_readl(S3C_OTHERS) & S3C_OTHERS_SYNCMUXSEL_SYNC) {
+               /* Synchronous mode */
+               hclk2 = apll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+       } else {
+               /* Asynchronous mode */
+               hclk2 = mpll / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK2);
+       }
        hclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_HCLK);
        pclk = hclk2 / GET_DIV(clkdiv0, S3C6400_CLKDIV0_PCLK);

-- 
1.5.3.4
                                                                             
