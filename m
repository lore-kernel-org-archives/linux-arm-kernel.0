From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 14 Dec 2011 17:03:16 +0200
Subject: [PATCH v7 04/14] arm/tegra: don't export clk_measure_input_freq
In-Reply-To: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1323875032-18221-5-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

don't export clk_measure_input_freq as its functionality is also available
using clk_get_rate().

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/clock.h         |    1 -
 arch/arm/mach-tegra/tegra2_clocks.c |    2 +-
 arch/arm/mach-tegra/timer.c         |   12 ++++++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
index 8c18e81..5c44106 100644
--- a/arch/arm/mach-tegra/clock.h
+++ b/arch/arm/mach-tegra/clock.h
@@ -148,7 +148,6 @@ struct tegra_clk_init_table {
 void tegra2_init_clocks(void);
 void clk_init(struct clk *clk);
 struct clk *tegra_get_clock_by_name(const char *name);
-unsigned long clk_measure_input_freq(void);
 int clk_reparent(struct clk *c, struct clk *parent);
 void tegra_clk_init_from_table(struct tegra_clk_init_table *table);
 unsigned long clk_get_rate_locked(struct clk *c);
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index c78abab..ff9e6b6 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -174,7 +174,7 @@ static int tegra_periph_clk_enable_refcount[3 * 32];
 #define pmc_readl(reg) \
 	__raw_readl(reg_pmc_base + (reg))
 
-unsigned long clk_measure_input_freq(void)
+static unsigned long clk_measure_input_freq(void)
 {
 	u32 clock_autodetect;
 	clk_writel(OSC_FREQ_DET_TRIG | 1, OSC_FREQ_DET);
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 2f1df47..6366654 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -182,14 +182,18 @@ static struct irqaction tegra_timer_irq = {
 static void __init tegra_init_timer(void)
 {
 	struct clk *clk;
-	unsigned long rate = clk_measure_input_freq();
+	unsigned long rate;
 	int ret;
 
 	clk = clk_get_sys("timer", NULL);
-	if (IS_ERR(clk))
-		pr_warn("Unable to get timer clock\n");
-	else
+	if (IS_ERR(clk)) {
+		pr_warn("Unable to get timer clock."
+			" Assuming 12Mhz input clock.\n");
+		rate = 12000000;
+	} else {
 		clk_enable(clk);
+		rate = clk_get_rate(clk);
+	}
 
 	/*
 	 * rtc registers are used by read_persistent_clock, keep the rtc clock
-- 
1.7.7.rc0.72.g4b5ea.dirty
