From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 27 Jul 2010 15:07:00 +0300
Subject: [PATCH 3/3 v2] [ARM] pxa/cm-x300: enable USB host port2
In-Reply-To: <1280232420-28691-1-git-send-email-grinberg@compulab.co.il>
References: <1280232420-28691-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1280232420-28691-4-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   77 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index fdda6be..f2f7f52 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <linux/gpio.h>
 #include <linux/dm9000.h>
@@ -50,6 +51,7 @@
 #include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 #include <mach/audio.h>
+#include <mach/pxa3xx-u2d.h>
 
 #include <asm/mach/map.h>
 
@@ -68,6 +70,8 @@
 #define GPIO97_RTC_RD		(97)
 #define GPIO98_RTC_IO		(98)
 
+#define GPIO_ULPI_PHY_RST	(127)
+
 static mfp_cfg_t cm_x3xx_mfp_cfg[] __initdata = {
 	/* LCD */
 	GPIO54_LCD_LDD_0,
@@ -472,6 +476,78 @@ static void __init cm_x300_init_mmc(void)
 static inline void cm_x300_init_mmc(void) {}
 #endif
 
+#if defined(CONFIG_PXA310_ULPI)
+static struct clk *pout_clk;
+
+static int cm_x300_ulpi_phy_reset(void)
+{
+	int err;
+
+	/* reset the PHY */
+	err = gpio_request(GPIO_ULPI_PHY_RST, "ulpi reset");
+	if (err) {
+		pr_err("%s: failed to request ULPI reset GPIO: %d\n",
+		       __func__, err);
+		return err;
+	}
+
+	gpio_direction_output(GPIO_ULPI_PHY_RST, 0);
+	msleep(10);
+	gpio_set_value(GPIO_ULPI_PHY_RST, 1);
+	msleep(10);
+
+	gpio_free(GPIO_ULPI_PHY_RST);
+
+	return 0;
+}
+
+static inline int cm_x300_u2d_init(struct device *dev)
+{
+	int err = 0;
+
+	if (cpu_is_pxa310()) {
+		/* CLK_POUT is connected to the ULPI PHY */
+		pout_clk = clk_get(NULL, "CLK_POUT");
+		if (IS_ERR(pout_clk)) {
+			err = PTR_ERR(pout_clk);
+			pr_err("%s: failed to get CLK_POUT: %d\n",
+			       __func__, err);
+			return err;
+		}
+		clk_enable(pout_clk);
+
+		err = cm_x300_ulpi_phy_reset();
+		if (err) {
+			clk_disable(pout_clk);
+			clk_put(pout_clk);
+		}
+	}
+
+	return err;
+}
+
+static void cm_x300_u2d_exit(struct device *dev)
+{
+	if (cpu_is_pxa310()) {
+		clk_disable(pout_clk);
+		clk_put(pout_clk);
+	}
+}
+
+static struct pxa3xx_u2d_platform_data cm_x300_u2d_platform_data = {
+	.ulpi_mode	= ULPI_SER_6PIN,
+	.init		= cm_x300_u2d_init,
+	.exit		= cm_x300_u2d_exit,
+};
+
+static void cm_x300_init_u2d(void)
+{
+	pxa3xx_set_u2d_info(&cm_x300_u2d_platform_data);
+}
+#else
+static inline void cm_x300_init_u2d(void) {}
+#endif
+
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 static int cm_x300_ohci_init(struct device *dev)
 {
@@ -752,6 +828,7 @@ static void __init cm_x300_init(void)
 	cm_x300_init_da9030();
 	cm_x300_init_dm9000();
 	cm_x300_init_lcd();
+	cm_x300_init_u2d();
 	cm_x300_init_ohci();
 	cm_x300_init_mmc();
 	cm_x300_init_nand();
-- 
1.7.1
