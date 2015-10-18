From: stefan@agner.ch (Stefan Agner)
Date: Sat, 17 Oct 2015 21:05:20 -0700
Subject: [PATCH 1/3] ARM: imx: clk-vf610: fix SAI clock tree
Message-ID: <1445141122-14183-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Synchronous Audio Interface (SAI) instances are clocked by
independent clocks: The bus clock and the audio clock (as shown in
Figure 51-1 in the Vybrid Reference Manual). The clock gates in
CCGR0/CCGR1 for SAI0 through SAI3 are bus clock gates, as access
tests to the registers with/without gating those clocks have shown.
The audio clock is gated by the SAIx_EN gates in CCM_CSCDR1,
followed by a clock divider (SAIx_DIV). Currently, the parent of
the bus clock gates has been assigned to SAIx_DIV, which is not
involved in the bus clock path for the SAI instances (see chapter
9.10.12, SAI clocking in the Vybrid Reference Manual).

Fix this by define the parent clock of VF610_CLK_SAIx to be the bus
clock.

If the driver needs the audio clock (when used in master mode), a
fixed device tree is required which assign the audio clock properly
to VF610_CLK_SAIx_DIV.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi all,

Patch 1 and 2 are actual fixes and should be applied toghether. If
the clock tree changes are applied only, master mode won't work
anymore. With only the device tree changes applied, it probably
will still work but the VF610_CLK_SAIx_DIV will be enabled twice.

Since Patch 3 also uses the fixed clock layout, it should be
applied after the clock tree fix too...

Not sure through which tree these changes should go?

--
Stefan

 drivers/clk/imx/clk-vf610.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index bff45ea..42a7a23 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -335,22 +335,22 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_SAI0_SEL] = imx_clk_mux("sai0_sel", CCM_CSCMR1, 0, 2, sai_sels, 4);
 	clk[VF610_CLK_SAI0_EN] = imx_clk_gate("sai0_en", "sai0_sel", CCM_CSCDR1, 16);
 	clk[VF610_CLK_SAI0_DIV] = imx_clk_divider("sai0_div", "sai0_en", CCM_CSCDR1, 0, 4);
-	clk[VF610_CLK_SAI0] = imx_clk_gate2("sai0", "sai0_div", CCM_CCGR0, CCM_CCGRx_CGn(15));
+	clk[VF610_CLK_SAI0] = imx_clk_gate2("sai0", "ipg_bus", CCM_CCGR0, CCM_CCGRx_CGn(15));
 
 	clk[VF610_CLK_SAI1_SEL] = imx_clk_mux("sai1_sel", CCM_CSCMR1, 2, 2, sai_sels, 4);
 	clk[VF610_CLK_SAI1_EN] = imx_clk_gate("sai1_en", "sai1_sel", CCM_CSCDR1, 17);
 	clk[VF610_CLK_SAI1_DIV] = imx_clk_divider("sai1_div", "sai1_en", CCM_CSCDR1, 4, 4);
-	clk[VF610_CLK_SAI1] = imx_clk_gate2("sai1", "sai1_div", CCM_CCGR1, CCM_CCGRx_CGn(0));
+	clk[VF610_CLK_SAI1] = imx_clk_gate2("sai1", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(0));
 
 	clk[VF610_CLK_SAI2_SEL] = imx_clk_mux("sai2_sel", CCM_CSCMR1, 4, 2, sai_sels, 4);
 	clk[VF610_CLK_SAI2_EN] = imx_clk_gate("sai2_en", "sai2_sel", CCM_CSCDR1, 18);
 	clk[VF610_CLK_SAI2_DIV] = imx_clk_divider("sai2_div", "sai2_en", CCM_CSCDR1, 8, 4);
-	clk[VF610_CLK_SAI2] = imx_clk_gate2("sai2", "sai2_div", CCM_CCGR1, CCM_CCGRx_CGn(1));
+	clk[VF610_CLK_SAI2] = imx_clk_gate2("sai2", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(1));
 
 	clk[VF610_CLK_SAI3_SEL] = imx_clk_mux("sai3_sel", CCM_CSCMR1, 6, 2, sai_sels, 4);
 	clk[VF610_CLK_SAI3_EN] = imx_clk_gate("sai3_en", "sai3_sel", CCM_CSCDR1, 19);
 	clk[VF610_CLK_SAI3_DIV] = imx_clk_divider("sai3_div", "sai3_en", CCM_CSCDR1, 12, 4);
-	clk[VF610_CLK_SAI3] = imx_clk_gate2("sai3", "sai3_div", CCM_CCGR1, CCM_CCGRx_CGn(2));
+	clk[VF610_CLK_SAI3] = imx_clk_gate2("sai3", "ipg_bus", CCM_CCGR1, CCM_CCGRx_CGn(2));
 
 	clk[VF610_CLK_NFC_SEL] = imx_clk_mux("nfc_sel", CCM_CSCMR1, 12, 2, nfc_sels, 4);
 	clk[VF610_CLK_NFC_EN] = imx_clk_gate("nfc_en", "nfc_sel", CCM_CSCDR2, 9);
-- 
2.6.1
