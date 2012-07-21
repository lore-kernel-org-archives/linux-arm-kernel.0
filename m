From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 21 Jul 2012 16:02:06 +0530
Subject: [PATCH 5/8 v2] ARM: EXYNOS5: Add PHY initialization code for usb 2.0
In-Reply-To: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1342866729-30460-6-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PHY setup functions usb 2.0 support on exynos5

Signed-off-by: Yulgon Kim <yulgon.kim@samsung.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                     |    1 +
 arch/arm/mach-exynos/include/mach/regs-usb-phy.h |   86 ++++++++
 arch/arm/mach-exynos/setup-usb-phy.c             |  232 +++++++++++++++++++++-
 3 files changed, 311 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e698ca0..e0bc441 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -416,6 +416,7 @@ config MACH_EXYNOS5_DT
 	select SOC_EXYNOS5250
 	select USE_OF
 	select ARM_AMBA
+	select EXYNOS4_SETUP_USB_PHY
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the EXYNOS4 SoC based board.
diff --git a/arch/arm/mach-exynos/include/mach/regs-usb-phy.h b/arch/arm/mach-exynos/include/mach/regs-usb-phy.h
index 0727773..2df4bd7 100644
--- a/arch/arm/mach-exynos/include/mach/regs-usb-phy.h
+++ b/arch/arm/mach-exynos/include/mach/regs-usb-phy.h
@@ -13,6 +13,7 @@
 
 #define EXYNOS4_HSOTG_PHYREG(x)		((x) + S3C_VA_USB_HSPHY)
 
+/* Exynos 4 */
 #define EXYNOS4_PHYPWR			EXYNOS4_HSOTG_PHYREG(0x00)
 #define PHY1_HSIC_NORMAL_MASK		(0xf << 9)
 #define PHY1_HSIC1_SLEEP		(1 << 12)
@@ -71,4 +72,89 @@
 #define EXYNOS4_PHY1CON			EXYNOS4_HSOTG_PHYREG(0x34)
 #define FPENABLEN			(1 << 0)
 
