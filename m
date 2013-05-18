From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 18 May 2013 09:25:28 +0200
Subject: [PATCH] ARM: i.MX6: clk: add different DualLite MLB clock config
Message-ID: <1368861928-16141-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCM_CBCMR register (address 0x02C4018) has different meaning
between the i.MX6 Quad/Dual and the i.MX6 Solo/DualLite.

Compared to the i.MX6 Quad/Dual, the CCM_CBCMR register in the
i.MX6 Solo/DualLite reuses the gpu2d_core bits for the MLB clock
configuration.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---

Note: This patch is against Shawn's for-next branch
https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/for-next

 arch/arm/mach-imx/clk-imx6q.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 50095dd..63530dd 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -506,7 +506,14 @@ int __init mx6q_clocks_init(void)
 	clk[ldb_di1]      = imx_clk_gate2("ldb_di1",       "ldb_di1_podf",      base + 0x74, 14);
 	clk[ipu2_di1]     = imx_clk_gate2("ipu2_di1",      "ipu2_di1_sel",      base + 0x74, 10);
 	clk[hsi_tx]       = imx_clk_gate2("hsi_tx",        "hsi_tx_podf",       base + 0x74, 16);
-	clk[mlb]          = imx_clk_gate2("mlb",           "axi",               base + 0x74, 18);
+	if (cpu_is_imx6dl())
+		/*
+		 * The multiplexer and divider of the imx6q clock gpu2d get
+		 * redefined/reused as mlb_sys_sel and mlb_sys_clk_podf on imx6dl.
+		 */
+		clk[mlb] = imx_clk_gate2("mlb",            "gpu2d_core_podf",   base + 0x74, 18);
+	else
+		clk[mlb] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);
 	clk[mmdc_ch0_axi] = imx_clk_gate2("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20);
 	clk[mmdc_ch1_axi] = imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch1_axi_podf", base + 0x74, 22);
 	clk[ocram]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
-- 
1.7.10.4
