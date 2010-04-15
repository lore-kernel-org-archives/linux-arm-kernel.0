From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 14 Apr 2010 20:00:48 -0500
Subject: [PATCH] ep93xx: move physmap flash registration into core.c
Message-ID: <0D753D10438DA54287A00B0270842697636D62B066@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a core.c __init function to handle the physmap flash
registration for all the ep93xx platforms.  Also, modify all
the ep93xx platforms to use this new function.

This simplifies all the ep93xx platform init code and removes
all the static variables that would exist in a unified kernel
supporting multiple ep93xx platforms.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

This is based on Russell's linux-arm/devel branch.  If accepted
it will be rebased as needed when that branch is merged with a
stable branch.

 arch/arm/mach-ep93xx/adssphere.c             |   24 +---------------
 arch/arm/mach-ep93xx/core.c                  |   38 ++++++++++++++++++++++++++
 arch/arm/mach-ep93xx/edb93xx.c               |   31 +-------------------
 arch/arm/mach-ep93xx/gesbc9312.c             |   24 +---------------
 arch/arm/mach-ep93xx/include/mach/platform.h |    3 ++
 arch/arm/mach-ep93xx/micro9.c                |   37 ++++++-------------------
 arch/arm/mach-ep93xx/simone.c                |   22 +--------------
 arch/arm/mach-ep93xx/ts72xx.c                |   23 +---------------
 8 files changed, 56 insertions(+), 146 deletions(-)

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 3a1a855..f744f67 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 
@@ -21,26 +20,6 @@
 #include <asm/mach/arch.h>
 
 
-static struct physmap_flash_data adssphere_flash_data = {
-	.width		= 4,
-};
-
-static struct resource adssphere_flash_resource = {
-	.start		= EP93XX_CS6_PHYS_BASE,
-	.end		= EP93XX_CS6_PHYS_BASE + SZ_32M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device adssphere_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &adssphere_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &adssphere_flash_resource,
-};
-
 static struct ep93xx_eth_data __initdata adssphere_eth_data = {
 	.phy_id		= 1,
 };
@@ -48,8 +27,7 @@ static struct ep93xx_eth_data __initdata adssphere_eth_data = {
 static void __init adssphere_init_machine(void)
 {
 	ep93xx_init_devices();
-	platform_device_register(&adssphere_flash);
-
+	ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_32M);
 	ep93xx_register_eth(&adssphere_eth_data, 1);
 }
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8d3f77e..802d1f2 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -29,6 +29,7 @@
 #include <linux/termios.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
+#include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 
@@ -346,6 +347,43 @@ static struct platform_device ep93xx_ohci_device = {
 
 
 /*************************************************************************
+ * EP93xx physmap'ed flash
+ *************************************************************************/
+static struct physmap_flash_data ep93xx_flash_data;
+
+static struct resource ep93xx_flash_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device ep93xx_flash = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &ep93xx_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &ep93xx_flash_resource,
+};
+
+/**
+ * ep93xx_register_flash() - Register the external flash device.
+ * @width:	bank width in octets
+ * @start:	resource start address
+ * @size:	resource size
+ */
+void __init ep93xx_register_flash(unsigned int width,
+				  resource_size_t start, resource_size_t size)
+{
+	ep93xx_flash_data.width		= width;
+
+	ep93xx_flash_resource.start	= start;
+	ep93xx_flash_resource.end	= start + size - 1;
+
+	platform_device_register(&ep93xx_flash);
+}
+
+
+/*************************************************************************
  * EP93xx ethernet peripheral handling
  *************************************************************************/
 static struct ep93xx_eth_data ep93xx_eth_data;
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 3884182..c2ce903 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -27,7 +27,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
@@ -38,39 +37,13 @@
 #include <asm/mach/arch.h>
 
 
-static struct physmap_flash_data edb93xx_flash_data;
-
-static struct resource edb93xx_flash_resource = {
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device edb93xx_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &edb93xx_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &edb93xx_flash_resource,
-};
-
-static void __init __edb93xx_register_flash(unsigned int width,
-			resource_size_t start, resource_size_t size)
-{
-	edb93xx_flash_data.width	= width;
-	edb93xx_flash_resource.start	= start;
-	edb93xx_flash_resource.end	= start + size - 1;
-
-	platform_device_register(&edb93xx_flash);
-}
-
 static void __init edb93xx_register_flash(void)
 {
 	if (machine_is_edb9307() || machine_is_edb9312() ||
 	    machine_is_edb9315()) {
-		__edb93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_32M);
+		ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_32M);
 	} else {
-		__edb93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
+		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
 	}
 }
 
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index a809618..d97168c 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 
@@ -21,26 +20,6 @@
 #include <asm/mach/arch.h>
 
 
