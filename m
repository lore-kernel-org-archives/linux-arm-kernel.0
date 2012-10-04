From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  4 Oct 2012 09:28:29 +0200
Subject: [PATCH 1/2] ARM: nomadik: switch over to using the FSMC driver
Message-ID: <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik NAND driver is really just a subset of the existing
FSMC driver, so let's switch over to using that driver instead,
since it handles more variants of this chip. The callbacks for
setting up the chip is doing stuff now handled by the FSMC
driver.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm requesting Mike Turquette's ACK on this patch so I can merge
it through ARM SoC.
---
 arch/arm/configs/nhk8815_defconfig        |  2 +-
 arch/arm/mach-nomadik/board-nhk8815.c     | 64 ++++++++++++++-----------------
 arch/arm/mach-nomadik/include/mach/fsmc.h | 29 --------------
 drivers/clk/clk-nomadik.c                 |  1 +
 4 files changed, 30 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/include/mach/fsmc.h

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index bf123c5..9a8adfd 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -58,7 +58,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_SMC=y
 CONFIG_MTD_NAND_VERIFY_WRITE=y
-CONFIG_MTD_NAND_NOMADIK=y
+CONFIG_MTD_NAND_FSMC=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_GENERIC=y
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index bfa1eab..a105d1b 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
+#include <linux/mtd/fsmc.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/i2c.h>
@@ -36,7 +37,6 @@
 #include <plat/mtu.h>
 #include <plat/pincfg.h>
 
-#include <linux/platform_data/mtd-nomadik-nand.h>
 #include <mach/fsmc.h>
 
 #include "cpu-8815.h"
@@ -48,36 +48,18 @@
 /* These addresses span 16MB, so use three individual pages */
 static struct resource nhk8815_nand_resources[] = {
 	{
-		.name = "nand_addr",
-		.start = NAND_IO_ADDR,
-		.end = NAND_IO_ADDR + 0xfff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.name = "nand_cmd",
-		.start = NAND_IO_CMD,
-		.end = NAND_IO_CMD + 0xfff,
+		.name = "nand_data",
+		.start = 0x40000000,
+		.end = 0x40000000 + SZ_16K - 1,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.name = "nand_data",
-		.start = NAND_IO_DATA,
-		.end = NAND_IO_DATA + 0xfff,
+		.name  = "fsmc_regs",
+		.start = NOMADIK_FSMC_BASE,
+		.end   = NOMADIK_FSMC_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
-	}
+	},
 };
 
-static int nhk8815_nand_init(void)
-{
-	/* FSMC setup for nand chip select (8-bit nand in 8815NHK) */
-	writel(0x0000000E, FSMC_PCR(0));
-	writel(0x000D0A00, FSMC_PMEM(0));
-	writel(0x00100A00, FSMC_PATT(0));
-
-	/* enable access to the chip select area */
-	writel(readl(FSMC_PCR(0)) | 0x04, FSMC_PCR(0));
-
-	return 0;
-}
-
 /*
  * These partitions are the same as those used in the 2.6.20 release
  * shipped by the vendor; the first two partitions are mandated
@@ -111,20 +93,30 @@ static struct mtd_partition nhk8815_partitions[] = {
 	}
 };
 
-static struct nomadik_nand_platform_data nhk8815_nand_data = {
-	.parts		= nhk8815_partitions,
-	.nparts		= ARRAY_SIZE(nhk8815_partitions),
-	.options	= NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING,
-	.init		= nhk8815_nand_init,
+static struct fsmc_nand_timings nhk8815_nand_timings = {
+	.thiz	= 0,
+	.thold	= 0x10,
+	.twait	= 0x0A,
+	.tset	= 0,
+};
+
+static struct fsmc_nand_platform_data nhk8815_nand_platform_data = {
+	.nand_timings = &nhk8815_nand_timings,
+	.partitions = nhk8815_partitions,
+	.nr_partitions = ARRAY_SIZE(nhk8815_partitions),
+	.width = FSMC_NAND_BW8,
+	.ale_off = 0x1000000,
+	.cle_off = 0x800000,
 };
 
 static struct platform_device nhk8815_nand_device = {
-	.name		= "nomadik_nand",
-	.dev		= {
-		.platform_data = &nhk8815_nand_data,
+	.name = "fsmc-nand",
+	.id = -1,
+	.resource = nhk8815_nand_resources,
+	.num_resources = ARRAY_SIZE(nhk8815_nand_resources),
+	.dev = {
+		.platform_data = &nhk8815_nand_platform_data,
 	},
-	.resource	= nhk8815_nand_resources,
-	.num_resources	= ARRAY_SIZE(nhk8815_nand_resources),
 };
 
 /* These are the partitions for the OneNand device, different from above */
diff --git a/arch/arm/mach-nomadik/include/mach/fsmc.h b/arch/arm/mach-nomadik/include/mach/fsmc.h
deleted file mode 100644
index 8c2c051..0000000
--- a/arch/arm/mach-nomadik/include/mach/fsmc.h
+++ /dev/null
@@ -1,29 +0,0 @@
-
-/* Definitions for the Nomadik FSMC "Flexible Static Memory controller" */
-
-#ifndef __ASM_ARCH_FSMC_H
-#define __ASM_ARCH_FSMC_H
-
-#include <mach/hardware.h>
-/*
- * Register list
- */
-
-/* bus control reg. and bus timing reg. for CS0..CS3 */
-#define FSMC_BCR(x)     (NOMADIK_FSMC_VA + (x << 3))
-#define FSMC_BTR(x)     (NOMADIK_FSMC_VA + (x << 3) + 0x04)
-
-/* PC-card and NAND:
- * PCR = control register
- * PMEM = memory timing
- * PATT = attribute timing
- * PIO = I/O timing
- * PECCR = ECC result
- */
-#define FSMC_PCR(x)     (NOMADIK_FSMC_VA + ((2 + x) << 5) + 0x00)
-#define FSMC_PMEM(x)    (NOMADIK_FSMC_VA + ((2 + x) << 5) + 0x08)
-#define FSMC_PATT(x)    (NOMADIK_FSMC_VA + ((2 + x) << 5) + 0x0c)
-#define FSMC_PIO(x)     (NOMADIK_FSMC_VA + ((2 + x) << 5) + 0x10)
-#define FSMC_PECCR(x)   (NOMADIK_FSMC_VA + ((2 + x) << 5) + 0x14)
-
-#endif /* __ASM_ARCH_FSMC_H */
diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 517a8ff..6b4c70f 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -20,6 +20,7 @@ void __init nomadik_clk_init(void)
 	clk_register_clkdev(clk, NULL, "gpio.2");
 	clk_register_clkdev(clk, NULL, "gpio.3");
 	clk_register_clkdev(clk, NULL, "rng");
+	clk_register_clkdev(clk, NULL, "fsmc-nand");
 
 	/*
 	 * The 2.4 MHz TIMCLK reference clock is active@boot time, this is
-- 
1.7.11.4
