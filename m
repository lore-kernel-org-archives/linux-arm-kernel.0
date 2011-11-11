From: peiyong.feng.kernel@gmail.com (peiyong feng)
Date: Fri, 11 Nov 2011 18:14:27 +0800
Subject: [PATCH] Add dm9000 network support for OK6410 board.
Message-ID: <1321006467-15824-1-git-send-email-peiyong.feng.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: peiyong feng <peiyong.feng.kernel@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 +
 arch/arm/plat-samsung/devs.c          |   40 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 8bc8edd..71e817a 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -276,6 +276,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
+	&s3c_device_dm9000,
 	&samsung_asoc_dma,
 	&s3c64xx_device_iisv4,
 	&samsung_device_keypad,
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 4ca8b57..38edc1a 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -29,6 +29,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mmc/host.h>
 #include <linux/ioport.h>
+#include <linux/dm9000.h>
 
 #include <asm/irq.h>
 #include <asm/pmu.h>
@@ -1401,6 +1402,45 @@ void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
 }
 #endif /* CONFIG_S5P_DEV_USB_EHCI */
 
+/* Ethernet */
+#ifdef CONFIG_DM9000
+#define S3C64XX_PA_DM9000	(0x18000000)
+#define S3C64XX_SZ_DM9000	SZ_1M
+#define S3C64XX_VA_DM9000	S3C_ADDR(0x03b00300)
+
+static struct resource dm9000_resources[] = {
+	[0] = {
+		.start		= S3C64XX_PA_DM9000,
+		.end		= S3C64XX_PA_DM9000 + 3,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= S3C64XX_PA_DM9000 + 4,
+		.end		= S3C64XX_PA_DM9000 + S3C64XX_SZ_DM9000 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start		= IRQ_EINT(7),
+		.end		= IRQ_EINT(7),
+		.flags		= IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
+	},
+};
+
+static struct dm9000_plat_data dm9000_setup = {
+	.flags			= DM9000_PLATF_16BITONLY,
+	.dev_addr		= { 0x08, 0x90, 0x00, 0xa0, 0x90, 0x90 },
+};
+
+static struct platform_device s3c_device_dm9000 = {
+	.name			= "dm9000",
+	.id				= 0,
+	.num_resources	= ARRAY_SIZE(dm9000_resources),
+	.resource		= dm9000_resources,
+	.dev			= {
+		.platform_data = &dm9000_setup,
+	}
+};
+#endif /*#ifdef CONFIG_DM9000*/
 /* USB HSOTG */
 
 #ifdef CONFIG_S3C_DEV_USB_HSOTG
-- 
1.7.7.rc0.235.g8d714
