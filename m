From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:14:09 -0600
Subject: [PATCH v6 30/41] ARM: davinci: switch to common clock framework
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-31-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches ARCH_DAVINCI to use the common clock framework. The legacy
clock code in arch/arm/mach-davinci/ is no longer used. New drivers in
drivers/clk/davinci/ are used instead.

A few macros had to be moved to prevent compile errors.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- clean up indent on Common objects section

 arch/arm/Kconfig                | 2 +-
 arch/arm/mach-davinci/Makefile  | 4 ++--
 arch/arm/mach-davinci/clock.h   | 4 ----
 arch/arm/mach-davinci/davinci.h | 4 ++++
 arch/arm/mach-davinci/psc.h     | 2 --
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c8df5..3a12f9e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -604,7 +604,7 @@ config ARCH_S3C24XX
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select CLKDEV_LOOKUP
+	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 4e81780..8725d8b 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -5,8 +5,8 @@
 #
 
 # Common objects
-obj-y 			:= time.o clock.o serial.o psc.o \
-			   usb.o common.o sram.o aemif.o
+obj-y 					:= time.o serial.o usb.o \
+					   common.o sram.o aemif.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index d7894d5..2d05856 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -12,10 +12,6 @@
 #ifndef __ARCH_ARM_DAVINCI_CLOCK_H
 #define __ARCH_ARM_DAVINCI_CLOCK_H
 
-#define DAVINCI_PLL1_BASE 0x01c40800
-#define DAVINCI_PLL2_BASE 0x01c40c00
-#define MAX_PLL 2
-
 /* PLL/Reset register offsets */
 #define PLLCTL          0x100
 #define PLLCTL_PLLEN    BIT(0)
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 270cef8..f5206a6 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -35,6 +35,10 @@
 #include <media/davinci/vpbe.h>
 #include <media/davinci/vpbe_osd.h>
 
+#define DAVINCI_PLL1_BASE		0x01c40800
+#define DAVINCI_PLL2_BASE		0x01c40c00
+#define	DAVINCI_PWR_SLEEP_CNTRL_BASE	0x01c41000
+
 #define DAVINCI_SYSTEM_MODULE_BASE	0x01c40000
 #define SYSMOD_VDAC_CONFIG		0x2c
 #define SYSMOD_VIDCLKCTL		0x38
diff --git a/arch/arm/mach-davinci/psc.h b/arch/arm/mach-davinci/psc.h
index 8af9f09..b58707c 100644
--- a/arch/arm/mach-davinci/psc.h
+++ b/arch/arm/mach-davinci/psc.h
@@ -27,8 +27,6 @@
 #ifndef __ASM_ARCH_PSC_H
 #define __ASM_ARCH_PSC_H
 
-#define	DAVINCI_PWR_SLEEP_CNTRL_BASE	0x01C41000
-
 /* Power and Sleep Controller (PSC) Domains */
 #define DAVINCI_GPSC_ARMDOMAIN		0
 #define DAVINCI_GPSC_DSPDOMAIN		1
-- 
2.7.4
