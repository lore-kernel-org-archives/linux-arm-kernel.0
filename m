From: leiwen@marvell.com (Lei Wen)
Date: Fri, 14 May 2010 13:30:21 +0800
Subject: [PATCH] mmp: add nand support to mmp2
Message-ID: <mailman.435.1273818139.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mmp2.h |    6 ++++
 arch/arm/mach-mmp/jasper.c            |   53 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h
b/arch/arm/mach-mmp/include/mach/mmp2.h
index 459f3be..5d706ed 100644
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
index cfd4d66..80a571e 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -58,8 +58,60 @@ static unsigned long jasper_pin_config[] __initdata = {
 	GPIO149_ND_CLE,
 	GPIO112_ND_RDY0,
 	GPIO160_ND_RDY1,
+	GPIO154_SMC_IRQ,
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
+	jasper_nand_info.parts[0] = jasper_nand_partitions;
+	jasper_nand_info.nr_parts[0] = ARRAY_SIZE(jasper_nand_partitions);
+	jasper_nand_info.enable_arbiter = 1;
+	jasper_nand_info.naked_cmd_support = 1;
+	mmp2_add_nand(&jasper_nand_info);
+}
+
 static void __init jasper_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(jasper_pin_config));
@@ -67,6 +119,7 @@ static void __init jasper_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
+	jasper_init_flash();
 }

 MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
-- 
1.5.6.5