-static struct physmap_flash_data gesbc9312_flash_data = {
-	.width		= 4,
-};
-
-static struct resource gesbc9312_flash_resource = {
-	.start		= EP93XX_CS6_PHYS_BASE,
-	.end		= EP93XX_CS6_PHYS_BASE + SZ_8M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device gesbc9312_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &gesbc9312_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &gesbc9312_flash_resource,
-};
-
 static struct ep93xx_eth_data __initdata gesbc9312_eth_data = {
 	.phy_id		= 1,
 };
@@ -48,8 +27,7 @@ static struct ep93xx_eth_data __initdata gesbc9312_eth_data = {
 static void __init gesbc9312_init_machine(void)
 {
 	ep93xx_init_devices();
-	platform_device_register(&gesbc9312_flash);
-
+	ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_8M);
 	ep93xx_register_eth(&gesbc9312_eth_data, 0);
 }
 
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index b663390..ff9ccfc 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -41,6 +41,9 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 
 unsigned int ep93xx_chip_revision(void);
 
+void ep93xx_register_flash(unsigned int width,
+			   resource_size_t start, resource_size_t size);
+
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 			 struct i2c_board_info *devices, int num);
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 1cc911b..2ba7763 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
 #include <linux/io.h>
 
 #include <mach/hardware.h>
@@ -31,31 +30,6 @@
  * Micro9-Lite uses a separate MTD map driver for flash support
  * Micro9-Slim has up to 64MB of either 32-bit or 16-bit flash on CS1
  *************************************************************************/
-static struct physmap_flash_data micro9_flash_data;
-
-static struct resource micro9_flash_resource = {
-	.start		= EP93XX_CS1_PHYS_BASE,
-	.end		= EP93XX_CS1_PHYS_BASE + SZ_64M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device micro9_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &micro9_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &micro9_flash_resource,
-};
-
-static void __init __micro9_register_flash(unsigned int width)
-{
-	micro9_flash_data.width = width;
-
-	platform_device_register(&micro9_flash);
-}
-
 static unsigned int __init micro9_detect_bootwidth(void)
 {
 	u32 v;
@@ -70,10 +44,17 @@ static unsigned int __init micro9_detect_bootwidth(void)
 
 static void __init micro9_register_flash(void)
 {
+	unsigned int width;
+
 	if (machine_is_micro9())
-		__micro9_register_flash(4);
+		width = 4;
 	else if (machine_is_micro9m() || machine_is_micro9s())
-		__micro9_register_flash(micro9_detect_bootwidth());
+		width = micro9_detect_bootwidth();
+	else
+		width = 0;
+
+	if (width)
+		ep93xx_register_flash(width, EP93XX_CS1_PHYS_BASE, SZ_64M);
 }
 
 
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 388aec9..cbac7e4 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -29,26 +29,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-static struct physmap_flash_data simone_flash_data = {
-	.width		= 2,
-};
-
-static struct resource simone_flash_resource = {
-	.start		= EP93XX_CS6_PHYS_BASE,
-	.end		= EP93XX_CS6_PHYS_BASE + SZ_8M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device simone_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.num_resources	= 1,
-	.resource	= &simone_flash_resource,
-	.dev = {
-		.platform_data	= &simone_flash_data,
-	},
-};
-
 static struct ep93xx_eth_data __initdata simone_eth_data = {
 	.phy_id		= 1,
 };
@@ -78,7 +58,7 @@ static void __init simone_init_machine(void)
 {
 	ep93xx_init_devices();
 
-	platform_device_register(&simone_flash);
+	ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_8M);
 	ep93xx_register_eth(&simone_eth_data, 1);
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 9553031..e0159f3 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/m48t86.h>
-#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 #include <mach/ts72xx.h>
@@ -114,30 +113,10 @@ static void __init ts72xx_map_io(void)
 /*************************************************************************
  * NOR flash (TS-7200 only)
  *************************************************************************/
-static struct physmap_flash_data ts72xx_flash_data = {
-	.width		= 2,
-};
-
-static struct resource ts72xx_flash_resource = {
-	.start		= EP93XX_CS6_PHYS_BASE,
-	.end		= EP93XX_CS6_PHYS_BASE + SZ_16M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device ts72xx_flash = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &ts72xx_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &ts72xx_flash_resource,
-};
-
 static void __init ts72xx_register_flash(void)
 {
 	if (board_is_ts7200())
-		platform_device_register(&ts72xx_flash);
+		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
 }
 
 static unsigned char ts72xx_rtc_readbyte(unsigned long addr)
