From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 May 2015 09:18:15 +0800
Subject: [PATCH v3 12/12] ARM: imx: move timer driver into
 drivers/clocksource
In-Reply-To: <556655BA.3020903@linaro.org>
References: <1432308599-28643-13-git-send-email-shawn.guo@linaro.org>
 <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
 <5565BD93.50600@linaro.org> <20150527140448.GJ16165@dragon>
 <556655BA.3020903@linaro.org>
Message-ID: <20150528011813.GK16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 01:39:38AM +0200, Daniel Lezcano wrote:
> please use the same as:
> 
> https://lkml.org/lkml/2015/5/22/855
> 
> and then add in the platform's Kconfig the timer option as:
> 
> https://lkml.org/lkml/2015/5/22/937

Okay, here it is.

------8<--------------------------

>From fac8436459ad63531b2c39d4f060fd9420f93efd Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Fri, 15 May 2015 15:41:00 +0800
Subject: [PATCH] ARM: imx: move timer driver into drivers/clocksource

After the cleanup on imx timer driver, now it's ready to be moved into
drivers/clocksource/.  Let's do it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig                                       | 2 +-
 arch/arm/mach-imx/Makefile                                      | 2 +-
 drivers/clocksource/Kconfig                                     | 6 ++++++
 drivers/clocksource/Makefile                                    | 1 +
 arch/arm/mach-imx/time.c => drivers/clocksource/timer-imx-gpt.c | 0
 5 files changed, 9 insertions(+), 2 deletions(-)
 rename arch/arm/mach-imx/time.c => drivers/clocksource/timer-imx-gpt.c (100%)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1d8707885c57..f5813f9f31df 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -2,7 +2,7 @@ menuconfig ARCH_MXC
 	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
-	select CLKSRC_MMIO
+	select CLKSRC_IMX_GPT
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	select PM_OPP if PM
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 799e65a530be..f70e18470799 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,4 +1,4 @@
-obj-y := time.o cpu.o system.o irq-common.o
+obj-y := cpu.o system.o irq-common.o
 
 obj-$(CONFIG_SOC_IMX1) += mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += mm-imx21.o
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 51d7865fdddb..139a20795073 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -258,4 +258,10 @@ config CLKSRC_PXA
 	help
 	  This enables OST0 support available on PXA and SA-11x0
 	  platforms.
+
+config CLKSRC_IMX_GPT
+	bool "Clocksource using i.MX GPT" if COMPILE_TEST
+	depends on OF
+	select CLKSRC_MMIO
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5b85f6adb258..fce332cac646 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -51,4 +51,5 @@ obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
 obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
+obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
diff --git a/arch/arm/mach-imx/time.c b/drivers/clocksource/timer-imx-gpt.c
similarity index 100%
rename from arch/arm/mach-imx/time.c
rename to drivers/clocksource/timer-imx-gpt.c
-- 
1.9.1
