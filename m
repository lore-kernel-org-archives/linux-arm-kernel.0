From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 May 2010 10:34:54 +0100
Subject: [PATCH 3/4] ARM: SAMSUNG: Add support for interrupt wakeup-sources
In-Reply-To: <1274348095-9390-1-git-send-email-ben-linux@fluff.org>
References: <1274348095-9390-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274348095-9390-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for wakeup-mask style interrupts that share a
single mask register for various different interrupts. This
registers a set of interrupt->bit mappings and the register
they belong to.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/Kconfig                    |    8 ++++
 arch/arm/plat-samsung/Makefile                   |    2 +
 arch/arm/plat-samsung/include/plat/wakeup-mask.h |   44 ++++++++++++++++++++
 arch/arm/plat-samsung/wakeup-mask.c              |   47 ++++++++++++++++++++++
 4 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/wakeup-mask.h
 create mode 100644 arch/arm/plat-samsung/wakeup-mask.c

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 229919e..75f1142 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -269,4 +269,12 @@ config SAMSUNG_PM_CHECK_CHUNKSIZE
 
 	  See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
 
+config SAMSUNG_WAKEMASK
+	bool "Support for wakeup mask to irq mapping"
+	depends on PM
+	help
+	  Compile support for wakeup-mask controls found on the S3C6400
+	  and above. This code allows a set of interrupt to wakeup-mask
+	  mappings. See <plat/wakeup-mask.h>
+
 endif
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4828849..fbd5d1c 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -58,6 +58,8 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
+obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
+
 # PWM support
 
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
diff --git a/arch/arm/plat-samsung/include/plat/wakeup-mask.h b/arch/arm/plat-samsung/include/plat/wakeup-mask.h
new file mode 100644
index 0000000..43e4acd
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/wakeup-mask.h
@@ -0,0 +1,44 @@
+/* arch/arm/plat-samsung/include/plat/wakeup-mask.h
+ *
+ * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * Support for wakeup mask interrupts on newer SoCs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#ifndef __PLAT_WAKEUP_MASK_H
+#define __PLAT_WAKEUP_MASK_H __file__
+
+/* if no irq yet defined, but still want to mask */
+#define NO_WAKEUP_IRQ (0x90000000)
+
+/**
+ * struct samsung_wakeup_mask - wakeup mask information
+ * @irq: The interrupt associated with this wakeup.
+ * @bit: The bit, as a (1 << bitno) controlling this source.
+ */ 
+struct samsung_wakeup_mask {
+	unsigned int	irq;
+	u32		bit;
+};
+
+/**
+ * samsung_sync_wakemask - sync wakeup mask information for pm
+ * @reg: The register that is used.
+ * @masks: The list of masks to use.
+ * @nr_masks: The number of entries pointed to buy @masks.
+ *
+ * Synchronise the wakeup mask information at suspend time from the list
+ * of interrupts and control bits in @masks. We do this at suspend time
+ * as overriding the relevant irq chips is harder and the register is only
+ * required to be correct before we enter sleep.
+ */
+extern void samsung_sync_wakemask(void __iomem *reg,
+				  struct samsung_wakeup_mask *masks,
+				  int nr_masks);
+
+#endif /* __PLAT_WAKEUP_MASK_H */
diff --git a/arch/arm/plat-samsung/wakeup-mask.c b/arch/arm/plat-samsung/wakeup-mask.c
new file mode 100644
index 0000000..2e09b6a
--- /dev/null
+++ b/arch/arm/plat-samsung/wakeup-mask.c
@@ -0,0 +1,47 @@
+/* arch/arm/plat-samsung/wakeup-mask.c
+ *
+ * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * Support for wakeup mask interrupts on newer SoCs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/sysdev.h>
+#include <linux/types.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <plat/wakeup-mask.h>
+#include <plat/pm.h>
+
+void samsung_sync_wakemask(void __iomem *reg,
+			   struct samsung_wakeup_mask *mask, int nr_mask)
+{
+	struct irq_desc *desc;
+	u32 val;
+
+	val = __raw_readl(reg);
+
+	for (; nr_mask > 0; nr_mask--, mask++) {
+		if (mask->irq == NO_WAKEUP_IRQ) {
+			val |= mask->bit;
+			continue;
+		}
+
+		desc = irq_to_desc(mask->irq);
+
+		/* bit of a liberty to read this directly from irq_desc. */
+		if (desc->wake_depth > 0)
+			val &= ~mask->bit;
+		else
+			val |= mask->bit;
+	}
+
+	printk(KERN_INFO "wakemask %08x => %08x\n", __raw_readl(reg), val);
+	__raw_writel(val, reg);
+}
-- 
1.6.3.3
