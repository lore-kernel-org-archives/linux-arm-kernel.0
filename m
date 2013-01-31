From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 10:50:49 +0900
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: Allow initialisation of GIC
 by DT
In-Reply-To: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359597051-32700-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the GIC interrupt controller of the  r8a7779 SoC to be
initialised using a flattened device tree blob.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi               |   40 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-r8a7779.c        |   27 +++++++++++++----
 3 files changed, 62 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7779.dtsi

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
new file mode 100644
index 0000000..eadc12e
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -0,0 +1,40 @@
+/*
+ * Device Tree Source for Renesas r8a7740
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Simon Horman
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,r8a7779";
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu at 2 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu at 3 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+        gic: interrupt-controller at f0001000 {
+                compatible = "arm,cortex-a9-gic";
+                #interrupt-cells = <3>;
+                #address-cells = <1>;
+                interrupt-controller;
+                reg = <0xf0001000 0x1000>,
+                      <0xf0000100 0x100>;
+        };
+};
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 16dab18..8ef7ebb 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -63,6 +63,7 @@ extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 
 extern void r8a7779_init_irq(void);
+extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
index 8807c27..f9cc4bc 100644
--- a/arch/arm/mach-shmobile/intc-r8a7779.c
+++ b/arch/arm/mach-shmobile/intc-r8a7779.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
+#include <linux/irqchip.h>
 #include <mach/intc.h>
 #include <mach/r8a7779.h>
 #include <asm/mach-types.h>
@@ -43,13 +44,8 @@ static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
 	return 0; /* always allow wakeup */
 }
 
-void __init r8a7779_init_irq(void)
+static void __init r8a7779_init_irq_common(void)
 {
-	void __iomem *gic_dist_base = IOMEM(0xf0001000);
-	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
-
-	/* use GIC to handle interrupts */
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
 
 	/* route all interrupts to ARM */
@@ -63,3 +59,22 @@ void __init r8a7779_init_irq(void)
 	__raw_writel(0xbffffffc, INT2SMSKCR3);
 	__raw_writel(0x003fee3f, INT2SMSKCR4);
 }
+
+void __init r8a7779_init_irq(void)
+{
+	void __iomem *gic_dist_base = IOMEM(0xf0001000);
+	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
+
+	/* use GIC to handle interrupts */
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+
+	r8a7779_init_irq_common();
+}
+
+#ifdef CONFIG_OF
+void __init r8a7779_init_irq_dt(void)
+{
+	irqchip_init();
+	r8a7779_init_irq_common();
+}
+#endif
-- 
1.7.10.4
