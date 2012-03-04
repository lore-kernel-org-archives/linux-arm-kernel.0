From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 4 Mar 2012 18:44:29 +0100
Subject: [PATCH 2/3] ARM: S3C24XX: Reuse S3C2443 dma for S3C2416
In-Reply-To: <201203041842.35420.heiko@sntech.de>
References: <201203041842.35420.heiko@sntech.de>
Message-ID: <201203041844.30047.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma controller is similar in S3C2443 and S3C2416 and has also
the same register layout with the same REQSEL-bits in the source
select.

The only small difference is the SIO channel of the S3C2443 for the
non-hsmmc controller which is not present on S3C2416/2450 and
second spi channel which is not present on the S3C2416.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig                 |   10 +++++-----
 arch/arm/mach-s3c24xx/Makefile                |    2 +-
 arch/arm/mach-s3c24xx/dma-s3c2443.c           |   22 ++++++++++++++++++++--
 arch/arm/plat-samsung/include/plat/regs-dma.h |    2 +-
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 48af6fc..5ebd150 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -42,7 +42,7 @@ config CPU_S3C2416
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
 	select S3C2443_COMMON
-	select S3C2416_DMA if S3C24XX_DMA
+	select S3C2443_DMA if S3C24XX_DMA
 	select S3C2416_PM if PM
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
@@ -479,15 +479,15 @@ config S3C2443_COMMON
 	  Common code for the S3C2443 and similar processors, which includes
 	  the S3C2416 and S3C2450.
 
-endif	# CPU_S3C2443 || CPU_S3C2416
-
-if CPU_S3C2443
-
 config S3C2443_DMA
 	bool
 	help
 	  Internal config node for S3C2443 DMA support
 
+endif	# CPU_S3C2443 || CPU_S3C2416
+
+if CPU_S3C2443
+
 comment "S3C2443 Boards"
 
 config MACH_SMDK2443
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 876e5e5..1909d66 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -32,11 +32,11 @@ obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o irq-s3c244x.o clock-s3c244x.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 
 obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o irq-s3c2443.o clock-s3c2443.o
-obj-$(CONFIG_S3C2443_DMA)	+= dma-s3c2443.o
 
 # common code
 
 obj-$(CONFIG_S3C2443_COMMON)	+= common-s3c2443.o
+obj-$(CONFIG_S3C2443_DMA)	+= dma-s3c2443.o
 
 #
 # machine support
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2443.c b/arch/arm/mach-s3c24xx/dma-s3c2443.c
index d9e1b3b..e227c47 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2443.c
@@ -51,7 +51,7 @@ static struct s3c24xx_dma_map __initdata s3c2443_dma_mappings[] = {
 		.name		= "xdreq1",
 		.channels	= MAP(S3C2443_DMAREQSEL_XDREQ1),
 	},
-	[DMACH_SDI] = {
+	[DMACH_SDI] = { /* only on S3C2443 */
 		.name		= "sdi",
 		.channels	= MAP(S3C2443_DMAREQSEL_SDI),
 	},
@@ -59,7 +59,7 @@ static struct s3c24xx_dma_map __initdata s3c2443_dma_mappings[] = {
 		.name		= "spi0",
 		.channels	= MAP(S3C2443_DMAREQSEL_SPI0TX),
 	},
-	[DMACH_SPI1] = {
+	[DMACH_SPI1] = { /* only on S3C2443/S3C2450 */
 		.name		= "spi1",
 		.channels	= MAP(S3C2443_DMAREQSEL_SPI1TX),
 	},
@@ -142,6 +142,23 @@ static int __init s3c2443_dma_add(struct device *dev,
 	return s3c24xx_dma_init_map(&s3c2443_dma_sel);
 }
 
+#ifdef CONFIG_CPU_S3C2416
+/* S3C2416 DMA contains the same selection table as the S3C2443 */
+static struct subsys_interface s3c2416_dma_interface = {
+	.name		= "s3c2416_dma",
+	.subsys		= &s3c2416_subsys,
+	.add_dev	= s3c2443_dma_add,
+};
+
+static int __init s3c2416_dma_init(void)
+{
+	return subsys_interface_register(&s3c2416_dma_interface);
+}
+
+arch_initcall(s3c2416_dma_init);
+#endif
+
+#ifdef CONFIG_CPU_S3C2443
 static struct subsys_interface s3c2443_dma_interface = {
 	.name		= "s3c2443_dma",
 	.subsys		= &s3c2443_subsys,
@@ -154,3 +171,4 @@ static int __init s3c2443_dma_init(void)
 }
 
 arch_initcall(s3c2443_dma_init);
+#endif
diff --git a/arch/arm/plat-samsung/include/plat/regs-dma.h b/arch/arm/plat-samsung/include/plat/regs-dma.h
index 178bccb..a7d622e 100644
--- a/arch/arm/plat-samsung/include/plat/regs-dma.h
+++ b/arch/arm/plat-samsung/include/plat/regs-dma.h
@@ -119,7 +119,7 @@
 #define S3C2412_DMAREQSEL_UART2_1	S3C2412_DMAREQSEL_SRC(24)
 #endif /* CONFIG_CPU_S3C2412 */
 
-#ifdef CONFIG_CPU_S3C2443
+#if defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2443)
 
 #define S3C2443_DMAREQSEL_SRC(x)	((x) << 1)
 
-- 
1.7.2.3
