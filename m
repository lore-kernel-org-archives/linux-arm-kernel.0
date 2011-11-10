From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:12 +0800
Subject: [PATCH 7/9] ARM: pm-imx5: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320900854-13031-7-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-mx5/pm-imx5.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/pm-imx5.c b/arch/arm/mach-mx5/pm-imx5.c
index 98052fc..9e8cfe5 100644
--- a/arch/arm/mach-mx5/pm-imx5.c
+++ b/arch/arm/mach-mx5/pm-imx5.c
@@ -22,7 +22,13 @@ static struct clk *gpc_dvfs_clk;
 
 static int mx5_suspend_prepare(void)
 {
-	return clk_enable(gpc_dvfs_clk);
+	int ret;
+	ret = clk_prepare(gpc_dvfs_clk);
+	if (!ret)
+		ret = clk_enable(gpc_dvfs_clk);
+	if (ret)
+		clk_unprepare(gpc_dvfs_clk);
+	return ret;
 }
 
 static int mx5_suspend_enter(suspend_state_t state)
@@ -53,6 +59,7 @@ static int mx5_suspend_enter(suspend_state_t state)
 static void mx5_suspend_finish(void)
 {
 	clk_disable(gpc_dvfs_clk);
+	clk_unprepare(gpc_dvfs_clk);
 }
 
 static int mx5_pm_valid(suspend_state_t state)
-- 
1.7.5.4
