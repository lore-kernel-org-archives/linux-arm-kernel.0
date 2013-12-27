From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 26 Dec 2013 16:44:27 -0800
Subject: [PATCH 7/7] clk: tegra: use max divider if divider overflows
In-Reply-To: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
References: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
Message-ID: <1388105067-24438-8-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When requesting a rate less than the minimum clock rate for a divider,
use the maximum divider value instead of bailing out with an error.
This matches the behavior of the generic clock divider.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/tegra/clk-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 4d75b1f..290f9c1 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -59,7 +59,7 @@ static int get_div(struct tegra_clk_frac_div *divider, unsigned long rate,
 		return 0;
 
 	if (divider_ux1 > get_max_div(divider))
-		return -EINVAL;
+		return get_max_div(divider);
 
 	return divider_ux1;
 }
-- 
1.8.5.1
