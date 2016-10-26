From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 22:06:47 -0500
Subject: [PATCH v6 1/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1477451211-31979-1-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
Message-ID: <1477451211-31979-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to this point, the USB phy clock configuration was handled manually in
the board files and in the usb drivers. This adds proper clocks so that
the usb drivers can use clk_get and clk_enable and not have to worry about
the details. Also, the related code is removed from the board files and
replaced with the new clock registration functions.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---

I have added "ARM: davinci: da8xx: Enable the usb20 "per" clk on phy_clk_enable"
from Axel Haslam to this patch.

In the review of Axel's patch, Sekhar said:

> We should not be using a NULL device pointer here. Can you pass the musb
> device pointer available in the same file? Also, da850_clks[] in da850.c
> needs to be fixed to add the matching device name.

However, the musb device may not be registered. The usb20_clk can be used to
supply a 48MHz clock to USB 1.1 (ohci) without using the musb device. So, I am
inclined to leave this as NULL.


 arch/arm/mach-davinci/board-da830-evm.c     |  22 ++-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  16 +-
 arch/arm/mach-davinci/include/mach/da8xx.h  |   3 +
 arch/arm/mach-davinci/usb-da8xx.c           | 232 +++++++++++++++++++++++++++-
 4 files changed, 252 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 3d8cf8c..605d444 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -115,18 +115,6 @@ static __init void da830_evm_usb_init(void)
 	 */
 	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
-	/* USB2.0 PHY reference clock is 24 MHz */
-	cfgchip2 &= ~CFGCHIP2_REFFREQ;
-	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
-
-	/*
-	 * Select internal reference clock for USB 2.0 PHY
-	 * and use it as a clock source for USB 1.1 PHY
-	 * (this is the default setting anyway).
-	 */
-	cfgchip2 &= ~CFGCHIP2_USB1PHYCLKMUX;
-	cfgchip2 |=  CFGCHIP2_USB2PHYCLKMUX;
-
 	/*
 	 * We have to override VBUS/ID signals when MUSB is configured into the
 	 * host-only mode -- ID pin will float if no cable is connected, so the
@@ -143,6 +131,16 @@ static __init void da830_evm_usb_init(void)
 	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
 	/* USB_REFCLKIN is not used. */
+	ret = da8xx_register_usb20_phy_clk(false);
+	if (ret)
+		pr_warn("%s: USB 2.0 PHY CLK registration failed: %d\n",
+			__func__, ret);
+
+	ret = da8xx_register_usb11_phy_clk(false);
+	if (ret)
+		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
+			__func__, ret);
+
 	ret = davinci_cfg_reg(DA830_USB0_DRVVBUS);
 	if (ret)
 		pr_warn("%s: USB 2.0 PinMux setup failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index ee62486..d4930b6 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -243,7 +243,6 @@ static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
 static __init void omapl138_hawk_usb_init(void)
 {
 	int ret;
-	u32 cfgchip2;
 
 	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
 	if (ret) {
@@ -251,12 +250,15 @@ static __init void omapl138_hawk_usb_init(void)
 		return;
 	}
 
-	/* Setup the Ref. clock frequency for the HAWK at 24 MHz. */
-
-	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-	cfgchip2 &= ~CFGCHIP2_REFFREQ;
-	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
-	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+	/* USB_REFCLKIN is not used. */
+	ret = da8xx_register_usb20_phy_clk(false);
+	if (ret)
+		pr_warn("%s: USB 2.0 PHY CLK registration failed: %d\n",
+			__func__, ret);
+	ret = da8xx_register_usb11_phy_clk(false);
+	if (ret)
+		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
+			__func__, ret);
 
 	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
 			GPIOF_DIR_OUT, "USB1 VBUS");
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index f9f9713..c367530 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -88,6 +88,9 @@ int da850_register_edma(struct edma_rsv_info *rsv[2]);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
 int da8xx_register_spi_bus(int instance, unsigned num_chipselect);
 int da8xx_register_watchdog(void);
+int da8xx_register_usb_refclkin(int rate);
+int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
+int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_emac(void);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index f141f51..71a6d85 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -1,20 +1,248 @@
 /*
  * DA8xx USB
  */
