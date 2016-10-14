From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 14 Oct 2016 15:44:05 -0300
Subject: [PATCH] clk: samsung: clk-exynos-audss: Fix module autoload
Message-ID: <1476470645-22159-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/clk/samsung/clk-exynos-audss.ko | grep alias
alias:          platform:exynos-audss-clk

After this patch:

$ modinfo drivers/clk/samsung/clk-exynos-audss.ko | grep alias
alias:          platform:exynos-audss-clk
alias:          of:N*T*Csamsung,exynos5420-audss-clockC*
alias:          of:N*T*Csamsung,exynos5420-audss-clock
alias:          of:N*T*Csamsung,exynos5410-audss-clockC*
alias:          of:N*T*Csamsung,exynos5410-audss-clock
alias:          of:N*T*Csamsung,exynos5250-audss-clockC*
alias:          of:N*T*Csamsung,exynos5250-audss-clock
alias:          of:N*T*Csamsung,exynos4210-audss-clockC*
alias:          of:N*T*Csamsung,exynos4210-audss-clock

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/clk/samsung/clk-exynos-audss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 51d152f735cc..17e68a724945 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -106,6 +106,7 @@ static const struct of_device_id exynos_audss_clk_of_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, exynos_audss_clk_of_match);
 
 static void exynos_audss_clk_teardown(void)
 {
-- 
2.7.4
