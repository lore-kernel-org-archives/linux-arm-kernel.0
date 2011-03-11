From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Mar 2011 08:16:46 +0000
Subject: [PATCH v3 0/7] ARM timer clock api support
In-Reply-To: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110311081646.GA13596@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2011 at 05:34:30PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This patch series converts ARM sp804 timer and smp_twd timer to use the clock
> api.

This is what I came up with - I've still not sorted these patches out,
the second is a superset of the first.
-------------- next part --------------
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 6ef3342..0480acb 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -40,19 +40,21 @@ static cycle_t sp804_read(struct clocksource *cs)
 }
 
 static struct clocksource clocksource_sp804 = {
-	.name		= "timer3",
 	.rating		= 200,
 	.read		= sp804_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-void __init sp804_clocksource_init(void __iomem *base)
+void __init sp804_clocksource_init(void __iomem *base, const char *name)
 {
 	struct clocksource *cs = &clocksource_sp804;
 
 	clksrc_base = base;
 
+	/* FIXME: cs->name should be const */
+	cs->name = (char *)name;
+
 	/* setup timer 0 as free-running clocksource */
 	writel(0, clksrc_base + TIMER_CTRL);
 	writel(0xffffffff, clksrc_base + TIMER_LOAD);
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index 21e75e3..11c386b 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -1,2 +1,2 @@
-void sp804_clocksource_init(void __iomem *);
+void sp804_clocksource_init(void __iomem *, const char *);
 void sp804_clockevents_init(void __iomem *, unsigned int);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 545d98a..51c29d3 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -476,7 +476,7 @@ static void __init intcp_timer_init(void)
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER2_VA_BASE);
+	sp804_clocksource_init(TIMER2_VA_BASE, "timer2");
 	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1);
 }
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 7066c60..1b6c1b8 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -545,7 +545,7 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer2_va_base + TIMER_CTRL);
 	writel(0, timer3_va_base + TIMER_CTRL);
 
-	sp804_clocksource_init(timer3_va_base);
+	sp804_clocksource_init(timer3_va_base, "timer3");
 	sp804_clockevents_init(timer0_va_base, timer_irq);
 }
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index ee63dc9..b9cd3ff 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -764,7 +764,7 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER3_VA_BASE);
+	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
 	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
 }
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 7f2c3a3..51fcb0a 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -73,7 +73,7 @@ static void __init ct_ca9x4_timer_init(void)
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1));
+	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), "timer1");
 	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
 }
 
-------------- next part --------------
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 6ef3342..ae265be 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -18,8 +18,10 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
@@ -29,7 +31,8 @@
 /*
  * These timers are currently always setup to be clocked at 1MHz.
  */
-#define TIMER_FREQ_KHZ	(1000)
+#define TIMER_FREQ_HZ	(1000000)
+#define TIMER_FREQ_KHZ	(TIMER_FREQ_HZ / 1000)
 #define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
 
 static void __iomem *clksrc_base;
@@ -40,19 +43,38 @@ static cycle_t sp804_read(struct clocksource *cs)
 }
 
 static struct clocksource clocksource_sp804 = {
-	.name		= "timer3",
 	.rating		= 200,
 	.read		= sp804_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-void __init sp804_clocksource_init(void __iomem *base)
+void __init sp804_clocksource_init(void __iomem *base, const char *name)
 {
 	struct clocksource *cs = &clocksource_sp804;
+	unsigned long rate = TIMER_FREQ_HZ;
+	struct clk *clk;
+
+	clk = clk_get_sys(name, NULL);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found, defaulting to 1MHz: %d\n",
+			name, ERR_PTR(clk));
+	} else {
+		int err = clk_enable(clk);
+		if (err != 0) {
+			pr_err("sp804: %s clock failed to enable: %d\n",
+				name, err);
+			clk_put(clk);
+		} else {
+			rate = clk_get_rate(clk);
+		}
+	}
 
 	clksrc_base = base;
 
+	/* FIXME: cs->name should be const */
+	cs->name = (char *)name;
+
 	/* setup timer 0 as free-running clocksource */
 	writel(0, clksrc_base + TIMER_CTRL);
 	writel(0xffffffff, clksrc_base + TIMER_LOAD);
@@ -60,7 +82,7 @@ void __init sp804_clocksource_init(void __iomem *base)
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clksrc_base + TIMER_CTRL);
 
-	clocksource_register_khz(cs, TIMER_FREQ_KHZ);
+	clocksource_register_hz(cs, rate);
 }
 
 
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index 21e75e3..11c386b 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -1,2 +1,2 @@
-void sp804_clocksource_init(void __iomem *);
+void sp804_clocksource_init(void __iomem *, const char *);
 void sp804_clockevents_init(void __iomem *, unsigned int);
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 545d98a..3563e0c 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -229,10 +229,17 @@ static struct clk cp_auxclk = {
 	.vcoreg	= CM_AUXOSC,
 };
 
+static struct clk timer2_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk_lookup cp_lookups[] = {
 	{	/* CLCD */
 		.dev_id		= "mb:c0",
 		.clk		= &cp_auxclk,
+	}, {	/* Timer 2 */
+		.dev_id		= "timer2",
+		.clk		= &timer2_clk,
 	},
 };
 
@@ -476,7 +483,7 @@ static void __init intcp_timer_init(void)
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER2_VA_BASE);
+	sp804_clocksource_init(TIMER2_VA_BASE, "timer2");
 	sp804_clockevents_init(TIMER1_VA_BASE, IRQ_TIMERINT1);
 }
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 7066c60..0cfba16 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -315,6 +315,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk timer3_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup lookups[] = {
@@ -357,7 +361,10 @@ static struct clk_lookup lookups[] = {
 	}, {	/* SSP */
 		.dev_id		= "dev:ssp0",
 		.clk		= &ref24_clk,
-	}
+	}, {	/* Timer 3 */
+		.dev_id		= "timer3",
+		.clk		= &timer3_clk,
+	},
 };
 
 void __init realview_init_early(void)
@@ -545,7 +552,7 @@ void __init realview_timer_init(unsigned int timer_irq)
 	writel(0, timer2_va_base + TIMER_CTRL);
 	writel(0, timer3_va_base + TIMER_CTRL);
 
-	sp804_clocksource_init(timer3_va_base);
+	sp804_clocksource_init(timer3_va_base, "timer3");
 	sp804_clockevents_init(timer0_va_base, timer_irq);
 }
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index ee63dc9..cca9b80 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -375,6 +375,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk timer3_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup lookups[] = {
@@ -411,7 +415,10 @@ static struct clk_lookup lookups[] = {
 	}, {	/* CLCD */
 		.dev_id		= "dev:20",
 		.clk		= &osc4_clk,
-	}
+	}, {	/* Timer3 */
+		.dev_id		= "timer3",
+		.clk		= &timer3_clk,
+	},
 };
 
 /*
@@ -764,7 +771,7 @@ static void __init versatile_timer_init(void)
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
 
-	sp804_clocksource_init(TIMER3_VA_BASE);
+	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
 	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
 }
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 7f2c3a3..51fcb0a 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -73,7 +73,7 @@ static void __init ct_ca9x4_timer_init(void)
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1));
+	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), "timer1");
 	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
 }
 
