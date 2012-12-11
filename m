From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 11 Dec 2012 12:07:30 +0900
Subject: [PATCH 2/6] ARM: mach-shmobile: sh73a0: Allow initialisation of GIC
 by DT
In-Reply-To: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
References: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1355195254-4563-3-git-send-email-horms+renesas@verge.net.au>
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

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v3
* No change

v2
* No change
---
 arch/arm/boot/dts/sh73a0.dtsi                |    9 +++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c         |   14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 6b374ff..77c8e43 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -29,4 +29,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	gic: interrupt-controller at f0001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0xf0001000 0x1000>,
+		      <0xf0000100 0x100>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index d47e215..b50447e 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -49,6 +49,7 @@ extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
 
 extern void sh73a0_init_irq(void);
+extern void sh73a0_init_irq_dt(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_add_early_devices(void);
 extern void sh73a0_add_standard_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index f0c5e51..e492350 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
 #include <mach/intc.h>
@@ -464,3 +465,16 @@ void __init sh73a0_init_irq(void)
 	sh73a0_pint1_cascade.handler = sh73a0_pint1_demux;
 	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
 }
+
+#ifdef CONFIG_OF
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ },
+};
+
+void __init sh73a0_init_irq_dt(void)
+{
+	of_irq_init(irq_of_match);
+	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
+}
+#endif
-- 
1.7.10.4
