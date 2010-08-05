From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 05 Aug 2010 11:47:05 +0900
Subject: [PATCH] ARM: S5PC110: Move the GPIO interrupt type definition to
	plat-samsung
Message-ID: <20100805024705.GA14155@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

It's common part for Samsung SoCs. so move to plat-samsung.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
index 49e029b..de0c899 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
@@ -31,13 +31,6 @@
 
 #define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
 
-/* values for S5P_EXTINT0 */
-#define S5P_EXTINT_LOWLEV		(0x00)
-#define S5P_EXTINT_HILEV		(0x01)
-#define S5P_EXTINT_FALLEDGE		(0x02)
-#define S5P_EXTINT_RISEEDGE		(0x03)
-#define S5P_EXTINT_BOTHEDGE		(0x04)
-
 #define EINT_MODE		S3C_GPIO_SFN(0xf)
 
 #define EINT_GPIO_0(x)		S5PV210_GPH0(x)
diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index f36cd33..530a28d 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -25,6 +25,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
+#include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <mach/regs-gpio.h>
 
@@ -67,23 +68,23 @@ static int s5p_irq_eint_set_type(unsigned int irq, unsigned int type)
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		newvalue = S5P_EXTINT_RISEEDGE;
+		newvalue = S5P_GPIO_EDGE_RISING;
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
-		newvalue = S5P_EXTINT_FALLEDGE;
+		newvalue = S5P_GPIO_EDGE_FALLING;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
-		newvalue = S5P_EXTINT_BOTHEDGE;
+		newvalue = S5P_GPIO_EDGE_BOTH;
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
-		newvalue = S5P_EXTINT_LOWLEV;
+		newvalue = GPIO_LEVEL_LOW;
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
-		newvalue = S5P_EXTINT_HILEV;
+		newvalue = GPIO_LEVEL_HIGH;
 		break;
 
 	default:
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index e358c7d..09c3768 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -14,6 +14,12 @@
 #define GPIOCON_OFF	(0x00)
 #define GPIODAT_OFF	(0x04)
 
+#define GPIO_LEVEL_LOW			(0x00)
+#define GPIO_LEVEL_HIGH			(0x01)
+#define S5P_GPIO_EDGE_FALLING		(0x02)
+#define S5P_GPIO_EDGE_RISING		(0x03)
+#define S5P_GPIO_EDGE_BOTH			(0x04)
+
 #define con_4bit_shift(__off) ((__off) * 4)
 
 /* Define the core gpiolib support functions that the s3c platforms may
