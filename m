From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:32 +0000
Subject: [PATCH v2 02/15] ARM: smp_twd: add device tree support
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings to support DT discovery of the ARM Timer Watchdog
(aka TWD). Only the timer side is converted by this patch.

Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/twd.txt |   29 +++++++++++
 arch/arm/include/asm/smp_twd.h                |    7 +++
 arch/arm/kernel/smp_twd.c                     |   67 +++++++++++++++++++-----
 3 files changed, 89 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/twd.txt

diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/arm/twd.txt
new file mode 100644
index 0000000..a9d5587
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/twd.txt
@@ -0,0 +1,29 @@
+* ARM Timer Watchdog
+
+ARM 11MP, Cortex-A5 and Cortex-A9 are often associated with a per-core
+Timer-Watchdog (aka TWD), which provides both a per-cpu local timer
+and watchdog.
+
+The TWD is usually attached to a GIC to deliver its two per-processor
+interrupts.
+
+Main node required properties:
+
+- compatible : Should be one of:
+	"arm,cortex-a9-twd"
+	"arm,cortex-a5-twd"
+	"arm,arm11mp-twd"
+	"arm,smp-twd"
+
+- interrupts : Two interrupts to each core, the first one for the
+  timer, the second one for the watchdog.
+
+- reg : Specify the base address and the size of the TWD.
+
+Example:
+
+	twd at 2c000600 {
+		compatible = "arm,arm11mp-twd", "arm,smp-twd";
+		reg = <0x2c000600 0x100>;
+		interrupts = <1 13 0xf01 1 14 0xf01>;
+	};
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 934f1bc..09c3b71 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -20,6 +20,7 @@
 
 struct clock_event_device;
 struct resource;
+struct of_device_id;
 
 extern void __iomem *twd_base;
 
@@ -27,11 +28,17 @@ void twd_timer_setup(struct clock_event_device *);
 void twd_timer_stop(struct clock_event_device *);
 #ifdef CONFIG_HAVE_ARM_TWD
 int twd_timer_register(struct resource *res, int res_nr);
+int twd_timer_of_init(const struct of_device_id *twd_of_match);
 #else
 static inline int twd_timer_register(struct resource *res, int res_nr)
 {
 	return 0;
 }
+
+static inline int twd_timer_of_init(const struct of_device_id *twd_of_match)
+{
+	return 0;
+}
 #endif
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index dedbdb4..98a6a59 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -18,6 +18,8 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
@@ -232,13 +234,40 @@ static struct notifier_block __cpuinitdata twd_cpu_nb = {
 	.notifier_call = twd_cpu_notify,
 };
 
-int __init twd_timer_register(struct resource *res, int res_nr)
+static int __init twd_timer_common_init(void)
 {
 	struct clock_event_device *clk;
+	int err;
 
-	if (!is_smp())
-		return -ENODEV;
+	if (!is_smp()) {
+		err = -ENODEV;
+		goto out_free;
+	}
+
+	twd_clock_event	= alloc_percpu(struct clock_event_device);
+	if (!twd_clock_event) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	/* Immediately configure the timer on the boot CPU */
+	clk = per_cpu_ptr(twd_clock_event, smp_processor_id());
+	twd_setup(clk);
+
+	register_cpu_notifier(&twd_cpu_nb);
+
+	return 0;
 
+out_free:
+	iounmap(twd_base);
+	twd_base = NULL;
+	free_percpu(twd_clock_event);
+
+	return err;
+}
+
+int __init twd_timer_register(struct resource *res, int res_nr)
+{
 	if (res_nr != 2 || res[1].start < 0)
 		return -EINVAL;
 
@@ -247,20 +276,30 @@ int __init twd_timer_register(struct resource *res, int res_nr)
 
 	twd_ppi		= res[1].start;
 	twd_base	= ioremap(res[0].start, resource_size(&res[0]));
-	twd_clock_event	= alloc_percpu(struct clock_event_device);
-	if (!twd_base || !twd_clock_event) {
-		iounmap(twd_base);
-		twd_base = NULL;
-		free_percpu(twd_clock_event);
+	if (!twd_base)
 		return -ENOMEM;
-	}
 
-	/* Immediately configure the timer on the boot CPU */
-	clk = per_cpu_ptr(twd_clock_event, smp_processor_id());
-	twd_setup(clk);
+	return twd_timer_common_init();
+}
 
-	register_cpu_notifier(&twd_cpu_nb);
+#ifdef CONFIG_OF
+int __init twd_timer_of_init(const struct of_device_id *twd_of_match)
+{
+	struct device_node *np;
 
-	return 0;
+	np = of_find_matching_node(NULL, twd_of_match);
+	if (!np)
+		return -ENODEV;
+
+	twd_ppi = irq_of_parse_and_map(np, 0);
+	if (!twd_ppi)
+		return -EINVAL;
+
+	twd_base = of_iomap(np, 0);
+	if (!twd_base)
+		return -ENOMEM;
+
+	return twd_timer_common_init();
 }
 #endif
+#endif
-- 
1.7.7.1
