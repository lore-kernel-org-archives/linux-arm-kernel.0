From: david@lechnology.com (David Lechner)
Date: Mon, 31 Oct 2016 15:47:20 -0500
Subject: [PATCH v8 2/3] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1477946841-16126-1-git-send-email-david@lechnology.com>
References: <1477946841-16126-1-git-send-email-david@lechnology.com>
Message-ID: <1477946841-16126-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to this point, the USB phy clock configuration was handled manually in
the board files and in the usb drivers. This adds proper clocks so that
the usb drivers can use clk_get and clk_enable and not have to worry about
the details. Also, the related code is removed from the board files and
replaced with the new clock registration functions.

This also removes the #if IS_ENABLED(CONFIG_USB_MUSB_HDRC) around the musb
declaration and renames the musb platform device so that we can reference
it from the usb20 clock even if the musb device is not used.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  31 +---
 arch/arm/mach-davinci/board-omapl138-hawk.c |  15 +-
 arch/arm/mach-davinci/include/mach/da8xx.h  |   3 +
 arch/arm/mach-davinci/usb-da8xx.c           | 267 ++++++++++++++++++++++++++--
 4 files changed, 274 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 53172ad..5db0901 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -18,7 +18,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pcf857x.h>
 #include <linux/platform_data/at24.h>
-#include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
@@ -108,30 +107,18 @@ static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
 
 static __init void da830_evm_usb_init(void)
 {
-	u32 cfgchip2;
 	int ret;
 
-	/*
-	 * Set up USB clock in the CFGCHIP2 register.
-	 * FYI:  CFGCHIP2 is 0x0000ef00 initially.
-	 */
-	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/* USB2.0 PHY reference clock is 24 MHz */
-	cfgchip2 &= ~CFGCHIP2_REFFREQ_MASK;
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
-	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
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
 
 	ret = da8xx_register_usb_phy();
 	if (ret)
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 67477ca..a4e8726 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/gpio.h>
-#include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/regulator/machine.h>
 
@@ -245,7 +244,6 @@ static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
 static __init void omapl138_hawk_usb_init(void)
 {
 	int ret;
-	u32 cfgchip2;
 
 	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
 	if (ret) {
@@ -253,12 +251,15 @@ static __init void omapl138_hawk_usb_init(void)
 		return;
 	}
 
-	/* Setup the Ref. clock frequency for the HAWK at 24 MHz. */
+	ret = da8xx_register_usb20_phy_clk(false);
+	if (ret)
+		pr_warn("%s: USB 2.0 PHY CLK registration failed: %d\n",
+			__func__, ret);
 
-	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-	cfgchip2 &= ~CFGCHIP2_REFFREQ_MASK;
-	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
-	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+	ret = da8xx_register_usb11_phy_clk(false);
+	if (ret)
+		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
+			__func__, ret);
 
 	ret = da8xx_register_usb_phy();
 	if (ret)
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 5e07d06..43322be 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -92,6 +92,9 @@ int da8xx_register_watchdog(void);
 int da8xx_register_usb_phy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
+int da8xx_register_usb_refclkin(int rate);
+int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
+int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
 int da8xx_register_emac(void);
 int da8xx_register_uio_pruss(void);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 4bb1903..b010e5f 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -1,24 +1,38 @@
 /*
  * DA8xx USB
  */
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
+#include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 
+#include "clock.h"
+
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
 static struct platform_device da8xx_usb_phy = {
 	.name		= "da8xx-usb-phy",
 	.id		= -1,
+	.dev		= {
+		/*
+		 * Setting init_name so that clock lookup will work in
+		 * da8xx_register_usb11_phy_clk() even if this device is not
+		 * registered yet.
+		 */
+		.init_name	= "da8xx-usb-phy",
+	},
 };
 
 int __init da8xx_register_usb_phy(void)
@@ -26,8 +40,6 @@ int __init da8xx_register_usb_phy(void)
 	return platform_device_register(&da8xx_usb_phy);
 }
 
-#if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
-
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= true,
 	.num_eps	= 5,
@@ -56,10 +68,15 @@ static struct resource da8xx_usb20_resources[] = {
 
 static u64 usb_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device usb_dev = {
+static struct platform_device da8xx_usb20_dev = {
 	.name		= "musb-da8xx",
 	.id             = -1,
 	.dev = {
+		/*
+		 * Setting init_name so that clock lookup will work in
+		 * usb20_phy_clk_enable() even if this device is not registered.
+		 */
+		.init_name		= "musb-da8xx",
 		.platform_data		= &usb_data,
 		.dma_mask		= &usb_dmamask,
 		.coherent_dma_mask      = DMA_BIT_MASK(32),
@@ -73,18 +90,9 @@ int __init da8xx_register_usb20(unsigned int mA, unsigned int potpgt)
 	usb_data.power	= mA > 510 ? 255 : mA / 2;
 	usb_data.potpgt = (potpgt + 1) / 2;
 
-	return platform_device_register(&usb_dev);
-}
-
-#else
-
-int __init da8xx_register_usb20(unsigned int mA, unsigned int potpgt)
-{
-	return 0;
+	return platform_device_register(&da8xx_usb20_dev);
 }
 
-#endif  /* CONFIG_USB_MUSB_HDRC */
-
 static struct resource da8xx_usb11_resources[] = {
 	[0] = {
 		.start	= DA8XX_USB1_BASE,
@@ -116,3 +124,236 @@ int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
 	da8xx_usb11_device.dev.platform_data = pdata;
 	return platform_device_register(&da8xx_usb11_device);
 }
+
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
+	int err;
+	u32 val;
+	u32 timeout = 500000; /* 500 msec */
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
+	if (IS_ERR(usb20_clk)) {
+		pr_err("could not get usb20 clk: %ld\n", PTR_ERR(usb20_clk));
+		return;
+	}
+
+	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
+	err = clk_prepare_enable(usb20_clk);
+	if (err) {
+		pr_err("failed to enable usb20 clk: %d\n", err);
+		clk_put(usb20_clk);
+		return;
+	}
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
+	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
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
+		pr_err("Bad parent on USB 2.0 PHY clock\n");
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
+		pr_err("Bad parent clock rate on USB 2.0 PHY clock\n");
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
+	CLK("da8xx-usb-phy", "usb20_phy", &usb20_phy_clk);
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
+		pr_err("Bad parent on USB 1.1 PHY clock\n");
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
+	CLK("da8xx-usb-phy", "usb11_phy", &usb11_phy_clk);
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
+	if (use_usb_refclkin)
+		parent = clk_get(NULL, "usb_refclkin");
+	else
+		parent = clk_get(&da8xx_usb_phy.dev, "usb20_phy");
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
-- 
2.7.4
