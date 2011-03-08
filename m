From: robherring2@gmail.com (Rob Herring)
Date: Tue,  8 Mar 2011 17:34:37 -0600
Subject: [PATCH v3 7/7] ARM: vexpress: add smp_twd clock
In-Reply-To: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
Message-ID: <1299627277-20311-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add smp_twd clock and call twd_timer_init to enable using it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 3528b1a..7366c5b 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -55,9 +55,6 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 
 static void __init ct_ca9x4_map_io(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = MMIO_P2V(A9_MPCORE_TWD);
-#endif
 	v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
@@ -143,10 +140,17 @@ static struct clk osc1_clk = {
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
 
-- 
1.7.1
