From: leiwen@marvell.com (Lei Wen)
Date: Thu, 3 Jun 2010 16:21:04 +0800
Subject: [PATCH 15/25] mmp: add nand support to mmp2
Message-ID: <mailman.28.1276839467.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/configs/mmp2_defconfig       |    4 +-
 arch/arm/mach-mmp/include/mach/mmp2.h |    6 ++++
 arch/arm/mach-mmp/jasper.c            |   52 +++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 4b55dcb..e63dec3 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -469,7 +469,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 #
 # User Modules And Translation Layers
 #
-# CONFIG_MTD_CHAR is not set
+CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
@@ -525,7 +525,7 @@ CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_GPIO is not set
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
-# CONFIG_MTD_NAND_PXA3xx is not set
+CONFIG_MTD_NAND_PXA3xx=y
 # CONFIG_MTD_NAND_NANDSIM is not set
 # CONFIG_MTD_NAND_PLATFORM is not set
 CONFIG_MTD_ONENAND=y
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h
b/arch/arm/mach-mmp/include/mach/mmp2.h
index fec220b..d68890b 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -4,6 +4,7 @@
 #include <linux/i2c.h>
 #include <mach/devices.h>
 #include <plat/i2c.h>
+#include <plat/pxa3xx_nand.h>

 extern struct pxa_device_desc mmp2_device_uart1;
 extern struct pxa_device_desc mmp2_device_uart2;
@@ -15,6 +16,7 @@ extern struct pxa_device_desc mmp2_device_twsi3;
 extern struct pxa_device_desc mmp2_device_twsi4;
 extern struct pxa_device_desc mmp2_device_twsi5;
 extern struct pxa_device_desc mmp2_device_twsi6;
+extern struct pxa_device_desc mmp2_device_nand;

 static inline int mmp2_add_uart(int id)
 {
@@ -56,5 +58,9 @@ static inline int mmp2_add_twsi(int id, struct
i2c_pxa_platform_data *data,
 	return pxa_register_device(d, data, sizeof(*data));
 }

+static inline int mmp2_add_nand(struct pxa3xx_nand_platform_data *data)
+{
+	return pxa_register_device(&mmp2_device_nand, data, sizeof(*data));
+}
 #endif /* __ASM_MACH_MMP2_H */

diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index d77dd41..5d055f3 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -67,6 +67,57 @@ static unsigned long jasper_pin_config[] __initdata = {
 	PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
 };

+static struct mtd_partition jasper_nand_partitions[] = {
+	[0] = {
+		.name		= "Bootloader",
+		.offset		= 0,
+		.size		= 0x100000,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	[1] = {
+		.name		= "Reserve",
+		.offset		= 0x100000,
+		.size		= 0x080000,
+	},
+	[2] = {
+		.name		= "Reserve",
+		.offset		= 0x180000,
+		.size		= 0x800000,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	[3] = {
+		.name		= "Kernel",
+		.offset		= 0x980000,
+		.size		= 0x300000,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	[4] = {
+		.name		= "system",
+		.offset		= 0x0c80000,
+		.size		= 0x7000000,
+	},
+	[5] = {
+		.name		= "userdata",
+		.offset		= 0x7c80000,
+		.size		= 0x7000000,
+	},
+	[6] = {
+		.name		= "filesystem",
+		.offset		= 0x0ec80000,
+		.size		= MTDPART_SIZ_FULL,
+	}
+};
+
+static struct pxa3xx_nand_platform_data jasper_nand_info;
+static void __init jasper_init_flash(void)
+{
+	jasper_nand_info.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_NAKED_CMD_EN
+		| PXA3XX_DMA_EN | PXA3XX_ADV_TIME_TUNING | PXA3XX_TWO_CHIP_EN;
+	jasper_nand_info.parts[0] = jasper_nand_partitions;
+	jasper_nand_info.nr_parts[0] = ARRAY_SIZE(jasper_nand_partitions);
+	mmp2_add_nand(&jasper_nand_info);
+}
+
 static struct regulator_consumer_supply max8649_supply[] = {
 	REGULATOR_SUPPLY("vcc_core", NULL),
 };
@@ -128,6 +179,7 @@ static void __init jasper_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
+	jasper_init_flash();
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));

 	regulator_has_full_constraints();
-- 
1.7.0.4
