From: denis@eukrea.com (Denis Carikli)
Date: Mon, 23 Jun 2014 15:25:27 +0200
Subject: [PATCH v2 2/2] ARM: i.MX25 clk: Use of_clk_init() for DT case
In-Reply-To: <1403529927-13868-1-git-send-email-denis@eukrea.com>
References: <1403529927-13868-1-git-send-email-denis@eukrea.com>
Message-ID: <1403529927-13868-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace .init_time() hook with of_clk_init() for DT targets.

Based on:
  d4347ee ARM: i.MX27 clk: Use of_clk_init() for DT case

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
- Rebased.
- Removing the warning about the useless int i declaration.
---
 arch/arm/mach-imx/clk-imx25.c |  287 +++++++++++++++++++++--------------------
 arch/arm/mach-imx/common.h    |    1 -
 arch/arm/mach-imx/imx25-dt.c  |    6 -
 3 files changed, 144 insertions(+), 150 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index e759a6d..49ab1d6 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -32,31 +32,29 @@
 #include "hardware.h"
 #include "mx25.h"
 
-#define CRM_BASE	MX25_IO_ADDRESS(MX25_CRM_BASE_ADDR)
+static void __iomem *ccm __initdata;
 
-#define CCM_MPCTL	0x00
-#define CCM_UPCTL	0x04
-#define CCM_CCTL	0x08
-#define CCM_CGCR0	0x0C
-#define CCM_CGCR1	0x10
-#define CCM_CGCR2	0x14
-#define CCM_PCDR0	0x18
-#define CCM_PCDR1	0x1C
-#define CCM_PCDR2	0x20
-#define CCM_PCDR3	0x24
-#define CCM_RCSR	0x28
-#define CCM_CRDR	0x2C
-#define CCM_DCVR0	0x30
-#define CCM_DCVR1	0x34
-#define CCM_DCVR2	0x38
-#define CCM_DCVR3	0x3c
-#define CCM_LTR0	0x40
-#define CCM_LTR1	0x44
-#define CCM_LTR2	0x48
-#define CCM_LTR3	0x4c
-#define CCM_MCR		0x64
-
-#define ccm(x)	(CRM_BASE + (x))
+#define CCM_MPCTL	(ccm + 0x00)
+#define CCM_UPCTL	(ccm + 0x04)
+#define CCM_CCTL	(ccm + 0x08)
+#define CCM_CGCR0	(ccm + 0x0C)
+#define CCM_CGCR1	(ccm + 0x10)
+#define CCM_CGCR2	(ccm + 0x14)
+#define CCM_PCDR0	(ccm + 0x18)
+#define CCM_PCDR1	(ccm + 0x1C)
+#define CCM_PCDR2	(ccm + 0x20)
+#define CCM_PCDR3	(ccm + 0x24)
+#define CCM_RCSR	(ccm + 0x28)
+#define CCM_CRDR	(ccm + 0x2C)
+#define CCM_DCVR0	(ccm + 0x30)
+#define CCM_DCVR1	(ccm + 0x34)
+#define CCM_DCVR2	(ccm + 0x38)
+#define CCM_DCVR3	(ccm + 0x3c)
+#define CCM_LTR0	(ccm + 0x40)
+#define CCM_LTR1	(ccm + 0x44)
+#define CCM_LTR2	(ccm + 0x48)
+#define CCM_LTR3	(ccm + 0x4c)
+#define CCM_MCR		(ccm + 0x64)
 
 static struct clk_onecell_data clk_data;
 
