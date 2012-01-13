From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Jan 2012 18:28:31 +0000
Subject: [PATCH v2 04/15] ARM: smp_twd: add device tree support
In-Reply-To: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326479322-6033-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings to support DT discovery of the ARM Timer Watchdog
(aka TWD). Only the timer side is converted by this patch.

Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/twd.txt |   48 ++++++++++++++++++
 arch/arm/include/asm/smp_twd.h                |    9 +++
 arch/arm/kernel/smp_twd.c                     |   67 ++++++++++++++++++++-----
 3 files changed, 111 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/twd.txt

diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/arm/twd.txt
new file mode 100644
index 0000000..75b8610
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/twd.txt
@@ -0,0 +1,48 @@
+* ARM Timer Watchdog
+
+ARM 11MP, Cortex-A5 and Cortex-A9 are often associated with a per-core
+Timer-Watchdog (aka TWD), which provides both a per-cpu local timer
+and watchdog.
+
+The TWD is usually attached to a GIC to deliver its two per-processor
+interrupts.
+
+** Timer node required properties:
+
+- compatible : Should be one of:
+	"arm,cortex-a9-twd-timer"
+	"arm,cortex-a5-twd-timer"
+	"arm,arm11mp-twd-timer"
+
+- interrupts : One interrupt to each core
+
+- reg : Specify the base address and the size of the TWD timer
+	register window.
+
+Example:
+
+	twd-timer at 2c000600 {
+		compatible = "arm,arm11mp-twd-timer"";
+		reg = <0x2c000600 0x20>;
+		interrupts = <1 13 0xf01>;
+	};
+
+** Watchdog node properties:
+
+- compatible : Should be one of:
+	"arm,cortex-a9-twd-wdt"
+	"arm,cortex-a5-twd-wdt"
+	"arm,arm11mp-twd-wdt"
+
+- interrupts : One interrupt to each core
+
+- reg : Specify the base address and the size of the TWD watchdog
+	register window.
+
+Example:
+
+	twd-watchdog at 2c000620 {
+		compatible = "arm,arm11mp-twd-wdt";
+		reg = <0x2c000620 0x20>;
+		interrupts = <1 14 0xf01>;
+	};
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 16c89b7..cfa6f30 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -40,4 +40,13 @@ struct twd_local_timer name __initdata = {	\
 
 int twd_local_timer_register(struct twd_local_timer *);
 
+#if CONFIG_HAVE_ARM_TWD
+int twd_local_timer_of_register(void);
+#else
+static inline int twd_local_timer_of_register(void)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index be245c7..a676f14 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -20,6 +20,8 @@
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
@@ -282,37 +284,76 @@ static struct local_timer_ops twd_lt_ops = {
 	.stop	= twd_timer_stop,
 };
 
-int __init twd_local_timer_register(struct twd_local_timer *tlt)
+static int __init twd_local_timer_common_register(void)
 {
 	int err;
 
-	if (twd_base || twd_evt)
-		return -EBUSY;
-
-	twd_ppi	= tlt->res[1].start;
-
 	twd_evt = alloc_percpu(struct clock_event_device *);
-	twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
-	if (!twd_base || !twd_evt) {
+	if (!twd_evt) {
 		err = -ENOMEM;
-		goto out;
+		goto out_free;
 	}
 
 	err = request_percpu_irq(twd_ppi, twd_handler, "twd", twd_evt);
 	if (err) {
 		pr_err("twd: can't register interrupt %d (%d)\n", twd_ppi, err);
-		goto out;
+		goto out_free;
 	}
 
 	err = local_timer_register(&twd_lt_ops);
 	if (err)
-		goto out;
+		goto out_irq;
 
 	return 0;
 
-out:
+out_irq:
+	free_percpu_irq(twd_ppi, twd_evt);
+out_free:
 	iounmap(twd_base);
+	twd_base = NULL;
 	free_percpu(twd_evt);
-	twd_base = twd_evt = NULL;
+
 	return err;
 }
+
+int __init twd_local_timer_register(struct twd_local_timer *tlt)
+{
+	if (twd_base || twd_evt)
+		return -EBUSY;
+
+	twd_ppi	= tlt->res[1].start;
+
+	twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
+	if (!twd_base)
+		return -ENOMEM;
+
+	return twd_local_timer_common_register();
+}
+
+#ifdef CONFIG_OF
+const static struct of_device_id twd_of_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-twd-timer",	},
+	{ .compatible = "arm,cortex-a5-twd-timer",	},
+	{ .compatible = "arm,arm11mp-twd-timer",	},
+	{ },
+};
+
+int __init twd_local_timer_of_register(void)
+{
+	struct device_node *np;
+
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
+	return twd_local_timer_common_register();
+}
+#endif
-- 
1.7.7.1
