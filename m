From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue,  4 Jan 2011 16:34:57 +1100
Subject: [PATCH v4 2/4] mc13xxx-core: Kconfig: Config menu driven by specific
	IC type
In-Reply-To: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1294119299-18352-3-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes config items for the mc13892 and mc13783 distinct and
splits introduces a separate config item for spi interface support in
preparation for a separate i2c and spi backend.

The mc13xxx generic core is therefore selected by the spi (or i2c) item:
having it the other way around doesn't work for other drivers that will
need to distinguish between mc13783 and mc13892 (at build time).

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/mfd/Kconfig |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3a1493b..9ce1d42 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -425,20 +425,36 @@ config MFD_PCF50633
 	  so that function-specific drivers can bind to them.
 
 config MFD_MC13783
-	tristate
-
-config MFD_MC13XXX
-	tristate "Support Freescale MC13783 and MC13892"
 	depends on SPI_MASTER
-	select MFD_CORE
-	select MFD_MC13783
+	select MFD_MC13XXX_SPI
+	tristate "Support for Freescale MC13783 PMIC"
 	help
-	  Support for the Freescale (Atlas) PMIC and audio CODECs
-	  MC13783 and MC13892.
-	  This driver provides common support for accessing  the device,
+	  Support for the Freescale MC13783 PMIC and audio CODEC.
+	  This driver provides common support for accessing the device,
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_MC13892
+	depends on SPI_MASTER || I2C
+	select MFD_MC13XXX
+	tristate "Support for Freescale MC13892 PMIC"
+	help
+	  Enable support for the Freescale MC13892 PMIC.
+	  As the MC13892 can connect by either I2C or SPI bus, you will
+	  also need to select which of these you would like to support.
+	  Additional drivers must be enabled in order to use the
+	  functionality of the device.
+
+config MFD_MC13XXX
+	tristate
+	depends on SPI_MASTER || I2C
+	select MFD_CORE
+
+config MFD_MC13XXX_SPI
+	tristate "Support Freescale MC13783 and MC13892 via SPI interface"
+	select MFD_MC13XXX
+	depends on SPI_MASTER && (MFD_MC13783 || MFD_MC13892)
+
 config PCF50633_ADC
 	tristate "Support for NXP PCF50633 ADC"
 	depends on MFD_PCF50633
-- 
1.7.1
