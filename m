From: davidb@codeaurora.org (David Brown)
Date: Wed,  2 Nov 2011 11:36:29 -0700
Subject: [RFC PATCH 32/34] msm: clock-8x60: Add local control of vpe_axi_clk
	and vpe_axi_clk
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1320258991-22325-33-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matt Wagantall <mattw@codeaurora.org>

The MAXI_EN2 register is no longer owned by the RPM. Add local
control of the VPE and Rotator AXI clocks which are in it.

Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/clock-8x60.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/clock-8x60.c b/arch/arm/mach-msm/clock-8x60.c
index 201c478..21c2472 100644
--- a/arch/arm/mach-msm/clock-8x60.c
+++ b/arch/arm/mach-msm/clock-8x60.c
@@ -122,6 +122,7 @@
 #define JPEGD_CC_REG				REG_MM(0x00A4)
 #define JPEGD_NS_REG				REG_MM(0x00AC)
 #define MAXI_EN_REG				REG_MM(0x0018)
+#define MAXI_EN2_REG				REG_MM(0x0020)
 #define MAXI_EN3_REG				REG_MM(0x002C)
 #define MDP_CC_REG				REG_MM(0x00C0)
 #define MDP_MD0_REG				REG_MM(0x00C4)
@@ -603,24 +604,32 @@ static struct branch_clk vfe_axi_clk = {
 
 static struct branch_clk rot_axi_clk = {
 	.b = {
+		.ctl_reg = MAXI_EN2_REG,
+		.en_mask = BIT(24),
 		.reset_reg = SW_RESET_AXI_REG,
 		.reset_mask = BIT(6),
+		.halt_reg = DBG_BUS_VEC_E_REG,
+		.halt_bit = 2,
 	},
 	.c = {
 		.dbg_name = "rot_axi_clk",
-		.ops = &clk_ops_reset,
+		.ops = &clk_ops_branch,
 		CLK_INIT(rot_axi_clk.c),
 	},
 };
 
 static struct branch_clk vpe_axi_clk = {
 	.b = {
+		.ctl_reg = MAXI_EN2_REG,
+		.en_mask = BIT(26),
 		.reset_reg = SW_RESET_AXI_REG,
 		.reset_mask = BIT(15),
+		.halt_reg = DBG_BUS_VEC_E_REG,
+		.halt_bit = 1,
 	},
 	.c = {
 		.dbg_name = "vpe_axi_clk",
-		.ops = &clk_ops_reset,
+		.ops = &clk_ops_branch,
 		CLK_INIT(vpe_axi_clk.c),
 	},
 };
@@ -2545,6 +2554,7 @@ static struct rcg_clk rot_clk = {
 	.set_rate = set_rate_div_banked,
 	.freq_tbl = clk_tbl_rot,
 	.bank_masks = &bdiv_info_rot,
+	.depends = &rot_axi_clk.c,
 	.current_freq = &local_dummy_freq,
 	.c = {
 		.dbg_name = "rot_clk",
@@ -2767,6 +2777,7 @@ static struct rcg_clk vpe_clk = {
 	.ns_mask = (BM(15, 12) | BM(2, 0)),
 	.set_rate = set_rate_nop,
 	.freq_tbl = clk_tbl_vpe,
+	.depends = &vpe_axi_clk.c,
 	.current_freq = &local_dummy_freq,
 	.c = {
 		.dbg_name = "vpe_clk",
@@ -3154,8 +3165,10 @@ static struct measure_sel measure_mux[] = {
 	{ TEST_MM_HS(0x13), &imem_axi_clk.c },
 	{ TEST_MM_HS(0x14), &jpegd_axi_clk.c },
 	{ TEST_MM_HS(0x15), &mdp_axi_clk.c },
+	{ TEST_MM_HS(0x16), &rot_axi_clk.c },
 	{ TEST_MM_HS(0x17), &vcodec_axi_clk.c },
 	{ TEST_MM_HS(0x18), &vfe_axi_clk.c },
+	{ TEST_MM_HS(0x19), &vpe_axi_clk.c },
 	{ TEST_MM_HS(0x1A), &mdp_clk.c },
 	{ TEST_MM_HS(0x1B), &rot_clk.c },
 	{ TEST_MM_HS(0x1C), &vpe_clk.c },
@@ -3566,7 +3579,7 @@ static void __init reg_init(void)
 	 * support it. Also set FORCE_CORE_ON bits, and any sleep and wake-up
 	 * delays to safe values. */
 	rmwreg(0x000207F9, MAXI_EN_REG,  0x0FFFFFFF);
-	/* MAXI_EN2_REG is owned by the RPM.  Don't touch it. */
+	writel_relaxed(0x7027FCFF, MAXI_EN2_REG);
 	writel_relaxed(0x3FE7FCFF, MAXI_EN3_REG);
 	writel_relaxed(0x000001D8, SAXI_EN_REG);
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
