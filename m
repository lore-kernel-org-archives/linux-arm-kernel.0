From: p.paneri@samsung.com (p.paneri at samsung.com)
Date: Tue, 21 Jun 2011 12:33:44 +0530
Subject: [RFC][PATCH 2/5] ARM: SAMSUNG: Changing the build condition of OTG
	platform device for samsung.
In-Reply-To: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1308639827-2121-3-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Praveen Paneri <p.paneri@samsung.com>

Adding dwc driver name in existing platform device
to probe DWC OTG driver.
Introduced otg_set_platdata function to pass platform data
Added selectable config option to add DWC OTG driver for different
machines.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 arch/arm/plat-samsung/Kconfig         |    6 ++++++
 arch/arm/plat-samsung/Makefile        |    1 +
 arch/arm/plat-samsung/dev-usb-hsotg.c |   20 ++++++++++++++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 4d79519..58ed8b1 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -227,6 +227,12 @@ config S3C_DEV_USB_HSOTG
 	help
 	  Compile in platform device definition for USB high-speed OtG
 
+config S3C_DEV_DWC_OTG
+	bool
+	help
+	  Compile in platform device definition for DWC OTG. This
+	  will make it selectable for different machines.
+
 config S3C_DEV_WDT
 	bool
 	default y if ARCH_S3C2410
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 53eb15b..785ca79 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
+obj-$(CONFIG_S3C_DEV_DWC_OTG)	+= dev-usb-hsotg.o
 obj-$(CONFIG_S3C_DEV_WDT)	+= dev-wdt.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
 obj-$(CONFIG_S3C_DEV_ONENAND)	+= dev-onenand.o
diff --git a/arch/arm/plat-samsung/dev-usb-hsotg.c b/arch/arm/plat-samsung/dev-usb-hsotg.c
index 33a844a..7e6228b 100644
--- a/arch/arm/plat-samsung/dev-usb-hsotg.c
+++ b/arch/arm/plat-samsung/dev-usb-hsotg.c
@@ -20,6 +20,8 @@
 #include <mach/map.h>
 
 #include <plat/devs.h>
+#include <plat/otg.h>
+#include <plat/usb-phy.h>
 
 static struct resource s3c_usb_hsotg_resources[] = {
 	[0] = {
@@ -37,7 +39,12 @@ static struct resource s3c_usb_hsotg_resources[] = {
 static u64 s3c_hsotg_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device s3c_device_usb_hsotg = {
+#ifdef CONFIG_S3C_DEV_USB_HSOTG
 	.name		= "s3c-hsotg",
+#endif
+#ifdef CONFIG_S3C_DEV_DWC_OTG
+	.name		= "dwc_otg",
+#endif
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s3c_usb_hsotg_resources),
 	.resource	= s3c_usb_hsotg_resources,
@@ -46,3 +53,16 @@ struct platform_device s3c_device_usb_hsotg = {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
+
+void __init s5p_otg_set_platdata(struct s5p_otg_platdata *pd)
+{
+	struct s5p_otg_platdata *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct s5p_otg_platdata),
+			&s3c_device_usb_hsotg);
+
+	if (!npd->phy_init)
+		npd->phy_init = s5p_usb_phy_init;
+	if (!npd->phy_exit)
+		npd->phy_exit = s5p_usb_phy_exit;
+}
-- 
1.7.0.4
