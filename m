From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 3 May 2013 11:08:45 +0200
Subject: [PATCH] ARM: i.MX6: clk: add i.MX6 DualLite differences
Message-ID: <1367572125-28420-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCM_CBCMR register (address 0x02C4018) has different meaning
between the i.MX6 Quad/Dual and the i.MX6 Solo/DualLite.

Compared to the i.MX6 Quad/Dual, the CCM_CBCMR register in the
i.MX6 Solo/DualLite doesn't have a gpu3d_shader configuration and
moves the gpu2_core configuration at that place.

Handle these i.MX6 Quad/Dual vs. i.MX6 Solo/DualLite clock differences
by using cpu_is_mx6dl().

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---

Note: This patch is against
      https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/imx/soc
      as it needs cpu_is_imx6dl() from the commit "ARM: imx: add initial imx6dl support"

 arch/arm/mach-imx/clk-imx6q.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 1512590..32c19c7 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -480,7 +480,14 @@ int __init mx6q_clocks_init(void)
 	clk[esai]         = imx_clk_gate2("esai",          "esai_podf",         base + 0x6c, 16);
 	clk[gpt_ipg]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
 	clk[gpt_ipg_per]  = imx_clk_gate2("gpt_ipg_per",   "ipg_per",           base + 0x6c, 22);
-	clk[gpu2d_core]   = imx_clk_gate2("gpu2d_core",    "gpu2d_core_podf",   base + 0x6c, 24);
+	if (cpu_is_imx6dl())
+		/*
+		 * The multiplexer and divider of imx6q clock gpu3d_shader get
+		 * redefined/reused as gpu2d_core_sel and gpu2d_core_podf on imx6dl.
+		 */
+		clk[gpu2d_core] = imx_clk_gate2("gpu2d_core", "gpu3d_shader", base + 0x6c, 24);
+	else
+		clk[gpu2d_core] = imx_clk_gate2("gpu2d_core", "gpu2d_core_podf", base + 0x6c, 24);
 	clk[gpu3d_core]   = imx_clk_gate2("gpu3d_core",    "gpu3d_core_podf",   base + 0x6c, 26);
 	clk[hdmi_iahb]    = imx_clk_gate2("hdmi_iahb",     "ahb",               base + 0x70, 0);
 	clk[hdmi_isfr]    = imx_clk_gate2("hdmi_isfr",     "pll3_pfd1_540m",    base + 0x70, 4);
-- 
1.8.2
