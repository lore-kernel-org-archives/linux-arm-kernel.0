From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 16 Apr 2012 18:37:48 -0500
Subject: [PATCH] ARM: imx: Fix imx5 idle logic bug
Message-ID: <1334619468-25680-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx5_idle() check of the tzic_eanble_wake() return value uses
incorrect (inverted) logic causing all attempt to idle to fail.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-imx/mm-imx5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 05250ae..e10f391 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -35,7 +35,7 @@ static void imx5_idle(void)
 	}
 	clk_enable(gpc_dvfs_clk);
 	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
-	if (tzic_enable_wake() != 0)
+	if (!tzic_enable_wake())
 		cpu_do_idle();
 	clk_disable(gpc_dvfs_clk);
 }
-- 
1.7.10
