From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Apr 2014 10:33:39 +0200
Subject: [PATCH] ARM: integrator: add MMCI device to IM-PD1
Message-ID: <1397550819-8209-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IM-PD1 logic module daughterboard holds an MMCI block, which
we can now provide using platform resources such as proper GPIO
lines etc. We add the GPIO table dynamically and using the new
GPIO descriptor mechanism. Tested and hey, it works:

root at integrator:/ mount /dev/mmcblk0p1 /mnt/
root at integrator:/ ls /mnt/
ARM          U-BOOT.EXE   u-boot.bin   u-boot.srec  u-pad.bin

Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/impd1.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 0e870ea818c4..29767cfc98bc 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -20,10 +20,13 @@
 #include <linux/mm.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/amba/mmci.h>
+#include <linux/amba/pl061.h>
 #include <linux/io.h>
 #include <linux/platform_data/clk-integrator.h>
 #include <linux/slab.h>
 #include <linux/irqchip/arm-vic.h>
+#include <linux/gpio/driver.h>
 
 #include <asm/sizes.h>
 #include "lm.h"
@@ -52,6 +55,14 @@ void impd1_tweak_control(struct device *dev, u32 mask, u32 val)
 EXPORT_SYMBOL(impd1_tweak_control);
 
 /*
+ * MMC support
+ */
+static struct mmci_platform_data mmc_data = {
+	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.cd_invert	= 1,
+};
+
+/*
  * CLCD support
  */
 #define PANEL		PROSPECTOR
@@ -291,6 +302,7 @@ static struct impd1_device impd1_devs[] = {
 		.offset	= 0x00700000,
 		.irq	= { 7, 8 },
 		.id	= 0x00041181,
+		.platform_data = &mmc_data,
 	}, {
 		.offset	= 0x00800000,
 		.irq	= { 9 },
@@ -367,6 +379,42 @@ static int __init impd1_probe(struct lm_device *dev)
 
 		pc_base = dev->resource.start + idev->offset;
 		snprintf(devname, 32, "lm%x:%5.5lx", dev->id, idev->offset >> 12);
+
+		/* Add GPIO descriptor lookup table for the PL061 block */
+		if (idev->offset == 0x00400000) {
+			struct gpiod_lookup_table *lookup;
+			char *chipname;
+			char *mmciname;
+
+			lookup = devm_kzalloc(&dev->dev,
+					      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
+					      GFP_KERNEL);
+			chipname = devm_kstrdup(&dev->dev, devname, GFP_KERNEL);
+			mmciname = kasprintf(GFP_KERNEL, "lm%x:00700", dev->id);
+			lookup->dev_id = mmciname;
+			/*
+			 * Offsets on GPIO block 1:
+			 * 3 = MMC WP (write protect)
+			 * 4 = MMC CD (card detect)
+			 *
+			 * Offsets on GPIO block 2:
+			 * 0 = Up key
+			 * 1 = Down key
+			 * 2 = Left key
+			 * 3 = Right key
+			 * 4 = Key lower left
+			 * 5 = Key lower right
+			 */
+			/* We need the two MMCI GPIO entries */
+			lookup->table[0].chip_label = chipname;
+			lookup->table[0].chip_hwnum = 3;
+			lookup->table[0].con_id = "wp";
+			lookup->table[1].chip_label = chipname;
+			lookup->table[1].chip_hwnum = 4;
+			lookup->table[1].con_id = "cd";
+			gpiod_add_lookup_table(lookup);
+		}
+
 		d = amba_ahb_device_add_res(&dev->dev, devname, pc_base, SZ_4K,
 					    irq1, irq2,
 					    idev->platform_data, idev->id,
-- 
1.9.0
