From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Sep 2010 00:35:37 +0200
Subject: [PATCH 2/2] ARM: platform data to use the FSMC NAND with the U300
Message-ID: <1284330937-3636-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just as it says, if this is merged along with the other patch, the
driver supports the U300 NAND flash interface.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/clock.c                  |    6 ++--
 arch/arm/mach-u300/core.c                   |   47 ++++++++++++++++++++++++---
 arch/arm/mach-u300/include/mach/u300-regs.h |    2 -
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
index 60acf9e..7458fc6 100644
--- a/arch/arm/mach-u300/clock.c
+++ b/arch/arm/mach-u300/clock.c
@@ -66,7 +66,7 @@ static DEFINE_SPINLOCK(syscon_resetreg_lock);
  *  AMBA bus
  *  |
  *  +- CPU
- *  +- NANDIF NAND Flash interface
+ *  +- FSMC NANDIF NAND Flash interface
  *  +- SEMI Shared Memory interface
  *  +- ISP Image Signal Processor (U335 only)
  *  +- CDS (U335 only)
@@ -726,7 +726,7 @@ static struct clk cpu_clk = {
 };
 
 static struct clk nandif_clk = {
-	.name       = "NANDIF",
+	.name       = "FSMC",
 	.parent	    = &amba_clk,
 	.hw_ctrld   = false,
 	.reset	    = true,
@@ -1259,7 +1259,7 @@ static struct clk_lookup lookups[] = {
 	/* Connected directly to the AMBA bus */
 	DEF_LOOKUP("amba",      &amba_clk),
 	DEF_LOOKUP("cpu",       &cpu_clk),
-	DEF_LOOKUP("fsmc",      &nandif_clk),
+	DEF_LOOKUP("fsmc-nand", &nandif_clk),
 	DEF_LOOKUP("semi",      &semi_clk),
 #ifdef CONFIG_MACH_U300_BS335
 	DEF_LOOKUP("isp",       &isp_clk),
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index ea41c23..5615587 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -21,7 +21,8 @@
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <mach/coh901318.h>
+#include <linux/mtd/nand.h>
+#include <mtd/fsmc.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -30,6 +31,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <mach/coh901318.h>
 #include <mach/hardware.h>
 #include <mach/syscon.h>
 #include <mach/dma_channels.h>
@@ -285,6 +287,13 @@ static struct resource rtc_resources[] = {
  */
 static struct resource fsmc_resources[] = {
 	{
+		.name  = "nand_data",
+		.start = U300_NAND_CS0_PHYS_BASE,
+		.end   = U300_NAND_CS0_PHYS_BASE + SZ_16K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.name  = "fsmc_regs",
 		.start = U300_NAND_IF_PHYS_BASE,
 		.end   = U300_NAND_IF_PHYS_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
@@ -1429,11 +1438,39 @@ static struct platform_device rtc_device = {
 	.resource = rtc_resources,
 };
 
-static struct platform_device fsmc_device = {
-	.name = "nandif",
+static struct mtd_partition u300_partitions[] = {
+	{
+		.name = "bootrecords",
+		.offset = 0,
+		.size = SZ_128K,
+	},
+	{
+		.name = "free",
+		.offset = SZ_128K,
+		.size = 8064 * SZ_1K,
+	},
+	{
+		.name = "platform",
+		.offset = 8192 * SZ_1K,
+		.size = 253952 * SZ_1K,
+	},
+};
+
+static struct fsmc_nand_platform_data nand_platform_data = {
+	.partitions = u300_partitions,
+	.nr_partitions = ARRAY_SIZE(u300_partitions),
+	.options = NAND_SKIP_BBTSCAN,
+	.width = FSMC_NAND_BW8,
+};
+
+static struct platform_device nand_device = {
+	.name = "fsmc-nand",
 	.id = -1,
-	.num_resources = ARRAY_SIZE(fsmc_resources),
 	.resource = fsmc_resources,
+	.num_resources = ARRAY_SIZE(fsmc_resources),
+	.dev = {
+		.platform_data = &nand_platform_data,
+	},
 };
 
 static struct platform_device ave_device = {
@@ -1465,7 +1502,7 @@ static struct platform_device *platform_devs[] __initdata = {
 	&keypad_device,
 	&rtc_device,
 	&gpio_device,
-	&fsmc_device,
+	&nand_device,
 	&wdog_device,
 	&ave_device
 };
diff --git a/arch/arm/mach-u300/include/mach/u300-regs.h b/arch/arm/mach-u300/include/mach/u300-regs.h
index 56721a0..8b85df4 100644
--- a/arch/arm/mach-u300/include/mach/u300-regs.h
+++ b/arch/arm/mach-u300/include/mach/u300-regs.h
@@ -20,11 +20,9 @@
 
 /* NAND Flash CS0 */
 #define U300_NAND_CS0_PHYS_BASE		0x80000000
-#define U300_NAND_CS0_VIRT_BASE		0xff040000
 
 /* NFIF */
 #define U300_NAND_IF_PHYS_BASE		0x9f800000
-#define U300_NAND_IF_VIRT_BASE		0xff030000
 
 /* AHB Peripherals */
 #define U300_AHB_PER_PHYS_BASE		0xa0000000
-- 
1.6.3.3
