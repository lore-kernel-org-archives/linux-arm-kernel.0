From: robherring2@gmail.com (Rob Herring)
Date: Tue,  8 Mar 2011 17:34:34 -0600
Subject: [PATCH v3 4/7] ARM: vexpress: add sp804 clock
In-Reply-To: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
Message-ID: <1299627277-20311-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a clock for sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |    4 ++--
 arch/arm/mach-vexpress/v2m.c      |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 30d5a5b..3528b1a 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -73,8 +73,8 @@ static void __init ct_ca9x4_timer_init(void)
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
 
-	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1));
-	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0);
+	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), NULL);
+	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0, NULL);
 }
 
 static struct sys_timer ct_ca9x4_timer = {
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 63ef663..c056259 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -335,6 +335,10 @@ static struct clk osc2_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup v2m_lookups[] = {
@@ -365,6 +369,9 @@ static struct clk_lookup v2m_lookups[] = {
 	}, {	/* CLCD */
 		.dev_id		= "mb:clcd",
 		.clk		= &osc1_clk,
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
 	},
 };
 
-- 
1.7.1
