From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 13:53:07 +0100
Subject: [PATCH] ARM: pxa: fix various compilation problems
Message-ID: <1391518387-5934-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to commit 88f718e3fa4d67f3a8dbe79a2f97d722323e4051
"ARM: pxa: delete the custom GPIO header" some drivers fail
compilation, for example like this:

In file included from sound/soc/pxa/spitz.c:28:0:
sound/soc/pxa/spitz.c: In function ?spitz_ext_control?:
arch/arm/mach-pxa/include/mach/spitz.h:111:30: error:
?PXA_NR_BUILTIN_GPIO? undeclared (first use in this function)
 #define SPITZ_SCP_GPIO_BASE (PXA_NR_BUILTIN_GPIO)
(etc.)

This is caused by implicit inclusion of <mach/irqs.h> from
various board-specific headers under <mach/*> in the PXA
platform. So we take a sweep over these, and for every such
header that uses PXA_NR_BUILTIN_GPIO or PXA_GPIO_TO_IRQ()
we explicitly #include "irqs.h" so that we satisfy the
dependency in the board include file alone.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC folks: please apply this patch directly to the ARM
SoC tree fixes branch if you are happy with it.
---
 arch/arm/mach-pxa/include/mach/balloon3.h         | 2 ++
 arch/arm/mach-pxa/include/mach/corgi.h            | 1 +
 arch/arm/mach-pxa/include/mach/csb726.h           | 2 ++
 arch/arm/mach-pxa/include/mach/gumstix.h          | 1 +
 arch/arm/mach-pxa/include/mach/idp.h              | 1 +
 arch/arm/mach-pxa/include/mach/palmld.h           | 2 ++
 arch/arm/mach-pxa/include/mach/palmt5.h           | 2 ++
 arch/arm/mach-pxa/include/mach/palmtc.h           | 2 ++
 arch/arm/mach-pxa/include/mach/palmtx.h           | 2 ++
 arch/arm/mach-pxa/include/mach/pcm027.h           | 2 ++
 arch/arm/mach-pxa/include/mach/pcm990_baseboard.h | 1 +
 arch/arm/mach-pxa/include/mach/poodle.h           | 2 ++
 arch/arm/mach-pxa/include/mach/spitz.h            | 2 +-
 arch/arm/mach-pxa/include/mach/tosa.h             | 2 ++
 arch/arm/mach-pxa/include/mach/trizeps4.h         | 2 ++
 15 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 954641e6c8b1..1b0825911e62 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -14,6 +14,8 @@
 #ifndef ASM_ARCH_BALLOON3_H
 #define ASM_ARCH_BALLOON3_H
 
+#include "irqs.h" /* PXA_NR_BUILTIN_GPIO */
+
 enum balloon3_features {
 	BALLOON3_FEATURE_OHCI,
 	BALLOON3_FEATURE_MMC,
diff --git a/arch/arm/mach-pxa/include/mach/corgi.h b/arch/arm/mach-pxa/include/mach/corgi.h
index f3c3493b468d..c030d955bbd7 100644
--- a/arch/arm/mach-pxa/include/mach/corgi.h
+++ b/arch/arm/mach-pxa/include/mach/corgi.h
@@ -13,6 +13,7 @@
 #ifndef __ASM_ARCH_CORGI_H
 #define __ASM_ARCH_CORGI_H  1
 
+#include "irqs.h" /* PXA_NR_BUILTIN_GPIO */
 
 /*
  * Corgi (Non Standard) GPIO Definitions
diff --git a/arch/arm/mach-pxa/include/mach/csb726.h b/arch/arm/mach-pxa/include/mach/csb726.h
index 2628e7b72116..00cfbbbf73f7 100644
--- a/arch/arm/mach-pxa/include/mach/csb726.h
+++ b/arch/arm/mach-pxa/include/mach/csb726.h
@@ -11,6 +11,8 @@
 #ifndef CSB726_H
 #define CSB726_H
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 #define CSB726_GPIO_IRQ_LAN	52
 #define CSB726_GPIO_IRQ_SM501	53
 #define CSB726_GPIO_MMC_DETECT	100
diff --git a/arch/arm/mach-pxa/include/mach/gumstix.h b/arch/arm/mach-pxa/include/mach/gumstix.h
index dba14b6503ad..f7df27bbb42e 100644
--- a/arch/arm/mach-pxa/include/mach/gumstix.h
+++ b/arch/arm/mach-pxa/include/mach/gumstix.h
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
 
 /* BTRESET - Reset line to Bluetooth module, active low signal. */
 #define GPIO_GUMSTIX_BTRESET          7
diff --git a/arch/arm/mach-pxa/include/mach/idp.h b/arch/arm/mach-pxa/include/mach/idp.h
index 22a96f87232b..7e63f4680271 100644
--- a/arch/arm/mach-pxa/include/mach/idp.h
+++ b/arch/arm/mach-pxa/include/mach/idp.h
@@ -23,6 +23,7 @@
  * IDP hardware.
  */
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
 
 #define IDP_FLASH_PHYS		(PXA_CS0_PHYS)
 #define IDP_ALT_FLASH_PHYS	(PXA_CS1_PHYS)
diff --git a/arch/arm/mach-pxa/include/mach/palmld.h b/arch/arm/mach-pxa/include/mach/palmld.h
index 2c4471336570..b184f296023b 100644
--- a/arch/arm/mach-pxa/include/mach/palmld.h
+++ b/arch/arm/mach-pxa/include/mach/palmld.h
@@ -13,6 +13,8 @@
 #ifndef _INCLUDE_PALMLD_H_
 #define _INCLUDE_PALMLD_H_
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 /** HERE ARE GPIOs **/
 
 /* GPIOs */
diff --git a/arch/arm/mach-pxa/include/mach/palmt5.h b/arch/arm/mach-pxa/include/mach/palmt5.h
index 0bd4f036c72f..e342c5921405 100644
--- a/arch/arm/mach-pxa/include/mach/palmt5.h
+++ b/arch/arm/mach-pxa/include/mach/palmt5.h
@@ -15,6 +15,8 @@
 #ifndef _INCLUDE_PALMT5_H_
 #define _INCLUDE_PALMT5_H_
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 /** HERE ARE GPIOs **/
 
 /* GPIOs */
diff --git a/arch/arm/mach-pxa/include/mach/palmtc.h b/arch/arm/mach-pxa/include/mach/palmtc.h
index c383a21680b6..81c727b3cfd2 100644
--- a/arch/arm/mach-pxa/include/mach/palmtc.h
+++ b/arch/arm/mach-pxa/include/mach/palmtc.h
@@ -16,6 +16,8 @@
 #ifndef _INCLUDE_PALMTC_H_
 #define _INCLUDE_PALMTC_H_
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 /** HERE ARE GPIOs **/
 
 /* GPIOs */
diff --git a/arch/arm/mach-pxa/include/mach/palmtx.h b/arch/arm/mach-pxa/include/mach/palmtx.h
index f2e530380253..92bc1f05300d 100644
--- a/arch/arm/mach-pxa/include/mach/palmtx.h
+++ b/arch/arm/mach-pxa/include/mach/palmtx.h
@@ -16,6 +16,8 @@
 #ifndef _INCLUDE_PALMTX_H_
 #define _INCLUDE_PALMTX_H_
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 /** HERE ARE GPIOs **/
 
 /* GPIOs */
diff --git a/arch/arm/mach-pxa/include/mach/pcm027.h b/arch/arm/mach-pxa/include/mach/pcm027.h
index 6bf28de228bd..86ebd7b6c960 100644
--- a/arch/arm/mach-pxa/include/mach/pcm027.h
+++ b/arch/arm/mach-pxa/include/mach/pcm027.h
@@ -23,6 +23,8 @@
  * Definitions of CPU card resources only
  */
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 /* phyCORE-PXA270 (PCM027) Interrupts */
 #define PCM027_IRQ(x)          (IRQ_BOARD_START + (x))
 #define PCM027_BTDET_IRQ       PCM027_IRQ(0)
diff --git a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
index 0260aaa2fc17..7e544c14967e 100644
--- a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
+++ b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
@@ -20,6 +20,7 @@
  */
 
 #include <mach/pcm027.h>
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
 
 /*
  * definitions relevant only when the PCM-990
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index f32ff75dcca8..b56b19351a03 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -15,6 +15,8 @@
 #ifndef __ASM_ARCH_POODLE_H
 #define __ASM_ARCH_POODLE_H  1
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 /*
  * GPIOs
  */
diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
index 0bfe6507c95d..25c9f62e46aa 100644
--- a/arch/arm/mach-pxa/include/mach/spitz.h
+++ b/arch/arm/mach-pxa/include/mach/spitz.h
@@ -15,8 +15,8 @@
 #define __ASM_ARCH_SPITZ_H  1
 #endif
 
+#include "irqs.h" /* PXA_NR_BUILTIN_GPIO, PXA_GPIO_TO_IRQ */
 #include <linux/fb.h>
-#include <linux/gpio.h>
 
 /* Spitz/Akita GPIOs */
 
diff --git a/arch/arm/mach-pxa/include/mach/tosa.h b/arch/arm/mach-pxa/include/mach/tosa.h
index 2bb0e862598c..0497d95cef25 100644
--- a/arch/arm/mach-pxa/include/mach/tosa.h
+++ b/arch/arm/mach-pxa/include/mach/tosa.h
@@ -13,6 +13,8 @@
 #ifndef _ASM_ARCH_TOSA_H_
 #define _ASM_ARCH_TOSA_H_ 1
 
+#include "irqs.h" /* PXA_NR_BUILTIN_GPIO */
+
 /*  TOSA Chip selects  */
 #define TOSA_LCDC_PHYS		PXA_CS4_PHYS
 /* Internel Scoop */
diff --git a/arch/arm/mach-pxa/include/mach/trizeps4.h b/arch/arm/mach-pxa/include/mach/trizeps4.h
index d2ca01053f69..ae3ca013afab 100644
--- a/arch/arm/mach-pxa/include/mach/trizeps4.h
+++ b/arch/arm/mach-pxa/include/mach/trizeps4.h
@@ -10,6 +10,8 @@
 #ifndef _TRIPEPS4_H_
 #define _TRIPEPS4_H_
 
+#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+
 /* physical memory regions */
 #define TRIZEPS4_FLASH_PHYS	(PXA_CS0_PHYS)  /* Flash region */
 #define TRIZEPS4_DISK_PHYS	(PXA_CS1_PHYS)  /* Disk On Chip region */
-- 
1.8.5.3
