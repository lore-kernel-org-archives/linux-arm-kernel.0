From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Sep 2013 17:40:11 +0200
Subject: [PATCH 1/8] ARM: plat-iop: move the GPIO driver to drivers/gpio
Message-ID: <1378741211-12884-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the IOP GPIO driver to live with its siblings in the
GPIO subsystem.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                    | 2 ++
 arch/arm/plat-iop/Makefile                          | 2 --
 drivers/gpio/Kconfig                                | 9 +++++++++
 drivers/gpio/Makefile                               | 1 +
 arch/arm/plat-iop/gpio.c => drivers/gpio/gpio-iop.c | 0
 5 files changed, 12 insertions(+), 2 deletions(-)
 rename arch/arm/plat-iop/gpio.c => drivers/gpio/gpio-iop.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a00f4c1..4ef9fc8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -456,6 +456,7 @@ config ARCH_IOP32X
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
+	select GPIO_IOP
 	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
 	select PCI
@@ -469,6 +470,7 @@ config ARCH_IOP33X
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
+	select GPIO_IOP
 	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
 	select PCI
diff --git a/arch/arm/plat-iop/Makefile b/arch/arm/plat-iop/Makefile
index a99dc15..224e56c 100644
--- a/arch/arm/plat-iop/Makefile
+++ b/arch/arm/plat-iop/Makefile
@@ -5,7 +5,6 @@
 obj-y :=
 
 # IOP32X
-obj-$(CONFIG_ARCH_IOP32X) += gpio.o
 obj-$(CONFIG_ARCH_IOP32X) += i2c.o
 obj-$(CONFIG_ARCH_IOP32X) += pci.o
 obj-$(CONFIG_ARCH_IOP32X) += setup.o
@@ -16,7 +15,6 @@ obj-$(CONFIG_ARCH_IOP32X) += pmu.o
 obj-$(CONFIG_ARCH_IOP32X) += restart.o
 
 # IOP33X
-obj-$(CONFIG_ARCH_IOP33X) += gpio.o
 obj-$(CONFIG_ARCH_IOP33X) += i2c.o
 obj-$(CONFIG_ARCH_IOP33X) += pci.o
 obj-$(CONFIG_ARCH_IOP33X) += setup.o
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 349b161..35e8223 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -312,6 +312,15 @@ config GPIO_ICH
 
 	  If unsure, say N.
 
+config GPIO_IOP
+	tristate "Intel ICH GPIO"
+	depends on ARM && (ARCH_IOP32X || ARCH_IOP33X)
+	help
+	  Say yes here to support the GPIO functionality of a number of Intel
+	  IOP32X or IOP33X.
+
+	  If unsure, say N.
+
 config GPIO_VX855
 	tristate "VIA VX855/VX875 GPIO"
 	depends on PCI && GENERIC_HARDIRQS
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 97438bf..66fb17e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_GPIO_F7188X)	+= gpio-f7188x.o
 obj-$(CONFIG_GPIO_GE_FPGA)	+= gpio-ge.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
+obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT8761E)	+= gpio-it8761e.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
diff --git a/arch/arm/plat-iop/gpio.c b/drivers/gpio/gpio-iop.c
similarity index 100%
rename from arch/arm/plat-iop/gpio.c
rename to drivers/gpio/gpio-iop.c
-- 
1.8.3.1
