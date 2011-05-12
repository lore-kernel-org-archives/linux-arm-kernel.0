From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 May 2011 14:51:41 +0100
Subject: [PATCH 15/13] clocksource: ARM sp804: obtain sp804 timer rate via clks
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Message-ID: <20110512135141.GC6098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows platforms to specify the rate of the SP804 clocksource via
the clk subsystem.  While ARM boards clock these at 1MHz, BCMRing also
has SP804 timers but are clocked at different rates.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/timer-sp.c               |   24 +++++++++++++++++++++++-
 arch/arm/mach-integrator/integrator_cp.c |    7 +++++++
 arch/arm/mach-realview/core.c            |    9 ++++++++-
 arch/arm/mach-versatile/core.c           |    9 ++++++++-
 arch/arm/mach-vexpress/ct-ca9x4.c        |    8 ++++++++
 arch/arm/mach-vexpress/v2m.c             |    8 ++++++++
 6 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index f6b9011..e201941 100644
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
@@ -34,6 +36,26 @@
 
 void __init sp804_clocksource_init(void __iomem *base, const char *name)
 {
+	unsigned long rate;
+	struct clk *clk;
+	int err;
+
+	clk = clk_get_sys("sp804", name);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found: %d\n", name,
+			(int)PTR_ERR(clk));
+		return;
+	}
+
+	err = clk_enable(clk);
+	if (err) {
+		pr_err("sp804: %s clock failed to enable: %d\n", name, err);
+		clk_put(clk);
+		return;
+	}
+
+	rate = clk_get_rate(clk);
+
 	/* setup timer 0 as free-running clocksource */
 	writel(0, base + TIMER_CTRL);
 	writel(0xffffffff, base + TIMER_LOAD);
@@ -42,7 +64,7 @@ void __init sp804_clocksource_init(void __iomem *base, const char *name)
 		base + TIMER_CTRL);
 
 	clocksource_mmio_init(base + TIMER_VALUE, name,
-		TIMER_FREQ_KHZ * 1000, 200, 32, clocksource_mmio_readl_down);
+		rate, 200, 32, clocksource_mmio_readl_down);
 }
 
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 46fb7f5..8fb8afb 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -229,10 +229,17 @@ static struct clk cp_auxclk = {
 	.vcoreg	= CM_AUXOSC,
 };
 
+static struct clk sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk_lookup cp_lookups[] = {
 	{	/* CLCD */
 		.dev_id		= "mb:c0",
 		.clk		= &cp_auxclk,
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
 	},
 };
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 6356b5e..6a9cd1e 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -315,6 +315,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
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
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
+	},
 };
 
 void __init realview_init_early(void)
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index aad6d39..b0b7de6 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -375,6 +375,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
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
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
+	},
 };
 
 /*
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index c833fd9..6004f06 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -141,10 +141,18 @@ static struct clk osc1_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk ct_sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk_lookup lookups[] = {
 	{	/* CLCD */
 		.dev_id		= "ct:clcd",
 		.clk		= &osc1_clk,
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
+		.con_id		= "ct-timer1",
+		.clk		= &ct_sp804_clk,
 	},
 };
 
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index ccf1f89..77d5db3 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -333,6 +333,10 @@ static struct clk osc2_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk v2m_sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup v2m_lookups[] = {
@@ -363,6 +367,10 @@ static struct clk_lookup v2m_lookups[] = {
 	}, {	/* CLCD */
 		.dev_id		= "mb:clcd",
 		.clk		= &osc1_clk,
+	}, {	/* SP804 timers */
+		.dev_id		= "sp804",
+		.con_id		= "v2m-timer1",
+		.clk		= &v2m_sp804_clk,
 	},
 };
 
-- 
1.7.4.4
