From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jan 2013 16:46:12 +0100
Subject: [PATCH V3 2/5] ARM: i.MX53: Add clocks for i.mx53 onewire master.
In-Reply-To: <20130129154608.5184.46101.stgit@localhost>
References: <20130129154608.5184.46101.stgit@localhost>
Message-ID: <20130129154612.5184.66887.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
 .../devicetree/bindings/clock/imx5-clock.txt       |    1 +
 arch/arm/mach-imx/clk-imx51-imx53.c                |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
index 04ad478..2a0c904 100644
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
@@ -171,6 +171,7 @@ clocks and IDs.
 	can_sel			156
 	can1_serial_gate	157
 	can1_ipg_gate		158
+	owire_gate		159
 
 Examples (for mx53):
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 579023f..7ff293b 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -83,6 +83,7 @@ enum imx5_clks {
 	ssi2_root_gate, ssi3_root_gate, ssi_ext1_gate, ssi_ext2_gate,
 	epit1_ipg_gate, epit1_hf_gate, epit2_ipg_gate, epit2_hf_gate,
 	can_sel, can1_serial_gate, can1_ipg_gate,
+	owire_gate,
 	clk_max
 };
 
@@ -233,12 +234,13 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[epit1_hf_gate] = imx_clk_gate2("epit1_hf_gate", "per_root", MXC_CCM_CCGR2, 4);
 	clk[epit2_ipg_gate] = imx_clk_gate2("epit2_ipg_gate", "ipg", MXC_CCM_CCGR2, 6);
 	clk[epit2_hf_gate] = imx_clk_gate2("epit2_hf_gate", "per_root", MXC_CCM_CCGR2, 8);
+	clk[owire_gate] = imx_clk_gate2("owire_gate", "per_root", MXC_CCM_CCGR2, 22);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
 			pr_err("i.MX5 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
-	
+
 	clk_register_clkdev(clk[gpt_hf_gate], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_gate], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[uart1_per_gate], "per", "imx21-uart.0");
