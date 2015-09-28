From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:34:39 +0200
Subject: [PATCH v4 16/26] ARM: pxa: magician: Fix support for Intel Strata NOR
 Flash
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609B26F.9010809@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Old definition for the physmap-flash driver is incomplete:
- Use of an EGPIO without previous request
- Missing the MTD partitions

This patch fixes it. Read functionality was tested on the machine with
board_id 0x3a. Writing was not tested.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 91b5ed0..8e8b122 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -788,20 +788,65 @@ static struct pxaohci_platform_data magician_ohci_info = {
  * StrataFlash
  */
 
+static int magician_flash_init(struct platform_device *pdev)
+{
+	int ret = gpio_request(EGPIO_MAGICIAN_FLASH_VPP, "flash Vpp enable");
+
+	if (ret) {
+		pr_err("Cannot request flash enable GPIO (%i)\n", ret);
+		return ret;
+	}
+
+	ret = gpio_direction_output(EGPIO_MAGICIAN_FLASH_VPP, 1);
+	if (ret) {
+		pr_err("Cannot set direction for flash enable (%i)\n", ret);
+		gpio_free(EGPIO_MAGICIAN_FLASH_VPP);
+	}
+
+	return ret;
+}
+
 static void magician_set_vpp(struct platform_device *pdev, int vpp)
 {
 	gpio_set_value(EGPIO_MAGICIAN_FLASH_VPP, vpp);
 }
 
+static void magician_flash_exit(struct platform_device *pdev)
+{
+	gpio_free(EGPIO_MAGICIAN_FLASH_VPP);
+}
+
 static struct resource strataflash_resource = {
 	.start	= PXA_CS0_PHYS,
 	.end	= PXA_CS0_PHYS + SZ_64M - 1,
 	.flags	= IORESOURCE_MEM,
 };
 
+static struct mtd_partition magician_flash_parts[] = {
+	{
+		.name		= "Bootloader",
+		.offset		= 0x0,
+		.size		= 0x40000,
+		.mask_flags	= MTD_WRITEABLE, /* EXPERIMENTAL */
+	},
+	{
+		.name		= "Linux Kernel",
+		.offset		= 0x40000,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+/*
+ * physmap-flash driver
+ */
+
 static struct physmap_flash_data strataflash_data = {
 	.width		= 4,
+	.init		= magician_flash_init,
 	.set_vpp	= magician_set_vpp,
+	.exit		= magician_flash_exit,
+	.parts		= magician_flash_parts,
+	.nr_parts	= ARRAY_SIZE(magician_flash_parts),
 };
 
 static struct platform_device strataflash = {
-- 
1.7.12.1
