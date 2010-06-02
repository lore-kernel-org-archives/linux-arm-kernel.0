From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  2 Jun 2010 10:40:50 +0300
Subject: [PATCH 5/5] [ARM] pxa/cm-x300: enable USB host port 2 on CM-X300 with
	PXA310 cpu.
In-Reply-To: <1275464450-23003-5-git-send-email-grinberg@compulab.co.il>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-4-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-5-git-send-email-grinberg@compulab.co.il>
Message-ID: <1275464450-23003-6-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |  102 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index d37cfa1..87ffb38 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <linux/gpio.h>
 #include <linux/dm9000.h>
@@ -35,6 +36,9 @@
 #include <linux/spi/spi_gpio.h>
 #include <linux/spi/tdo24m.h>
 
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/setup.h>
@@ -47,6 +51,7 @@
 #include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 #include <mach/audio.h>
+#include <mach/pxa310-ulpi.h>
 
 #include <asm/mach/map.h>
 
@@ -65,6 +70,8 @@
 #define GPIO97_RTC_RD		(97)
 #define GPIO98_RTC_IO		(98)
 
+#define GPIO127_ULPI_PHY_RST	(127)
+
 static mfp_cfg_t cm_x3xx_mfp_cfg[] __initdata = {
 	/* LCD */
 	GPIO54_LCD_LDD_0,
@@ -470,23 +477,118 @@ static inline void cm_x300_init_mmc(void) {}
 #endif
 
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+#if defined(CONFIG_PXA310_ULPI)
+static struct clk *pout_clk;
+
+static int cm_x300_ulpi_clk_enable(void)
+{
+	int err;
+
+	/* CLK_POUT is connected to the ULPI PHY */
+	pout_clk = clk_get(NULL, "CLK_POUT");
+	if (IS_ERR(pout_clk)) {
+		err = PTR_ERR(pout_clk);
+		pr_err("%s: failed to get CLK_POUT: %d\n", __func__, err);
+		return err;
+	}
+	clk_enable(pout_clk);
+
+	return 0;
+}
+
+static inline void cm_x300_ulpi_clk_disable(void)
+{
+	if (!IS_ERR(pout_clk)) {
+		clk_disable(pout_clk);
+		clk_put(pout_clk);
+	}
+}
+
+static int cm_x300_ulpi_phy_reset(void)
+{
+	int err;
+
+	/* reset the PHY */
+	err = gpio_request(GPIO127_ULPI_PHY_RST, "ulpi reset");
+	if (err) {
+		pr_err("%s: failed to request ULPI reset GPIO: %d\n",
+		       __func__, err);
+		return err;
+	}
+
+	gpio_direction_output(GPIO127_ULPI_PHY_RST, 0);
+	msleep(10);
+	gpio_set_value(GPIO127_ULPI_PHY_RST, 1);
+	msleep(10);
+
+	gpio_free(GPIO127_ULPI_PHY_RST);
+
+	return 0;
+}
+
+static inline int cm_x300_ulpi_init(void)
+{
+	int err;
+
+	err = cm_x300_ulpi_clk_enable();
+	if (err)
+		return err;
+
+	err = cm_x300_ulpi_phy_reset();
+	if (err)
+		pr_err("%s: ULPI PHY init failed!\n", __func__);
+
+	return err;
+}
+#else
+static inline int cm_x300_ulpi_init(void) { return 0; }
+static inline void cm_x300_ulpi_clk_disable(void) {}
+#endif /* CONFIG_PXA310_ULPI */
+
 static int cm_x300_ohci_init(struct device *dev)
 {
 	if (cpu_is_pxa300())
 		UP2OCR = UP2OCR_HXS
 			| UP2OCR_HXOE | UP2OCR_DMPDE | UP2OCR_DPPDE;
 
+	if (cpu_is_pxa310())
+		cm_x300_ulpi_init();
+
 	return 0;
 }
 
+static void cm_x300_ohci_exit(struct device *dev)
+{
+	if (cpu_is_pxa310())
+		cm_x300_ulpi_clk_disable();
+}
+
 static struct pxaohci_platform_data cm_x300_ohci_platform_data = {
 	.port_mode	= PMM_PERPORT_MODE,
 	.flags		= ENABLE_PORT_ALL | POWER_CONTROL_LOW,
 	.init		= cm_x300_ohci_init,
+	.exit		= cm_x300_ohci_exit,
+
+#if defined(CONFIG_PXA310_ULPI)
+	.ulpi_mode	= ULPI_IC_6PIN,
+#endif
 };
 
 static void __init cm_x300_init_ohci(void)
 {
+	if (cpu_is_pxa310()) {
+#if defined(CONFIG_PXA310_ULPI)
+		cm_x300_ohci_platform_data.otg =
+			otg_ulpi_create(&pxa310_ulpi_access_ops,
+					USB_OTG_PULLDOWN_DM |
+					USB_OTG_PULLDOWN_DP |
+					USB_OTG_DRV_VBUS,
+					ULPI_IC_6PIN,
+					ULPI_FC_DEFAULT |
+					ULPI_FC_TRM_SEL);
+#endif
+	}
+
 	pxa_set_ohci_info(&cm_x300_ohci_platform_data);
 }
 #else
-- 
1.6.4.4
