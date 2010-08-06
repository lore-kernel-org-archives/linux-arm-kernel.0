From: augulis.darius@gmail.com (Darius Augulis)
Date: Fri, 06 Aug 2010 13:21:40 +0300
Subject: [PATCH 2/4] s3c: mach-real6410: add support for dm9000 ethernet
In-Reply-To: <20100806101914.2481.67766.stgit@darius-desktop>
References: <20100806101914.2481.67766.stgit@darius-desktop>
Message-ID: <20100806102118.2481.58456.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
 * Renamed from 's3c: add dm9000 ethernet support for mach-real6410'
 * Added IORESOURCE_IRQ_HIGHLEVEL to irq resource flags

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-real6410.c |   63 +++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 04a472a..4aaee3f 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/init.h>
+#include <linux/dm9000.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <asm/mach-types.h>
@@ -24,6 +25,7 @@
 #include <asm/mach/map.h>
 #include <mach/map.h>
 #include <mach/s3c6410.h>
+#include <mach/regs-srom.h>
 #include <plat/cpu.h>
 #include <plat/regs-serial.h>
 
@@ -62,6 +64,44 @@ static struct s3c2410_uartcfg real6410_uartcfgs[] __initdata = {
 	},
 };
 
+/* DM9000AEP 10/100 ethernet controller */
+
+static struct resource real6410_dm9k_resource[] = {
+        [0] = {
+                .start = S3C64XX_PA_XM0CSN1,
+                .end   = S3C64XX_PA_XM0CSN1 + 1,
+                .flags = IORESOURCE_MEM
+        },
+        [1] = {
+                .start = S3C64XX_PA_XM0CSN1 + 4,
+                .end   = S3C64XX_PA_XM0CSN1 + 5,
+                .flags = IORESOURCE_MEM
+        },
+        [2] = {
+                .start = S3C_EINT(7),
+                .end   = S3C_EINT(7),
+                .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+        }
+};
+
+static struct dm9000_plat_data real6410_dm9k_pdata = {
+        .flags          = (DM9000_PLATF_16BITONLY | DM9000_PLATF_NO_EEPROM),
+};
+
+static struct platform_device real6410_device_eth = {
+        .name           = "dm9000",
+        .id             = -1,
+        .num_resources  = ARRAY_SIZE(real6410_dm9k_resource),
+        .resource       = real6410_dm9k_resource,
+        .dev            = {
+                .platform_data  = &real6410_dm9k_pdata,
+        },
+};
+
+static struct platform_device *real6410_devices[] __initdata = {
+	&real6410_device_eth,
+};
+
 static void __init real6410_map_io(void)
 {
 	s3c64xx_init_io(NULL, 0);
@@ -71,6 +111,29 @@ static void __init real6410_map_io(void)
 
 static void __init real6410_machine_init(void)
 {
+	u32 cs1;
+
+	/* configure nCS1 width to 16 bits */
+
+	cs1 = __raw_readl(S3C64XX_SROM_BW) &
+		~(S3C64XX_SROM_BW__CS_MASK << S3C64XX_SROM_BW__NCS1__SHIFT);
+	cs1 |= ((1 << S3C64XX_SROM_BW__DATAWIDTH__SHIFT) |
+		(1 << S3C64XX_SROM_BW__WAITENABLE__SHIFT) |
+		(1 << S3C64XX_SROM_BW__BYTEENABLE__SHIFT)) <<
+			S3C64XX_SROM_BW__NCS1__SHIFT;
+	__raw_writel(cs1, S3C64XX_SROM_BW);
+
+	/* set timing for nCS1 suitable for ethernet chip */
+
+	__raw_writel((0 << S3C64XX_SROM_BCX__PMC__SHIFT) |
+			(6 << S3C64XX_SROM_BCX__TACP__SHIFT) |
+			(4 << S3C64XX_SROM_BCX__TCAH__SHIFT) |
+			(1 << S3C64XX_SROM_BCX__TCOH__SHIFT) |
+			(13 << S3C64XX_SROM_BCX__TACC__SHIFT) |
+			(4 << S3C64XX_SROM_BCX__TCOS__SHIFT) |
+			(0 << S3C64XX_SROM_BCX__TACS__SHIFT), S3C64XX_SROM_BC1);
+
+	platform_add_devices(real6410_devices, ARRAY_SIZE(real6410_devices));
 }
 
 MACHINE_START(REAL6410, "REAL6410")
