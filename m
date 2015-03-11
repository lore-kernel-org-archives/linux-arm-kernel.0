From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Mar 2015 11:21:28 -0300
Subject: [PATCH v2 1/7] ARM: mx25: Remove mx25_clocks_init()
Message-ID: <1426083694-6624-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mx25_clocks_init() is only used to register the clocks for non-dt platforms.

As mx25 has been converted to a dt-only platform, we can safely remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/mach-imx/clk-imx25.c | 75 -------------------------------------------
 arch/arm/mach-imx/common.h    |  1 -
 2 files changed, 76 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 59c0c85..9c2633a 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -30,7 +30,6 @@
 #include "clk.h"
 #include "common.h"
 #include "hardware.h"
-#include "mx25.h"
 
 #define CCM_MPCTL	0x00
 #define CCM_UPCTL	0x04
@@ -239,80 +238,6 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
 	return 0;
 }
 
-int __init mx25_clocks_init(void)
-{
-	void __iomem *ccm;
-
-	ccm = ioremap(MX25_CRM_BASE_ADDR, SZ_16K);
-
-	__mx25_clocks_init(24000000, ccm);
-
-	clk_register_clkdev(clk[gpt1_ipg], "ipg", "imx-gpt.0");
-	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
-	/* i.mx25 has the i.mx21 type uart */
-	clk_register_clkdev(clk[uart1_ipg], "ipg", "imx21-uart.0");
-	clk_register_clkdev(clk[uart_ipg_per], "per", "imx21-uart.0");
-	clk_register_clkdev(clk[uart2_ipg], "ipg", "imx21-uart.1");
-	clk_register_clkdev(clk[uart_ipg_per], "per", "imx21-uart.1");
-	clk_register_clkdev(clk[uart3_ipg], "ipg", "imx21-uart.2");
-	clk_register_clkdev(clk[uart_ipg_per], "per", "imx21-uart.2");
-	clk_register_clkdev(clk[uart4_ipg], "ipg", "imx21-uart.3");
-	clk_register_clkdev(clk[uart_ipg_per], "per", "imx21-uart.3");
-	clk_register_clkdev(clk[uart5_ipg], "ipg", "imx21-uart.4");
-	clk_register_clkdev(clk[uart_ipg_per], "per", "imx21-uart.4");
-	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.0");
-	clk_register_clkdev(clk[usbotg_ahb], "ahb", "mxc-ehci.0");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.0");
-	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.1");
-	clk_register_clkdev(clk[usbotg_ahb], "ahb", "mxc-ehci.1");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.1");
-	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
-	clk_register_clkdev(clk[usbotg_ahb], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
-	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx27");
-	clk_register_clkdev(clk[usbotg_ahb], "ahb", "imx-udc-mx27");
-	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx27");
-	clk_register_clkdev(clk[nfc_ipg_per], NULL, "imx25-nand.0");
-	/* i.mx25 has the i.mx35 type cspi */
-	clk_register_clkdev(clk[cspi1_ipg], NULL, "imx35-cspi.0");
-	clk_register_clkdev(clk[cspi2_ipg], NULL, "imx35-cspi.1");
-	clk_register_clkdev(clk[cspi3_ipg], NULL, "imx35-cspi.2");
-	clk_register_clkdev(clk[kpp_ipg], NULL, "imx-keypad");
-	clk_register_clkdev(clk[tsc_ipg], NULL, "mx25-adc");
-	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.0");
-	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.1");
-	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.2");
-	clk_register_clkdev(clk[fec_ipg], "ipg", "imx25-fec.0");
-	clk_register_clkdev(clk[fec_ahb], "ahb", "imx25-fec.0");
-	clk_register_clkdev(clk[dryice_ipg], NULL, "imxdi_rtc.0");
-	clk_register_clkdev(clk[lcdc_ipg_per], "per", "imx21-fb.0");
-	clk_register_clkdev(clk[lcdc_ipg], "ipg", "imx21-fb.0");
-	clk_register_clkdev(clk[lcdc_ahb], "ahb", "imx21-fb.0");
-	clk_register_clkdev(clk[wdt_ipg], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[ssi1_ipg], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_ipg], NULL, "imx-ssi.1");
-	clk_register_clkdev(clk[esdhc1_ipg_per], "per", "sdhci-esdhc-imx25.0");
-	clk_register_clkdev(clk[esdhc1_ipg], "ipg", "sdhci-esdhc-imx25.0");
-	clk_register_clkdev(clk[esdhc1_ahb], "ahb", "sdhci-esdhc-imx25.0");
-	clk_register_clkdev(clk[esdhc2_ipg_per], "per", "sdhci-esdhc-imx25.1");
-	clk_register_clkdev(clk[esdhc2_ipg], "ipg", "sdhci-esdhc-imx25.1");
-	clk_register_clkdev(clk[esdhc2_ahb], "ahb", "sdhci-esdhc-imx25.1");
-	clk_register_clkdev(clk[csi_ipg_per], "per", "imx25-camera.0");
-	clk_register_clkdev(clk[csi_ipg], "ipg", "imx25-camera.0");
-	clk_register_clkdev(clk[csi_ahb], "ahb", "imx25-camera.0");
-	clk_register_clkdev(clk[dummy], "audmux", NULL);
-	clk_register_clkdev(clk[can1_ipg], NULL, "flexcan.0");
-	clk_register_clkdev(clk[can2_ipg], NULL, "flexcan.1");
-	/* i.mx25 has the i.mx35 type sdma */
-	clk_register_clkdev(clk[sdma_ipg], "ipg", "imx35-sdma");
-	clk_register_clkdev(clk[sdma_ahb], "ahb", "imx35-sdma");
-	clk_register_clkdev(clk[iim_ipg], "iim", NULL);
-
-	mxc_timer_init(MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), MX25_INT_GPT1);
-
-	return 0;
-}
-
 static void __init mx25_clocks_init_dt(struct device_node *np)
 {
 	struct device_node *refnp;
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 1028b6c..a12b52d 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -51,7 +51,6 @@ void epit_timer_init(void __iomem *base, int irq);
 void mxc_timer_init(void __iomem *, int);
 int mx1_clocks_init(unsigned long fref);
 int mx21_clocks_init(unsigned long lref, unsigned long fref);
-int mx25_clocks_init(void);
 int mx27_clocks_init(unsigned long fref);
 int mx31_clocks_init(unsigned long fref);
 int mx35_clocks_init(void);
-- 
1.9.1
