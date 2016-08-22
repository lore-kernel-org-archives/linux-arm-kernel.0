From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 23 Aug 2016 01:03:20 +0800
Subject: [PATCH] ARM: imx6: enable WAIT mode hardware workaround for imx6sx
Message-ID: <1471885400-9140-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need to enable INT_MEM_CLK_LPM bit in CCM_CGPR for WAIT mode,
without this bit set, if there is pending interrupt during
ARM platform entering WAIT mode without power gating, cache
data will be corrupted, this is a hardware workaround for WAIT
mode and must be enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 3c6672b..41cdce6 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -90,6 +90,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
 
 int __init imx6sx_cpuidle_init(void)
 {
+	imx6q_set_int_mem_clk_lpm(true);
 	imx6_enable_rbc(false);
 	/*
 	 * set ARM power up/down timing to the fastest,
-- 
1.9.1
