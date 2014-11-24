From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 24 Nov 2014 23:18:22 +0100
Subject: [PATCH] ARM: pxa: arbitrarily set first interrupt number
Message-ID: <1416867502-6877-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As IRQ0, the legacy timer interrupt  should not be used as an interrupt
number, shift the interrupts by a fixed number.

As we had in a special case a shift of 16 when ISA bus was used on a
PXA, use that value as the first interrupt number, regardless of ISA or
not.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/Kconfig             | 5 -----
 arch/arm/mach-pxa/include/mach/irqs.h | 9 ++-------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index e6690a4..bfca4ead 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -73,14 +73,12 @@ config ARCH_VIPER
 	select I2C_GPIO if I2C=y
 	select ISA
 	select PXA25x
-	select PXA_HAVE_ISA_IRQS
 
 config MACH_ARCOM_ZEUS
 	bool "Arcom/Eurotech ZEUS SBC"
 	select ARCOM_PCMCIA
 	select ISA
 	select PXA27x
-	select PXA_HAVE_ISA_IRQS
 
 config MACH_BALLOON3
 	bool "Balloon 3 board"
@@ -680,9 +678,6 @@ config SHARPSL_PM_MAX1111
 	select SPI
 	select SPI_MASTER
 
-config PXA_HAVE_ISA_IRQS
-	bool
-
 config PXA310_ULPI
 	bool
 
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 48c2fd8..83e04d4 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -12,14 +12,9 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
-#ifdef CONFIG_PXA_HAVE_ISA_IRQS
-#define PXA_ISA_IRQ(x)	(x)
-#define PXA_ISA_IRQ_NUM	(16)
-#else
-#define PXA_ISA_IRQ_NUM	(0)
-#endif
+#include <asm/irq.h>
 
-#define PXA_IRQ(x)	(PXA_ISA_IRQ_NUM + (x))
+#define PXA_IRQ(x)	(NR_IRQS_LEGACY + (x))
 
 #define IRQ_SSP3	PXA_IRQ(0)	/* SSP3 service request */
 #define IRQ_MSL		PXA_IRQ(1)	/* MSL Interface interrupt */
-- 
2.1.0
