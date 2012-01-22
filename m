From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:34 +0100
Subject: [RFC PATCH 08/11] Cortex-M3: Add NVIC support
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch implements the NVIC (interrupt controller) support for
Cortex-M3.

[ukleinek: use a raw spinlock]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Actually it should be able to share much code with/use
arch/arm/common/gic.c, but I didn't manage to get it up.

My problem is that I need hardware irq 13 but in gic.c hw_irq is set to
at least 16. I guess I didn't understood something correctly and would
be glad to get a tip who to fix that.
---
 arch/arm/common/Kconfig              |    3 +
 arch/arm/common/Makefile             |    1 +
 arch/arm/common/nvic.c               |   98 ++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hardware/nvic.h |   34 ++++++++++++
 4 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/common/nvic.c
 create mode 100644 arch/arm/include/asm/hardware/nvic.h

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 81a933e..74adbe7 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -21,6 +21,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
+config ARM_NVIC
+	bool
+
 config ICST
 	bool
 
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 6ea9b6f..102f5a2 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_ARM_GIC)		+= gic.o
 obj-$(CONFIG_ARM_VIC)		+= vic.o
+obj-$(CONFIG_ARM_NVIC)		+= nvic.o
 obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_PL330)		+= pl330.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
diff --git a/arch/arm/common/nvic.c b/arch/arm/common/nvic.c
new file mode 100644
index 0000000..a0d76f4
--- /dev/null
+++ b/arch/arm/common/nvic.c
@@ -0,0 +1,98 @@
+/*
+ *  linux/arch/arm/common/nvic.c
+ *
+ *  Copyright (C) 2008 ARM Limited, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Support for the Nested Vectored Interrupt Controller found on the
+ * ARMv7-M CPUs (Cortex-M3)
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/mach/irq.h>
+#include <asm/hardware/nvic.h>
+
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
+/*
+ * Routines to acknowledge, disable and enable interrupts
+ *
+ * Linux assumes that when we're done with an interrupt we need to
+ * unmask it, in the same way we need to unmask an interrupt when
+ * we first enable it.
+ *
+ * The NVIC has a separate notion of "end of interrupt" to re-enable
+ * an interrupt after handling, in order to support hardware
+ * prioritisation.
+ *
+ * We can make the NVIC behave in the way that Linux expects by making
+ * our "acknowledge" routine disable the interrupt, then mark it as
+ * complete.
+ */
+static void nvic_ack_irq(struct irq_data *d)
+{
+	u32 mask = 1 << (d->irq % 32);
+
+	raw_spin_lock(&irq_controller_lock);
+	writel(mask, NVIC_CLEAR_ENABLE + d->irq / 32 * 4);
+	raw_spin_unlock(&irq_controller_lock);
+}
+
+static void nvic_mask_irq(struct irq_data *d)
+{
+	u32 mask = 1 << (d->irq % 32);
+
+	raw_spin_lock(&irq_controller_lock);
+	writel(mask, NVIC_CLEAR_ENABLE + d->irq / 32 * 4);
+	raw_spin_unlock(&irq_controller_lock);
+}
+
+static void nvic_unmask_irq(struct irq_data *d)
+{
+	u32 mask = 1 << (d->irq % 32);
+
+	raw_spin_lock(&irq_controller_lock);
+	writel(mask, NVIC_SET_ENABLE + d->irq / 32 * 4);
+	raw_spin_unlock(&irq_controller_lock);
+}
+
+static struct irq_chip nvic_chip = {
+	.name = "NVIC",
+	.irq_ack = nvic_ack_irq,
+	.irq_mask = nvic_mask_irq,
+	.irq_unmask = nvic_unmask_irq,
+};
+
+void __init nvic_init(void)
+{
+	unsigned int max_irq, i;
+
+	max_irq = ((readl(NVIC_INTR_CTRL) & 0x1f) + 1) * 32;
+
+	/*
+	 * Disable all interrupts
+	 */
+	for (i = 0; i < max_irq / 32; i++)
+		writel(~0, NVIC_CLEAR_ENABLE + i * 4);
+
+	/*
+	 * Set priority on all interrupts.
+	 */
+	for (i = 0; i < max_irq; i += 4)
+		writel(0, NVIC_PRIORITY + i);
+
+	/*
+	 * Setup the Linux IRQ subsystem.
+	 */
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_set_chip_and_handler(i, &nvic_chip, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+	}
+}
diff --git a/arch/arm/include/asm/hardware/nvic.h b/arch/arm/include/asm/hardware/nvic.h
new file mode 100644
index 0000000..b7f8026
--- /dev/null
+++ b/arch/arm/include/asm/hardware/nvic.h
@@ -0,0 +1,34 @@
+/*
+ *  linux/include/asm-arm/hardware/nvic.h
+ *
+ *  Copyright (C) 2008 ARM Limited, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM_HARDWARE_NVIC_H
+#define __ASM_ARM_HARDWARE_NVIC_H
+
+#include <linux/compiler.h>
+
+#define V7M_SCS				0xe000e000
+#define NVIC_INTR_CTRL			(V7M_SCS + 0x004)
+#define NVIC_SYSTICK_CTRL		(V7M_SCS + 0x010)
+#define NVIC_SYSTICK_RELOAD		(V7M_SCS + 0x014)
+#define NVIC_SYSTICK_CURRENT		(V7M_SCS + 0x018)
+#define NVIC_SYSTICK_CALIBRATION	(V7M_SCS + 0x01c)
+#define NVIC_SET_ENABLE			(V7M_SCS + 0x100)
+#define NVIC_CLEAR_ENABLE		(V7M_SCS + 0x180)
+#define NVIC_SET_PENDING		(V7M_SCS + 0x200)
+#define NVIC_CLEAR_PENDING		(V7M_SCS + 0x280)
+#define NVIC_ACTIVE_BIT			(V7M_SCS + 0x300)
+#define NVIC_PRIORITY			(V7M_SCS + 0x400)
+#define NVIC_INTR_CTRL_STATE		(V7M_SCS + 0xd04)
+#define NVIC_SOFTWARE_INTR		(V7M_SCS + 0xf00)
+
+#ifndef __ASSEMBLY__
+void nvic_init(void);
+#endif
+
+#endif
-- 
1.7.8.3
