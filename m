From: peng.fan@nxp.com (Peng Fan)
Date: Sat, 30 Dec 2017 21:53:18 +0800
Subject: [PATCH 1/2] ARM: imx: no unmask/mask GINT for WAIT_CLOCKED
Message-ID: <1514641999-20521-1-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WAIT_CLOCKED is for RUN mode, there is no need to unmask/mask
IRQ32 in GPC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 This is to upstream patch:
 http://git.freescale.com/git/cgit.cgi/imx/linux-imx.git/commit/?h=imx_4.9.11_1.0.0_ga&id=0d980646ee068b92db71fd5e4e4efcbc33749cbd

 arch/arm/mach-imx/pm-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 153a0afc7645..56bfd9b5229e 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -337,9 +337,11 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 	 *
 	 * Note that IRQ #32 is GIC SPI #0.
 	 */
-	imx_gpc_hwirq_unmask(0);
+	if (mode != WAIT_CLOCKED)
+		imx_gpc_hwirq_unmask(0);
 	writel_relaxed(val, ccm_base + CLPCR);
-	imx_gpc_hwirq_mask(0);
+	if (mode != WAIT_CLOCKED)
+		imx_gpc_hwirq_mask(0);
 
 	return 0;
 }
-- 
2.14.1
