From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:25:03 -0600
Subject: [PATCH v5 40/44] ARM: da8xx: Remove legacy clock init
Message-ID: <1515378307-23718-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the unused legacy clock init code from
arch/arm/mach-davinci/{devices,usb}-da8xx}.c.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |  29 -----
 arch/arm/mach-davinci/usb-da8xx.c     | 238 ----------------------------------
 2 files changed, 267 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 7ffacb9..d3660fd 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -31,11 +31,6 @@
 #include "cpuidle.h"
 #include "sram.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include <mach/clock.h>
-#include "clock.h"
-#endif
-
 #define DA8XX_TPCC_BASE			0x01c00000
 #define DA8XX_TPTC0_BASE		0x01c08000
 #define DA8XX_TPTC1_BASE		0x01c08400
@@ -1046,29 +1041,6 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
-#ifndef CONFIG_COMMON_CLK
-static struct clk sata_refclk = {
-	.name		= "sata_refclk",
-	.set_rate	= davinci_simple_set_rate,
-};
-
-static struct clk_lookup sata_refclk_lookup =
-		CLK("ahci_da850", "refclk", &sata_refclk);
-
-int __init da850_register_sata_refclk(int rate)
-{
-	int ret;
-
-	sata_refclk.rate = rate;
-	ret = clk_register(&sata_refclk);
-	if (ret)
-		return ret;
-
-	clkdev_add(&sata_refclk_lookup);
-
-	return 0;
-}
-#else
 int __init da850_register_sata_refclk(int rate)
 {
 	struct clk *clk;
@@ -1079,7 +1051,6 @@ int __init da850_register_sata_refclk(int rate)
 
 	return clk_register_clkdev(clk, "refclk", "ahci_da850");
 }
