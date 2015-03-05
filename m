From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 20:17:42 +0100
Subject: [PATCH v2 1/7] ARM: at91: switch to multiplatform
In-Reply-To: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425583068-5826-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425583068-5826-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch AT91 to multiplatform as all SoCs are properly handled.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/Kconfig            |  13 -----
 arch/arm/mach-at91/Kconfig  | 117 +++++++++++++++++++++++---------------------
 arch/arm/mach-at91/Makefile |   2 +
 3 files changed, 62 insertions(+), 70 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f6c5b05e8de8..a1d153098001 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -356,19 +356,6 @@ config ARCH_VERSATILE
 	help
 	  This enables support for ARM Ltd Versatile board.
 
-config ARCH_AT91
-	bool "Atmel AT91"
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select IRQ_DOMAIN
-	select PINCTRL
-	select PINCTRL_AT91
-	select SOC_BUS
-	select USE_OF
-	help
-	  This enables support for systems based on Atmel
-	  AT91RM9200, AT91SAM9 and SAMA5 processors.
-
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7ecde7de69da..1b8525c324c3 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,51 +1,22 @@
-if ARCH_AT91
-
-config HAVE_AT91_UTMI
-	bool
-
-config HAVE_AT91_USB_CLK
-	bool
-
-config COMMON_CLK_AT91
-	bool
-	select COMMON_CLK
-
-config HAVE_AT91_SMD
-	bool
-
-config HAVE_AT91_H32MX
-	bool
-
-config SOC_SAMA5
+config ARCH_AT91
 	bool
-	select ATMEL_AIC5_IRQ
+	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_AT91
-	select CPU_V7
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
-	select MEMORY
-	select ATMEL_SDRAMC
-	select PHYLIB if NETDEVICES
-
-menu "Atmel AT91 System-on-Chip"
-
-choice
-
-	prompt "Core type"
-
-config SOC_SAM_V4_V5
-	bool "ARM9 AT91SAM9/AT91RM9200"
-	help
-	  Select this if you are using one of Atmel's AT91SAM9 or
-	  AT91RM9200 SoC.
-
-config SOC_SAM_V7
-	bool "Cortex A5"
+	select IRQ_DOMAIN
+	select NEED_MACH_IO_H if PCCARD
+	select PINCTRL
+	select PINCTRL_AT91
+	select SOC_BUS
+	select USE_OF
+
+menuconfig SOC_SAM_V7
+	bool "Atmel SAMA5" if ARCH_MULTI_V7
+	select ARCH_AT91
 	help
-	  Select this if you are using one of Atmel's SAMA5D3 SoC.
-
-endchoice
-
-comment "Atmel AT91 Processor"
+	  This enables support for systems based on Atmel
+	  SAMA5D3 or SAMA5D4 SoCs.
 
 if SOC_SAM_V7
 config SOC_SAMA5D3
@@ -71,25 +42,29 @@ config SOC_SAMA5D4
 	select HAVE_AT91_H32MX
 	help
 	  Select this if you are using one of Atmel's SAMA5D4 family SoC.
-endif
+endif # SOC_SAM_V7
+
+
+menuconfig SOC_SAM_V4_V5
+	bool "Atmel ARM9 AT91SAM9/AT91RM9200" if ARCH_MULTI_V4_V5
+	select ARCH_AT91
+	help
+	  Select this if you are using one of Atmel's AT91SAM9 or
+	  AT91RM9200 SoC.
 
 if SOC_SAM_V4_V5
 config SOC_AT91RM9200
-	bool "AT91RM9200"
+	bool "AT91RM9200" if ARCH_MULTI_V4T
 	select ATMEL_AIC_IRQ
-	select COMMON_CLK_AT91
 	select CPU_ARM920T
-	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USB_CLK
 	select MIGHT_HAVE_PCI
 
 config SOC_AT91SAM9
-	bool "AT91SAM9"
+	bool "AT91SAM9" if ARCH_MULTI_V5
 	select ATMEL_AIC_IRQ
 	select ATMEL_SDRAMC
-	select COMMON_CLK_AT91
 	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_SMD
 	select HAVE_AT91_USB_CLK
 	select HAVE_AT91_UTMI
@@ -115,6 +90,34 @@ config SOC_AT91SAM9
 	    AT91SAM9XE
 endif # SOC_SAM_V4_V5
 
+if ARCH_AT91
+
+config HAVE_AT91_UTMI
+	bool
+
+config HAVE_AT91_USB_CLK
+	bool
+
+config COMMON_CLK_AT91
+	bool
+	select COMMON_CLK
+
+config HAVE_AT91_SMD
+	bool
+
+config HAVE_AT91_H32MX
+	bool
+
+config SOC_SAMA5
+	bool
+	select ATMEL_AIC5_IRQ
+	select CPU_V7
+	select MEMORY
+	select ATMEL_SDRAMC
+	select PHYLIB if NETDEVICES
+
+menu "Atmel AT91 common options"
+
 comment "AT91 Feature Selections"
 
 config AT91_SLOW_CLOCK
@@ -132,12 +135,12 @@ config AT91_SLOW_CLOCK
 	  need to be completely re-initialized.
 
 config AT91_TIMER_HZ
-       int "Kernel HZ (jiffies per second)"
-       range 32 1024
-       depends on ARCH_AT91
-       default "128" if SOC_AT91RM9200
-       default "100"
-       help
+	int "Kernel HZ (jiffies per second)"
+	range 32 1024
+	depends on ARCH_AT91
+	default "128" if SOC_AT91RM9200
+	default "100"
+	help
 	  On AT91rm9200 chips where you're using a system clock derived
 	  from the 32768 Hz hardware clock, this tick rate should divide
 	  it exactly: use a power-of-two value, such as 128 or 256, to
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 999f12dbdd16..e51170eeaacd 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the linux kernel.
 #
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-y		:= soc.o
 
-- 
2.1.0
