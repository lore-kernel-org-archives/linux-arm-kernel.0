From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 08 Aug 2012 13:11:01 +0530
Subject: [PATCH v3 5/5] ARM: Exynos4210: Enabling samsung-usbphy driver
In-Reply-To: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
References: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1344411661-17821-6-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding usbphy node for Exynos4210 along with the platform data.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi       |    5 +++++
 arch/arm/mach-exynos/include/mach/map.h |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c  |    8 ++++++++
 arch/arm/mach-exynos/setup-usb-phy.c    |   13 +++++++++++++
 4 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 02891fe..e28cf10 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -62,6 +62,11 @@
 		interrupts = <0 44 0>, <0 45 0>;
 	};
 
+	usbphy at 125B0000 {
+		compatible = "samsung,exynos4210-usbphy";
+		reg = <0x125B0000 0x100>;
+	};
+
 	keypad at 100A0000 {
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c72b675..0625c0a 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -234,6 +234,7 @@
 #define S3C_PA_SPI1			EXYNOS4_PA_SPI1
 #define S3C_PA_SPI2			EXYNOS4_PA_SPI2
 #define S3C_PA_USB_HSOTG		EXYNOS4_PA_HSOTG
+#define S3C_PA_USB_PHY			EXYNOS4_PA_HSPHY
 
 #define S5P_PA_EHCI			EXYNOS4_PA_EHCI
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index b2b5d5f..a652db0 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -13,6 +13,7 @@
 
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
+#include <linux/platform_data/samsung-usbphy.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
@@ -20,9 +21,14 @@
 
 #include <plat/cpu.h>
 #include <plat/regs-serial.h>
+#include <plat/usb-phy.h>
 
 #include "common.h"
 
+static struct samsung_usbphy_data exynos4_usbphy_pdata = {
+	.pmu_isolation = s5p_usb_phy_pmu_isolation,
+};
+
 /*
  * The following lookup table is used to override device names when devices
  * are registered from device tree. This is temporarily added to enable
@@ -63,6 +69,8 @@ static const struct of_dev_auxdata exynos4210_auxdata_lookup[] __initconst = {
 				"exynos4210-spi.2", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA1, "dma-pl330.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-usbphy", EXYNOS4_PA_HSPHY,
+			"s3c-usbphy", &exynos4_usbphy_pdata),
 	{},
 };
 
diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index b81cc56..1c62d20 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -221,3 +221,16 @@ int s5p_usb_phy_exit(struct platform_device *pdev, int type)
 
 	return -EINVAL;
 }
+
+void s5p_usb_phy_pmu_isolation(int on)
+{
+	if (on) {
+		writel(readl(S5P_USBDEVICE_PHY_CONTROL)
+			& ~S5P_USBDEVICE_PHY_ENABLE,
+				S5P_USBDEVICE_PHY_CONTROL);
+	} else {
+		writel(readl(S5P_USBDEVICE_PHY_CONTROL)
+			| S5P_USBDEVICE_PHY_ENABLE,
+				S5P_USBDEVICE_PHY_CONTROL);
+	}
+}
-- 
1.7.1