+/* Exynos 5 */
+#define EXYNOS5_PHY_HOST_CTRL0			EXYNOS4_HSOTG_PHYREG(0x00)
+#define HOST_CTRL0_PHYSWRSTALL			(0x1 << 31)
+
+#define HOST_CTRL0_REFCLKSEL_XTAL		(0x0)
+#define HOST_CTRL0_REFCLKSEL_EXTL		(0x1)
+#define HOST_CTRL0_REFCLKSEL_CLK_CORE		(0x2)
+#define HOST_CTRL0_REFCLKSEL_MASK		(0x3)
+#define HOST_CTRL0_REFCLKSEL_SHIFT		(19)
+
+#define EXYNOS5_CLKSEL_50M			(0x7)
+#define EXYNOS5_CLKSEL_24M			(0x5)
+#define EXYNOS5_CLKSEL_20M			(0x4)
+#define EXYNOS5_CLKSEL_19200K			(0x3)
+#define EXYNOS5_CLKSEL_12M			(0x2)
+#define EXYNOS5_CLKSEL_10M			(0x1)
+#define EXYNOS5_CLKSEL_9600K			(0x0)
+#define HOST_CTRL0_FSEL_MASK			(0x7 << 16)
+#define HOST_CTRL0_CLKSEL_SHIFT			(16)
+
+#define HOST_CTRL0_COMMONON_N			(0x1 << 9)
+#define HOST_CTRL0_SIDDQ			(0x1 << 6)
+#define HOST_CTRL0_FORCESLEEP			(0x1 << 5)
+#define HOST_CTRL0_FORCESUSPEND			(0x1 << 4)
+#define HOST_CTRL0_WORDINTERFACE		(0x1 << 3)
+#define HOST_CTRL0_UTMISWRST			(0x1 << 2)
+#define HOST_CTRL0_LINKSWRST			(0x1 << 1)
+#define HOST_CTRL0_PHYSWRST			(0x1 << 0)
+
+#define EXYNOS5_PHY_HOST_TUNE0			EXYNOS4_HSOTG_PHYREG(0x04)
+#define EXYNOS5_PHY_HOST_TEST0			EXYNOS4_HSOTG_PHYREG(0x08)
+
+#define EXYNOS5_PHY_HSIC_CTRL1			EXYNOS4_HSOTG_PHYREG(0x10)
+#define EXYNOS5_PHY_HSIC_CTRL2			EXYNOS4_HSOTG_PHYREG(0x20)
+#define HSIC_CTRL_REFCLKSEL			(0x2)
+#define HSIC_CTRL_REFCLKSEL_MASK		(0x3)
+#define HSIC_CTRL_REFCLKSEL_SHIFT		(23)
+
+#define HSIC_CTRL_REFCLKDIV_12			(0x24)
+#define HSIC_CTRL_REFCLKDIV_15			(0x1C)
+#define HSIC_CTRL_REFCLKDIV_16			(0x1A)
+#define HSIC_CTRL_REFCLKDIV_19_2		(0x15)
+#define HSIC_CTRL_REFCLKDIV_20			(0x14)
+#define HSIC_CTRL_REFCLKDIV_MASK		(0x7f)
+#define HSIC_CTRL_REFCLKDIV_SHIFT		(16)
+
+#define HSIC_CTRL_SIDDQ				(0x1 << 6)
+#define HSIC_CTRL_FORCESLEEP			(0x1 << 5)
+#define HSIC_CTRL_FORCESUSPEND			(0x1 << 4)
+#define HSIC_CTRL_WORDINTERFACE			(0x1 << 3)
+#define HSIC_CTRL_UTMISWRST			(0x1 << 2)
+#define HSIC_CTRL_PHYSWRST			(0x1 << 0)
+
+#define EXYNOS5_PHY_HOST_EHCICTRL		EXYNOS4_HSOTG_PHYREG(0x30)
+#define EHCICTRL_ENAINCRXALIGN			(0x1 << 29)
+#define EHCICTRL_ENAINCR4			(0x1 << 28)
+#define EHCICTRL_ENAINCR8			(0x1 << 27)
+#define EHCICTRL_ENAINCR16			(0x1 << 26)
+
+#define EXYNOS5_PHY_HOST_OHCICTRL		EXYNOS4_HSOTG_PHYREG(0x34)
+#define OHCICTRL_SUSPLGCY			(0x1 << 3)
+#define OHCICTRL_APPSTARTCLK			(0x1 << 2)
+#define OHCICTRL_CNTSEL				(0x1 << 1)
+#define OHCICTRL_CLKCKTRST			(0x1 << 0)
+
+#define EXYNOS5_PHY_OTG_SYS			EXYNOS4_HSOTG_PHYREG(0x38)
+#define OTG_SYS_PHYLINK_SW_RESET		(0x1 << 14)
+#define OTG_SYS_LINK_SW_RST_UOTG		(0x1 << 13)
+#define OTG_SYS_PHY0_SW_RST			(0x1 << 12)
+
+#define OTG_SYS_REF_CLK_SEL_XTAL		(0x0)
+#define OTG_SYS_REF_CLK_SEL_EXTL		(0x1)
+#define OTG_SYS_REF_CLK_SEL_CLKCORE		(0x2)
+#define OTG_SYS_REF_CLK_SEL_MASK		(0x3)
+#define OTG_SYS_REF_CLK_SEL_SHIFT		(9)
+
+#define OTG_SYS_IP_PULLUP_UOTG			(0x1 << 8)
+#define OTG_SYS_COMMON_ON			(0x1 << 7)
+#define OTG_SYS_CLKSEL_SHIFT			(4)
+#define OTG_SYS_CTRL0_FSEL_MASK			(0x7 << 4)
+#define OTG_SYS_FORCE_SLEEP			(0x1 << 3)
+#define OTG_SYS_OTGDISABLE			(0x1 << 2)
+#define OTG_SYS_SIDDQ_UOTG			(0x1 << 1)
+#define OTG_SYS_FORCE_SUSPEND			(0x1 << 0)
+
 #endif /* __PLAT_S5P_REGS_USB_PHY_H */
diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index 1a4ea07..e6f2f84 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -19,11 +19,36 @@
 #include <plat/cpu.h>
 #include <plat/usb-phy.h>
 
