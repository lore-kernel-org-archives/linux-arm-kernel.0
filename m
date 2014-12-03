From: bisson.gary@gmail.com (Gary Bisson)
Date: Wed,  3 Dec 2014 15:03:51 -0800
Subject: [PATCH v2] ARM: clk-imx6q: fix video divider for rev T0 1.0
Message-ID: <1417647831-30261-1-git-send-email-bisson.gary@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The post dividers do not work on i.MX6Q rev T0 1.0 so they must be fixed
to 1. As the table index was wrong, a divider a of 4 could still be
requested which implied the clock not to be set properly. This is the
root cause of the HDMI not working at high resolution on rev T0 1.0 of
the SoC.

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
---
Changes v1->v2:
- Remove error trace in commit log as it only appears on FSL kernels
(suggested by Fabio)

This patch has been tested with a Sabrelite rev D (5-9-12).

However I've realized this patch doesn't fix the HDMI at 1080p60 but only
resolutions up to 1080p30. As mainline kernel is forcing the highest
resolution supported by the monitor it might not work on 1080p60-enable
displays. This latter issue is being investigated.

This patch is being integrated into meta-fsl-arm. Fabio suggested to
submit this patch already as clearly the array index is currently
wrong and "Better to have some HDMI then no HDMI at all":
https://lists.yoctoproject.org/pipermail/meta-freescale/2014-December/011796.html

Thanks,
Gary
---
 arch/arm/mach-imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4e79da7..2aa1b67 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -144,7 +144,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		post_div_table[1].div = 1;
 		post_div_table[2].div = 1;
 		video_div_table[1].div = 1;
-		video_div_table[2].div = 1;
+		video_div_table[3].div = 1;
 	};
 
 	clk[IMX6QDL_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src", base + 0x00, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-- 
2.1.3
