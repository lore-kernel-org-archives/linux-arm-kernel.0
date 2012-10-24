From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 24 Oct 2012 16:37:34 +0200
Subject: [PATCH 1/4] ARM: EXYNOS: Skip wakeup-int setup if pinctrl driver is
 used on Exynos4x12
In-Reply-To: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
Message-ID: <1351089457-8205-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the old wakeup interrupt initialization code to
detect pinctrl driver by using for_each_matching_node instead of
for_each_compatible_node and adds match table for both Exynos4210 and
Exynos4x12.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index cb891a7..109f878 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -1032,11 +1032,14 @@ static int __init exynos_init_irq_eint(void)
 	 * platforms switch over to using the pinctrl driver, the wakeup
 	 * interrupt support code here can be completely removed.
 	 */
+	static const struct of_device_id exynos_pinctrl_ids[] = {
+		{ .compatible = "samsung,pinctrl-exynos4210", },
+		{ .compatible = "samsung,pinctrl-exynos4x12", },
+	};
 	struct device_node *pctrl_np, *wkup_np;
-	const char *pctrl_compat = "samsung,pinctrl-exynos4210";
 	const char *wkup_compat = "samsung,exynos4210-wakeup-eint";
 
-	for_each_compatible_node(pctrl_np, NULL, pctrl_compat) {
+	for_each_matching_node(pctrl_np, exynos_pinctrl_ids) {
 		if (of_device_is_available(pctrl_np)) {
 			wkup_np = of_find_compatible_node(pctrl_np, NULL,
 							wkup_compat);
-- 
1.7.12
