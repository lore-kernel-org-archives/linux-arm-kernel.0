From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri,  7 Jan 2011 16:24:05 -0500
Subject: [PATCH] ARM: vexpress: register platform PATA device.
Message-ID: <1294435445-2020-1-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compactflash device on this platform is not usable simply because it
is never registered with the kernel.  Fix that up.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-vexpress/v2m.c |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c..ee61039 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -264,6 +264,7 @@ config ARCH_VEXPRESS
 	select HAVE_CLK
 	select ICST
 	select PLAT_VERSATILE
+	select HAVE_PATA_PLATFORM
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 7eaa232..89ec45c 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/ata_platform.h>
 #include <linux/smsc911x.h>
 #include <linux/spinlock.h>
 #include <linux/sysdev.h>
@@ -238,6 +239,29 @@ static struct platform_device v2m_flash_device = {
 	.dev.platform_data = &v2m_flash_data,
 };
 
+static struct pata_platform_info v2m_pata_data = {
+	.ioport_shift	= 2,
+};
+
+static struct resource v2m_pata_resources[] = {
+	{
+		.start	= V2M_CF,
+		.end	= V2M_CF + 0xff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= V2M_CF + 0x100,
+		.end	= V2M_CF + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device v2m_cf_device = {
+	.name		= "pata_platform",
+	.id		= -1,
+	.resource       = v2m_pata_resources,
+	.num_resources  = ARRAY_SIZE(v2m_pata_resources),
+	.dev.platform_data = &v2m_pata_data,
+};
 
 static unsigned int v2m_mmci_status(struct device *dev)
 {
@@ -352,6 +376,7 @@ static int __init v2m_init(void)
 	platform_device_register(&v2m_pcie_i2c_device);
 	platform_device_register(&v2m_ddc_i2c_device);
 	platform_device_register(&v2m_flash_device);
+	platform_device_register(&v2m_cf_device);
 	platform_device_register(&v2m_eth_device);
 	platform_device_register(&v2m_usb_device);
 
-- 
1.7.2.2
