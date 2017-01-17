From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 17 Jan 2017 13:26:08 +0100
Subject: [PATCH v2 06/14] ARM: davinci: da850: model the SATA refclk
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484655976-25382-7-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register a dummy clock modelling the external SATA oscillator for
da850 DT mode. For non-DT boot we don't register the clock - instead
we rely on the default MPY value defined in the da850 ahci driver (as
is done currently).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da8xx-dt.c           |  8 ++++++++
 arch/arm/mach-davinci/devices-da8xx.c      | 23 +++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index b83e5d1..13137cb 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -61,6 +61,14 @@ static void __init da850_init_machine(void)
 		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
 			__func__, ret);
 
+	if (of_machine_is_compatible("ti,da850-evm") ||
+	    of_machine_is_compatible("ti,da850-lcdk")) {
+		ret = da850_register_sata_refclk(100000000);
+		if (ret)
+			pr_warn("%s: registering SATA_REFCLK clock failed: %d",
+				__func__, ret);
+	}
+
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 	davinci_pm_init();
 }
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index c2457b3..2bb5b69 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -24,6 +24,7 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
+#include <mach/clock.h>
 #include "cpuidle.h"
 #include "sram.h"
 
@@ -1023,6 +1024,28 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
+static struct clk sata_refclk = {
+	.name		= "sata_refclk",
+	.set_rate	= davinci_simple_set_rate,
+};
+
+static struct clk_lookup sata_refclk_lookup =
+		CLK("ahci_da850", "refclk", &sata_refclk);
+
+int __init da850_register_sata_refclk(int rate)
+{
+	int ret;
+
+	sata_refclk.rate = rate;
+	ret = clk_register(&sata_refclk);
+	if (ret)
+		return ret;
+
+	clkdev_add(&sata_refclk_lookup);
+
+	return 0;
+}
+
 static struct resource da850_sata_resources[] = {
 	{
 		.start	= DA850_SATA_BASE,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 85ff218..7e46422 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -95,6 +95,7 @@ int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_usb_refclkin(int rate);
 int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
+int da850_register_sata_refclk(int rate);
 int da8xx_register_emac(void);
 int da8xx_register_uio_pruss(void);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
-- 
2.9.3
