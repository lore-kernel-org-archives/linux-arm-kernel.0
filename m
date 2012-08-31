From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 10:28:22 +0900
Subject: [PATCH 11/11] ARM: shmobile: marzen: add USB OHCI driver support
In-Reply-To: <1346376502-12114-1-git-send-email-horms@verge.net.au>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
Message-ID: <1346376502-12114-12-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch supports CN21/CN22 USB 1.x (port 0/1/2),
and enable input event on defconfig

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig     |  5 +--
 arch/arm/mach-shmobile/Kconfig        |  1 +
 arch/arm/mach-shmobile/board-marzen.c | 57 +++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index c30ea5e..30f2714 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -61,9 +61,8 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
@@ -81,6 +80,8 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_UIO=y
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8937d69..66befbc 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -42,6 +42,7 @@ config ARCH_R8A7779
 	select ARM_GIC
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_OHCI
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index eb0a05a..30c794b 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -33,6 +33,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
@@ -203,9 +204,65 @@ static struct platform_device ehci1_device = {
 	.resource	= ehci1_resources,
 };
 
+static struct usb_ohci_pdata ohcix_pdata = {
+	.power_on	= xhci_power_on,
+	.power_off	= xhci_power_off,
+	.power_suspend	= xhci_power_off,
+};
+
+static struct resource ohci0_resources[] = {
+	[0] = {
+		.start	= 0xffe70400,
+		.end	= 0xffe70800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(44),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ohci0_device = {
+	.name	= "ohci-platform",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= &ohci0_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ohcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ohci0_resources),
+	.resource	= ohci0_resources,
+};
+
+static struct resource ohci1_resources[] = {
+	[0] = {
+		.start	= 0xfff70400,
+		.end	= 0xfff70800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(45),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ohci1_device = {
+	.name	= "ohci-platform",
+	.id	= 1,
+	.dev	= {
+		.dma_mask		= &ohci1_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &ohcix_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(ohci1_resources),
+	.resource	= ohci1_resources,
+};
+
 static struct platform_device *marzen_usb_devices[] __initdata = {
 	&ehci0_device,
 	&ehci1_device,
+	&ohci0_device,
+	&ohci1_device,
 };
 
 static void __init marzen_init(void)
-- 
1.7.10.2.484.gcd07cc5
