From: augulis.darius@gmail.com (Darius Augulis)
Date: Wed, 29 Sep 2010 22:35:47 +0300
Subject: [PATCH 6/9] ARM: S3C64XX: add nand support for mach-mini6410
In-Reply-To: <20100929192354.25307.40197.stgit@darius-desktop>
References: <20100929192354.25307.40197.stgit@darius-desktop>
Message-ID: <20100929193539.25307.9193.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nand device support and mtd partition
table for mini6410

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/Kconfig         |    1 +
 arch/arm/mach-s3c64xx/mach-mini6410.c |   41 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index bbeb4ca..3bbd204 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -105,6 +105,7 @@ config MACH_MINI6410
 	select S3C_DEV_HSMMC1
 	select S3C64XX_SETUP_SDHCI
 	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
 	help
 	  Machine support for the FriendlyARM MINI6410
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 425e65d..7408d55 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -18,6 +18,8 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/dm9000.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
 #include <linux/serial_core.h>
 #include <linux/types.h>
 
@@ -32,6 +34,7 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/nand.h>
 #include <plat/regs-serial.h>
 
 #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
@@ -103,11 +106,47 @@ static struct platform_device mini6410_device_eth = {
 	},
 };
 
+static struct mtd_partition mini6410_nand_part[] = {
+	[0] = {
+		.name	= "uboot",
+		.size	= SZ_1M,
+		.offset	= 0,
+	},
+	[1] = {
+		.name	= "kernel",
+		.size	= SZ_2M,
+		.offset	= SZ_1M,
+	},
+	[2] = {
+		.name	= "rootfs",
+		.size	= MTDPART_SIZ_FULL,
+		.offset	= SZ_1M + SZ_2M,
+	},
+};
+
+static struct s3c2410_nand_set mini6410_nand_sets[] = {
+	[0] = {
+		.name		= "nand",
+		.nr_chips	= 1,
+		.nr_partitions	= ARRAY_SIZE(mini6410_nand_part),
+		.partitions	= mini6410_nand_part,
+	},
+};
+
+static struct s3c2410_platform_nand mini6410_nand_info = {
+	.tacls		= 25,
+	.twrph0		= 55,
+	.twrph1		= 40,
+	.nr_sets	= ARRAY_SIZE(mini6410_nand_sets),
+	.sets		= mini6410_nand_sets,
+};
+
 static struct platform_device *mini6410_devices[] __initdata = {
 	&mini6410_device_eth,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_ohci,
+	&s3c_device_nand,
 };
 
 static void __init mini6410_map_io(void)
@@ -121,6 +160,8 @@ static void __init mini6410_machine_init(void)
 {
 	u32 cs1;
 
+	s3c_nand_set_platdata(&mini6410_nand_info);
+
 	/* configure nCS1 width to 16 bits */
 
 	cs1 = __raw_readl(S3C64XX_SROM_BW) &
