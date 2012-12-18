From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 19 Dec 2012 06:34:03 +1300
Subject: [PATCH RESEND 1/6] clk: omap: Fix incorrect usage of IS_ERR_OR_NULL
In-Reply-To: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1355852048-23188-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend to include mailing lists.

Replace IS_ERR_OR_NULL with IS_ERR on clk_get results.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 938b50a..e5e150d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -143,7 +143,7 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
 		timer->fclk = clk_get(&timer->pdev->dev, "fck");
-		if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
+		if (WARN_ON_ONCE(IS_ERR(timer->fclk))) {
 			timer->fclk = NULL;
 			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
 			return -EINVAL;
@@ -418,7 +418,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 		return pdata->set_timer_src(timer->pdev, source);
 
 	fclk = clk_get(&timer->pdev->dev, "fck");
-	if (IS_ERR_OR_NULL(fclk)) {
+	if (IS_ERR(fclk)) {
 		pr_err("%s: fck not found\n", __func__);
 		return -EINVAL;
 	}
@@ -438,7 +438,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	}
 
 	parent = clk_get(&timer->pdev->dev, parent_name);
-	if (IS_ERR_OR_NULL(parent)) {
+	if (IS_ERR(parent)) {
 		pr_err("%s: %s not found\n", __func__, parent_name);
 		ret = -EINVAL;
 		goto out;
-- 
1.7.9.5
