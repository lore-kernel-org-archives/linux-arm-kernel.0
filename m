From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Jun 2013 17:36:44 +0200
Subject: [PATCH] ARM: sirf: use CONFIG_SIRF rather than CONFIG_PRIMA2 where
 necessary
Message-ID: <201306101736.44652.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got a build error today that made me realize that it is not
possible to build a kernel for a SiRF platform without enabling
CONFIG_PRIMA2, since a lot of common code depends on CONFIG_PRIMA2.

This fixes all occurences that appear like common SiRF code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Barry, can you see if this patch makes sense to you?

Mark, Grant, Mike, Greg, Wolfram: would you like to get a split-out
patch, or should I apply it in one piece to arm-soc?

There is no harm in changing just one file, they are all
equally wrong and don't depend on one another.

 arch/arm/Makefile          | 2 +-
 drivers/clk/Makefile       | 2 +-
 drivers/i2c/busses/Kconfig | 2 +-
 drivers/spi/Kconfig        | 2 +-
 drivers/tty/serial/Kconfig | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 3380c4f..fcb4b48 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -169,7 +169,7 @@ machine-$(CONFIG_ARCH_OMAP1)		+= omap1
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
-machine-$(CONFIG_ARCH_PRIMA2)		+= prima2
+machine-$(CONFIG_ARCH_SIRF)		+= prima2
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_RPC)		+= rpc
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f41e3e3..a9f616f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
 obj-$(CONFIG_COMMON_CLK_VERSATILE) += versatile/
-obj-$(CONFIG_ARCH_PRIMA2)	+= clk-prima2.o
+obj-$(CONFIG_ARCH_SIRF)		+= clk-prima2.o
 obj-$(CONFIG_PLAT_ORION)	+= mvebu/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)		+= mmp/
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2d030df..11c8eb8 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -676,7 +676,7 @@ config I2C_SIMTEC
 
 config I2C_SIRF
 	tristate "CSR SiRFprimaII I2C interface"
-	depends on ARCH_PRIMA2
+	depends on ARCH_SIRF
 	help
 	  If you say yes to this option, support will be included for the
 	  CSR SiRFprimaII I2C interface.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2015897..89cbbab 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -404,7 +404,7 @@ config SPI_SH_HSPI
 
 config SPI_SIRF
 	tristate "CSR SiRFprimaII SPI controller"
-	depends on ARCH_PRIMA2
+	depends on ARCH_SIRF
 	select SPI_BITBANG
 	help
 	  SPI driver for CSR SiRFprimaII SoCs
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 95e66ac..7b4aa69 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -251,7 +251,7 @@ config SERIAL_SAMSUNG_CONSOLE
 
 config SERIAL_SIRFSOC
         tristate "SiRF SoC Platform Serial port support"
-        depends on ARCH_PRIMA2
+        depends on ARCH_SIRF
         select SERIAL_CORE
         help
           Support for the on-chip UART on the CSR SiRFprimaII series,
