From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  7 Apr 2010 18:05:23 +0300
Subject: [PATCH 2/2] [ARM] pxa/cm-x300: enable USB host port 2 on modules with
	PXA310 cpu.
In-Reply-To: <cover.1270651775.git.grinberg@compulab.co.il>
References: <cover.1270651775.git.grinberg@compulab.co.il>
Message-ID: <0647d37966c6971fe9a0322704c0967bdb1129ff.1270651775.git.grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   65 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index d37cfa1..e8f02a7 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include <linux/gpio.h>
 #include <linux/dm9000.h>
@@ -52,6 +53,7 @@
 
 #include "generic.h"
 #include "devices.h"
+#include "pxa310-ulpi.h"
 
 #define CM_X300_ETH_PHYS	0x08000010
 
@@ -65,6 +67,8 @@
 #define GPIO97_RTC_RD		(97)
 #define GPIO98_RTC_IO		(98)
 
+#define GPIO127_ULPI_PHY_RST	(127)
+
 static mfp_cfg_t cm_x3xx_mfp_cfg[] __initdata = {
 	/* LCD */
 	GPIO54_LCD_LDD_0,
@@ -470,12 +474,73 @@ static inline void cm_x300_init_mmc(void) {}
 #endif
 
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static int cm_x300_ulpi_clk_enable(void)
+{
+	int err;
+	struct clk *pout_clk;
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
+static int cm_x300_ulpi_init(void)
+{
+	int err;
+
+	err = cm_x300_ulpi_clk_enable();
+	if (err)
+		return err;
+
+	err = cm_x300_ulpi_phy_reset();
+	if (err) {
+		pr_err("%s: ULPI PHY init failed!\n", __func__);
+		return err;
+	}
+
+	err = pxa310_ulpi_init(SER_6PIN);
+
+	return err;
+}
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
 
-- 
1.6.4.4