@@ -93,134 +91,136 @@ static struct clk *clk[clk_max];
 
 static int __init __mx25_clocks_init(unsigned long osc_rate)
 {
+	BUG_ON(!ccm);
+
 	clk[dummy] = imx_clk_fixed("dummy", 0);
 	clk[osc] = imx_clk_fixed("osc", osc_rate);
-	clk[mpll] = imx_clk_pllv1("mpll", "osc", ccm(CCM_MPCTL));
-	clk[upll] = imx_clk_pllv1("upll", "osc", ccm(CCM_UPCTL));
+	clk[mpll] = imx_clk_pllv1("mpll", "osc", CCM_MPCTL);
+	clk[upll] = imx_clk_pllv1("upll", "osc", CCM_UPCTL);
 	clk[mpll_cpu_3_4] = imx_clk_fixed_factor("mpll_cpu_3_4", "mpll", 3, 4);
-	clk[cpu_sel] = imx_clk_mux("cpu_sel", ccm(CCM_CCTL), 14, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
-	clk[cpu] = imx_clk_divider("cpu", "cpu_sel", ccm(CCM_CCTL), 30, 2);
-	clk[ahb] = imx_clk_divider("ahb", "cpu", ccm(CCM_CCTL), 28, 2);
-	clk[usb_div] = imx_clk_divider("usb_div", "upll", ccm(CCM_CCTL), 16, 6); 
+	clk[cpu_sel] = imx_clk_mux("cpu_sel", CCM_CCTL, 14, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
+	clk[cpu] = imx_clk_divider("cpu", "cpu_sel", CCM_CCTL, 30, 2);
+	clk[ahb] = imx_clk_divider("ahb", "cpu", CCM_CCTL, 28, 2);
+	clk[usb_div] = imx_clk_divider("usb_div", "upll", CCM_CCTL, 16, 6);
 	clk[ipg] = imx_clk_fixed_factor("ipg", "ahb", 1, 2);
-	clk[per0_sel] = imx_clk_mux("per0_sel", ccm(CCM_MCR), 0, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per1_sel] = imx_clk_mux("per1_sel", ccm(CCM_MCR), 1, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per2_sel] = imx_clk_mux("per2_sel", ccm(CCM_MCR), 2, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per3_sel] = imx_clk_mux("per3_sel", ccm(CCM_MCR), 3, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per4_sel] = imx_clk_mux("per4_sel", ccm(CCM_MCR), 4, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per5_sel] = imx_clk_mux("per5_sel", ccm(CCM_MCR), 5, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per6_sel] = imx_clk_mux("per6_sel", ccm(CCM_MCR), 6, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per7_sel] = imx_clk_mux("per7_sel", ccm(CCM_MCR), 7, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per8_sel] = imx_clk_mux("per8_sel", ccm(CCM_MCR), 8, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per9_sel] = imx_clk_mux("per9_sel", ccm(CCM_MCR), 9, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per10_sel] = imx_clk_mux("per10_sel", ccm(CCM_MCR), 10, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per11_sel] = imx_clk_mux("per11_sel", ccm(CCM_MCR), 11, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per12_sel] = imx_clk_mux("per12_sel", ccm(CCM_MCR), 12, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per13_sel] = imx_clk_mux("per13_sel", ccm(CCM_MCR), 13, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per14_sel] = imx_clk_mux("per14_sel", ccm(CCM_MCR), 14, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[per15_sel] = imx_clk_mux("per15_sel", ccm(CCM_MCR), 15, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
-	clk[cko_div] = imx_clk_divider("cko_div", "cko_sel", ccm(CCM_MCR), 24, 6);
-	clk[cko_sel] = imx_clk_mux("cko_sel", ccm(CCM_MCR), 20, 4, cko_sel_clks, ARRAY_SIZE(cko_sel_clks));
-	clk[cko] = imx_clk_gate("cko", "cko_div", ccm(CCM_MCR),  30);
-	clk[per0] = imx_clk_divider("per0", "per0_sel", ccm(CCM_PCDR0), 0, 6);
-	clk[per1] = imx_clk_divider("per1", "per1_sel", ccm(CCM_PCDR0), 8, 6);
-	clk[per2] = imx_clk_divider("per2", "per2_sel", ccm(CCM_PCDR0), 16, 6);
-	clk[per3] = imx_clk_divider("per3", "per3_sel", ccm(CCM_PCDR0), 24, 6);
-	clk[per4] = imx_clk_divider("per4", "per4_sel", ccm(CCM_PCDR1), 0, 6);
-	clk[per5] = imx_clk_divider("per5", "per5_sel", ccm(CCM_PCDR1), 8, 6);
-	clk[per6] = imx_clk_divider("per6", "per6_sel", ccm(CCM_PCDR1), 16, 6);
-	clk[per7] = imx_clk_divider("per7", "per7_sel", ccm(CCM_PCDR1), 24, 6);
-	clk[per8] = imx_clk_divider("per8", "per8_sel", ccm(CCM_PCDR2), 0, 6);
-	clk[per9] = imx_clk_divider("per9", "per9_sel", ccm(CCM_PCDR2), 8, 6);
-	clk[per10] = imx_clk_divider("per10", "per10_sel", ccm(CCM_PCDR2), 16, 6);
-	clk[per11] = imx_clk_divider("per11", "per11_sel", ccm(CCM_PCDR2), 24, 6);
-	clk[per12] = imx_clk_divider("per12", "per12_sel", ccm(CCM_PCDR3), 0, 6);
-	clk[per13] = imx_clk_divider("per13", "per13_sel", ccm(CCM_PCDR3), 8, 6);
-	clk[per14] = imx_clk_divider("per14", "per14_sel", ccm(CCM_PCDR3), 16, 6);
-	clk[per15] = imx_clk_divider("per15", "per15_sel", ccm(CCM_PCDR3), 24, 6);
-	clk[csi_ipg_per] = imx_clk_gate("csi_ipg_per", "per0", ccm(CCM_CGCR0), 0);
-	clk[epit_ipg_per] = imx_clk_gate("epit_ipg_per", "per1", ccm(CCM_CGCR0),  1);
-	clk[esai_ipg_per] = imx_clk_gate("esai_ipg_per", "per2", ccm(CCM_CGCR0),  2);
-	clk[esdhc1_ipg_per] = imx_clk_gate("esdhc1_ipg_per", "per3", ccm(CCM_CGCR0),  3);
-	clk[esdhc2_ipg_per] = imx_clk_gate("esdhc2_ipg_per", "per4", ccm(CCM_CGCR0),  4);
-	clk[gpt_ipg_per] = imx_clk_gate("gpt_ipg_per", "per5", ccm(CCM_CGCR0),  5);
-	clk[i2c_ipg_per] = imx_clk_gate("i2c_ipg_per", "per6", ccm(CCM_CGCR0),  6);
-	clk[lcdc_ipg_per] = imx_clk_gate("lcdc_ipg_per", "per7", ccm(CCM_CGCR0),  7);
-	clk[nfc_ipg_per] = imx_clk_gate("nfc_ipg_per", "per8", ccm(CCM_CGCR0),  8);
-	clk[owire_ipg_per] = imx_clk_gate("owire_ipg_per", "per9", ccm(CCM_CGCR0),  9);
-	clk[pwm_ipg_per] = imx_clk_gate("pwm_ipg_per", "per10", ccm(CCM_CGCR0),  10);
-	clk[sim1_ipg_per] = imx_clk_gate("sim1_ipg_per", "per11", ccm(CCM_CGCR0),  11);
-	clk[sim2_ipg_per] = imx_clk_gate("sim2_ipg_per", "per12", ccm(CCM_CGCR0),  12);
-	clk[ssi1_ipg_per] = imx_clk_gate("ssi1_ipg_per", "per13", ccm(CCM_CGCR0), 13);
-	clk[ssi2_ipg_per] = imx_clk_gate("ssi2_ipg_per", "per14", ccm(CCM_CGCR0), 14);
-	clk[uart_ipg_per] = imx_clk_gate("uart_ipg_per", "per15", ccm(CCM_CGCR0), 15);
-	clk[ata_ahb] = imx_clk_gate("ata_ahb", "ahb", ccm(CCM_CGCR0), 16);
+	clk[per0_sel] = imx_clk_mux("per0_sel", CCM_MCR, 0, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per1_sel] = imx_clk_mux("per1_sel", CCM_MCR, 1, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per2_sel] = imx_clk_mux("per2_sel", CCM_MCR, 2, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per3_sel] = imx_clk_mux("per3_sel", CCM_MCR, 3, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per4_sel] = imx_clk_mux("per4_sel", CCM_MCR, 4, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per5_sel] = imx_clk_mux("per5_sel", CCM_MCR, 5, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per6_sel] = imx_clk_mux("per6_sel", CCM_MCR, 6, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per7_sel] = imx_clk_mux("per7_sel", CCM_MCR, 7, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per8_sel] = imx_clk_mux("per8_sel", CCM_MCR, 8, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per9_sel] = imx_clk_mux("per9_sel", CCM_MCR, 9, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per10_sel] = imx_clk_mux("per10_sel", CCM_MCR, 10, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per11_sel] = imx_clk_mux("per11_sel", CCM_MCR, 11, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per12_sel] = imx_clk_mux("per12_sel", CCM_MCR, 12, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per13_sel] = imx_clk_mux("per13_sel", CCM_MCR, 13, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per14_sel] = imx_clk_mux("per14_sel", CCM_MCR, 14, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[per15_sel] = imx_clk_mux("per15_sel", CCM_MCR, 15, 1, per_sel_clks, ARRAY_SIZE(per_sel_clks));
+	clk[cko_div] = imx_clk_divider("cko_div", "cko_sel", CCM_MCR, 24, 6);
+	clk[cko_sel] = imx_clk_mux("cko_sel", CCM_MCR, 20, 4, cko_sel_clks, ARRAY_SIZE(cko_sel_clks));
+	clk[cko] = imx_clk_gate("cko", "cko_div", CCM_MCR,  30);
+	clk[per0] = imx_clk_divider("per0", "per0_sel", CCM_PCDR0, 0, 6);
+	clk[per1] = imx_clk_divider("per1", "per1_sel", CCM_PCDR0, 8, 6);
+	clk[per2] = imx_clk_divider("per2", "per2_sel", CCM_PCDR0, 16, 6);
+	clk[per3] = imx_clk_divider("per3", "per3_sel", CCM_PCDR0, 24, 6);
+	clk[per4] = imx_clk_divider("per4", "per4_sel", CCM_PCDR1, 0, 6);
+	clk[per5] = imx_clk_divider("per5", "per5_sel", CCM_PCDR1, 8, 6);
+	clk[per6] = imx_clk_divider("per6", "per6_sel", CCM_PCDR1, 16, 6);
+	clk[per7] = imx_clk_divider("per7", "per7_sel", CCM_PCDR1, 24, 6);
+	clk[per8] = imx_clk_divider("per8", "per8_sel", CCM_PCDR2, 0, 6);
+	clk[per9] = imx_clk_divider("per9", "per9_sel", CCM_PCDR2, 8, 6);
+	clk[per10] = imx_clk_divider("per10", "per10_sel", CCM_PCDR2, 16, 6);
+	clk[per11] = imx_clk_divider("per11", "per11_sel", CCM_PCDR2, 24, 6);
+	clk[per12] = imx_clk_divider("per12", "per12_sel", CCM_PCDR3, 0, 6);
+	clk[per13] = imx_clk_divider("per13", "per13_sel", CCM_PCDR3, 8, 6);
+	clk[per14] = imx_clk_divider("per14", "per14_sel", CCM_PCDR3, 16, 6);
+	clk[per15] = imx_clk_divider("per15", "per15_sel", CCM_PCDR3, 24, 6);
+	clk[csi_ipg_per] = imx_clk_gate("csi_ipg_per", "per0", CCM_CGCR0, 0);
+	clk[epit_ipg_per] = imx_clk_gate("epit_ipg_per", "per1", CCM_CGCR0,  1);
+	clk[esai_ipg_per] = imx_clk_gate("esai_ipg_per", "per2", CCM_CGCR0,  2);
+	clk[esdhc1_ipg_per] = imx_clk_gate("esdhc1_ipg_per", "per3", CCM_CGCR0,  3);
+	clk[esdhc2_ipg_per] = imx_clk_gate("esdhc2_ipg_per", "per4", CCM_CGCR0,  4);
+	clk[gpt_ipg_per] = imx_clk_gate("gpt_ipg_per", "per5", CCM_CGCR0,  5);
+	clk[i2c_ipg_per] = imx_clk_gate("i2c_ipg_per", "per6", CCM_CGCR0,  6);
+	clk[lcdc_ipg_per] = imx_clk_gate("lcdc_ipg_per", "per7", CCM_CGCR0,  7);
+	clk[nfc_ipg_per] = imx_clk_gate("nfc_ipg_per", "per8", CCM_CGCR0,  8);
+	clk[owire_ipg_per] = imx_clk_gate("owire_ipg_per", "per9", CCM_CGCR0,  9);
+	clk[pwm_ipg_per] = imx_clk_gate("pwm_ipg_per", "per10", CCM_CGCR0,  10);
+	clk[sim1_ipg_per] = imx_clk_gate("sim1_ipg_per", "per11", CCM_CGCR0,  11);
+	clk[sim2_ipg_per] = imx_clk_gate("sim2_ipg_per", "per12", CCM_CGCR0,  12);
+	clk[ssi1_ipg_per] = imx_clk_gate("ssi1_ipg_per", "per13", CCM_CGCR0, 13);
+	clk[ssi2_ipg_per] = imx_clk_gate("ssi2_ipg_per", "per14", CCM_CGCR0, 14);
+	clk[uart_ipg_per] = imx_clk_gate("uart_ipg_per", "per15", CCM_CGCR0, 15);
+	clk[ata_ahb] = imx_clk_gate("ata_ahb", "ahb", CCM_CGCR0, 16);
 	/* CCM_CGCR0(17): reserved */
-	clk[csi_ahb] = imx_clk_gate("csi_ahb", "ahb", ccm(CCM_CGCR0), 18);
-	clk[emi_ahb] = imx_clk_gate("emi_ahb", "ahb", ccm(CCM_CGCR0), 19);
-	clk[esai_ahb] = imx_clk_gate("esai_ahb", "ahb", ccm(CCM_CGCR0), 20);
-	clk[esdhc1_ahb] = imx_clk_gate("esdhc1_ahb", "ahb", ccm(CCM_CGCR0), 21);
-	clk[esdhc2_ahb] = imx_clk_gate("esdhc2_ahb", "ahb", ccm(CCM_CGCR0), 22);
-	clk[fec_ahb] = imx_clk_gate("fec_ahb", "ahb", ccm(CCM_CGCR0), 23);
-	clk[lcdc_ahb] = imx_clk_gate("lcdc_ahb", "ahb", ccm(CCM_CGCR0), 24);
-	clk[rtic_ahb] = imx_clk_gate("rtic_ahb", "ahb", ccm(CCM_CGCR0), 25);
-	clk[sdma_ahb] = imx_clk_gate("sdma_ahb", "ahb", ccm(CCM_CGCR0), 26);
-	clk[slcdc_ahb] = imx_clk_gate("slcdc_ahb", "ahb", ccm(CCM_CGCR0), 27);
-	clk[usbotg_ahb] = imx_clk_gate("usbotg_ahb", "ahb", ccm(CCM_CGCR0), 28);
+	clk[csi_ahb] = imx_clk_gate("csi_ahb", "ahb", CCM_CGCR0, 18);
+	clk[emi_ahb] = imx_clk_gate("emi_ahb", "ahb", CCM_CGCR0, 19);
+	clk[esai_ahb] = imx_clk_gate("esai_ahb", "ahb", CCM_CGCR0, 20);
+	clk[esdhc1_ahb] = imx_clk_gate("esdhc1_ahb", "ahb", CCM_CGCR0, 21);
+	clk[esdhc2_ahb] = imx_clk_gate("esdhc2_ahb", "ahb", CCM_CGCR0, 22);
+	clk[fec_ahb] = imx_clk_gate("fec_ahb", "ahb", CCM_CGCR0, 23);
+	clk[lcdc_ahb] = imx_clk_gate("lcdc_ahb", "ahb", CCM_CGCR0, 24);
+	clk[rtic_ahb] = imx_clk_gate("rtic_ahb", "ahb", CCM_CGCR0, 25);
+	clk[sdma_ahb] = imx_clk_gate("sdma_ahb", "ahb", CCM_CGCR0, 26);
+	clk[slcdc_ahb] = imx_clk_gate("slcdc_ahb", "ahb", CCM_CGCR0, 27);
+	clk[usbotg_ahb] = imx_clk_gate("usbotg_ahb", "ahb", CCM_CGCR0, 28);
 	/* CCM_CGCR0(29-31): reserved */
 	/* CCM_CGCR1(0): reserved in datasheet, used as audmux in FSL kernel */
-	clk[can1_ipg] = imx_clk_gate("can1_ipg", "ipg", ccm(CCM_CGCR1),  2);
-	clk[can2_ipg] = imx_clk_gate("can2_ipg", "ipg", ccm(CCM_CGCR1),  3);
-	clk[csi_ipg] = imx_clk_gate("csi_ipg", "ipg", ccm(CCM_CGCR1),  4);
-	clk[cspi1_ipg] = imx_clk_gate("cspi1_ipg", "ipg", ccm(CCM_CGCR1),  5);
-	clk[cspi2_ipg] = imx_clk_gate("cspi2_ipg", "ipg", ccm(CCM_CGCR1),  6);
-	clk[cspi3_ipg] = imx_clk_gate("cspi3_ipg", "ipg", ccm(CCM_CGCR1),  7);
-	clk[dryice_ipg] = imx_clk_gate("dryice_ipg", "ipg", ccm(CCM_CGCR1),  8);
-	clk[ect_ipg] = imx_clk_gate("ect_ipg", "ipg", ccm(CCM_CGCR1),  9);
-	clk[epit1_ipg] = imx_clk_gate("epit1_ipg", "ipg", ccm(CCM_CGCR1),  10);
-	clk[epit2_ipg] = imx_clk_gate("epit2_ipg", "ipg", ccm(CCM_CGCR1),  11);
+	clk[can1_ipg] = imx_clk_gate("can1_ipg", "ipg", CCM_CGCR1,  2);
+	clk[can2_ipg] = imx_clk_gate("can2_ipg", "ipg", CCM_CGCR1,  3);
+	clk[csi_ipg] = imx_clk_gate("csi_ipg", "ipg", CCM_CGCR1,  4);
+	clk[cspi1_ipg] = imx_clk_gate("cspi1_ipg", "ipg", CCM_CGCR1,  5);
+	clk[cspi2_ipg] = imx_clk_gate("cspi2_ipg", "ipg", CCM_CGCR1,  6);
+	clk[cspi3_ipg] = imx_clk_gate("cspi3_ipg", "ipg", CCM_CGCR1,  7);
+	clk[dryice_ipg] = imx_clk_gate("dryice_ipg", "ipg", CCM_CGCR1,  8);
+	clk[ect_ipg] = imx_clk_gate("ect_ipg", "ipg", CCM_CGCR1,  9);
+	clk[epit1_ipg] = imx_clk_gate("epit1_ipg", "ipg", CCM_CGCR1,  10);
+	clk[epit2_ipg] = imx_clk_gate("epit2_ipg", "ipg", CCM_CGCR1,  11);
 	/* CCM_CGCR1(12): reserved in datasheet, used as esai in FSL kernel */
-	clk[esdhc1_ipg] = imx_clk_gate("esdhc1_ipg", "ipg", ccm(CCM_CGCR1), 13);
-	clk[esdhc2_ipg] = imx_clk_gate("esdhc2_ipg", "ipg", ccm(CCM_CGCR1), 14);
-	clk[fec_ipg] = imx_clk_gate("fec_ipg", "ipg", ccm(CCM_CGCR1), 15);
+	clk[esdhc1_ipg] = imx_clk_gate("esdhc1_ipg", "ipg", CCM_CGCR1, 13);
+	clk[esdhc2_ipg] = imx_clk_gate("esdhc2_ipg", "ipg", CCM_CGCR1, 14);
+	clk[fec_ipg] = imx_clk_gate("fec_ipg", "ipg", CCM_CGCR1, 15);
 	/* CCM_CGCR1(16): reserved in datasheet, used as gpio1 in FSL kernel */
 	/* CCM_CGCR1(17): reserved in datasheet, used as gpio2 in FSL kernel */
 	/* CCM_CGCR1(18): reserved in datasheet, used as gpio3 in FSL kernel */
-	clk[gpt1_ipg] = imx_clk_gate("gpt1_ipg", "ipg", ccm(CCM_CGCR1), 19);
-	clk[gpt2_ipg] = imx_clk_gate("gpt2_ipg", "ipg", ccm(CCM_CGCR1), 20);
-	clk[gpt3_ipg] = imx_clk_gate("gpt3_ipg", "ipg", ccm(CCM_CGCR1), 21);
-	clk[gpt4_ipg] = imx_clk_gate("gpt4_ipg", "ipg", ccm(CCM_CGCR1), 22);
+	clk[gpt1_ipg] = imx_clk_gate("gpt1_ipg", "ipg", CCM_CGCR1, 19);
+	clk[gpt2_ipg] = imx_clk_gate("gpt2_ipg", "ipg", CCM_CGCR1, 20);
+	clk[gpt3_ipg] = imx_clk_gate("gpt3_ipg", "ipg", CCM_CGCR1, 21);
+	clk[gpt4_ipg] = imx_clk_gate("gpt4_ipg", "ipg", CCM_CGCR1, 22);
 	/* CCM_CGCR1(23): reserved in datasheet, used as i2c1 in FSL kernel */
 	/* CCM_CGCR1(24): reserved in datasheet, used as i2c2 in FSL kernel */
 	/* CCM_CGCR1(25): reserved in datasheet, used as i2c3 in FSL kernel */
-	clk[iim_ipg] = imx_clk_gate("iim_ipg", "ipg", ccm(CCM_CGCR1), 26);
+	clk[iim_ipg] = imx_clk_gate("iim_ipg", "ipg", CCM_CGCR1, 26);
 	/* CCM_CGCR1(27): reserved in datasheet, used as iomuxc in FSL kernel */
 	/* CCM_CGCR1(28): reserved in datasheet, used as kpp in FSL kernel */
-	clk[kpp_ipg] = imx_clk_gate("kpp_ipg", "ipg", ccm(CCM_CGCR1), 28);
-	clk[lcdc_ipg] = imx_clk_gate("lcdc_ipg", "ipg", ccm(CCM_CGCR1), 29);
+	clk[kpp_ipg] = imx_clk_gate("kpp_ipg", "ipg", CCM_CGCR1, 28);
+	clk[lcdc_ipg] = imx_clk_gate("lcdc_ipg", "ipg", CCM_CGCR1, 29);
 	/* CCM_CGCR1(30): reserved in datasheet, used as owire in FSL kernel */
-	clk[pwm1_ipg] = imx_clk_gate("pwm1_ipg", "ipg", ccm(CCM_CGCR1), 31);
-	clk[pwm2_ipg] = imx_clk_gate("pwm2_ipg", "ipg", ccm(CCM_CGCR2),  0);
-	clk[pwm3_ipg] = imx_clk_gate("pwm3_ipg", "ipg", ccm(CCM_CGCR2),  1);
-	clk[pwm4_ipg] = imx_clk_gate("pwm4_ipg", "ipg", ccm(CCM_CGCR2),  2);
-	clk[rngb_ipg] = imx_clk_gate("rngb_ipg", "ipg", ccm(CCM_CGCR2),  3);
+	clk[pwm1_ipg] = imx_clk_gate("pwm1_ipg", "ipg", CCM_CGCR1, 31);
+	clk[pwm2_ipg] = imx_clk_gate("pwm2_ipg", "ipg", CCM_CGCR2,  0);
+	clk[pwm3_ipg] = imx_clk_gate("pwm3_ipg", "ipg", CCM_CGCR2,  1);
+	clk[pwm4_ipg] = imx_clk_gate("pwm4_ipg", "ipg", CCM_CGCR2,  2);
+	clk[rngb_ipg] = imx_clk_gate("rngb_ipg", "ipg", CCM_CGCR2,  3);
 	/* CCM_CGCR2(4): reserved in datasheet, used as rtic in FSL kernel */
-	clk[scc_ipg] = imx_clk_gate("scc_ipg", "ipg", ccm(CCM_CGCR2),  5);
-	clk[sdma_ipg] = imx_clk_gate("sdma_ipg", "ipg", ccm(CCM_CGCR2),  6);
-	clk[sim1_ipg] = imx_clk_gate("sim1_ipg", "ipg", ccm(CCM_CGCR2),  7);
-	clk[sim2_ipg] = imx_clk_gate("sim2_ipg", "ipg", ccm(CCM_CGCR2),  8);
-	clk[slcdc_ipg] = imx_clk_gate("slcdc_ipg", "ipg", ccm(CCM_CGCR2),  9);
-	clk[spba_ipg] = imx_clk_gate("spba_ipg", "ipg", ccm(CCM_CGCR2),  10);
-	clk[ssi1_ipg] = imx_clk_gate("ssi1_ipg", "ipg", ccm(CCM_CGCR2), 11);
-	clk[ssi2_ipg] = imx_clk_gate("ssi2_ipg", "ipg", ccm(CCM_CGCR2), 12);
-	clk[tsc_ipg] = imx_clk_gate("tsc_ipg", "ipg", ccm(CCM_CGCR2), 13);
-	clk[uart1_ipg] = imx_clk_gate("uart1_ipg", "ipg", ccm(CCM_CGCR2), 14);
-	clk[uart2_ipg] = imx_clk_gate("uart2_ipg", "ipg", ccm(CCM_CGCR2), 15);
-	clk[uart3_ipg] = imx_clk_gate("uart3_ipg", "ipg", ccm(CCM_CGCR2), 16);
-	clk[uart4_ipg] = imx_clk_gate("uart4_ipg", "ipg", ccm(CCM_CGCR2), 17);
-	clk[uart5_ipg] = imx_clk_gate("uart5_ipg", "ipg", ccm(CCM_CGCR2), 18);
+	clk[scc_ipg] = imx_clk_gate("scc_ipg", "ipg", CCM_CGCR2,  5);
+	clk[sdma_ipg] = imx_clk_gate("sdma_ipg", "ipg", CCM_CGCR2,  6);
+	clk[sim1_ipg] = imx_clk_gate("sim1_ipg", "ipg", CCM_CGCR2,  7);
+	clk[sim2_ipg] = imx_clk_gate("sim2_ipg", "ipg", CCM_CGCR2,  8);
+	clk[slcdc_ipg] = imx_clk_gate("slcdc_ipg", "ipg", CCM_CGCR2,  9);
+	clk[spba_ipg] = imx_clk_gate("spba_ipg", "ipg", CCM_CGCR2,  10);
+	clk[ssi1_ipg] = imx_clk_gate("ssi1_ipg", "ipg", CCM_CGCR2, 11);
+	clk[ssi2_ipg] = imx_clk_gate("ssi2_ipg", "ipg", CCM_CGCR2, 12);
+	clk[tsc_ipg] = imx_clk_gate("tsc_ipg", "ipg", CCM_CGCR2, 13);
+	clk[uart1_ipg] = imx_clk_gate("uart1_ipg", "ipg", CCM_CGCR2, 14);
+	clk[uart2_ipg] = imx_clk_gate("uart2_ipg", "ipg", CCM_CGCR2, 15);
+	clk[uart3_ipg] = imx_clk_gate("uart3_ipg", "ipg", CCM_CGCR2, 16);
+	clk[uart4_ipg] = imx_clk_gate("uart4_ipg", "ipg", CCM_CGCR2, 17);
+	clk[uart5_ipg] = imx_clk_gate("uart5_ipg", "ipg", CCM_CGCR2, 18);
 	/* CCM_CGCR2(19): reserved in datasheet, but used as wdt in FSL kernel */
-	clk[wdt_ipg] = imx_clk_gate("wdt_ipg", "ipg", ccm(CCM_CGCR2), 19);
+	clk[wdt_ipg] = imx_clk_gate("wdt_ipg", "ipg", CCM_CGCR2, 19);
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
@@ -240,6 +240,8 @@ static int __init __mx25_clocks_init(unsigned long osc_rate)
 
 int __init mx25_clocks_init(void)
 {
+	ccm = ioremap(MX25_CRM_BASE_ADDR, SZ_16K);
+
 	__mx25_clocks_init(24000000);
 
 	clk_register_clkdev(clk[gpt1_ipg], "ipg", "imx-gpt.0");
@@ -308,29 +310,28 @@ int __init mx25_clocks_init(void)
 	return 0;
 }
 
-int __init mx25_clocks_init_dt(void)
+static void __init mx25_clocks_init_dt(struct device_node *np)
 {
-	struct device_node *np;
+	struct device_node *refnp;
 	unsigned long osc_rate = 24000000;
 
 	/* retrieve the freqency of fixed clocks from device tree */
-	for_each_compatible_node(np, NULL, "fixed-clock") {
+	for_each_compatible_node(refnp, NULL, "fixed-clock") {
 		u32 rate;
-		if (of_property_read_u32(np, "clock-frequency", &rate))
+		if (of_property_read_u32(refnp, "clock-frequency", &rate))
 			continue;
 
-		if (of_device_is_compatible(np, "fsl,imx-osc"))
+		if (of_device_is_compatible(refnp, "fsl,imx-osc"))
 			osc_rate = rate;
 	}
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx25-ccm");
+	ccm = of_iomap(np, 0);
+	__mx25_clocks_init(osc_rate);
+
 	clk_data.clks = clk;
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	__mx25_clocks_init(osc_rate);
-
 	mxc_timer_init_dt(of_find_compatible_node(NULL, NULL, "fsl,imx25-gpt"));
-
-	return 0;
 }
+CLK_OF_DECLARE(imx25_ccm, "fsl,imx25-ccm", mx25_clocks_init_dt);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 50ee9c2..08ab255 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -55,7 +55,6 @@ int mx25_clocks_init(void);
 int mx27_clocks_init(unsigned long fref);
 int mx31_clocks_init(unsigned long fref);
 int mx35_clocks_init(void);
-int mx25_clocks_init_dt(void);
 int mx31_clocks_init_dt(void);
 struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index 42a65e0..cf8032b 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -29,16 +29,10 @@ static const char * const imx25_dt_board_compat[] __initconst = {
 	NULL
 };
 
-static void __init imx25_timer_init(void)
-{
-	mx25_clocks_init_dt();
-}
-
 DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.map_io		= mx25_map_io,
 	.init_early	= imx25_init_early,
 	.init_irq	= mx25_init_irq,
-	.init_time	= imx25_timer_init,
 	.init_machine	= imx25_dt_init,
 	.dt_compat	= imx25_dt_board_compat,
 	.restart	= mxc_restart,
-- 
1.7.9.5
