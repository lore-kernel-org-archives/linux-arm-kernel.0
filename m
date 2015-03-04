From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:04 +0100
Subject: [RFC PATCH 10/18] gpio: move msm-v1 driver to mach-msm
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm gpio driver uses the gpiomux infrastructure that
relies on platform specific internals. We should really
use a proper pinmux driver here, but for now, the easiest
solution is to move it into mach-msm to get rid of the
header file dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/Makefile                        | 2 ++
 {drivers/gpio => arch/arm/mach-msm}/gpio-msm-v1.c | 0
 drivers/gpio/Kconfig                              | 8 --------
 drivers/gpio/Makefile                             | 1 -
 4 files changed, 2 insertions(+), 9 deletions(-)
 rename {drivers/gpio => arch/arm/mach-msm}/gpio-msm-v1.c (100%)

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index bab22a179c47..eb0fa4bf7f36 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
 
 obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
 
+obj-$(CONFIG_ARCH_MSM) += gpio-msm-v1.o
+
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 
diff --git a/drivers/gpio/gpio-msm-v1.c b/arch/arm/mach-msm/gpio-msm-v1.c
similarity index 100%
rename from drivers/gpio/gpio-msm-v1.c
rename to arch/arm/mach-msm/gpio-msm-v1.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2ebc124e1217..00c489f31d9d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -223,14 +223,6 @@ config GPIO_MPC8XXX
 	  Say Y here if you're going to use hardware that connects to the
 	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
 
-config GPIO_MSM_V1
-	tristate "Qualcomm MSM GPIO v1"
-	depends on GPIOLIB && ARCH_MSM && (ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50)
-	help
-	  Say yes here to support the GPIO interface on ARM v6 based
-	  Qualcomm MSM chips.  Most of the pins on the MSM can be
-	  selected for GPIO, and are controlled by this driver.
-
 config GPIO_MSM_V2
 	tristate "Qualcomm MSM GPIO v2"
 	depends on GPIOLIB && OF && ARCH_QCOM
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 0e48e5d89d63..b2fb21036655 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_GPIO_MOXART)	+= gpio-moxart.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
 obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
-obj-$(CONFIG_GPIO_MSM_V1)	+= gpio-msm-v1.o
 obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
 obj-$(CONFIG_GPIO_MVEBU)        += gpio-mvebu.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
-- 
2.1.0.rc2
