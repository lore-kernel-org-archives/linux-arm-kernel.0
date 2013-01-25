From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:13:30 +0900
Subject: [PATCH 12/15] ARM: mach-shmobile: sh73a0: Allow initialisation of GIC
 by DT
In-Reply-To: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080013-29189-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the GIC interrupt controller of the sh73a0 SoC to be
initialised using a flattened device tree blob.

It does not allow the INTC interrupt controller which is also present on
the sh73a0 SoC to be enabled via device tree.  Nor does it handle sharing
of interrupts between the GIC and INTC interrupt controllers.

This limits the usefulness of this code to applications which only wish to
access devices which use interrupts that can be handled by the GIC
interrupt controller. Other applications should, for now, continue using
non-device tree initialisation of the sh72a0 interrupt controllers.

Includes update to use irqchip_init() by Thierry Reding

Cc: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi                |   33 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c         |    9 +++++++
 3 files changed, 43 insertions(+)
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
new file mode 100644
index 0000000..7dae1f4
--- /dev/null
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Device Tree Source for the SH73A0 SoC
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,sh73a0";
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+	gic: interrupt-controller at f0001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0xf0001000 0x1000>,
+		      <0xf0000100 0x100>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 4b1af93..e2ba16b 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -34,6 +34,7 @@ extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
 
 extern void sh73a0_init_irq(void);
+extern void sh73a0_init_irq_dt(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
 extern void sh73a0_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 45973b5..91faba6 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
+#include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 #include <mach/intc.h>
 #include <mach/irqs.h>
@@ -459,3 +460,11 @@ void __init sh73a0_init_irq(void)
 	sh73a0_pint1_cascade.handler = sh73a0_pint1_demux;
 	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
 }
+
+#ifdef CONFIG_OF
+void __init sh73a0_init_irq_dt(void)
+{
+	irqchip_init();
+	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
+}
+#endif
-- 
1.7.10.4
