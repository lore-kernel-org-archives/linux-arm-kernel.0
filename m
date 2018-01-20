From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:14:19 -0600
Subject: [PATCH v6 40/41] ARM: da8xx-dt: switch to device tree clocks
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-41-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes all of the clock init code from da8xx-dt.c. This includes
all of the OF_DEV_AUXDATA that was just used for looking up clocks.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- removed misleading statement from commit message

 arch/arm/mach-davinci/da8xx-dt.c | 61 +---------------------------------------
 1 file changed, 1 insertion(+), 60 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index ab199f4..d5c6cdb 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -19,69 +19,11 @@
 #include "cp_intc.h"
 #include <mach/da8xx.h>
 
-static struct of_dev_auxdata da850_aemif_auxdata_lookup[] = {
-	OF_DEV_AUXDATA("ti,davinci-nand", 0x62000000, "davinci-nand.0", NULL),
-	{}
-};
-
-static struct aemif_platform_data aemif_data = {
-	.dev_lookup = da850_aemif_auxdata_lookup,
-};
-
-static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
-	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01e28000, "i2c_davinci.2", NULL),
-	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "davinci-wdt", NULL),
-	OF_DEV_AUXDATA("ti,da830-mmc", 0x01c40000, "da830-mmc.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f02000, "ehrpwm.1", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap.1", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap.2", NULL),
-	OF_DEV_AUXDATA("ti,da830-spi", 0x01c41000, "spi_davinci.0", NULL),
-	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
-	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
-	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
-	OF_DEV_AUXDATA("ns16550a", 0x01d0d000, "serial8250.2", NULL),
-	OF_DEV_AUXDATA("ti,davinci_mdio", 0x01e24000, "davinci_mdio.0", NULL),
-	OF_DEV_AUXDATA("ti,davinci-dm6467-emac", 0x01e20000, "davinci_emac.1",
-		       NULL),
-	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", &aemif_data),
-	OF_DEV_AUXDATA("ti,da850-tilcdc", 0x01e13000, "da8xx_lcdc.0", NULL),
-	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci-da8xx", NULL),
-	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
-	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
-	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
-	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
-	OF_DEV_AUXDATA("ti,da850-dsp", 0x11800000, "davinci-rproc.0", NULL),
-	{}
-};
-
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
 static void __init da850_init_machine(void)
 {
-	/* All existing boards use 100MHz SATA refclkpn */
-	static const unsigned long sata_refclkpn = 100 * 1000 * 1000;
-
-	int ret;
-
-	ret = da8xx_register_usb20_phy_clk(false);
-	if (ret)
-		pr_warn("%s: registering USB 2.0 PHY clock failed: %d",
-			__func__, ret);
-	ret = da8xx_register_usb11_phy_clk(false);
-	if (ret)
-		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
-			__func__, ret);
-
-	ret = da850_register_sata_refclk(sata_refclkpn);
-	if (ret)
-		pr_warn("%s: registering SATA REFCLK failed: %d",
-			__func__, ret);
-
-	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 	davinci_pm_init();
 	pdata_quirks_init();
 }
@@ -96,7 +38,6 @@ static const char *const da850_boards_compat[] __initconst = {
 
 DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
 	.map_io		= da850_init,
-	.init_time	= da850_init_time,
 	.init_machine	= da850_init_machine,
 	.dt_compat	= da850_boards_compat,
 	.init_late	= davinci_init_late,
-- 
2.7.4