+#define PHY_ENABLE	1
+#define PHY_DISABLE	0
+
+enum usb_phy_type {
+	USB_PHY		= (0x1 << 0),
+};
+
 static atomic_t host_usage;
 
 static int exynos4_usb_host_phy_is_on(void)
 {
-	return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
+	if (soc_is_exynos5250()) {
+		return (readl(EXYNOS5_PHY_HOST_CTRL0) &
+				HOST_CTRL0_PHYSWRSTALL) ? 0 : 1;
+	} else {
+		return (readl(EXYNOS4_PHYPWR) &
+				PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
+	}
+}
+
+static void exynos_usb_mux_change(struct platform_device *pdev, int val)
+{
+	u32 is_host;
+	if (soc_is_exynos5250()) {
+		is_host = readl(EXYNOS5_USB_CFG);
+		writel(val, EXYNOS5_USB_CFG);
+	}
+	if (is_host != val)
+		dev_dbg(&pdev->dev, "Change USB MUX from %s to %s",
+		is_host ? "Host" : "Device", val ? "Host" : "Device");
 }
 
 static struct clk *exynos_usb_clock_enable(struct platform_device *pdev)
@@ -31,7 +56,10 @@ static struct clk *exynos_usb_clock_enable(struct platform_device *pdev)
 	struct clk *usb_clk = NULL;
 	int err = 0;
 
-	usb_clk = clk_get(&pdev->dev, "otg");
+	if (soc_is_exynos5250())
+		usb_clk = clk_get(&pdev->dev, "usbhost");
+	else
+		usb_clk = clk_get(&pdev->dev, "otg");
 	if (IS_ERR(usb_clk)) {
 		dev_err(&pdev->dev, "Failed to get otg clock\n");
 		return NULL;
@@ -50,7 +78,11 @@ static int exynos4210_usb_phy_clkset(struct platform_device *pdev)
 	struct clk *xusbxti_clk;
 	u32 phyclk = 0;
 
-	xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
+	if (soc_is_exynos5250())
+		xusbxti_clk = clk_get(&pdev->dev, "ext_xtal");
+	else
+		xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
+
 	if (xusbxti_clk && !IS_ERR(xusbxti_clk)) {
 		if (soc_is_exynos4210()) {
 			/* set clock frequency for PLL */
@@ -96,12 +128,47 @@ static int exynos4210_usb_phy_clkset(struct platform_device *pdev)
 				break;
 			}
 			writel(phyclk, EXYNOS4_PHYCLK);
+		} else if (soc_is_exynos5250()) {
+			/* set clock frequency for PLL */
+			switch (clk_get_rate(xusbxti_clk)) {
+			case 96 * 100000:
+				phyclk |= EXYNOS5_CLKSEL_9600K;
+				break;
+			case 10 * MHZ:
+				phyclk |= EXYNOS5_CLKSEL_10M;
+				break;
+			case 12 * MHZ:
+				phyclk |= EXYNOS5_CLKSEL_12M;
+				break;
+			case 192 * 100000:
+				phyclk |= EXYNOS5_CLKSEL_19200K;
+				break;
+			case 20 * MHZ:
+				phyclk |= EXYNOS5_CLKSEL_20M;
+				break;
+			case 50 * MHZ:
+				phyclk |= EXYNOS5_CLKSEL_50M;
+				break;
+			case 24 * MHZ:
+			default:
+				/* default reference clock */
+				phyclk |= EXYNOS5_CLKSEL_24M;
+				break;
+			}
 		}
 		clk_put(xusbxti_clk);
 	}
 	return phyclk;
 }
 
+static void exynos_usb_phy_control(enum usb_phy_type phy_type , int on)
+{
+	if (soc_is_exynos5250()) {
+		if (phy_type & USB_PHY)
+			writel(on, S5P_USBHOST_PHY_CONTROL);
+	}
+}
+
 static int exynos4210_usb_phy0_init(struct platform_device *pdev)
 {
 	u32 rstcon;
@@ -204,12 +271,158 @@ static int exynos4210_usb_phy1_exit(struct platform_device *pdev)
 	return 0;
 }
 
