From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Tue, 5 Aug 2014 22:58:09 +0800
Subject: [PATCH 2/3] arm: mediatek: Add support for GIC interrupt polarity
 extension.
In-Reply-To: <1407250690-2858-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1407250690-2858-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1407250690-2858-3-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Mediatek SoCs have an interrupt polarity extension which allows
to swap the polarity for given interrupts.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/mt6589.dtsi     |  7 ++++-
 arch/arm/mach-mediatek/Makefile   |  2 +-
 arch/arm/mach-mediatek/common.h   | 19 ++++++++++++
 arch/arm/mach-mediatek/intpol.c   | 61 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c | 10 +++++++
 5 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mediatek/common.h
 create mode 100644 arch/arm/mach-mediatek/intpol.c

diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index d0297a0..18df47f 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -76,11 +76,16 @@
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt6577-timer";
 			reg = <0x10008000 0x80>;
-			interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&system_clk>, <&rtc_clk>;
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		intpol: intpol at 10200100 {
+			compatible = "mediatek,mt6577-intpol";
+			reg = <0x10200100 0x1c>;
+		};
+
 		gic: interrupt-controller at 10212000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 43e619f..82c39d8 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_ARCH_MEDIATEK) += mediatek.o
+obj-$(CONFIG_ARCH_MEDIATEK) += mediatek.o intpol.o
diff --git a/arch/arm/mach-mediatek/common.h b/arch/arm/mach-mediatek/common.h
new file mode 100644
index 0000000..8f2bbeb
--- /dev/null
+++ b/arch/arm/mach-mediatek/common.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2014 Mediatek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __MEDIATEK_COMMON_H__
+#define __MEDIATEK_COMMON_H__
+
+extern char init_intpol(void);
+
+#endif /* __MEDIATEK_COMMON_H__ */
diff --git a/arch/arm/mach-mediatek/intpol.c b/arch/arm/mach-mediatek/intpol.c
new file mode 100644
index 0000000..65ccc7c
--- /dev/null
+++ b/arch/arm/mach-mediatek/intpol.c
@@ -0,0 +1,61 @@
+/*
+ * This file contains common code that is intended to be used across
+ * boards so that it's not replicated.
+ *
+ * Copyright (C) 2014 Mediatek Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/arm-gic.h>
+
+#define GIC_HW_IRQ_BASE  32
+#define INT_POL_INDEX(a)   ((a) - GIC_HW_IRQ_BASE)
+
+static void __iomem *int_pol_base;
+
+static int mtk_int_pol_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int irq = d->hwirq;
+	u32 offset, reg_index, value;
+
+	offset = INT_POL_INDEX(irq) & 0x1F;
+	reg_index = INT_POL_INDEX(irq) >> 5;
+
+	/* This arch extension was called with irq_controller_lock held,
+	   so the read-modify-write will be atomic */
+	value = readl(int_pol_base + reg_index * 4);
+	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING)
+		value |= (1 << offset);
+	else
+		value &= ~(1 << offset);
+	writel(value, int_pol_base + reg_index * 4);
+
+	return 0;
+}
+
+void init_intpol(void)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "mediatek,mt6577-intpol");
+	if (!node)
+		return;
+
+	int_pol_base = of_io_request_and_map(node, 0, "intpol");
+	if (IS_ERR(int_pol_base)) {
+		pr_warn("Can't get resource\n");
+		return;
+	}
+
+	gic_arch_extn.irq_set_type = mtk_int_pol_set_type;
+}
diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index 48051a2..aa10c70 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -16,6 +16,15 @@
  */
 #include <linux/init.h>
 #include <asm/mach/arch.h>
+#include <linux/irqchip.h>
+
+#include "common.h"
+
+static void __init mediatek_init_irq(void)
+{
+	init_intpol();
+	irqchip_init();
+}
 
 static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt6589",
@@ -26,4 +35,5 @@ static const char * const mediatek_board_dt_compat[] = {
 
 DT_MACHINE_START(MEDIATEK_DT, "Mediatek Cortex-A7 (Device Tree)")
 	.dt_compat	= mediatek_board_dt_compat,
+	.init_irq       = mediatek_init_irq,
 MACHINE_END
-- 
1.8.1.1.dirty
