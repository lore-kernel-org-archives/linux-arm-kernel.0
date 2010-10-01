From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Sep 2010 19:20:44 -0500
Subject: [PATCH 2/3] ARM: timer-sp: support timer clock freq other than 1MHz
Message-ID: <4CA5295C.60007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer-sp code is fixed to 1MHz timer clock. Add clock
api calls to get the timer clock frequency.

Signed-off-by: Rob Herring <rob.herring@smooth-stone.com>
---
  arch/arm/common/timer-sp.c |   30 +++++++++++++++++++++++++-----
  1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index b552358..44e83a2 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -18,6 +18,8 @@
   * along with this program; if not, write to the Free Software
   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
   */
+#include <linux/clk.h>
+#include <linux/err.h>
  #include <linux/clocksource.h>
  #include <linux/clockchips.h>
  #include <linux/interrupt.h>
@@ -29,9 +31,9 @@
  /*
   * These timers are currently always setup to be clocked at 1MHz.
   */
-#define TIMER_FREQ_KHZ	(1000)
-#define TIMER_RELOAD	(TIMER_FREQ_KHZ * 1000 / HZ)
+#define TIMER_FREQ_HZ	(1000000)
  +static unsigned long sp804_rate;
  static void __iomem *clksrc_base;
   static cycle_t sp804_read(struct clocksource *cs)
@@ -50,10 +52,19 @@ static struct clocksource clocksource_sp804 = {
   void __init sp804_clocksource_init(void __iomem *base)
  {
+	struct clk *clk;
  	struct clocksource *cs = &clocksource_sp804;
   	clksrc_base = base;
  +	if (sp804_rate == 0) {
+		clk = clk_get_sys(NULL, "sp804_timer");
+		if (!IS_ERR(clk))
+			sp804_rate = clk_get_rate(clk);
+		else
+			sp804_rate = TIMER_FREQ_HZ;
+	}
+
  	/* setup timer 0 as free-running clocksource */
  	writel(0, clksrc_base + TIMER_CTRL);
  	writel(0xffffffff, clksrc_base + TIMER_LOAD);
@@ -61,7 +72,7 @@ void __init sp804_clocksource_init(void __iomem *base)
  	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
  		clksrc_base + TIMER_CTRL);
  -	cs->mult = clocksource_khz2mult(TIMER_FREQ_KHZ, cs->shift);
+	cs->mult = clocksource_khz2mult(sp804_rate / 1000, cs->shift);
  	clocksource_register(cs);
  }
  @@ -92,7 +103,7 @@ static void sp804_set_mode(enum clock_event_mode mode,
   	switch (mode) {
  	case CLOCK_EVT_MODE_PERIODIC:
-		writel(TIMER_RELOAD, clkevt_base + TIMER_LOAD);
+		writel(sp804_rate / HZ, clkevt_base + TIMER_LOAD);
  		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
  		break;
  @@ -140,12 +151,21 @@ static struct irqaction sp804_timer_irq = {
   void __init sp804_clockevents_init(void __iomem *base, unsigned int 
timer_irq)
  {
+	struct clk *clk;
  	struct clock_event_device *evt = &sp804_clockevent;
   	clkevt_base = base;
  +	if (sp804_rate == 0) {
+		clk = clk_get_sys(NULL, "sp804_timer");
+		if (!IS_ERR(clk))
+			sp804_rate = clk_get_rate(clk);
+		else
+			sp804_rate = TIMER_FREQ_HZ;
+	}
+
  	evt->irq = timer_irq;
-	evt->mult = div_sc(TIMER_FREQ_KHZ, NSEC_PER_MSEC, evt->shift);
+	evt->mult = div_sc(sp804_rate / 1000, NSEC_PER_MSEC, evt->shift);
  	evt->max_delta_ns = clockevent_delta2ns(0xffffffff, evt);
  	evt->min_delta_ns = clockevent_delta2ns(0xf, evt);
  -- 1.7.0.4
