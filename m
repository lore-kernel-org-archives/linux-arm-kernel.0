From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed,  6 Jul 2011 20:34:38 +0800
Subject: [PATCH 08/17] mach-integrator: retire custom LED code
In-Reply-To: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1309955687-19365-9-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 4 LEDs in baseboard instead of the LED in core module.

The CPU activity LED is now handled by the trigger in the leds
subsystem, retire this old CONFIG_LEDS-based code.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/Kconfig                  |    7 ++
 arch/arm/mach-integrator/Makefile |    3 +-
 arch/arm/mach-integrator/core.c   |    1 -
 arch/arm/mach-integrator/leds.c   |  147 +++++++++++++++++++------------------
 4 files changed, 84 insertions(+), 74 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index df971c7..066009a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -243,6 +243,13 @@ config ARCH_INTEGRATOR
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_FPGA_IRQ
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_CPU
+	select LEDS_TRIGGER_HEARTBEAT
+	select LEDS_TRIGGER_DEFAULT_ON
+
 	help
 	  Support for ARM's Integrator platform.
 
diff --git a/arch/arm/mach-integrator/Makefile b/arch/arm/mach-integrator/Makefile
index ebeef96..5521d18 100644
--- a/arch/arm/mach-integrator/Makefile
+++ b/arch/arm/mach-integrator/Makefile
@@ -4,11 +4,10 @@
 
 # Object file lists.
 
-obj-y					:= core.o lm.o
+obj-y					:= core.o lm.o leds.o
 obj-$(CONFIG_ARCH_INTEGRATOR_AP)	+= integrator_ap.o
 obj-$(CONFIG_ARCH_INTEGRATOR_CP)	+= integrator_cp.o
 
-obj-$(CONFIG_LEDS)			+= leds.o
 obj-$(CONFIG_PCI)			+= pci_v3.o pci.o
 obj-$(CONFIG_CPU_FREQ_INTEGRATOR)	+= cpu.o
 obj-$(CONFIG_INTEGRATOR_IMPD1)		+= impd1.o
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 77315b9..c4753d8 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -28,7 +28,6 @@
 #include <asm/irq.h>
 #include <mach/cm.h>
 #include <asm/system.h>
-#include <asm/leds.h>
 #include <asm/mach/time.h>
 #include <asm/pgtable.h>
 
diff --git a/arch/arm/mach-integrator/leds.c b/arch/arm/mach-integrator/leds.c
index 28be186..21a5d97 100644
--- a/arch/arm/mach-integrator/leds.c
+++ b/arch/arm/mach-integrator/leds.c
@@ -1,91 +1,96 @@
 /*
- *  linux/arch/arm/mach-integrator/leds.c
+ * Driver for the 4 user LEDs found on the Integrator AP/CP baseboard
+ * Based on Versatile and RealView machine LED code
  *
- *  Integrator/AP and Integrator/CP LED control routines
- *
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Bryan Wu <bryan.wu@canonical.com>
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/spinlock.h>
 #include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/leds.h>
-#include <asm/system.h>
-#include <asm/mach-types.h>
-#include <mach/cm.h>
 
-static int saved_leds;
+#define ALPHA_REG __io_address(INTEGRATOR_DBG_BASE)
+#define LEDREG	(__io_address(INTEGRATOR_DBG_BASE) + INTEGRATOR_DBG_LEDS_OFFSET)
+
+struct integrator_led {
+	struct led_classdev	cdev;
+	u8			mask;
+};
+
+/*
+ * The triggers lines up below will only be used if the
+ * LED triggers are compiled in.
+ */
+static const struct {
+	const char *name;
+	const char *trigger;
+} integrator_leds[] = {
+	{ "integrator:green0", "heartbeat", },
+	{ "integrator:yellow", "cpu", },
+	{ "integrator:red", "default-on" },
+	{ "integrator:green1", },
+};
 
-static void integrator_leds_event(led_event_t ledevt)
+static void integrator_led_set(struct led_classdev *cdev,
+			      enum led_brightness b)
 {
-	unsigned long flags;
-	const unsigned int dbg_base = IO_ADDRESS(INTEGRATOR_DBG_BASE);
-	unsigned int update_alpha_leds;
-
-	// yup, change the LEDs
-	local_irq_save(flags);
-	update_alpha_leds = 0;
-
-	switch(ledevt) {
-	case led_idle_start:
-		cm_control(CM_CTRL_LED, 0);
-		break;
-
-	case led_idle_end:
-		cm_control(CM_CTRL_LED, CM_CTRL_LED);
-		break;
-
-	case led_timer:
-		saved_leds ^= GREEN_LED;
-		update_alpha_leds = 1;
-		break;
-
-	case led_red_on:
-		saved_leds |= RED_LED;
-		update_alpha_leds = 1;
-		break;
-
-	case led_red_off:
-		saved_leds &= ~RED_LED;
-		update_alpha_leds = 1;
-		break;
-
-	default:
-		break;
-	}
+	struct integrator_led *led = container_of(cdev,
+						 struct integrator_led, cdev);
+	u32 reg = __raw_readl(LEDREG);
 
-	if (update_alpha_leds) {
-		while (__raw_readl(dbg_base + INTEGRATOR_DBG_ALPHA_OFFSET) & 1);
-		__raw_writel(saved_leds, dbg_base + INTEGRATOR_DBG_LEDS_OFFSET);
-	}
-	local_irq_restore(flags);
+	if (b != LED_OFF)
+		reg |= led->mask;
+	else
+		reg &= ~led->mask;
+
+	while (__raw_readl(ALPHA_REG) & 1)
+		cpu_relax();
+
+	__raw_writel(reg, LEDREG);
 }
 
-static int __init leds_init(void)
+static enum led_brightness integrator_led_get(struct led_classdev *cdev)
 {
-	if (machine_is_integrator() || machine_is_cintegrator())
-		leds_event = integrator_leds_event;
+	struct integrator_led *led = container_of(cdev,
+						 struct integrator_led, cdev);
+	u32 reg = __raw_readl(LEDREG);
+
+	return (reg & led->mask) ? LED_FULL : LED_OFF;
+}
+
+static int __init integrator_leds_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(integrator_leds); i++) {
+		struct integrator_led *led;
+
+		led = kzalloc(sizeof(*led), GFP_KERNEL);
+		if (!led)
+			break;
+
+		led->cdev.name = integrator_leds[i].name;
+		led->cdev.brightness_set = integrator_led_set;
+		led->cdev.brightness_get = integrator_led_get;
+		led->cdev.default_trigger = integrator_leds[i].trigger;
+		led->mask = BIT(i);
+
+		if (led_classdev_register(NULL, &led->cdev) < 0) {
+			kfree(led);
+			break;
+		}
+	}
 
 	return 0;
 }
 
-core_initcall(leds_init);
+/*
+ * Since we may have triggers on any subsystem, defer registration
+ * until after subsystem_init.
+ */
+fs_initcall(integrator_leds_init);
-- 
1.7.5
