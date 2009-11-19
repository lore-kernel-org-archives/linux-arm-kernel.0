From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 19 Nov 2009 12:02:11 +0100
Subject: [PATCH 6/6] ARM: MX3: add NOR flash support via physmap mtd driver
In-Reply-To: <1258628531-15783-5-git-send-email-daniel@caiaq.de>
References: <1258628531-15783-1-git-send-email-daniel@caiaq.de>
	<1258628531-15783-2-git-send-email-daniel@caiaq.de>
	<1258628531-15783-3-git-send-email-daniel@caiaq.de>
	<1258628531-15783-4-git-send-email-daniel@caiaq.de>
	<1258628531-15783-5-git-send-email-daniel@caiaq.de>
Message-ID: <1258628531-15783-6-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lite.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite.c b/arch/arm/mach-mx3/mx31lite.c
index 4651e23..def6b67 100644
--- a/arch/arm/mach-mx3/mx31lite.c
+++ b/arch/arm/mach-mx3/mx31lite.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -181,6 +182,32 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 };
 
 /*
+ * NOR flash
+ */
+
+static struct physmap_flash_data nor_flash_data = {
+	.width  = 2,
+};
+
+static struct resource nor_flash_resource = {
+	.start  = 0xa0000000,
+	.end    = 0xa1ffffff,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct platform_device physmap_flash_device = {
+	.name   = "physmap-flash",
+	.id     = 0,
+	.dev    = {
+		.platform_data  = &nor_flash_data,
+	},
+	.resource = &nor_flash_resource,
+	.num_resources = 1,
+};
+
+
+
+/*
  * This structure defines the MX31 memory map.
  */
 static struct map_desc mx31lite_io_desc[] __initdata = {
@@ -227,7 +254,10 @@ static void __init mxc_board_init(void)
 	mxc_iomux_setup_multiple_pins(mx31lite_pins, ARRAY_SIZE(mx31lite_pins),
 				      "mx31lite");
 
+	/* NOR and NAND flash */
+	platform_device_register(&physmap_flash_device);
 	mxc_register_device(&mxc_nand_device, &mx31lite_nand_board_info);
+
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 	spi_register_board_info(&mc13783_spi_dev, 1);
 
-- 
1.6.5.2
