From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:32:03 -0600
Subject: [PATCH 7/7] ARM: vexpress: add smp_twd clock
In-Reply-To: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
Message-ID: <1294875123-14086-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add smp_twd clock and call twd_timer_init to enable using it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index db4614c..62d5a2d 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -53,9 +53,6 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 
 static void __init ct_ca9x4_map_io(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = MMIO_P2V(A9_MPCORE_TWD);
-#endif
 	v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
@@ -183,10 +180,17 @@ static struct clk osc1_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk twd_clk = {
+	.rate	= 200000000,
+};
+
 static struct clk_lookup lookups[] = {
 	{	/* CLCD */
 		.dev_id		= "ct:clcd",
 		.clk		= &osc1_clk,
+	}, {	/* TWD */
+		.dev_id		= "smp_twd",
+		.clk		= &twd_clk,
 	},
 };
 
@@ -194,6 +198,10 @@ static void __init ct_ca9x4_init_early(void)
 {
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 	v2m_init_early();
+
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_timer_init(MMIO_P2V(A9_MPCORE_TWD));
+#endif
 }
 
 static struct resource pmu_resources[] = {
-- 
1.7.1