-#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/usb/musb.h>
 
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
+
+#include "clock.h"
 
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
+static struct clk usb_refclkin = {
+	.name		= "usb_refclkin",
+	.set_rate	= davinci_simple_set_rate,
+};
+
+static struct clk_lookup usb_refclkin_lookup =
+	CLK(NULL, "usb_refclkin", &usb_refclkin);
+
+/**
+ * da8xx_register_usb_refclkin - register USB_REFCLKIN clock
+ *
+ * @rate: The clock rate in Hz
+ *
+ * This clock is only needed if the board provides an external USB_REFCLKIN
+ * signal, in which case it will be used as the parent of usb20_phy_clk and/or
+ * usb11_phy_clk.
+ */
+int __init da8xx_register_usb_refclkin(int rate)
+{
+	int ret;
+
+	usb_refclkin.rate = rate;
+	ret = clk_register(&usb_refclkin);
+	if (ret)
+		return ret;
+
+	clkdev_add(&usb_refclkin_lookup);
+
+	return 0;
+}
+
+static void usb20_phy_clk_enable(struct clk *clk)
+{
+	struct clk *usb20_clk;
+	u32 val;
+	u32 timeout = 500000; /* 500 msec */
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	usb20_clk = clk_get(NULL, "usb20");
+	if (IS_ERR(usb20_clk)) {
+		pr_err("could not get usb20 clk\n");
+		return;
+	}
+
+	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
+	clk_prepare_enable(usb20_clk);
+
+	/*
+	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
+	 * host may use the PLL clock without USB 2.0 OTG being used.
+	 */
+	val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
+	val |= CFGCHIP2_PHY_PLLON;
+
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	while (--timeout) {
+		val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+		if (val & CFGCHIP2_PHYCLKGD)
+			goto done;
+		udelay(1);
+	}
+
+	pr_err("Timeout waiting for USB 2.0 PHY clock good.\n");
+done:
+	clk_disable_unprepare(usb20_clk);
+	clk_put(usb20_clk);
+}
+
+static void usb20_phy_clk_disable(struct clk *clk)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+	val |= CFGCHIP2_PHYPWRDN;
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+}
+
+static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	/* Set the mux depending on the parent clock. */
+	if (parent == &usb_refclkin) {
+		val &= ~CFGCHIP2_USB2PHYCLKMUX;
+	} else if (strcmp(parent->name, "pll0_aux_clk") == 0) {
+		val |= CFGCHIP2_USB2PHYCLKMUX;
+	} else {
+		pr_err("Bad parent on USB 2.0 PHY clock.\n");
+		return -EINVAL;
+	}
+
+	/* reference frequency also comes from parent clock */
+	val &= ~CFGCHIP2_REFFREQ_MASK;
+	switch (clk_get_rate(parent)) {
+	case 12000000:
+		val |= CFGCHIP2_REFFREQ_12MHZ;
+		break;
+	case 13000000:
+		val |= CFGCHIP2_REFFREQ_13MHZ;
+		break;
+	case 19200000:
+		val |= CFGCHIP2_REFFREQ_19_2MHZ;
+		break;
+	case 20000000:
+		val |= CFGCHIP2_REFFREQ_20MHZ;
+		break;
+	case 24000000:
+		val |= CFGCHIP2_REFFREQ_24MHZ;
+		break;
+	case 26000000:
+		val |= CFGCHIP2_REFFREQ_26MHZ;
+		break;
+	case 38400000:
+		val |= CFGCHIP2_REFFREQ_38_4MHZ;
+		break;
+	case 40000000:
+		val |= CFGCHIP2_REFFREQ_40MHZ;
+		break;
+	case 48000000:
+		val |= CFGCHIP2_REFFREQ_48MHZ;
+		break;
+	default:
+		pr_err("Bad parent clock rate on USB 2.0 PHY clock.\n");
+		return -EINVAL;
+	}
+
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	return 0;
+}
+
+static struct clk usb20_phy_clk = {
+	.name		= "usb20_phy",
+	.clk_enable	= usb20_phy_clk_enable,
+	.clk_disable	= usb20_phy_clk_disable,
+	.set_parent	= usb20_phy_clk_set_parent,
+};
+
+static struct clk_lookup usb20_phy_clk_lookup =
+	CLK(NULL, "usb20_phy", &usb20_phy_clk);
+
+/**
+ * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
+ *
+ * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
+ *	or "pll0_aux" if false.
+ */
+int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
+{
+	struct clk *parent;
+	int ret = 0;
+
+	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	usb20_phy_clk.parent = parent;
+	ret = clk_register(&usb20_phy_clk);
+	if (!ret)
+		clkdev_add(&usb20_phy_clk_lookup);
+
+	clk_put(parent);
+
+	return ret;
+}
+
+static int usb11_phy_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
+	if (parent == &usb20_phy_clk) {
+		val &= ~CFGCHIP2_USB1PHYCLKMUX;
+	} else if (parent == &usb_refclkin) {
+		val |= CFGCHIP2_USB1PHYCLKMUX;
+	} else {
+		pr_err("Bad parent on USB 1.1 PHY clock.\n");
+		return -EINVAL;
+	}
+
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	return 0;
+}
+
+static struct clk usb11_phy_clk = {
+	.name		= "usb11_phy",
+	.set_parent	= usb11_phy_clk_set_parent,
+};
+
+static struct clk_lookup usb11_phy_clk_lookup =
+	CLK(NULL, "usb11_phy", &usb11_phy_clk);
+
+/**
+ * da8xx_register_usb11_phy_clk - register USB1PHYCLKMUX clock
+ *
+ * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
+ *	or "usb20_phy" if false.
+ */
+int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
+{
+	struct clk *parent;
+	int ret = 0;
+
+	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "usb20_phy");
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	usb11_phy_clk.parent = parent;
+	ret = clk_register(&usb11_phy_clk);
+	if (!ret)
+		clkdev_add(&usb11_phy_clk_lookup);
+
+	clk_put(parent);
+
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
 
 static struct musb_hdrc_config musb_config = {
-- 
2.7.4
