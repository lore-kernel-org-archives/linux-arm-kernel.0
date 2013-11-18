From: marex@denx.de (Marek Vasut)
Date: Mon, 18 Nov 2013 15:30:41 +0100
Subject: [PATCH V2 3/5] ARM: imx: imx53: Add SATA PHY clock
In-Reply-To: <1384785043-5027-1-git-send-email-marex@denx.de>
References: <1384785043-5027-1-git-send-email-marex@denx.de>
Message-ID: <1384785043-5027-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SATA PHY clock which are derived from the USB PHY1 clock. Note that this
patch derives the SATA PHY clock from USB PHY1 clock gate so that the SATA
driver can ungate both the SATA PHY clock and USB PHY1 clock for the SATA to
work correctly.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/mach-imx/clk-imx51-imx53.c    | 1 +
 include/dt-bindings/clock/imx5-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

V2: Use the clock ID macros

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 07d275f..c128ec6 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -244,6 +244,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk[IMX5_CLK_SPDIF0_GATE]	= imx_clk_gate2("spdif0_gate", "spdif0_com_sel", MXC_CCM_CCGR5, 26);
 	clk[IMX5_CLK_SPDIF_IPG_GATE]	= imx_clk_gate2("spdif_ipg_gate", "ipg", MXC_CCM_CCGR5, 30);
 	clk[IMX5_CLK_SAHARA_IPG_GATE]	= imx_clk_gate2("sahara_ipg_gate", "ipg", MXC_CCM_CCGR4, 14);
+	clk[IMX5_CLK_SATA_PHY]		= imx_clk_fixed_factor("sata_phy", "usb_phy1_gate", 1, 1);
 
 	for (i = 0; i < ARRAY_SIZE(clk); i++)
 		if (IS_ERR(clk[i]))
diff --git a/include/dt-bindings/clock/imx5-clock.h b/include/dt-bindings/clock/imx5-clock.h
index 5c2f634..a719c04 100644
--- a/include/dt-bindings/clock/imx5-clock.h
+++ b/include/dt-bindings/clock/imx5-clock.h
@@ -197,6 +197,7 @@
 #define IMX5_CLK_SPDIF_IPG_GATE		185
 #define IMX5_CLK_OCRAM			186
 #define IMX5_CLK_SAHARA_IPG_GATE	187
-#define IMX5_CLK_END			188
+#define IMX5_CLK_SATA_PHY		188
+#define IMX5_CLK_END			189
 
 #endif /* __DT_BINDINGS_CLOCK_IMX5_H */
-- 
1.8.4.2
