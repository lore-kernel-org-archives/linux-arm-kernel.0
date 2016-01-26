From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jan 2016 12:12:02 +0100
Subject: [PATCH 3/6] ARM: versatile: move flash registration to the device tree
In-Reply-To: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1453806725-4880-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the boardfile definition of the flash memory in the
Versatile board into the device tree. The flash was already
defined with the property "arm,versatile-flash" which was
not handled by the kernel: instead define it as compatible
also with "cfi-flash" so it detects properly, and delete the
corresponding boardfile code so we get a smooth transition.

The old compatible string "arm,versatile-flash" is reused to
indicate to the MTD physmap subsystem that this flash requires
special VPP handling. (See separate patch.)

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/versatile-ab.dts     |  5 ++--
 arch/arm/mach-versatile/versatile_dt.c | 47 ----------------------------------
 2 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 6fd7efbead34..28253ee84404 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -119,8 +119,9 @@
 	};
 
 	flash at 34000000 {
-		compatible = "arm,versatile-flash";
-		reg = <0x34000000 0x4000000>;
+		/* 64 MiB NOR flash in non-interleaved chips */
+		compatible = "arm,versatile-flash", "cfi-flash";
+		reg = <0x34000000 0x04000000>;
 		bank-width = <4>;
 	};
 
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index dff1c0595b67..d643b9210dbd 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -32,7 +32,6 @@
 #include <linux/amba/clcd.h>
 #include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/amba/mmci.h>
-#include <linux/mtd/physmap.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -42,27 +41,15 @@
 #define __io_address(n)		((void __iomem __force *)IO_ADDRESS(n))
 
 /*
- * Memory definitions
- */
-#define VERSATILE_FLASH_BASE           0x34000000
-#define VERSATILE_FLASH_SIZE           SZ_64M
-
-/*
  * ------------------------------------------------------------------------
  *  Versatile Registers
  * ------------------------------------------------------------------------
  */
 #define VERSATILE_SYS_PCICTL_OFFSET           0x44
 #define VERSATILE_SYS_MCI_OFFSET              0x48
-#define VERSATILE_SYS_FLASH_OFFSET            0x4C
 #define VERSATILE_SYS_CLCD_OFFSET             0x50
 
 /*
- * VERSATILE_SYS_FLASH
- */
-#define VERSATILE_FLASHPROG_FLVPPEN	(1 << 0)	/* Enable writing to flash */
-
-/*
  * VERSATILE peripheral addresses
  */
 #define VERSATILE_MMCI0_BASE           0x10005000	/* MMC interface */
@@ -86,39 +73,6 @@
 static void __iomem *versatile_sys_base;
 static void __iomem *versatile_ib2_ctrl;
 
-static void versatile_flash_set_vpp(struct platform_device *pdev, int on)
-{
-	u32 val;
-
-	val = readl(versatile_sys_base + VERSATILE_SYS_FLASH_OFFSET);
-	if (on)
-		val |= VERSATILE_FLASHPROG_FLVPPEN;
-	else
-		val &= ~VERSATILE_FLASHPROG_FLVPPEN;
-	writel(val, versatile_sys_base + VERSATILE_SYS_FLASH_OFFSET);
-}
-
-static struct physmap_flash_data versatile_flash_data = {
-	.width			= 4,
-	.set_vpp		= versatile_flash_set_vpp,
-};
-
-static struct resource versatile_flash_resource = {
-	.start			= VERSATILE_FLASH_BASE,
-	.end			= VERSATILE_FLASH_BASE + VERSATILE_FLASH_SIZE - 1,
-	.flags			= IORESOURCE_MEM,
-};
-
-struct platform_device versatile_flash_device = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev			= {
-		.platform_data	= &versatile_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &versatile_flash_resource,
-};
-
 unsigned int mmc_status(struct device *dev)
 {
 	struct amba_device *adev = container_of(dev, struct amba_device, dev);
@@ -390,7 +344,6 @@ static void __init versatile_dt_init(void)
 
 	versatile_dt_pci_init();
 
-	platform_device_register(&versatile_flash_device);
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     versatile_auxdata_lookup, NULL);
 }
-- 
2.4.3
