From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 15:03:33 +0100
Subject: [PATCH] NFC: nfcmrvl: fix SPI driver dependencies
Message-ID: <243350307.K4hHIg3V2N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added nfcmrvl_spi driver uses the spi_nci
infrastructure, but does not have a Kconfig dependency on
that, so we can get a link-time error:

drivers/built-in.o: In function `nfcmrvl_spi_nci_send':
(.text+0x1428dc): undefined reference to `nci_spi_send'
drivers/built-in.o: In function `nfcmrvl_spi_probe':
(.text+0x142a24): undefined reference to `nci_spi_allocate_spi'
drivers/built-in.o: In function `nfcmrvl_spi_int_irq_thread_fn':
(.text+0x142abc): undefined reference to `nci_spi_read'

This clarifies the dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: caf6e49bf6d0 ("NFC: nfcmrvl: add spi driver")
---
Found on ARM randconfig builds on yesterday's linux-next

diff --git a/drivers/nfc/nfcmrvl/Kconfig b/drivers/nfc/nfcmrvl/Kconfig
index 444ca94697d9..670af76922e0 100644
--- a/drivers/nfc/nfcmrvl/Kconfig
+++ b/drivers/nfc/nfcmrvl/Kconfig
@@ -44,7 +44,7 @@ config NFC_MRVL_I2C
 
 config NFC_MRVL_SPI
 	tristate "Marvell NFC-over-SPI driver"
-	depends on NFC_MRVL && SPI
+	depends on NFC_MRVL && NFC_NCI_SPI
 	help
 	  Marvell NFC-over-SPI driver.
 
