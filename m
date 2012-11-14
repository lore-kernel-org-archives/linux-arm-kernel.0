From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 15 Nov 2012 03:37:33 +0530
Subject: [PATCH v3 11/11] ARM: Exynos: add support for mct clock setup
In-Reply-To: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
References: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1352930853-12268-12-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for mct clock lookup and setup to ensure that the mct clock
is has been turned on.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mct.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 47bc6b35..09815a9 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -489,7 +489,12 @@ static struct local_timer_ops exynos4_mct_tick_ops __cpuinitdata = {
 
 static void __init exynos4_timer_resources(struct device_node *np)
 {
-	struct clk *tick_clk;
+	struct clk *mct_clk, *tick_clk;
+
+	mct_clk = clk_get(NULL, "mct");
+	if (IS_ERR(mct_clk))
+		panic("%s: unable to retrieve mct clock instance\n", __func__);
+	clk_prepare_enable(mct_clk);
 
 	tick_clk = clk_get(NULL, "fin_pll");
 	if (IS_ERR(tick_clk))
-- 
1.7.4.4
