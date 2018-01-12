From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Jan 2018 14:38:12 +0100
Subject: [PATCH 2/3] soc: brcmstb: Do not fail initcalls on non-STB platforms
In-Reply-To: <20180112133813.3716-1-thierry.reding@gmail.com>
References: <20180112133813.3716-1-thierry.reding@gmail.com>
Message-ID: <20180112133813.3716-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

If the early initcalls are run on non-STB platforms, abort early with a
return value of 0. This avoids getting this expected behaviour flagged
as a failure.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/bcm/brcmstb/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 816a0f55a9ea..32478628bcb3 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -74,7 +74,7 @@ static int __init brcmstb_soc_device_early_init(void)
 
 	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
 	if (!sun_top_ctrl)
-		return -ENODEV;
+		return 0;
 
 	sun_top_ctrl_base = of_iomap(sun_top_ctrl, 0);
 	if (!sun_top_ctrl_base) {
@@ -100,7 +100,7 @@ static int __init brcmstb_soc_device_init(void)
 
 	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
 	if (!sun_top_ctrl)
-		return -ENODEV;
+		return 0;
 
 	of_node_put(sun_top_ctrl);
 
-- 
2.15.1
