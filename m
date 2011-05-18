From: davidb@codeaurora.org (David Brown)
Date: Wed, 18 May 2011 14:50:53 -0700
Subject: [PATCH 7/7] gpio_msm: Move Qualcomm MSM v2 gpio driver into drivers
In-Reply-To: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1305755453-31112-8-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate the driver for the v7-based MSM chips into drivers/gpio.  The
driver is unchanged, only moved.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig                          |    1 +
 arch/arm/mach-msm/Makefile                         |    6 ------
 drivers/gpio/Kconfig                               |    8 ++++++++
 drivers/gpio/Makefile                              |    1 +
 .../mach-msm/gpio-v2.c => drivers/gpio/msm_v2.c    |    2 +-
 5 files changed, 11 insertions(+), 7 deletions(-)
 rename arch/arm/mach-msm/gpio-v2.c => drivers/gpio/msm_v2.c (99%)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index cc7c0b2..f5cce3f 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -47,6 +47,7 @@ config ARCH_MSM8X60
 	select ARM_GIC
 	select CPU_V7
 	select MSM_V2_TLMM
+	select GPIO_MSM_V2
 	select MSM_GPIOMUX
 	select MSM_SCM if SMP
 
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index edb6659..7e58b45 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -32,9 +32,3 @@ obj-$(CONFIG_ARCH_MSM8960) += board-msm8960.o devices-msm8960.o
 obj-$(CONFIG_ARCH_MSM7X30) += gpiomux-v1.o gpiomux.o
 obj-$(CONFIG_ARCH_QSD8X50) += gpiomux-8x50.o gpiomux-v1.o gpiomux.o
 obj-$(CONFIG_ARCH_MSM8X60) += gpiomux-8x60.o gpiomux-v2.o gpiomux.o
-ifdef CONFIG_MSM_V2_TLMM
-ifndef CONFIG_ARCH_MSM8960
-# TODO: TLMM Mapping issues need to be resolved
-obj-y	+= gpio-v2.o
-endif
-endif
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index aa5a3f9..235b6c9 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -139,6 +139,14 @@ config GPIO_MSM_V1
 	  Qualcomm MSM chips.  Most of the pins on the MSM can be
 	  selected for GPIO, and are controlled by this driver.
 
+config GPIO_MSM_V2
+	tristate "Qualcomm MSM GPIO v2"
+	depends on GPIOLIB && ARCH_MSM
+	help
+	  Say yes here to support the GPIO interface on ARM many v7
+	  based Qualcomm MSM chips.  Most of the pins on the MSM can
+	  be selected for GPIO, and are controlled by this driver.
+
 comment "I2C GPIO expanders:"
 
 config GPIO_MAX7300
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b6386e4..c2f2d3f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -42,5 +42,6 @@ obj-$(CONFIG_GPIO_JANZ_TTL)	+= janz-ttl.o
 obj-$(CONFIG_GPIO_SX150X)	+= sx150x.o
 obj-$(CONFIG_GPIO_VX855)	+= vx855_gpio.o
 obj-$(CONFIG_GPIO_MSM_V1)	+= msm_v1.o
+obj-$(CONFIG_GPIO_MSM_V2)	+= msm_v2.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= ml_ioh_gpio.o
 obj-$(CONFIG_AB8500_GPIO)       += ab8500-gpio.o
diff --git a/arch/arm/mach-msm/gpio-v2.c b/drivers/gpio/msm_v2.c
similarity index 99%
rename from arch/arm/mach-msm/gpio-v2.c
rename to drivers/gpio/msm_v2.c
index 56a964e..62193bf 100644
--- a/arch/arm/mach-msm/gpio-v2.c
+++ b/drivers/gpio/msm_v2.c
@@ -27,8 +27,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/msm_gpiomux.h>
 #include <mach/msm_iomap.h>
-#include "gpiomux.h"
 
 /* Bits of interest in the GPIO_IN_OUT register.
  */
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
