From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 21 May 2012 22:55:10 +0100
Subject: [PATCH] ARM: kirkwood: Force nand platform device name
In-Reply-To: <20120521011209.GK24238@titan.lakedaemon.net>
References: <20120521011209.GK24238@titan.lakedaemon.net>
Message-ID: <1337637311-24388-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk framework relies on device names to be constant. Pre-dt, the
NAND platform device was called "orion_nand" which is what the framework
expects. The following auxdata block forces the name to "orion_nand",
so the clk framework finds it and keeps required clocks enabled.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/mach-kirkwood/board-dt.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index edc3f8a..dbf7fe3 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -25,6 +25,12 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 	{ }
 };
 
+struct of_dev_auxdata kirkwood_dt_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("mrvl,orion-nand", KIRKWOOD_NAND_MEM_PHYS_BASE,
+		       "orion_nand", NULL),
+	{ }
+};
+
 static void __init kirkwood_dt_init(void)
 {
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
@@ -68,7 +74,8 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("raidsonic,ib-nas62x0"))
 		ib62x0_init();
 
-	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
+	of_platform_populate(NULL, kirkwood_dt_match_table,
+			kirkwood_dt_auxdata_lookup, NULL);
 }
 
 static const char *kirkwood_dt_board_compat[] = {
-- 
1.7.10
