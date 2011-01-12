From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:31:57 -0600
Subject: [PATCH 1/7] ARM: integrator cp: init clocks early and add sp804 clock
In-Reply-To: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
Message-ID: <1294875123-14086-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move clock initialization to mdesc->init_early and add a clock for
sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-integrator/integrator_cp.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 85e48a5..d99a880 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -305,14 +305,25 @@ static struct clk cp_auxclk = {
 	.params	= &cp_auxvco_params,
 	.vcoreg	= CM_AUXOSC,
 };
+static struct clk sp804_clk = {
+	.rate = 1000000,
+};
 
 static struct clk_lookup cp_lookups[] = {
 	{	/* CLCD */
 		.dev_id		= "mb:c0",
 		.clk		= &cp_auxclk,
-	},
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
+	}
 };
 
+static void __init intcp_init_early(void)
+{
+	clkdev_add_table(cp_lookups, ARRAY_SIZE(cp_lookups));
+}
+
 /*
  * Flash handling.
  */
@@ -569,7 +580,6 @@ static void __init intcp_init(void)
 {
 	int i;
 
-	clkdev_add_table(cp_lookups, ARRAY_SIZE(cp_lookups));
 	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
@@ -601,6 +611,7 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	.boot_params	= 0x00000100,
 	.map_io		= intcp_map_io,
 	.reserve	= integrator_reserve,
+	.init_early	= intcp_init_early,
 	.init_irq	= intcp_init_irq,
 	.timer		= &cp_timer,
 	.init_machine	= intcp_init,
-- 
1.7.1
