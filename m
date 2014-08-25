From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:23 +0900
Subject: [PATCH 3/3] ARM: shmobile: Move legacy INTC definitions from irqs.h
 to intc.h
In-Reply-To: <cover.1408927858.git.horms+renesas@verge.net.au>
References: <cover.1408927858.git.horms+renesas@verge.net.au>
Message-ID: <86155b35d173317518458c6f9c0a3ea8c5324bed.1408927858.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Move all definitions for legacy INTC from the common "irqs.h" to the
INTC-specific "intc.h".
Include "intc.h" in sh7372/sh73a0 CPU and board files where needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
[horms+renesas at verge.net.au: omitted whitespace change]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c    | 1 +
 arch/arm/mach-shmobile/board-mackerel.c | 1 +
 arch/arm/mach-shmobile/intc.h           | 5 +++++
 arch/arm/mach-shmobile/irqs.h           | 6 ------
 arch/arm/mach-shmobile/setup-sh7372.c   | 1 +
 arch/arm/mach-shmobile/setup-sh73a0.c   | 1 +
 6 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index f8bc7f8..1bcd7eb 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -50,6 +50,7 @@
 #include <video/sh_mobile_lcdc.h>
 
 #include "common.h"
+#include "intc.h"
 #include "irqs.h"
 #include "sh73a0.h"
 
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 79f448e..b7c4261 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -63,6 +63,7 @@
 #include <asm/mach-types.h>
 
 #include "common.h"
+#include "intc.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
 #include "sh-gpio.h"
diff --git a/arch/arm/mach-shmobile/intc.h b/arch/arm/mach-shmobile/intc.h
index a5603c7..40b2ad4 100644
--- a/arch/arm/mach-shmobile/intc.h
+++ b/arch/arm/mach-shmobile/intc.h
@@ -287,4 +287,9 @@ static struct intc_desc p ## _desc __initdata = {			\
 			     p ## _sense_registers, NULL),		\
 }
 
+/* INTCS */
+#define INTCS_VECT_BASE		0x3400
+#define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
+#define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
+
 #endif  /* __ASM_MACH_INTC_H */
diff --git a/arch/arm/mach-shmobile/irqs.h b/arch/arm/mach-shmobile/irqs.h
index 8e28223..3070f6d 100644
--- a/arch/arm/mach-shmobile/irqs.h
+++ b/arch/arm/mach-shmobile/irqs.h
@@ -1,18 +1,12 @@
 #ifndef __SHMOBILE_IRQS_H
 #define __SHMOBILE_IRQS_H
 
-#include <linux/sh_intc.h>
 #include "include/mach/irqs.h"
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
 #define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */
 
-/* INTCS */
-#define INTCS_VECT_BASE		0x3400
-#define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
-#define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
-
 /* GPIO IRQ */
 #define _GPIO_IRQ_BASE		2500
 #define GPIO_IRQ_BASE(x)	(_GPIO_IRQ_BASE + (32 * x))
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 3731ecc..eaf5d13 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -41,6 +41,7 @@
 
 #include "common.h"
 #include "dma-register.h"
+#include "intc.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
 #include "sh7372.h"
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 8ff9679..173c678 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -40,6 +40,7 @@
 
 #include "common.h"
 #include "dma-register.h"
+#include "intc.h"
 #include "irqs.h"
 #include "sh73a0.h"
 
-- 
2.0.1
