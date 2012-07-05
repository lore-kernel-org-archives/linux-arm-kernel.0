From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Thu,  5 Jul 2012 10:31:36 +0300
Subject: [PATCH for 3.5] ARM: apx4devkit: fix FEC enabling PHY clock
Message-ID: <1341473496-2535-1-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ethernet stopped to work after mxs clk framework change.

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
Shawn,

Any chance to get this patch into 3.5? Ethernet is currently dead on
apx4devkit. We are going to move device tree in the near future but before
that we would like to keep our machine in good condition.

Lauri


 arch/arm/mach-mxs/mach-apx4devkit.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-mxs/mach-apx4devkit.c b/arch/arm/mach-mxs/mach-apx4devkit.c
index 5e90b9d..f5f0617 100644
--- a/arch/arm/mach-mxs/mach-apx4devkit.c
+++ b/arch/arm/mach-mxs/mach-apx4devkit.c
@@ -205,6 +205,16 @@ static int apx4devkit_phy_fixup(struct phy_device *phy)
 	return 0;
 }
 
+static void __init apx4devkit_fec_phy_clk_enable(void)
+{
+	struct clk *clk;
+
+	/* Enable fec phy clock */
+	clk = clk_get_sys("enet_out", NULL);
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
+}
+
 static void __init apx4devkit_init(void)
 {
 	mx28_soc_init();
@@ -225,6 +235,7 @@ static void __init apx4devkit_init(void)
 	phy_register_fixup_for_uid(PHY_ID_KS8051, MICREL_PHY_ID_MASK,
 			apx4devkit_phy_fixup);
 
+	apx4devkit_fec_phy_clk_enable();
 	mx28_add_fec(0, &mx28_fec_pdata);
 
 	mx28_add_mxs_mmc(0, &apx4devkit_mmc_pdata);
-- 
1.7.9.5
