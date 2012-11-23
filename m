From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 23 Nov 2012 18:02:32 +0530
Subject: [PATCH v9 3/3] ARM: EXYNOS: Enabling samsung-usbphy driver for
 EXYNOS4210
In-Reply-To: <1353673952-13537-1-git-send-email-p.paneri@samsung.com>
References: <1353673952-13537-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1353673952-13537-4-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding usbphy node for Exynos4210 along with the platform data.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 arch/arm/boot/dts/exynos4210-smdkv310.dts    |    5 +++++
 arch/arm/mach-exynos/Kconfig                 |    1 +
 arch/arm/mach-exynos/include/mach/map.h      |    1 +
 arch/arm/mach-exynos/mach-exynos4-dt.c       |    8 ++++++++
 arch/arm/mach-exynos/setup-usb-phy.c         |   13 +++++++++++++
 arch/arm/plat-samsung/include/plat/usb-phy.h |    1 +
 6 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 9b23a82..550903a 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -59,6 +59,11 @@
 		status = "okay";
 	};
 
+	usbphy at 125B0000 {
+		compatible = "samsung,exynos4210-usbphy";
+		reg = <0x125B0000 0x100>;
+	};
+
 	keypad at 100A0000 {
 		samsung,keypad-num-rows = <2>;
 		samsung,keypad-num-columns = <8>;
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 945ce49..e0d481f 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -419,6 +419,7 @@ config MACH_EXYNOS4_DT
 	select PINCTRL
 	select PINCTRL_EXYNOS4
 	select USE_OF
+	select EXYNOS4_SETUP_USB_PHY
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the Exynos4 SoC based board.
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 1df6abb..556aced 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -246,6 +246,7 @@
 #define S3C_PA_SPI1			EXYNOS4_PA_SPI1
 #define S3C_PA_SPI2			EXYNOS4_PA_SPI2
 #define S3C_PA_USB_HSOTG		EXYNOS4_PA_HSOTG
+#define S3C_PA_USB_PHY			EXYNOS4_PA_HSPHY
 
 #define S5P_PA_EHCI			EXYNOS4_PA_EHCI
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 8858068..f7887e5 100644
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
@@ -79,6 +85,8 @@ static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-tmu", EXYNOS4_PA_TMU,
 				"exynos-tmu", NULL),
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
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
index 46b54bf..fafb0cc 100644
--- a/arch/arm/plat-samsung/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -20,5 +20,6 @@ enum s5p_usb_phy_type {
 extern struct samsung_usbphy_data s3c_usbphy_pdata;
 extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
 extern int s5p_usb_phy_exit(struct platform_device *pdev, int type);
+extern void s5p_usb_phy_pmu_isolation(int on);
 
 #endif /* __PLAT_SAMSUNG_USB_PHY_H */
-- 
1.7.1
