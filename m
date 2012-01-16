From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 13:52:28 +0000
Subject: [PATCH v3 03/15] ARM: smp_twd: add runtime registration support
In-Reply-To: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
References: <1326721960-2224-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326721960-2224-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the new registration interface to smp_twd.
Platforms can populate a struct twd_local_timer with MMIO
and IRQ resources, and then call twd_local_timer_register()
to have the timer registered with the core.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/smp_twd.h |   18 +++++++++++++-
 arch/arm/kernel/smp_twd.c      |   51 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index bf8449d..16c89b7 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -18,10 +18,26 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
+#include <linux/ioport.h>
+
 struct clock_event_device;
 
 extern void __iomem *twd_base;
 
-void twd_timer_setup(struct clock_event_device *);
+int twd_timer_setup(struct clock_event_device *);
+
+struct twd_local_timer {
+	struct resource	res[2];
+};
+
+#define DEFINE_TWD_LOCAL_TIMER(name,base,irq)	\
+struct twd_local_timer name __initdata = {	\
+	.res	= {				\
+		DEFINE_RES_MEM(base, 0x10),	\
+		DEFINE_RES_IRQ(irq),		\
+	},					\
+};
+
+int twd_local_timer_register(struct twd_local_timer *);
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 95a0c14..f105e91 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -32,6 +32,7 @@ static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
 
 static struct clock_event_device __percpu **twd_evt;
+static int twd_ppi;
 
 static void twd_set_mode(enum clock_event_mode mode,
 			struct clock_event_device *clk)
@@ -227,7 +228,7 @@ static struct clk *twd_get_clock(void)
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit twd_timer_setup(struct clock_event_device *clk)
+int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
 	struct clock_event_device **this_cpu_clk;
 
@@ -237,7 +238,7 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 		twd_evt = alloc_percpu(struct clock_event_device *);
 		if (!twd_evt) {
 			pr_err("twd: can't allocate memory\n");
-			return;
+			return -ENOMEM;
 		}
 
 		err = request_percpu_irq(clk->irq, twd_handler,
@@ -245,7 +246,7 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 		if (err) {
 			pr_err("twd: can't register interrupt %d (%d)\n",
 			       clk->irq, err);
-			return;
+			return err;
 		}
 	}
 
@@ -263,6 +264,8 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
+	if (!clk->irq)
+		clk->irq = twd_ppi;
 
 	this_cpu_clk = __this_cpu_ptr(twd_evt);
 	*this_cpu_clk = clk;
@@ -270,4 +273,46 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clockevents_config_and_register(clk, twd_timer_rate,
 					0xf, 0xffffffff);
 	enable_percpu_irq(clk->irq, 0);
+
+	return 0;
+}
+
+static struct local_timer_ops twd_lt_ops __cpuinitdata = {
+	.setup	= twd_timer_setup,
+	.stop	= twd_timer_stop,
+};
+
+int __init twd_local_timer_register(struct twd_local_timer *tlt)
+{
+	int err;
+
+	if (twd_base || twd_evt)
+		return -EBUSY;
+
+	twd_ppi	= tlt->res[1].start;
+
+	twd_evt = alloc_percpu(struct clock_event_device *);
+	twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
+	if (!twd_base || !twd_evt) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = request_percpu_irq(twd_ppi, twd_handler, "twd", twd_evt);
+	if (err) {
+		pr_err("twd: can't register interrupt %d (%d)\n", twd_ppi, err);
+		goto out;
+	}
+
+	err = local_timer_register(&twd_lt_ops);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	iounmap(twd_base);
+	free_percpu(twd_evt);
+	twd_base = twd_evt = NULL;
+	return err;
 }
-- 
1.7.7.1
