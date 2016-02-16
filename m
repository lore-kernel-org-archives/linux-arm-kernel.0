From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 15:54:24 +0100
Subject: [PATCH] mfd: fsl-imx25-tsadc: select IRQ_DOMAIN
Message-ID: <1455634467-2013548-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added tsadc code use irq domains, but it can be enabled
when they are disabled in Kconfig:

drivers/mfd/fsl-imx25-tsadc.c:41:22: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
   generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
drivers/mfd/fsl-imx25-tsadc.c: In function 'mx25_tsadc_setup_irq':
drivers/mfd/fsl-imx25-tsadc.c:80:18: error: implicit declaration of function 'irq_domain_add_simple' [-Werror=implicit-function-declaration]

This adds a 'select IRQ_DOMAIN' code, like we have it in all other
drivers with this requirement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e2fccf5c1515 ("mfd: fsl-imx25-tsadc: Register touchscreen ADC driver")
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index aa21dc55eb15..8cab3ecca8fc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -300,6 +300,7 @@ config MFD_MC13XXX_I2C
 config MFD_MX25_TSADC
 	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
 	select REGMAP_MMIO
+	select IRQ_DOMAIN
 	depends on (SOC_IMX25 && OF) || COMPILE_TEST
 	help
 	  Enable support for the integrated Touchscreen and ADC unit of the
-- 
2.7.0
