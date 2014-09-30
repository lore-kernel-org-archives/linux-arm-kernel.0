From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 14:09:46 +0200
Subject: [PATCH] spi: bcm53xx: add BCMA dependency
Message-ID: <3256402.M8e92DFkbg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCMA bus framework can be disabled on bcm53xx, which leads to a link
error when building the SPI driver:

drivers/built-in.o: In function `bcm53xxspi_module_init':
:(.init.text+0x76d4): undefined reference to `__bcma_driver_register'
drivers/built-in.o: In function `bcm53xxspi_module_exit':
:(.exit.text+0x10fe): undefined reference to `bcma_driver_unregister'

To avoid that, this adds an explicit dependency on BCMA. While we're
changing the dependencies, let's also add a COMPILE_TEST option, which
will of course not have any effect unless building on another machine
that has BCMA enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0fc6a323e19 ("spi: bcm53xx: driver for SPI controller on Broadcom bcma SoC")

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bb7b5ec000d9..ababd27a4211 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -115,7 +115,8 @@ config SPI_AU1550
 
 config SPI_BCM53XX
 	tristate "Broadcom BCM53xx SPI controller"
-	depends on ARCH_BCM_5301X
+	depends on ARCH_BCM_5301X || COMPILE_TEST
+	depends on BCMA
 	help
           Enable support for the SPI controller on Broadcom BCM53xx ARM SoCs.
 
