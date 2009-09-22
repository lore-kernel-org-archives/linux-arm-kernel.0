From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 23 Sep 2009 01:57:35 +0800
Subject: [PATCH] [ARM] pxa: add onenand support for TTC-DKB
Message-ID: <mailman.12.1253642552.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |   87 +++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 08cfef6..10e8401 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -11,9 +11,13 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/onenand.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
@@ -26,6 +30,86 @@ static unsigned long ttc_dkb_pin_config[] __initdata =3D=
 {
 	/* UART2 */
 	GPIO47_UART2_RXD,
 	GPIO48_UART2_TXD,
+
+	/* DFI */
+	DF_IO0_ND_IO0,
+	DF_IO1_ND_IO1,
+	DF_IO2_ND_IO2,
+	DF_IO3_ND_IO3,
+	DF_IO4_ND_IO4,
+	DF_IO5_ND_IO5,
+	DF_IO6_ND_IO6,
+	DF_IO7_ND_IO7,
+	DF_IO8_ND_IO8,
+	DF_IO9_ND_IO9,
+	DF_IO10_ND_IO10,
+	DF_IO11_ND_IO11,
+	DF_IO12_ND_IO12,
+	DF_IO13_ND_IO13,
+	DF_IO14_ND_IO14,
+	DF_IO15_ND_IO15,
+	DF_nCS0_SM_nCS2_nCS0,
+	DF_ALE_SM_WEn_ND_ALE,
+	DF_CLE_SM_OEn_ND_CLE,
+	DF_WEn_DF_WEn,
+	DF_REn_DF_REn,
+	DF_RDY0_DF_RDY0,
+};
+
+static struct mtd_partition ttc_dkb_onenand_partitions[] =3D {
+	{
+		.name		=3D "bootloader",
+		.offset		=3D 0,
+		.size		=3D SZ_1M,
+		.mask_flags	=3D MTD_WRITEABLE,
+	}, {
+		.name		=3D "reserved",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D SZ_128K,
+		.mask_flags	=3D MTD_WRITEABLE,
+	}, {
+		.name		=3D "reserved",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D SZ_8M,
+		.mask_flags	=3D MTD_WRITEABLE,
+	}, {
+		.name		=3D "kernel",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D (SZ_2M + SZ_1M),
+		.mask_flags	=3D 0,
+	}, {
+		.name		=3D "filesystem",
+		.offset		=3D MTDPART_OFS_APPEND,
+		.size		=3D SZ_48M,
+		.mask_flags	=3D 0,
+	}
+};
+
+static struct flash_platform_data ttc_dkb_onenand_info =3D {
+	.parts		=3D ttc_dkb_onenand_partitions,
+	.nr_parts	=3D ARRAY_SIZE(ttc_dkb_onenand_partitions),
+};
+
+static struct resource ttc_dkb_resource_onenand[] =3D {
+	[0] =3D {
+		.start	=3D SMC_CS0_PHYS_BASE,
+		.end	=3D 256 * SZ_1M,
+		.flags	=3D IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ttc_dkb_device_onenand =3D {
+	.name		=3D "onenand",
+	.id		=3D -1,
+	.resource	=3D ttc_dkb_resource_onenand,
+	.num_resources	=3D ARRAY_SIZE(ttc_dkb_resource_onenand),
+	.dev		=3D {
+		.platform_data	=3D &ttc_dkb_onenand_info,
+	},
+};
+
+static struct platform_device *ttc_dkb_devices[] =3D {
+	&ttc_dkb_device_onenand,
 };

 static void __init ttc_dkb_init(void)
@@ -34,6 +118,9 @@ static void __init ttc_dkb_init(void)

 	/* on-chip devices */
 	pxa910_add_uart(1);
+
+	/* off-chip devices */
+	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 }

 MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
--=20
1.6.3.3
