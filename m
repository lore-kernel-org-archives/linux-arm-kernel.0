From: b20788@freescale.com (Anson Huang)
Date: Tue, 9 Dec 2014 15:58:05 +0800
Subject: [PATCH] arm: imx: correct the hardware clock gate setting for shared
 nodes
Message-ID: <1418111885-3623-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For those clk gates which hold share count, since its is_enabled
callback is only checking the share count rather than reading
the hardware register setting, in the late phase of kernel bootup,
the clk_disable_unused action will NOT handle the scenario of
share_count is 0 but the hardware setting is enabled, actually,
uboot normally enables all clk gates, then those shared clk gates
will be always enabled until they are used by some modules.

So the problem would be: when kernel boot up, the usecount cat
from clk tree is 0, but the clk gates actually is enabled in
hardware register, it will confuse user and bring unnecessary power
consumption, take i.MX6SX for example, the ESAI clk info
is as below, the use count is 0, but the hardware register read
from CCM_CCGR1_CG8 is ungated.

cat /sys/kernel/debug/clk/clk_summary | grep esai

esai_sel            0            0   393216000          0 0
   esai_pred           0            0   196608000          0 0
      esai_podf           0            0    24576000          0 0
         esai_extal           0            0    24576000          0 0
      esai_mem           0            0   132000000          0 0
      esai_ipg           0            0   132000000          0 0

Read CCM_CCGR1:

0x020C406C:  F33FFF00

This patch disables all those clk gates which hold share count
before registering them, then the hardware status will match the
clk tree info.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c  |    6 ++++++
 arch/arm/mach-imx/clk-imx6sl.c |    2 ++
 arch/arm/mach-imx/clk-imx6sx.c |    6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 5951660..fe53473 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -369,6 +369,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 
 	/*                                            name             parent_name          reg         shift */
 	clk[IMX6QDL_CLK_APBH_DMA]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
+	/* make sure the initial clock gate setting of share_count is off */
+	writel_relaxed(readl_relaxed(base + 0x68) & (~(0x3 << 6)), base + 0x68);
 	clk[IMX6QDL_CLK_ASRC]         = imx_clk_gate2_shared("asrc",         "asrc_podf",   base + 0x68, 6, &share_count_asrc);
 	clk[IMX6QDL_CLK_ASRC_IPG]     = imx_clk_gate2_shared("asrc_ipg",     "ahb",         base + 0x68, 6, &share_count_asrc);
 	clk[IMX6QDL_CLK_ASRC_MEM]     = imx_clk_gate2_shared("asrc_mem",     "ahb",         base + 0x68, 6, &share_count_asrc);
@@ -385,6 +387,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	else
 		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
 	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
+	/* make sure the initial clock gate setting of share_count is off */
+	writel_relaxed(readl_relaxed(base + 0x6c) & (~(0x3 << 16)), base + 0x6c);
 	clk[IMX6QDL_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal",   "esai_podf",   base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ipg",           base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
@@ -443,6 +447,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_SDMA]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clk[IMX6QDL_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
 	clk[IMX6QDL_CLK_SPDIF]        = imx_clk_gate2("spdif",         "spdif_podf",        base + 0x7c, 14);
+	/* make sure the initial clock gate setting of share_count is off */
+	writel_relaxed(readl_relaxed(base + 0x7c) & (~(0x3f << 18)), base + 0x7c);
 	clk[IMX6QDL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",      "ipg",        base + 0x7c, 18, &share_count_ssi1);
 	clk[IMX6QDL_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",      "ipg",        base + 0x7c, 20, &share_count_ssi2);
 	clk[IMX6QDL_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",      "ipg",        base + 0x7c, 22, &share_count_ssi3);
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index e982ebe..6af14a8 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -396,6 +396,8 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_SDMA]         = imx_clk_gate2("sdma",         "ipg",               base + 0x7c, 6);
 	clks[IMX6SL_CLK_SPBA]         = imx_clk_gate2("spba",         "ipg",               base + 0x7c, 12);
 	clks[IMX6SL_CLK_SPDIF]        = imx_clk_gate2("spdif",        "spdif0_podf",       base + 0x7c, 14);
+	/* make sure the initial clock gate setting of share_count is off */
+	writel_relaxed(readl_relaxed(base + 0x7c) & (~(0x3f << 18)), base + 0x7c);
 	clks[IMX6SL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",     "ipg",        base + 0x7c, 18, &share_count_ssi1);
 	clks[IMX6SL_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",     "ipg",        base + 0x7c, 20, &share_count_ssi2);
 	clks[IMX6SL_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",     "ipg",        base + 0x7c, 22, &share_count_ssi3);
diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 17354a1..e42052e 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -379,6 +379,8 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_AIPS_TZ1]     = imx_clk_gate2("aips_tz1",      "ahb",               base + 0x68, 0);
 	clks[IMX6SX_CLK_AIPS_TZ2]     = imx_clk_gate2("aips_tz2",      "ahb",               base + 0x68, 2);
 	clks[IMX6SX_CLK_APBH_DMA]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
+	/* make sure the initial clock gate setting of share_count is off */
+	writel_relaxed(readl_relaxed(base + 0x68) & (~(0x3 << 6)), base + 0x68);
 	clks[IMX6SX_CLK_ASRC_MEM]     = imx_clk_gate2_shared("asrc_mem", "ahb",             base + 0x68, 6, &share_count_asrc);
 	clks[IMX6SX_CLK_ASRC_IPG]     = imx_clk_gate2_shared("asrc_ipg", "ahb",             base + 0x68, 6, &share_count_asrc);
 	clks[IMX6SX_CLK_CAAM_MEM]     = imx_clk_gate2("caam_mem",      "ahb",               base + 0x68, 8);
@@ -400,6 +402,8 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_ECSPI5]       = imx_clk_gate2("ecspi5",        "ecspi_podf",        base + 0x6c, 8);
 	clks[IMX6SX_CLK_EPIT1]        = imx_clk_gate2("epit1",         "perclk",            base + 0x6c, 12);
 	clks[IMX6SX_CLK_EPIT2]        = imx_clk_gate2("epit2",         "perclk",            base + 0x6c, 14);
+	/* make sure the initial clock gate setting of share_count is off */
+	writel_relaxed(readl_relaxed(base + 0x6c) & (~(0x3 << 16)), base + 0x6c);
 	clks[IMX6SX_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal", "esai_podf",     base + 0x6c, 16, &share_count_esai);
 	clks[IMX6SX_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
 	clks[IMX6SX_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem",   "ahb",           base + 0x6c, 16, &share_count_esai);
@@ -455,6 +459,8 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_ROM]          = imx_clk_gate2("rom",           "ahb",               base + 0x7c, 0);
 	clks[IMX6SX_CLK_SDMA]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clks[IMX6SX_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
+	/* make sure the initial clock gate setting of share_count is off */
+	writel_relaxed(readl_relaxed(base + 0x7c) & (~(0x3 << 14)) & (~(0x3f << 18)), base + 0x7c);
 	clks[IMX6SX_CLK_AUDIO]        = imx_clk_gate2_shared("audio",  "audio_podf",        base + 0x7c, 14, &share_count_audio);
 	clks[IMX6SX_CLK_SPDIF]        = imx_clk_gate2_shared("spdif",  "spdif_podf",        base + 0x7c, 14, &share_count_audio);
 	clks[IMX6SX_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",      "ipg",        base + 0x7c, 18, &share_count_ssi1);
-- 
1.7.9.5