+static int exynos5_usb_phy20_init(struct platform_device *pdev)
+{
+	struct clk *host_clk;
+	u32 refclk_freq;
+	u32 hostphy_ctrl0;
+	u32 otgphy_sys;
+	u32 hsic_ctrl;
+	u32 ehcictrl;
+	u32 ohcictrl;
+
+	atomic_inc(&host_usage);
+	host_clk = exynos_usb_clock_enable(pdev);
+	if (host_clk == NULL) {
+		dev_err(&pdev->dev, "Failed to enable USB2.0 host clock\n");
+		return -1;
+	}
+
+	if (exynos4_usb_host_phy_is_on()) {
+		dev_err(&pdev->dev, "Already power on PHY\n");
+		return 0;
+	}
+
+	exynos_usb_mux_change(pdev, 1);
+
+	exynos_usb_phy_control(USB_PHY, PHY_ENABLE);
+
+	/* Host and Device should be set at the same time */
+	hostphy_ctrl0 = readl(EXYNOS5_PHY_HOST_CTRL0);
+	hostphy_ctrl0 &= ~(HOST_CTRL0_FSEL_MASK);
+	otgphy_sys = readl(EXYNOS5_PHY_OTG_SYS);
+	otgphy_sys &= ~(OTG_SYS_CTRL0_FSEL_MASK);
+
+	/* 2.0 phy reference clock configuration */
+	refclk_freq = exynos4210_usb_phy_clkset(pdev);
+	hostphy_ctrl0 |= (refclk_freq << HOST_CTRL0_CLKSEL_SHIFT);
+	otgphy_sys |= (refclk_freq << OTG_SYS_CLKSEL_SHIFT);
+
+	/* COMMON Block configuration during suspend */
+	hostphy_ctrl0 |= (HOST_CTRL0_COMMONON_N);
+	otgphy_sys &= ~(OTG_SYS_COMMON_ON);
+
+	/* otg phy reset */
+	otgphy_sys &= ~(OTG_SYS_FORCE_SUSPEND | OTG_SYS_SIDDQ_UOTG
+						| OTG_SYS_FORCE_SLEEP);
+	otgphy_sys &= ~(OTG_SYS_REF_CLK_SEL_MASK << OTG_SYS_REF_CLK_SEL_SHIFT);
+	otgphy_sys |= (((OTG_SYS_REF_CLK_SEL_CLKCORE & OTG_SYS_REF_CLK_SEL_MASK)
+						<< OTG_SYS_REF_CLK_SEL_SHIFT)
+						| OTG_SYS_OTGDISABLE);
+	otgphy_sys |= (OTG_SYS_PHY0_SW_RST | OTG_SYS_LINK_SW_RST_UOTG
+						| OTG_SYS_PHYLINK_SW_RESET);
+	writel(otgphy_sys, EXYNOS5_PHY_OTG_SYS);
+	udelay(10);
+	otgphy_sys &= ~(OTG_SYS_PHY0_SW_RST | OTG_SYS_LINK_SW_RST_UOTG
+						| OTG_SYS_PHYLINK_SW_RESET);
+	writel(otgphy_sys, EXYNOS5_PHY_OTG_SYS);
+
+	/* host phy reset */
+	hostphy_ctrl0 &= ~(HOST_CTRL0_PHYSWRST | HOST_CTRL0_PHYSWRSTALL
+						| HOST_CTRL0_SIDDQ);
+	hostphy_ctrl0 &= ~(HOST_CTRL0_FORCESUSPEND | HOST_CTRL0_FORCESLEEP);
+	hostphy_ctrl0 |= (HOST_CTRL0_LINKSWRST | HOST_CTRL0_UTMISWRST);
+	writel(hostphy_ctrl0, EXYNOS5_PHY_HOST_CTRL0);
+	udelay(10);
+	hostphy_ctrl0 &= ~(HOST_CTRL0_LINKSWRST | HOST_CTRL0_UTMISWRST);
+	writel(hostphy_ctrl0, EXYNOS5_PHY_HOST_CTRL0);
+
+	/* HSIC phy reset */
+	hsic_ctrl = (((HSIC_CTRL_REFCLKDIV_12 & HSIC_CTRL_REFCLKDIV_MASK)
+				<< HSIC_CTRL_REFCLKDIV_SHIFT)
+			| ((HSIC_CTRL_REFCLKSEL & HSIC_CTRL_REFCLKSEL_MASK)
+				<< HSIC_CTRL_REFCLKSEL_SHIFT)
+			| HSIC_CTRL_PHYSWRST);
+	writel(hsic_ctrl, EXYNOS5_PHY_HSIC_CTRL1);
+	writel(hsic_ctrl, EXYNOS5_PHY_HSIC_CTRL2);
+	udelay(10);
+	hsic_ctrl &= ~(HSIC_CTRL_PHYSWRST);
+	writel(hsic_ctrl, EXYNOS5_PHY_HSIC_CTRL1);
+	writel(hsic_ctrl, EXYNOS5_PHY_HSIC_CTRL2);
+
+	udelay(80);
+
+	/* enable EHCI DMA burst  */
+	ehcictrl = readl(EXYNOS5_PHY_HOST_EHCICTRL);
+	ehcictrl |= (EHCICTRL_ENAINCRXALIGN | EHCICTRL_ENAINCR4
+				| EHCICTRL_ENAINCR8 | EHCICTRL_ENAINCR16);
+	writel(ehcictrl, EXYNOS5_PHY_HOST_EHCICTRL);
+
+	/* set ohci_suspend_on_n */
+	ohcictrl = readl(EXYNOS5_PHY_HOST_OHCICTRL);
+	ohcictrl |= OHCICTRL_SUSPLGCY;
+	writel(ohcictrl, EXYNOS5_PHY_HOST_OHCICTRL);
+
+	clk_disable(host_clk);
+	clk_put(host_clk);
+	return 0;
+}
+
+static int exynos5_usb_phy20_exit(struct platform_device *pdev)
+{
+	struct clk *host_clk;
+	u32 hostphy_ctrl0;
+	u32 otgphy_sys;
+	u32 hsic_ctrl;
+
+	if (atomic_dec_return(&host_usage) > 0) {
+		dev_info(&pdev->dev, "still being used\n");
+		return -EBUSY;
+	}
+
+	host_clk = exynos_usb_clock_enable(pdev);
+	if (host_clk == NULL) {
+		dev_err(&pdev->dev, "Failed to enable otg clock this time\n");
+		return -1;
+	}
+
+	hsic_ctrl = (((HSIC_CTRL_REFCLKDIV_12 & HSIC_CTRL_REFCLKDIV_MASK)
+				<< HSIC_CTRL_REFCLKDIV_SHIFT)
+			| ((HSIC_CTRL_REFCLKSEL	& HSIC_CTRL_REFCLKSEL_MASK)
+				<< HSIC_CTRL_REFCLKSEL_SHIFT)
+			| HSIC_CTRL_SIDDQ | HSIC_CTRL_FORCESLEEP
+			| HSIC_CTRL_FORCESUSPEND);
+	writel(hsic_ctrl, EXYNOS5_PHY_HSIC_CTRL1);
+	writel(hsic_ctrl, EXYNOS5_PHY_HSIC_CTRL2);
+
+	hostphy_ctrl0 = readl(EXYNOS5_PHY_HOST_CTRL0);
+	hostphy_ctrl0 |= (HOST_CTRL0_SIDDQ);
+	hostphy_ctrl0 |= (HOST_CTRL0_FORCESUSPEND | HOST_CTRL0_FORCESLEEP);
+	hostphy_ctrl0 |= (HOST_CTRL0_PHYSWRST | HOST_CTRL0_PHYSWRSTALL);
+	writel(hostphy_ctrl0, EXYNOS5_PHY_HOST_CTRL0);
+
+	otgphy_sys = readl(EXYNOS5_PHY_OTG_SYS);
+	otgphy_sys |= (OTG_SYS_FORCE_SUSPEND | OTG_SYS_SIDDQ_UOTG
+				| OTG_SYS_FORCE_SLEEP);
+	writel(otgphy_sys, EXYNOS5_PHY_OTG_SYS);
+
+	exynos_usb_phy_control(USB_PHY, PHY_DISABLE);
+
+	clk_disable(host_clk);
+	clk_put(host_clk);
+	return 0;
+}
+
 int s5p_usb_phy_init(struct platform_device *pdev, int type)
 {
 	if (type == S5P_USB_PHY_DEVICE)
 		return exynos4210_usb_phy0_init(pdev);
-	else if (type == S5P_USB_PHY_HOST)
-		return exynos4210_usb_phy1_init(pdev);
+	else if (type == S5P_USB_PHY_HOST) {
+		if (soc_is_exynos5250())
+			return exynos5_usb_phy20_init(pdev);
+		else
+			return exynos4210_usb_phy1_init(pdev);
+	}
 
 	return -EINVAL;
 }
@@ -218,8 +431,11 @@ int s5p_usb_phy_exit(struct platform_device *pdev, int type)
 {
 	if (type == S5P_USB_PHY_DEVICE)
 		return exynos4210_usb_phy0_exit(pdev);
-	else if (type == S5P_USB_PHY_HOST)
-		return exynos4210_usb_phy1_exit(pdev);
-
+	else if (type == S5P_USB_PHY_HOST) {
+		if (soc_is_exynos5250())
+			return exynos5_usb_phy20_exit(pdev);
+		else
+			return exynos4210_usb_phy1_exit(pdev);
+	}
 	return -EINVAL;
 }
-- 
1.7.0.4
