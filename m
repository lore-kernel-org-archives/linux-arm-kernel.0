From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  2 Jun 2011 15:54:07 +0400
Subject: [PATCH 1/2] clps711x/ceiva: port to use physmap flash
Message-ID: <1307015648-17505-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Port ceiva machine to use physmap flash instead of custom mapping driver
(which even can't compile cleanly with current kernels). All info
is gathered from drivers/mtd/maps/ceiva.c. Compile tested only.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-clps711x/ceiva.c |   60 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-clps711x/ceiva.c b/arch/arm/mach-clps711x/ceiva.c
index 16481cf..00e3c45 100644
--- a/arch/arm/mach-clps711x/ceiva.c
+++ b/arch/arm/mach-clps711x/ceiva.c
@@ -26,6 +26,9 @@
 #include <asm/mach/arch.h>
 
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 #include <asm/page.h>
@@ -46,6 +49,56 @@ static struct map_desc ceiva_io_desc[] __initdata = {
 	}
 };
 
+/* Flash / Partition sizing */
+/* For the 28F8003, we use the block mapping to calcuate the sizes */
+#define MAX_SIZE_KiB                  (16 + 8 + 8 + 96 + (7*128))
+#define BOOT_PARTITION_SIZE_KiB       (16)
+#define PARAMS_PARTITION_SIZE_KiB     (8)
+#define KERNEL_PARTITION_SIZE_KiB     (4*128)
+/* Use both remaining portion of first flash, and all of second flash */
+#define ROOT_PARTITION_SIZE_KiB       ((3*128) + (8*128))
+
+static struct mtd_partition ceiva_partitions[] = {
+	{
+		.name = "Ceiva BOOT partition",
+		.size   = BOOT_PARTITION_SIZE_KiB*1024,
+		.offset = 0,
+
+	}, {
+		.name = "Ceiva parameters partition",
+		.size   = PARAMS_PARTITION_SIZE_KiB*1024,
+		.offset = (16 + 8) * 1024,
+	}, {
+		.name = "Ceiva kernel partition",
+		.size = (KERNEL_PARTITION_SIZE_KiB)*1024,
+		.offset = 0x20000,
+
+	}, {
+		.name = "Ceiva root filesystem partition",
+		.offset = MTDPART_OFS_APPEND,
+		.size = (ROOT_PARTITION_SIZE_KiB)*1024,
+	}
+};
+
+static struct physmap_flash_data __initdata ceiva_flash_data = {
+	.width		= CEIVA_FLASH_WIDTH,
+	.parts		= ceiva_partitions,
+	.nr_parts	= ARRAY_SIZE(ceiva_partitions),
+	.probe_type	= "jedec_probe",
+};
+
+static struct resource __initdata ceiva_flash_resouces[] = {
+	{
+		.start	= CS0_PHYS_BASE,
+		.end	= CS0_PHYS_BASE + SZ_32M,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= CS1_PHYS_BASE,
+		.end	= CS1_PHYS_BASE + SZ_32M,
+		.flags	= IORESOURCE_MEM,
+	}
+};
 
 static void __init ceiva_map_io(void)
 {
@@ -53,11 +106,18 @@ static void __init ceiva_map_io(void)
         iotable_init(ceiva_io_desc, ARRAY_SIZE(ceiva_io_desc));
 }
 
+static void __init ceiva_init(void)
+{
+	platform_device_register_resndata(NULL, "physmap-flash", -1,
+			ceiva_flash_resouces, ARRAY_SIZE(ceiva_flash_resouces),
+			&ceiva_flash_data, sizeof(ceiva_flash_data));
+}
 
 MACHINE_START(CEIVA, "CEIVA/Polaroid Photo MAX Digital Picture Frame")
 	/* Maintainer: Rob Scott */
 	.boot_params	= 0xc0000100,
 	.map_io		= ceiva_map_io,
 	.init_irq	= clps711x_init_irq,
+	.init_machine	= ceiva_init,
 	.timer		= &clps711x_timer,
 MACHINE_END
-- 
1.7.4.4
