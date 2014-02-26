From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 26 Feb 2014 21:44:40 +0800
Subject: [PATCH 4/4] ARM: imx6: do not call imx6q_suspend_init() with
 !CONFIG_SUSPEND
In-Reply-To: <1393422280-22283-1-git-send-email-shawn.guo@linaro.org>
References: <1393422280-22283-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1393422280-22283-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_SUSPEND is not enabled, we should reasonably skip the call
to imx6q_suspend_init().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/pm-imx6q.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 2473ad4..16f0d24 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -516,10 +516,12 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 
 	WARN_ON(!ccm_base);
 
-	ret = imx6q_suspend_init(socdata);
-	if (ret)
-		pr_warn("%s: No DDR LPM support with suspend %d!\n",
-			__func__, ret);
+	if (IS_ENABLED(CONFIG_SUSPEND)) {
+		ret = imx6q_suspend_init(socdata);
+		if (ret)
+			pr_warn("%s: No DDR LPM support with suspend %d!\n",
+				__func__, ret);
+	}
 
 	/*
 	 * This is for SW workaround step #1 of ERR007265, see comments
-- 
1.7.9.5
