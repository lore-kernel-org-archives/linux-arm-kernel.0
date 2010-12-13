From: gbean@codeaurora.org (Gregory Bean)
Date: Mon, 13 Dec 2010 09:02:49 -0800
Subject: [PATCH 1/2] msm: gpiomux: Improve gpiomux interface design.
Message-ID: <1292259770-22972-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the gpiomux interface by:
- collapsing redundant abstractions into shared common ones
- disconnecting gpiomux abstractions from particular MSM implementations
- moving platform-specific details out of the common abstraction
- moving implementation complexity out of the interface and back into
  the implementation, where it should have been in the first place
- allowing for the future extension of the set of power states
- disambiguating 'settings' and 'configurations'.
- improving the initialization sequence to provide more flexibility
- not forcing lines to reset to input mode at power transitions

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/mach-msm/gpio.c         |   17 ++++
 arch/arm/mach-msm/gpio.h         |   28 +++++++
 arch/arm/mach-msm/gpiomux-7x30.c |   69 +++++++++++++----
 arch/arm/mach-msm/gpiomux-8x50.c |   43 +++++++++--
 arch/arm/mach-msm/gpiomux-8x60.c |    9 ++-
 arch/arm/mach-msm/gpiomux-v1.c   |   24 +++++-
 arch/arm/mach-msm/gpiomux-v1.h   |   67 -----------------
 arch/arm/mach-msm/gpiomux-v2.c   |   17 ++++-
 arch/arm/mach-msm/gpiomux-v2.h   |   61 ---------------
 arch/arm/mach-msm/gpiomux.c      |  121 ++++++++++++++++++++++--------
 arch/arm/mach-msm/gpiomux.h      |  152 +++++++++++++++++++++++++++-----------
 11 files changed, 378 insertions(+), 230 deletions(-)
 create mode 100644 arch/arm/mach-msm/gpio.h
 delete mode 100644 arch/arm/mach-msm/gpiomux-v1.h
 delete mode 100644 arch/arm/mach-msm/gpiomux-v2.h

diff --git a/arch/arm/mach-msm/gpio.c b/arch/arm/mach-msm/gpio.c
index 33051b5..3f23454 100644
--- a/arch/arm/mach-msm/gpio.c
+++ b/arch/arm/mach-msm/gpio.c
@@ -374,3 +374,20 @@ static int __init msm_init_gpio(void)
 }
 
 postcore_initcall(msm_init_gpio);
+
+/* Locate the GPIO_OUT register for the given GPIO and return its address
+ * and the bit position of the gpio's bit within the register.
+ *
+ * This function is used by gpiomux-v1 in order to support output transitions.
+ */
+void msm_gpio_find_out(const unsigned gpio, void __iomem **out,
+	unsigned *offset)
+{
+	struct msm_gpio_chip *msm_chip = msm_gpio_chips;
+
+	while (gpio >= msm_chip->chip.base + msm_chip->chip.ngpio)
+		++msm_chip;
+
+	*out = msm_chip->regs.out;
+	*offset = gpio - msm_chip->chip.base;
+}
diff --git a/arch/arm/mach-msm/gpio.h b/arch/arm/mach-msm/gpio.h
new file mode 100644
index 0000000..b143b8c
--- /dev/null
+++ b/arch/arm/mach-msm/gpio.h
@@ -0,0 +1,28 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#ifndef _ARCH_ARM_MACH_MSM_GPIO_H_
+#define _ARCH_ARM_MACH_MSM_GPIO_H_
+
+/* Locate the GPIO_OUT register for the given GPIO and return its address
+ * and the bit position of the gpio's bit within the register.
+ *
+ * This function is used by gpiomux-v1 in order to support output transitions.
+ */
+void msm_gpio_find_out(const unsigned gpio, void __iomem **out,
+	unsigned *offset);
+
+#endif
diff --git a/arch/arm/mach-msm/gpiomux-7x30.c b/arch/arm/mach-msm/gpiomux-7x30.c
index 6ce41c5..fadb5da 100644
--- a/arch/arm/mach-msm/gpiomux-7x30.c
+++ b/arch/arm/mach-msm/gpiomux-7x30.c
@@ -14,25 +14,64 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
+#include <linux/module.h>
+#include <mach/irqs.h>
 #include "gpiomux.h"
 
-struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
-#ifdef CONFIG_SERIAL_MSM_CONSOLE
-	[49] = { /* UART2 RFR */
-		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
-			     GPIOMUX_FUNC_2 | GPIOMUX_VALID,
+static struct msm_gpiomux_config msm7x30_uart2_configs[] __initdata = {
+	{
+		.gpio = 49, /* UART2 RFR */
+		.settings = {
+			[GPIOMUX_SUSPENDED] = {
+				.func = GPIOMUX_FUNC_2,
+				.drv  = GPIOMUX_DRV_2MA,
+				.pull = GPIOMUX_PULL_DOWN,
+			},
+		},
 	},
-	[50] = { /* UART2 CTS */
-		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
-			     GPIOMUX_FUNC_2 | GPIOMUX_VALID,
+	{
+		.gpio = 50, /* UART2 CTS */
+		.settings = {
+			[GPIOMUX_SUSPENDED] = {
+				.func = GPIOMUX_FUNC_2,
+				.drv  = GPIOMUX_DRV_2MA,
+				.pull = GPIOMUX_PULL_DOWN,
+			},
+		},
 	},
-	[51] = { /* UART2 RX */
-		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
-			     GPIOMUX_FUNC_2 | GPIOMUX_VALID,
+	{
+		.gpio = 51, /* UART2 RX */
+		.settings = {
+			[GPIOMUX_SUSPENDED] = {
+				.func = GPIOMUX_FUNC_2,
+				.drv  = GPIOMUX_DRV_2MA,
+				.pull = GPIOMUX_PULL_DOWN,
+			},
+		},
 	},
-	[52] = { /* UART2 TX */
-		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
-			     GPIOMUX_FUNC_2 | GPIOMUX_VALID,
+	{
+		.gpio = 52, /* UART2 TX */
+		.settings = {
+			[GPIOMUX_SUSPENDED] = {
+				.func = GPIOMUX_FUNC_2,
+				.drv  = GPIOMUX_DRV_2MA,
+				.pull = GPIOMUX_PULL_DOWN,
+			},
+		},
 	},
-#endif
 };
+
+static int __init gpiomux_init(void)
+{
+	int rc;
+
+	rc = msm_gpiomux_init(NR_GPIO_IRQS);
+	if (rc)
+		return rc;
+
+	msm_gpiomux_install(msm7x30_uart2_configs,
+		ARRAY_SIZE(msm7x30_uart2_configs));
+
+	return 0;
+}
+postcore_initcall(gpiomux_init);
diff --git a/arch/arm/mach-msm/gpiomux-8x50.c b/arch/arm/mach-msm/gpiomux-8x50.c
index 4406e0f..dd45851 100644
--- a/arch/arm/mach-msm/gpiomux-8x50.c
+++ b/arch/arm/mach-msm/gpiomux-8x50.c
@@ -14,15 +14,44 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
+#include <linux/module.h>
+#include <mach/irqs.h>
 #include "gpiomux.h"
 
-struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
-	[86] = { /* UART3 RX */
-		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
-			     GPIOMUX_FUNC_1 | GPIOMUX_VALID,
+static struct msm_gpiomux_config msm8x50_uart3_configs[] __initdata = {
+	{
+		.gpio = 86, /* UART3 RX */
+		.settings = {
+			[GPIOMUX_SUSPENDED] = {
+				.func = GPIOMUX_FUNC_1,
+				.drv  = GPIOMUX_DRV_2MA,
+				.pull = GPIOMUX_PULL_DOWN,
+			},
+		},
 	},
-	[87] = { /* UART3 TX */
-		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
-			     GPIOMUX_FUNC_1 | GPIOMUX_VALID,
+	{
+		.gpio = 87, /* UART3 TX */
+		.settings = {
+			[GPIOMUX_SUSPENDED] = {
+				.func = GPIOMUX_FUNC_1,
+				.drv  = GPIOMUX_DRV_2MA,
+				.pull = GPIOMUX_PULL_DOWN,
+			},
+		},
 	},
 };
+
+static int __init gpiomux_init(void)
+{
+	int rc;
+
+	rc = msm_gpiomux_init(NR_GPIO_IRQS);
+	if (rc)
+		return rc;
+
+	msm_gpiomux_install(msm8x50_uart3_configs,
+		ARRAY_SIZE(msm8x50_uart3_configs));
+
+	return 0;
+}
+postcore_initcall(gpiomux_init);
diff --git a/arch/arm/mach-msm/gpiomux-8x60.c b/arch/arm/mach-msm/gpiomux-8x60.c
index 7b380b3..9415ae1 100644
--- a/arch/arm/mach-msm/gpiomux-8x60.c
+++ b/arch/arm/mach-msm/gpiomux-8x60.c
@@ -14,6 +14,13 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
+#include <linux/module.h>
+#include <mach/irqs.h>
+#include <asm/mach-types.h>
 #include "gpiomux.h"
 
-struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {};
+static int __init gpiomux_init(void)
+{
+	return msm_gpiomux_init(NR_GPIO_IRQS);
+}
+postcore_initcall(gpiomux_init);
diff --git a/arch/arm/mach-msm/gpiomux-v1.c b/arch/arm/mach-msm/gpiomux-v1.c
index 27de2ab..9ba2acd 100644
--- a/arch/arm/mach-msm/gpiomux-v1.c
+++ b/arch/arm/mach-msm/gpiomux-v1.c
@@ -14,17 +14,35 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
+#include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <linux/io.h>
 #include "gpiomux.h"
 #include "proc_comm.h"
+#include "gpio.h"
 
-void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val)
+void __msm_gpiomux_write(unsigned gpio, struct gpiomux_setting val)
 {
-	unsigned tlmm_config  = (val & ~GPIOMUX_CTL_MASK) |
-				((gpio & 0x3ff) << 4);
+	unsigned tlmm_config;
 	unsigned tlmm_disable = 0;
+	void __iomem *out_reg;
+	unsigned offset;
+	uint32_t bits;
 	int rc;
 
+	tlmm_config  = (val.drv << 17) |
+		(val.pull << 15) |
+		((gpio & 0x3ff) << 4) |
+		val.func;
+	if (val.func == GPIOMUX_FUNC_GPIO) {
+		tlmm_config |= (val.dir > GPIOMUX_IN ? BIT(14) : 0);
+		msm_gpio_find_out(gpio, &out_reg, &offset);
+		bits = readl(out_reg);
+		if (val.dir == GPIOMUX_OUT_HIGH)
+			writel(bits | BIT(offset), out_reg);
+		else
+			writel(bits & ~BIT(offset), out_reg);
+	}
 	rc = msm_proc_comm(PCOM_RPC_GPIO_TLMM_CONFIG_EX,
 			   &tlmm_config, &tlmm_disable);
 	if (rc)
diff --git a/arch/arm/mach-msm/gpiomux-v1.h b/arch/arm/mach-msm/gpiomux-v1.h
deleted file mode 100644
index 71d86fe..0000000
--- a/arch/arm/mach-msm/gpiomux-v1.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-#ifndef __ARCH_ARM_MACH_MSM_GPIOMUX_V1_H
-#define __ARCH_ARM_MACH_MSM_GPIOMUX_V1_H
-
-#if defined(CONFIG_ARCH_MSM7X30)
-#define GPIOMUX_NGPIOS 182
-#elif defined(CONFIG_ARCH_QSD8X50)
-#define GPIOMUX_NGPIOS 165
-#else
-#define GPIOMUX_NGPIOS 133
-#endif
-
-typedef u32 gpiomux_config_t;
-
-enum {
-	GPIOMUX_DRV_2MA  = 0UL << 17,
-	GPIOMUX_DRV_4MA  = 1UL << 17,
-	GPIOMUX_DRV_6MA  = 2UL << 17,
-	GPIOMUX_DRV_8MA  = 3UL << 17,
-	GPIOMUX_DRV_10MA = 4UL << 17,
-	GPIOMUX_DRV_12MA = 5UL << 17,
-	GPIOMUX_DRV_14MA = 6UL << 17,
-	GPIOMUX_DRV_16MA = 7UL << 17,
-};
-
-enum {
-	GPIOMUX_FUNC_GPIO = 0UL,
-	GPIOMUX_FUNC_1    = 1UL,
-	GPIOMUX_FUNC_2    = 2UL,
-	GPIOMUX_FUNC_3    = 3UL,
-	GPIOMUX_FUNC_4    = 4UL,
-	GPIOMUX_FUNC_5    = 5UL,
-	GPIOMUX_FUNC_6    = 6UL,
-	GPIOMUX_FUNC_7    = 7UL,
-	GPIOMUX_FUNC_8    = 8UL,
-	GPIOMUX_FUNC_9    = 9UL,
-	GPIOMUX_FUNC_A    = 10UL,
-	GPIOMUX_FUNC_B    = 11UL,
-	GPIOMUX_FUNC_C    = 12UL,
-	GPIOMUX_FUNC_D    = 13UL,
-	GPIOMUX_FUNC_E    = 14UL,
-	GPIOMUX_FUNC_F    = 15UL,
-};
-
-enum {
-	GPIOMUX_PULL_NONE   = 0UL << 15,
-	GPIOMUX_PULL_DOWN   = 1UL << 15,
-	GPIOMUX_PULL_KEEPER = 2UL << 15,
-	GPIOMUX_PULL_UP     = 3UL << 15,
-};
-
-#endif
diff --git a/arch/arm/mach-msm/gpiomux-v2.c b/arch/arm/mach-msm/gpiomux-v2.c
index 273396d..f74552f 100644
--- a/arch/arm/mach-msm/gpiomux-v2.c
+++ b/arch/arm/mach-msm/gpiomux-v2.c
@@ -14,12 +14,23 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
+#include <linux/bitops.h>
 #include <linux/io.h>
 #include <mach/msm_iomap.h>
 #include "gpiomux.h"
 
-void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val)
+#define GPIO_CFG(n)    (MSM_TLMM_BASE + 0x1000 + (0x10 * n))
+#define GPIO_IN_OUT(n) (MSM_TLMM_BASE + 0x1004 + (0x10 * n))
+
+void __msm_gpiomux_write(unsigned gpio, struct gpiomux_setting val)
 {
-	writel(val & ~GPIOMUX_CTL_MASK,
-	       MSM_TLMM_BASE + 0x1000 + (0x10 * gpio));
+	uint32_t bits;
+
+	bits = (val.drv << 6) | (val.func << 2) | val.pull;
+	if (val.func == GPIOMUX_FUNC_GPIO) {
+		bits |= val.dir > GPIOMUX_IN ? BIT(9) : 0;
+		writel(val.dir == GPIOMUX_OUT_HIGH ? BIT(1) : 0,
+			GPIO_IN_OUT(gpio));
+	}
+	writel(bits, GPIO_CFG(gpio));
 }
diff --git a/arch/arm/mach-msm/gpiomux-v2.h b/arch/arm/mach-msm/gpiomux-v2.h
deleted file mode 100644
index 3bf10e7..0000000
--- a/arch/arm/mach-msm/gpiomux-v2.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-#ifndef __ARCH_ARM_MACH_MSM_GPIOMUX_V2_H
-#define __ARCH_ARM_MACH_MSM_GPIOMUX_V2_H
-
-#define GPIOMUX_NGPIOS 173
-
-typedef u16 gpiomux_config_t;
-
-enum {
-	GPIOMUX_DRV_2MA  = 0UL << 6,
-	GPIOMUX_DRV_4MA  = 1UL << 6,
-	GPIOMUX_DRV_6MA  = 2UL << 6,
-	GPIOMUX_DRV_8MA  = 3UL << 6,
-	GPIOMUX_DRV_10MA = 4UL << 6,
-	GPIOMUX_DRV_12MA = 5UL << 6,
-	GPIOMUX_DRV_14MA = 6UL << 6,
-	GPIOMUX_DRV_16MA = 7UL << 6,
-};
-
-enum {
-	GPIOMUX_FUNC_GPIO = 0UL  << 2,
-	GPIOMUX_FUNC_1    = 1UL  << 2,
-	GPIOMUX_FUNC_2    = 2UL  << 2,
-	GPIOMUX_FUNC_3    = 3UL  << 2,
-	GPIOMUX_FUNC_4    = 4UL  << 2,
-	GPIOMUX_FUNC_5    = 5UL  << 2,
-	GPIOMUX_FUNC_6    = 6UL  << 2,
-	GPIOMUX_FUNC_7    = 7UL  << 2,
-	GPIOMUX_FUNC_8    = 8UL  << 2,
-	GPIOMUX_FUNC_9    = 9UL  << 2,
-	GPIOMUX_FUNC_A    = 10UL << 2,
-	GPIOMUX_FUNC_B    = 11UL << 2,
-	GPIOMUX_FUNC_C    = 12UL << 2,
-	GPIOMUX_FUNC_D    = 13UL << 2,
-	GPIOMUX_FUNC_E    = 14UL << 2,
-	GPIOMUX_FUNC_F    = 15UL << 2,
-};
-
-enum {
-	GPIOMUX_PULL_NONE   = 0UL,
-	GPIOMUX_PULL_DOWN   = 1UL,
-	GPIOMUX_PULL_KEEPER = 2UL,
-	GPIOMUX_PULL_UP     = 3UL,
-};
-
-#endif
diff --git a/arch/arm/mach-msm/gpiomux.c b/arch/arm/mach-msm/gpiomux.c
index 53af21a..637845f 100644
--- a/arch/arm/mach-msm/gpiomux.c
+++ b/arch/arm/mach-msm/gpiomux.c
@@ -15,50 +15,74 @@
  * 02110-1301, USA.
  */
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include "gpiomux.h"
 
+struct msm_gpiomux_rec {
+	struct gpiomux_setting *sets[GPIOMUX_NSETTINGS];
+	int ref;
+};
 static DEFINE_SPINLOCK(gpiomux_lock);
+static struct msm_gpiomux_rec *msm_gpiomux_recs;
+static struct gpiomux_setting *msm_gpiomux_sets;
+static unsigned msm_gpiomux_ngpio;
 
-int msm_gpiomux_write(unsigned gpio,
-		      gpiomux_config_t active,
-		      gpiomux_config_t suspended)
+int msm_gpiomux_write(unsigned gpio, enum msm_gpiomux_setting which,
+	struct gpiomux_setting *setting, struct gpiomux_setting *old_setting)
 {
-	struct msm_gpiomux_config *cfg = msm_gpiomux_configs + gpio;
+	struct msm_gpiomux_rec *rec = msm_gpiomux_recs + gpio;
+	unsigned set_slot = gpio * GPIOMUX_NSETTINGS + which;
 	unsigned long irq_flags;
-	gpiomux_config_t setting;
+	struct gpiomux_setting *new_set;
+	int status = 0;
 
-	if (gpio >= GPIOMUX_NGPIOS)
+	if (!msm_gpiomux_recs)
+		return -EFAULT;
+
+	if (gpio >= msm_gpiomux_ngpio)
 		return -EINVAL;
 
 	spin_lock_irqsave(&gpiomux_lock, irq_flags);
 
-	if (active & GPIOMUX_VALID)
-		cfg->active = active;
+	if (old_setting) {
+		if (rec->sets[which] == NULL)
+			status = 1;
+		else
+			*old_setting =  *(rec->sets[which]);
+	}
 
-	if (suspended & GPIOMUX_VALID)
-		cfg->suspended = suspended;
+	if (setting) {
+		msm_gpiomux_sets[set_slot] = *setting;
+		rec->sets[which] = &msm_gpiomux_sets[set_slot];
+	} else {
+		rec->sets[which] = NULL;
+	}
 
-	setting = cfg->ref ? active : suspended;
-	if (setting & GPIOMUX_VALID)
-		__msm_gpiomux_write(gpio, setting);
+	new_set = rec->ref ? rec->sets[GPIOMUX_ACTIVE] :
+		rec->sets[GPIOMUX_SUSPENDED];
+	if (new_set)
+		__msm_gpiomux_write(gpio, *new_set);
 
 	spin_unlock_irqrestore(&gpiomux_lock, irq_flags);
-	return 0;
+	return status;
 }
 EXPORT_SYMBOL(msm_gpiomux_write);
 
 int msm_gpiomux_get(unsigned gpio)
 {
-	struct msm_gpiomux_config *cfg = msm_gpiomux_configs + gpio;
+	struct msm_gpiomux_rec *rec = msm_gpiomux_recs + gpio;
 	unsigned long irq_flags;
 
-	if (gpio >= GPIOMUX_NGPIOS)
+	if (!msm_gpiomux_recs)
+		return -EFAULT;
+
+	if (gpio >= msm_gpiomux_ngpio)
 		return -EINVAL;
 
 	spin_lock_irqsave(&gpiomux_lock, irq_flags);
-	if (cfg->ref++ == 0 && cfg->active & GPIOMUX_VALID)
-		__msm_gpiomux_write(gpio, cfg->active);
+	if (rec->ref++ == 0 && rec->sets[GPIOMUX_ACTIVE])
+		__msm_gpiomux_write(gpio, *rec->sets[GPIOMUX_ACTIVE]);
 	spin_unlock_irqrestore(&gpiomux_lock, irq_flags);
 	return 0;
 }
@@ -66,31 +90,66 @@ EXPORT_SYMBOL(msm_gpiomux_get);
 
 int msm_gpiomux_put(unsigned gpio)
 {
-	struct msm_gpiomux_config *cfg = msm_gpiomux_configs + gpio;
+	struct msm_gpiomux_rec *rec = msm_gpiomux_recs + gpio;
 	unsigned long irq_flags;
 
-	if (gpio >= GPIOMUX_NGPIOS)
+	if (!msm_gpiomux_recs)
+		return -EFAULT;
+
+	if (gpio >= msm_gpiomux_ngpio)
 		return -EINVAL;
 
 	spin_lock_irqsave(&gpiomux_lock, irq_flags);
-	BUG_ON(cfg->ref == 0);
-	if (--cfg->ref == 0 && cfg->suspended & GPIOMUX_VALID)
-		__msm_gpiomux_write(gpio, cfg->suspended);
+	BUG_ON(rec->ref == 0);
+	if (--rec->ref == 0 && rec->sets[GPIOMUX_SUSPENDED])
+		__msm_gpiomux_write(gpio, *rec->sets[GPIOMUX_SUSPENDED]);
 	spin_unlock_irqrestore(&gpiomux_lock, irq_flags);
 	return 0;
 }
 EXPORT_SYMBOL(msm_gpiomux_put);
 
-static int __init gpiomux_init(void)
+int msm_gpiomux_init(size_t ngpio)
 {
-	unsigned n;
+	if (!ngpio)
+		return -EINVAL;
 
-	for (n = 0; n < GPIOMUX_NGPIOS; ++n) {
-		msm_gpiomux_configs[n].ref = 0;
-		if (!(msm_gpiomux_configs[n].suspended & GPIOMUX_VALID))
-			continue;
-		__msm_gpiomux_write(n, msm_gpiomux_configs[n].suspended);
+	if (msm_gpiomux_recs)
+		return -EPERM;
+
+	msm_gpiomux_recs = kzalloc(sizeof(struct msm_gpiomux_rec) * ngpio,
+				   GFP_KERNEL);
+	if (!msm_gpiomux_recs)
+		return -ENOMEM;
+
+	/* There is no need to zero this memory, as clients will be blindly
+	 * installing settings on top of it.
+	 */
+	msm_gpiomux_sets = kmalloc(sizeof(struct gpiomux_setting) * ngpio *
+		GPIOMUX_NSETTINGS, GFP_KERNEL);
+	if (!msm_gpiomux_sets) {
+		kfree(msm_gpiomux_recs);
+		msm_gpiomux_recs = NULL;
+		return -ENOMEM;
 	}
+
+	msm_gpiomux_ngpio = ngpio;
+
 	return 0;
 }
-postcore_initcall(gpiomux_init);
+EXPORT_SYMBOL(msm_gpiomux_init);
+
+void msm_gpiomux_install(struct msm_gpiomux_config *configs, unsigned nconfigs)
+{
+	unsigned c, s;
+	int rc;
+
+	for (c = 0; c < nconfigs; ++c) {
+		for (s = 0; s < GPIOMUX_NSETTINGS; ++s) {
+			rc = msm_gpiomux_write(configs[c].gpio, s,
+				&configs[c].settings[s], NULL);
+			if (rc)
+				pr_err("%s: write failure: %d\n", __func__, rc);
+		}
+	}
+}
+EXPORT_SYMBOL(msm_gpiomux_install);
diff --git a/arch/arm/mach-msm/gpiomux.h b/arch/arm/mach-msm/gpiomux.h
index b178d9c..227e210 100644
--- a/arch/arm/mach-msm/gpiomux.h
+++ b/arch/arm/mach-msm/gpiomux.h
@@ -20,56 +20,112 @@
 #include <linux/bitops.h>
 #include <linux/errno.h>
 
-#if defined(CONFIG_MSM_V2_TLMM)
-#include "gpiomux-v2.h"
-#else
-#include "gpiomux-v1.h"
-#endif
+enum msm_gpiomux_setting {
+	GPIOMUX_ACTIVE = 0,
+	GPIOMUX_SUSPENDED,
+	GPIOMUX_NSETTINGS
+};
+
+enum gpiomux_drv {
+	GPIOMUX_DRV_2MA = 0,
+	GPIOMUX_DRV_4MA,
+	GPIOMUX_DRV_6MA,
+	GPIOMUX_DRV_8MA,
+	GPIOMUX_DRV_10MA,
+	GPIOMUX_DRV_12MA,
+	GPIOMUX_DRV_14MA,
+	GPIOMUX_DRV_16MA,
+};
+
+enum gpiomux_func {
+	GPIOMUX_FUNC_GPIO = 0,
+	GPIOMUX_FUNC_1,
+	GPIOMUX_FUNC_2,
+	GPIOMUX_FUNC_3,
+	GPIOMUX_FUNC_4,
+	GPIOMUX_FUNC_5,
+	GPIOMUX_FUNC_6,
+	GPIOMUX_FUNC_7,
+	GPIOMUX_FUNC_8,
+	GPIOMUX_FUNC_9,
+	GPIOMUX_FUNC_A,
+	GPIOMUX_FUNC_B,
+	GPIOMUX_FUNC_C,
+	GPIOMUX_FUNC_D,
+	GPIOMUX_FUNC_E,
+	GPIOMUX_FUNC_F,
+};
+
+enum gpiomux_pull {
+	GPIOMUX_PULL_NONE = 0,
+	GPIOMUX_PULL_DOWN,
+	GPIOMUX_PULL_KEEPER,
+	GPIOMUX_PULL_UP,
+};
+
+/* Direction settings are only meaningful when GPIOMUX_FUNC_GPIO is selected.
+ * This element is ignored for all other FUNC selections, as the output-
+ * enable pin is not under software control in those cases.  See the SWI
+ * for your target for more details.
+ */
+enum gpiomux_dir {
+	GPIOMUX_IN = 0,
+	GPIOMUX_OUT_HIGH,
+	GPIOMUX_OUT_LOW,
+};
+
+struct gpiomux_setting {
+	enum gpiomux_func func;
+	enum gpiomux_drv  drv;
+	enum gpiomux_pull pull;
+	enum gpiomux_dir  dir;
+};
 
 /**
  * struct msm_gpiomux_config: gpiomux settings for one gpio line.
  *
- * A complete gpiomux config is the bitwise-or of a drive-strength,
- * function, and pull.  For functions other than GPIO, the OE
- * is hard-wired according to the function.  For GPIO mode,
- * OE is controlled by gpiolib.
- *
- * Available settings differ by target; see the gpiomux header
- * specific to your target arch for available configurations.
+ * A complete gpiomux config is the combination of a drive-strength,
+ * function, pull, and (sometimes) direction.  For functions other than GPIO,
+ * the input/output setting is hard-wired according to the function.
  *
- * @active: The configuration to be installed when the line is
- * active, or its reference count is > 0.
- * @suspended: The configuration to be installed when the line
- * is suspended, or its reference count is 0.
- * @ref: The reference count of the line.  For internal use of
- * the gpiomux framework only.
+ * @gpio: The index number of the gpio being described.
+ * @settings: The settings to be installed, specifically:
+ *           GPIOMUX_ACTIVE: The setting to be installed when the
+ *           line is active, or its reference count is > 0.
+ *           GPIOMUX_SUSPENDED: The setting to be installed when
+ *           the line is suspended, or its reference count is 0.
  */
 struct msm_gpiomux_config {
-	gpiomux_config_t active;
-	gpiomux_config_t suspended;
-	unsigned         ref;
+	unsigned gpio;
+	struct gpiomux_setting settings[GPIOMUX_NSETTINGS];
 };
 
 /**
- * @GPIOMUX_VALID:	If set, the config field contains 'good data'.
- *                      The absence of this bit will prevent the gpiomux
- *			system from applying the configuration under all
- *			circumstances.
+ * struct msm_gpiomux_configs: a collection of gpiomux configs.
+ *
+ * It is so common to manage blocks of gpiomux configs that the data structure
+ * for doing so has been standardized here as a convenience.
+ *
+ * @cfg:  A pointer to the first config in an array of configs.
+ * @ncfg: The number of configs in the array.
  */
-enum {
-	GPIOMUX_VALID	 = BIT(sizeof(gpiomux_config_t) * BITS_PER_BYTE - 1),
-	GPIOMUX_CTL_MASK = GPIOMUX_VALID,
+struct msm_gpiomux_configs {
+	struct msm_gpiomux_config *cfg;
+	size_t                     ncfg;
 };
 
 #ifdef CONFIG_MSM_GPIOMUX
 
-/* Each architecture must provide its own instance of this table.
- * To avoid having gpiomux manage any given gpio, one or both of
- * the entries can avoid setting GPIOMUX_VALID - the absence
- * of that flag will prevent the configuration from being applied
- * during state transitions.
+/* Before using gpiomux, initialize the subsystem by telling it how many
+ * gpios are going to be managed.  Calling any other gpiomux functions before
+ * msm_gpiomux_init is unsupported.
+ */
+int msm_gpiomux_init(size_t ngpio);
+
+/* Install a block of gpiomux configurations in gpiomux.  This is functionally
+ * identical to calling msm_gpiomux_write many times.
  */
-extern struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS];
+void msm_gpiomux_install(struct msm_gpiomux_config *configs, unsigned nconfigs);
 
 /* Increment a gpio's reference count, possibly activating the line. */
 int __must_check msm_gpiomux_get(unsigned gpio);
@@ -77,12 +133,16 @@ int __must_check msm_gpiomux_get(unsigned gpio);
 /* Decrement a gpio's reference count, possibly suspending the line. */
 int msm_gpiomux_put(unsigned gpio);
 
-/* Install a new configuration to the gpio line.  To avoid overwriting
- * a configuration, leave the VALID bit out.
+/* Install a new setting in a gpio.  To erase a slot, use NULL.
+ * The old setting that was overwritten can be passed back to the caller
+ * old_setting can be NULL if the caller is not interested in the previous
+ * setting
+ * If a previous setting was not available to return (NULL configuration)
+ * - the function returns 1
+ * else function returns 0
  */
-int msm_gpiomux_write(unsigned gpio,
-		      gpiomux_config_t active,
-		      gpiomux_config_t suspended);
+int msm_gpiomux_write(unsigned gpio, enum msm_gpiomux_setting which,
+	struct gpiomux_setting *setting, struct gpiomux_setting *old_setting);
 
 /* Architecture-internal function for use by the framework only.
  * This function can assume the following:
@@ -92,8 +152,16 @@ int msm_gpiomux_write(unsigned gpio,
  * This function is not for public consumption.  External users
  * should use msm_gpiomux_write.
  */
-void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val);
+void __msm_gpiomux_write(unsigned gpio, struct gpiomux_setting val);
 #else
+static inline int msm_gpiomux_init(size_t ngpio)
+{
+	return -ENOSYS;
+}
+
+static inline void
+msm_gpiomux_install(struct msm_gpiomux_config *configs, unsigned nconfigs) {}
+
 static inline int __must_check msm_gpiomux_get(unsigned gpio)
 {
 	return -ENOSYS;
@@ -105,8 +173,8 @@ static inline int msm_gpiomux_put(unsigned gpio)
 }
 
 static inline int msm_gpiomux_write(unsigned gpio,
-				    gpiomux_config_t active,
-				    gpiomux_config_t suspended)
+	enum msm_gpiomux_setting which, struct gpiomux_setting *setting,
+	struct gpiomux_setting *old_setting);
 {
 	return -ENOSYS;
 }
-- 
1.7.0.4

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