-#endif
 
 static struct resource da850_sata_resources[] = {
 	{
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index d7340670..d05a6c7 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -21,18 +21,9 @@
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 
-#ifndef CONFIG_COMMON_CLK
-#include <mach/clock.h>
-#include "clock.h"
-#endif
-
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
-#ifndef CONFIG_COMMON_CLK
-static struct clk *usb20_clk;
-#endif
-
 static struct platform_device da8xx_usb_phy = {
 	.name		= "da8xx-usb-phy",
 	.id		= -1,
@@ -136,234 +127,6 @@ int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
 	return platform_device_register(&da8xx_usb11_device);
 }
 
-#ifndef CONFIG_COMMON_CLK
-static struct clk usb_refclkin = {
-	.name		= "usb_refclkin",
-	.set_rate	= davinci_simple_set_rate,
-};
-
-static struct clk_lookup usb_refclkin_lookup =
-	CLK(NULL, "usb_refclkin", &usb_refclkin);
-
-/**
- * da8xx_register_usb_refclkin - register USB_REFCLKIN clock
- *
- * @rate: The clock rate in Hz
- *
- * This clock is only needed if the board provides an external USB_REFCLKIN
- * signal, in which case it will be used as the parent of usb20_phy_clk and/or
- * usb11_phy_clk.
- */
-int __init da8xx_register_usb_refclkin(int rate)
-{
-	int ret;
-
-	usb_refclkin.rate = rate;
-	ret = clk_register(&usb_refclkin);
-	if (ret)
-		return ret;
-
-	clkdev_add(&usb_refclkin_lookup);
-
-	return 0;
-}
-
-static void usb20_phy_clk_enable(struct clk *clk)
-{
-	u32 val;
-	u32 timeout = 500000; /* 500 msec */
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
-	davinci_clk_enable(usb20_clk);
-
-	/*
-	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
-	 * host may use the PLL clock without USB 2.0 OTG being used.
-	 */
-	val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
-	val |= CFGCHIP2_PHY_PLLON;
-
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	while (--timeout) {
-		val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-		if (val & CFGCHIP2_PHYCLKGD)
-			goto done;
-		udelay(1);
-	}
-
-	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
-done:
-	davinci_clk_disable(usb20_clk);
-}
-
-static void usb20_phy_clk_disable(struct clk *clk)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-	val |= CFGCHIP2_PHYPWRDN;
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-}
-
-static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/* Set the mux depending on the parent clock. */
-	if (parent == &usb_refclkin) {
-		val &= ~CFGCHIP2_USB2PHYCLKMUX;
-	} else if (strcmp(parent->name, "pll0_aux_clk") == 0) {
-		val |= CFGCHIP2_USB2PHYCLKMUX;
-	} else {
-		pr_err("Bad parent on USB 2.0 PHY clock\n");
-		return -EINVAL;
-	}
-
-	/* reference frequency also comes from parent clock */
-	val &= ~CFGCHIP2_REFFREQ_MASK;
-	switch (clk_get_rate(parent)) {
-	case 12000000:
-		val |= CFGCHIP2_REFFREQ_12MHZ;
-		break;
-	case 13000000:
-		val |= CFGCHIP2_REFFREQ_13MHZ;
-		break;
-	case 19200000:
-		val |= CFGCHIP2_REFFREQ_19_2MHZ;
-		break;
-	case 20000000:
-		val |= CFGCHIP2_REFFREQ_20MHZ;
-		break;
-	case 24000000:
-		val |= CFGCHIP2_REFFREQ_24MHZ;
-		break;
-	case 26000000:
-		val |= CFGCHIP2_REFFREQ_26MHZ;
-		break;
-	case 38400000:
-		val |= CFGCHIP2_REFFREQ_38_4MHZ;
-		break;
-	case 40000000:
-		val |= CFGCHIP2_REFFREQ_40MHZ;
-		break;
-	case 48000000:
-		val |= CFGCHIP2_REFFREQ_48MHZ;
-		break;
-	default:
-		pr_err("Bad parent clock rate on USB 2.0 PHY clock\n");
-		return -EINVAL;
-	}
-
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	return 0;
-}
-
-static struct clk usb20_phy_clk = {
-	.name		= "usb20_phy",
-	.clk_enable	= usb20_phy_clk_enable,
-	.clk_disable	= usb20_phy_clk_disable,
-	.set_parent	= usb20_phy_clk_set_parent,
-};
-
-static struct clk_lookup usb20_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb20_phy", &usb20_phy_clk);
-
-/**
- * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
- *
- * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
- *	or "pll0_aux" if false.
- */
-int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
-{
-	struct clk *parent;
-	int ret;
-
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
-	ret = PTR_ERR_OR_ZERO(usb20_clk);
-	if (ret)
-		return ret;
-
-	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
-	ret = PTR_ERR_OR_ZERO(parent);
-	if (ret) {
-		clk_put(usb20_clk);
-		return ret;
-	}
-
-	usb20_phy_clk.parent = parent;
-	ret = clk_register(&usb20_phy_clk);
-	if (!ret)
-		clkdev_add(&usb20_phy_clk_lookup);
-
-	clk_put(parent);
-
-	return ret;
-}
-
-static int usb11_phy_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
-	if (parent == &usb20_phy_clk) {
-		val &= ~CFGCHIP2_USB1PHYCLKMUX;
-	} else if (parent == &usb_refclkin) {
-		val |= CFGCHIP2_USB1PHYCLKMUX;
-	} else {
-		pr_err("Bad parent on USB 1.1 PHY clock\n");
-		return -EINVAL;
-	}
-
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	return 0;
-}
-
-static struct clk usb11_phy_clk = {
-	.name		= "usb11_phy",
-	.set_parent	= usb11_phy_clk_set_parent,
-};
-
-static struct clk_lookup usb11_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb11_phy", &usb11_phy_clk);
-
-/**
- * da8xx_register_usb11_phy_clk - register USB1PHYCLKMUX clock
- *
- * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
- *	or "usb20_phy" if false.
- */
-int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
-{
-	struct clk *parent;
-	int ret = 0;
-
-	if (use_usb_refclkin)
-		parent = clk_get(NULL, "usb_refclkin");
-	else
-		parent = clk_get(&da8xx_usb_phy.dev, "usb20_phy");
-	if (IS_ERR(parent))
-		return PTR_ERR(parent);
-
-	usb11_phy_clk.parent = parent;
-	ret = clk_register(&usb11_phy_clk);
-	if (!ret)
-		clkdev_add(&usb11_phy_clk_lookup);
-
-	clk_put(parent);
-
-	return ret;
-}
-#else
 /**
  * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
  *
@@ -435,4 +198,3 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 
 	return clk_register_clkdev(clk, "usb11_phy", "da8xx-usb-phy");
 }
-#endif
-- 
2.7.4
