From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Apr 2011 20:39:00 +0200
Subject: [PATCH 2/2] at91: add generic allocator support for sram
In-Reply-To: <20110415183152.GA10539@game.jcrosoft.org>
References: <20110415183152.GA10539@game.jcrosoft.org>
Message-ID: <1302892740-2010-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/Kconfig                       |    1 +
 arch/arm/mach-at91/Makefile            |    2 +-
 arch/arm/mach-at91/at91cap9.c          |    8 ++++++
 arch/arm/mach-at91/at91rm9200.c        |    8 ++++++
 arch/arm/mach-at91/at91sam9260.c       |   12 ++++++++
 arch/arm/mach-at91/at91sam9261.c       |   11 ++++++++
 arch/arm/mach-at91/at91sam9263.c       |    9 ++++++
 arch/arm/mach-at91/at91sam9g45.c       |    8 ++++++
 arch/arm/mach-at91/generic.h           |    4 +++
 arch/arm/mach-at91/include/mach/sram.h |   39 ++++++++++++++++++++++++++++
 arch/arm/mach-at91/sram.c              |   44 ++++++++++++++++++++++++++++++++
 11 files changed, 145 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/sram.h
 create mode 100644 arch/arm/mach-at91/sram.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fdc9d4d..2bc50b6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -288,6 +288,7 @@ config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select GENERIC_ALLOCATOR
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index a83835e..0f876b4 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= irq.o gpio.o
+obj-y		:= irq.o gpio.o sram.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 7337617..55da140 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -381,3 +381,11 @@ void __init at91cap9_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+static int sram_init(void)
+{
+	at91_sram_init(&at91cap9_io_desc[1]);
+
+	return 0;
+}
+core_initcall(sram_init);
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 2e9ecad..72184a1 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -345,3 +345,11 @@ void __init at91rm9200_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+static int sram_init(void)
+{
+	at91_sram_init(&at91rm9200_io_desc[2]);
+
+	return 0;
+}
+core_initcall(sram_init);
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 32524ef..8e4db5d 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -380,3 +380,15 @@ void __init at91sam9260_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+static int sram_init(void)
+{
+	if (cpu_is_at91sam9g20()) {
+		at91_sram_init(&at91sam9g20_sram_desc[0]);
+	} else {
+		at91_sram_init(&at91sam9260_sram_desc[0]);
+	}
+
+	return 0;
+}
+core_initcall(sram_init);
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index fcad886..77ab068 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -346,3 +346,14 @@ void __init at91sam9261_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+static int sram_init(void)
+{
+	if (cpu_is_at91sam9g10())
+		at91_sram_init(&at91sam9g10_sram_desc[0]);
+	else
+		at91_sram_init(&at91sam9261_sram_desc[0]);
+
+	return 0;
+}
+core_initcall(sram_init);
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 249f900..b7c4215 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -351,3 +351,12 @@ void __init at91sam9263_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+static int sram_init(void)
+{
+	at91_sram_init(&at91sam9263_io_desc[1]);
+	at91_sram_init(&at91sam9263_io_desc[2]);
+
+	return 0;
+}
+core_initcall(sram_init);
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index c67b47f..b20afdb 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -378,3 +378,11 @@ void __init at91sam9g45_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	/* Enable GPIO interrupts */
 	at91_gpio_irq_setup();
 }
+
+static int sram_init(void)
+{
+	at91_sram_init(&at91sam9g45_io_desc[1]);
+
+	return 0;
+}
+core_initcall(sram_init);
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c66deb..4100a26 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -63,3 +63,7 @@ extern void __init at91_gpio_irq_setup(void);
 
 extern void (*at91_arch_reset)(void);
 extern int at91_extern_irq;
+
+/* SRAM */
+struct map_desc;
+extern int __init at91_sram_init(struct map_desc *io_desc);
diff --git a/arch/arm/mach-at91/include/mach/sram.h b/arch/arm/mach-at91/include/mach/sram.h
new file mode 100644
index 0000000..99dac2b
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/sram.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __MACH_SRAM_H__
+#define __MACH_SRAM_H__
+
+#include <linux/genalloc.h>
+
+extern struct gen_pool *sram_pool;
+
+static inline unsigned long sram_virt_to_phys(void* addr)
+{
+	if (!sram_pool)
+		return ~0UL;
+
+	return gen_pool_virt_to_phys(sram_pool, (unsigned long)addr);
+}
+
+static inline void* sram_alloc(size_t len)
+{
+	if (!sram_pool)
+		return NULL;
+
+	return (void*)gen_pool_alloc(sram_pool, len);
+}
+
+static inline void sram_free(void* addr, size_t len)
+{
+	if (!sram_pool)
+		return;
+
+	return gen_pool_free(sram_pool, (unsigned long)addr, len);
+}
+
+#endif /* __MACH_SRAM_H__ */
diff --git a/arch/arm/mach-at91/sram.c b/arch/arm/mach-at91/sram.c
new file mode 100644
index 0000000..11e9768
--- /dev/null
+++ b/arch/arm/mach-at91/sram.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+
+#include <asm/mach/map.h>
+#include <mach/sram.h>
+
+struct gen_pool *sram_pool;
+
+extern int __init at91_sram_init(struct map_desc *io_desc)
+{
+	int ret = -ENOMEM;
+
+	if (!io_desc) {
+		ret = -EIO;
+		goto fail;
+	}
+
+	if (!sram_pool) {
+		sram_pool = gen_pool_create(2, -1);
+		if (!sram_pool)
+			goto fail;
+	}
+
+	if (gen_pool_add_virt(sram_pool, io_desc->virtual,
+			      __pfn_to_phys(io_desc->pfn), io_desc->length, -1))
+		goto fail;
+	pr_info("AT91: create SRAM pool of 0x%x at 0x%lx (mapped at 0x%lx)\n",
+		io_desc->length,
+		gen_pool_virt_to_phys(sram_pool, io_desc->virtual),
+		io_desc->virtual);
+
+	return 0;
+
+fail:
+	pr_err("Failed to create SRAM pool\n");
+	return ret;
+}
-- 
1.7.4.1
