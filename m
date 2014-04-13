From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:40:00 +0200
Subject: [PATCH 23/29] ARM: orion5x: use DT to describe NOR on edmini_v2
In-Reply-To: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397400006-4315-24-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit converts the already partially DT-converted edmini_v2
platform to use the Device Tree for NOR flash, using the Device Bus.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 46 +++++++++++++++-
 arch/arm/mach-orion5x/edmini_v2-setup.c            | 62 ----------------------
 2 files changed, 45 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index ff90b01..44cc36a 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -27,7 +27,51 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
-			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>;
+			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
+			 <MBUS_ID(0x01, 0x0f) 0 0xfff80000 0x80000>;
+
+		devbus-bootcs {
+			status = "okay";
+
+			/* Read parameters */
+			devbus,bus-width    = <8>;
+			devbus,turn-off-ps  = <90000>;
+			devbus,badr-skew-ps = <0>;
+			devbus,acc-first-ps = <186000>;
+			devbus,acc-next-ps  = <186000>;
+
+			/* Write parameters */
+			devbus,wr-high-ps  = <90000>;
+			devbus,wr-low-ps   = <90000>;
+			devbus,ale-wr-ps   = <90000>;
+
+			/*
+			 * Currently the MTD code does not recognize
+			 * the MX29LV400CBCT as a bottom-type
+			 * device. This could cause risks of
+			 * accidentally erasing critical flash
+			 * sectors. We thus define a single,
+			 * write-protected partition covering the
+			 * whole flash.  TODO: once the flash part
+			 * TOP/BOTTOM detection issue is sorted out in
+			 * the MTD code, break this into at least
+			 * three partitions: 'u-boot code', 'u-boot
+			 * environment' and 'whatever is left'.
+			 */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0x80000>;
+				bank-width = <1>;
+		                #address-cells = <1>;
+				#size-cells = <1>;
+
+				partition at 0 {
+					label = "Full512Kb";
+					reg = <0 0x80000>;
+					read-only;
+				};
+			};
+		};
 
 		internal-regs {
 			pinctrl at 10000 {
diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index 2eebc0c..6bef2d5 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -42,74 +42,12 @@
  * EDMINI_V2 Info
  ****************************************************************************/
 
-/*
- * 512KB NOR flash Device bus boot chip select
- */
-
-#define EDMINI_V2_NOR_BOOT_BASE		0xfff80000
-#define EDMINI_V2_NOR_BOOT_SIZE		SZ_512K
-
-/*****************************************************************************
- * 512KB NOR Flash on BOOT Device
- ****************************************************************************/
-
-/*
- * Currently the MTD code does not recognize the MX29LV400CBCT as a bottom
- * -type device. This could cause risks of accidentally erasing critical
- * flash sectors. We thus define a single, write-protected partition covering
- * the whole flash.
- * TODO: once the flash part TOP/BOTTOM detection issue is sorted out in the MTD
- * code, break this into at least three partitions: 'u-boot code', 'u-boot
- * environment' and 'whatever is left'.
- */
-
-static struct mtd_partition edmini_v2_partitions[] = {
-	{
-		.name		= "Full512kb",
-		.size		= 0x00080000,
-		.offset		= 0x00000000,
-		.mask_flags	= MTD_WRITEABLE,
-	},
-};
-
-static struct physmap_flash_data edmini_v2_nor_flash_data = {
-	.width		= 1,
-	.parts		= edmini_v2_partitions,
-	.nr_parts	= ARRAY_SIZE(edmini_v2_partitions),
-};
-
-static struct resource edmini_v2_nor_flash_resource = {
-	.flags			= IORESOURCE_MEM,
-	.start			= EDMINI_V2_NOR_BOOT_BASE,
-	.end			= EDMINI_V2_NOR_BOOT_BASE
-		+ EDMINI_V2_NOR_BOOT_SIZE - 1,
-};
-
-static struct platform_device edmini_v2_nor_flash = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev		= {
-		.platform_data	= &edmini_v2_nor_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &edmini_v2_nor_flash_resource,
-};
-
 /*****************************************************************************
  * General Setup
  ****************************************************************************/
 
 void __init edmini_v2_init(void)
 {
-	/*
-	 * Configure peripherals.
-	 */
-	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
-				    ORION_MBUS_DEVBUS_BOOT_ATTR,
-				    EDMINI_V2_NOR_BOOT_BASE,
-				    EDMINI_V2_NOR_BOOT_SIZE);
-	platform_device_register(&edmini_v2_nor_flash);
-
 	pr_notice("edmini_v2: USB device port, flash write and power-off "
 		  "are not yet supported.\n");
 }
-- 
1.8.3.2
