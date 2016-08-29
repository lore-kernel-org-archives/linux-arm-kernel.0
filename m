From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 29 Aug 2016 21:49:57 +0800
Subject: [PATCH V2 2/2] ARM: imx: enable WAIT mode hardware workaround for
 imx6sx
In-Reply-To: <1472478597-6731-1-git-send-email-Anson.Huang@nxp.com>
References: <1472478597-6731-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1472478597-6731-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need to enable INT_MEM_CLK_LPM bit in CCM_CGPR for WAIT mode,
without this bit set, if there is pending interrupt during
ARM platform entering WAIT mode without power gating, cache
data will be corrupted, this is a hardware workaround for WAIT
mode and must be enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	function name is changed in 1/2 patch, change it accordingly.
 arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 3c6672b..261aaa4 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -90,6 +90,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
 
 int __init imx6sx_cpuidle_init(void)
 {
+	imx6_set_int_mem_clk_lpm(true);
 	imx6_enable_rbc(false);
 	/*
 	 * set ARM power up/down timing to the fastest,
-- 
1.9.1
