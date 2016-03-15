From: david@lechnology.com (David Lechner)
Date: Tue, 15 Mar 2016 17:37:50 -0500
Subject: [PATCH 2/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <1458081473-8223-1-git-send-email-david@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
Message-ID: <1458081473-8223-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to this point, the USB phy clock configuration was handled manually in
the board files and in the usb drivers. This adds proper clocks so that
the usb drivers can use clk_get and clk_enable and not have to worry about
the details. Also, the related code is removed from the board files.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  12 ---
 arch/arm/mach-davinci/board-omapl138-hawk.c |   7 --
 arch/arm/mach-davinci/da830.c               | 128 ++++++++++++++++++++++++++--
 arch/arm/mach-davinci/da850.c               | 113 ++++++++++++++++++++++++
 4 files changed, 233 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 3d8cf8c..f3a8cc9 100644
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
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index ee62486..d27e753 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -251,13 +251,6 @@ static __init void omapl138_hawk_usb_init(void)
 		return;
 	}
 
-	/* Setup the Ref. clock frequency for the HAWK at 24 MHz. */
-
-	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-	cfgchip2 &= ~CFGCHIP2_REFFREQ;
-	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
-	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
 	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
 			GPIOF_DIR_OUT, "USB1 VBUS");
 	if (ret < 0) {
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 7187e7f..213fb17e 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_data/usb-davinci.h>
 
 #include <asm/mach/map.h>
 
@@ -297,13 +298,6 @@ static struct clk mcasp2_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk usb20_clk = {
-	.name		= "usb20",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_USB20,
-	.gpsc		= 1,
-};
-
 static struct clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll0_sysclk3,
@@ -346,6 +340,12 @@ static struct clk i2c1_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk usb_ref_clk = {
+	.name		= "usb_ref_clk",
+	.rate		= 48000000,
+	.set_rate	= davinci_simple_set_rate,
+};
+
 static struct clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
@@ -353,6 +353,115 @@ static struct clk usb11_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk usb20_clk = {
+	.name		= "usb20",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_USB20,
+	.gpsc		= 1,
+};
+
+static void usb20_phy_clk_enable(struct clk *clk)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	/*
+	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
+	 * host may use the PLL clock without USB 2.0 OTG being used.
+	 */
+		val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
+		val |= CFGCHIP2_PHY_PLLON;
+
+	/* Set the mux depending on the parent clock. */
+	if (clk->parent == &pll0_aux_clk)
+		val |= CFGCHIP2_USB2PHYCLKMUX;
+	else if (clk->parent == &usb_ref_clk)
+		val &= ~CFGCHIP2_USB2PHYCLKMUX;
+	else
+		pr_err("Bad parent on USB 2.0 PHY clock.\n");
+
+	/* reference frequency also comes from parent clock */
+	val &= ~CFGCHIP2_REFFREQ;
+	switch (clk_get_rate(clk->parent)) {
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
+		break;
+	}
+
+		writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	pr_info("Waiting for USB 2.0 PHY clock good...\n");
+		while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
+							 & CFGCHIP2_PHYCLKGD))
+			cpu_relax();
+	}
+
+static void usb20_phy_clk_disable(struct clk *clk)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+	val |= CFGCHIP2_PHYPWRDN;
+	__raw_writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+}
+
+static struct clk usb20_phy_clk = {
+	.name		= "usb20_phy",
+	.parent		= &pll0_aux_clk, /* or &usb_ref_clk */
+	.clk_enable	= usb20_phy_clk_enable,
+	.clk_disable	= usb20_phy_clk_disable,
+};
+
+static void usb11_phy_clk_enable(struct clk *clk)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
+	if (clk->parent == &usb20_phy_clk)
+		val &= ~CFGCHIP2_USB1PHYCLKMUX;
+	else if (clk->parent == &usb_ref_clk)
+		val &= ~CFGCHIP2_USB1PHYCLKMUX;
+	else
+		pr_err("Bad parent on USB 1.1 PHY clock.\n");
+
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+}
+
+static struct clk usb11_phy_clk = {
+	.name		= "usb11_phy",
+	.parent		= &usb20_phy_clk, /* or &usb_ref_clk */
+	.clk_enable	= usb11_phy_clk_enable,
+};
 static struct clk emif3_clk = {
 	.name		= "emif3",
 	.parent		= &pll0_sysclk5,
@@ -412,7 +521,6 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK(NULL,		"usb20",	&usb20_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
@@ -420,7 +528,11 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci_mdio.0",   "fck",          &emac_clk),
 	CLK(NULL,		"gpio",		&gpio_clk),
 	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
+	CLK(NULL,		"usb_ref_clk",	&usb_ref_clk),
 	CLK(NULL,		"usb11",	&usb11_clk),
+	CLK(NULL,		"usb20",	&usb20_clk),
+	CLK(NULL,		"usb20_phy",	&usb20_phy_clk),
+	CLK(NULL,		"usb11_phy",	&usb11_phy_clk),
 	CLK(NULL,		"emif3",	&emif3_clk),
 	CLK(NULL,		"arm",		&arm_clk),
 	CLK(NULL,		"rmii",		&rmii_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 97d8779..649d3fa 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -19,6 +19,7 @@
 #include <linux/cpufreq.h>
 #include <linux/regulator/consumer.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_data/usb-davinci.h>
 
 #include <asm/mach/map.h>
 
@@ -333,6 +334,12 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
+static struct clk usb_ref_clk = {
+	.name		= "usb_ref_clk",
+	.rate		= 48000000,
+	.set_rate	= davinci_simple_set_rate,
+};
+
 static struct clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
@@ -347,6 +354,109 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
+static void usb20_phy_clk_enable(struct clk *clk)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	/*
+	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
+	 * host may use the PLL clock without USB 2.0 OTG being used.
+	 */
+	val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
+	val |= CFGCHIP2_PHY_PLLON;
+
+	/* Set the mux depending on the parent clock. */
+	if (clk->parent == &pll0_aux_clk)
+		val |= CFGCHIP2_USB2PHYCLKMUX;
+	else if (clk->parent == &usb_ref_clk)
+		val &= ~CFGCHIP2_USB2PHYCLKMUX;
+	else
+		pr_err("Bad parent on USB 2.0 PHY clock.\n");
+
+	/* reference frequency also comes from parent clock */
+	val &= ~CFGCHIP2_REFFREQ;
+	switch (clk_get_rate(clk->parent)) {
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
+		break;
+	}
+
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	pr_info("Waiting for USB 2.0 PHY clock good...\n");
+	while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
+						& CFGCHIP2_PHYCLKGD))
+		cpu_relax();
+}
+
+static void usb20_phy_clk_disable(struct clk *clk)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+	val |= CFGCHIP2_PHYPWRDN;
+	__raw_writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+}
+
+static struct clk usb20_phy_clk = {
+	.name		= "usb20_phy",
+	.parent		= &pll0_aux_clk, /* or &usb_ref_clk */
+	.clk_enable	= usb20_phy_clk_enable,
+	.clk_disable	= usb20_phy_clk_disable,
+};
+
+static void usb11_phy_clk_enable(struct clk *clk)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
+	if (clk->parent == &usb20_phy_clk)
+		val &= ~CFGCHIP2_USB1PHYCLKMUX;
+	else if (clk->parent == &usb_ref_clk)
+		val &= ~CFGCHIP2_USB1PHYCLKMUX;
+	else
+		pr_err("Bad parent on USB 1.1 PHY clock.\n");
+
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+}
+
+static struct clk usb11_phy_clk = {
+	.name		= "usb11_phy",
+	.parent		= &usb20_phy_clk, /* or &usb_ref_clk */
+	.clk_enable	= usb11_phy_clk_enable,
+};
+
 static struct clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll0_sysclk2,
@@ -468,8 +578,11 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
+	CLK(NULL,		"usb_ref_clk",	&usb_ref_clk),
 	CLK(NULL,		"usb11",	&usb11_clk),
 	CLK(NULL,		"usb20",	&usb20_clk),
+	CLK(NULL,		"usb20_phy",	&usb20_phy_clk),
+	CLK(NULL,		"usb11_phy",	&usb11_phy_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
-- 
1.9.1
