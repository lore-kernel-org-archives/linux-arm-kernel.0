From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 15 Apr 2014 19:34:29 +0200
Subject: [PATCH 2/5] exynos4-is: Fix compilation for !CONFIG_COMMON_CLK
In-Reply-To: <1397583272-28295-1-git-send-email-s.nawrocki@samsung.com>
References: <1397583272-28295-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1397583272-28295-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_COMMON_CLK is not enabled on S5PV210 platform, so include
some clk API data structures conditionally to avoid compilation
errors. These #ifdefs will be removed for next kernel release,
when the S5PV210 platform moves to DT and the common clk API.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/media/platform/exynos4-is/media-dev.c |    2 +-
 drivers/media/platform/exynos4-is/media-dev.h |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 2a2d42e..002abbf 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -1523,7 +1523,7 @@ err:
 }
 #else
 #define fimc_md_register_clk_provider(fmd) (0)
-#define fimc_md_unregister_clk_provider(fmd) (0)
+#define fimc_md_unregister_clk_provider(fmd)
 #endif
 
 static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
diff --git a/drivers/media/platform/exynos4-is/media-dev.h b/drivers/media/platform/exynos4-is/media-dev.h
index ee1e251..58c4945 100644
--- a/drivers/media/platform/exynos4-is/media-dev.h
+++ b/drivers/media/platform/exynos4-is/media-dev.h
@@ -94,7 +94,9 @@ struct fimc_sensor_info {
 };
 
 struct cam_clk {
+#ifdef CONFIG_COMMON_CLK
 	struct clk_hw hw;
+#endif
 	struct fimc_md *fmd;
 };
 #define to_cam_clk(_hw) container_of(_hw, struct cam_clk, hw)
@@ -142,7 +144,9 @@ struct fimc_md {
 
 	struct cam_clk_provider {
 		struct clk *clks[FIMC_MAX_CAMCLKS];
+#ifdef CONFIG_COMMON_CLK
 		struct clk_onecell_data clk_data;
+#endif
 		struct device_node *of_node;
 		struct cam_clk camclk[FIMC_MAX_CAMCLKS];
 		int num_clocks;
-- 
1.7.9.5
