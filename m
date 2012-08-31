From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 10:28:19 +0900
Subject: [PATCH 08/11] ARM: shmobile: marzen: add USB EHCI driver support
In-Reply-To: <1346376502-12114-1-git-send-email-horms@verge.net.au>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
Message-ID: <1346376502-12114-9-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch supports CN21/CN22 USB 2.0 (port 0/1/2),
and enable USB momery on defconfig

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig     |  6 +++
 arch/arm/mach-shmobile/Kconfig        |  1 +
 arch/arm/mach-shmobile/board-marzen.c | 88 +++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index cd2dc21..61d1c55 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -47,6 +47,8 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_FARADAY is not set
@@ -75,6 +77,10 @@ CONFIG_SSB=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4cacc2d..8937d69 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -41,6 +41,7 @@ config ARCH_R8A7779
 	select SH_CLK_CPG
 	select ARM_GIC
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select USB_ARCH_HAS_EHCI
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index dec3ffc..0249c0e 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -32,6 +32,8 @@
 #include <linux/smsc911x.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/pm_runtime.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
@@ -116,6 +118,80 @@ static struct platform_device *marzen_devices[] __initdata = {
 	&sdhi0_device,
 };
 
+/* USB */
+static int xhci_power_on(struct platform_device *pdev)
+{
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	return 0;
+}
+
+static void xhci_power_off(struct platform_device *pdev)
+{
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static struct usb_ehci_pdata ehcix_pdata = {
+	.power_on	= xhci_power_on,
+	.power_off	= xhci_power_off,
+	.power_suspend	= xhci_power_off,
+};
+
+static struct resource ehci0_resources[] = {
+	[0] = {
+		.start	= 0xffe70000,
+		.end	= 0xffe70400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(44),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ehci0_device = {
+	.name	= "ehci-platform",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= &ehci0_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ehcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ehci0_resources),
+	.resource	= ehci0_resources,
+};
+
+static struct resource ehci1_resources[] = {
+	[0] = {
+		.start	= 0xfff70000,
+		.end	= 0xfff70400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(45),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ehci1_device = {
+	.name	= "ehci-platform",
+	.id	= 1,
+	.dev	= {
+		.dma_mask		= &ehci1_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ehcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ehci1_resources),
+	.resource	= ehci1_resources,
+};
+
+static struct platform_device *marzen_usb_devices[] __initdata = {
+	&ehci0_device,
+	&ehci1_device,
+};
+
 static void __init marzen_init(void)
 {
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
@@ -147,8 +223,20 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_SD0_CD, NULL);
 	gpio_request(GPIO_FN_SD0_WP, NULL);
 
+	/* USB (CN21) */
+	gpio_request(GPIO_FN_USB_OVC0, NULL);
+	gpio_request(GPIO_FN_USB_OVC1, NULL);
+	gpio_request(GPIO_FN_USB_OVC2, NULL);
+
+	/* USB (CN22) */
+	gpio_request(GPIO_FN_USB_PENC2, NULL);
+
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
+
+	if (0 == r8a7779_usb_phy_init(0))
+		platform_add_devices(marzen_usb_devices,
+				     ARRAY_SIZE(marzen_usb_devices));
 }
 
 MACHINE_START(MARZEN, "marzen")
-- 
1.7.10.2.484.gcd07cc5
