From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  8 Mar 2017 10:27:55 +0800
Subject: [PATCH 1/3] drm/rockchip: cdn-dp: return error code when clk_get_rate
 failed
In-Reply-To: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
References: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1488940077-22297-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_get_rate return 0 if something goes wrong, so it can never be
less then zero, the ret should be set a error code, otherwise the
cdn_dp_clk_enable will return 0 when it failed at clk_get_rate.
In addition, clk_get_rate() returns an "unsigned long", so use
"unsigned long" instead of "u32" is better.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 5 +++--
 drivers/gpu/drm/rockchip/cdn-dp-reg.c  | 2 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index fd79a70..9edb8dc 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -94,7 +94,7 @@ static int cdn_dp_grf_write(struct cdn_dp_device *dp,
 static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 {
 	int ret;
-	u32 rate;
+	unsigned long rate;
 
 	ret = clk_prepare_enable(dp->pclk);
 	if (ret < 0) {
@@ -123,7 +123,8 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 
 	rate = clk_get_rate(dp->core_clk);
 	if (!rate) {
-		DRM_DEV_ERROR(dp->dev, "get clk rate failed: %d\n", rate);
+		DRM_DEV_ERROR(dp->dev, "get clk rate failed\n");
+		ret = -EINVAL;
 		goto err_set_rate;
 	}
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 319dbba..963d8ab 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -29,7 +29,7 @@
 #define LINK_TRAINING_RETRY_MS		20
 #define LINK_TRAINING_TIMEOUT_MS	500
 
-void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, u32 clk)
+void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, unsigned long clk)
 {
 	writel(clk / 1000000, dp->regs + SW_CLK_H);
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index b5f2153..3507be3 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -462,7 +462,7 @@ enum vic_bt_type {
 
 void cdn_dp_clock_reset(struct cdn_dp_device *dp);
 
-void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, u32 clk);
+void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, unsigned long clk);
 int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
 			 u32 i_size, const u32 *d_mem, u32 d_size);
 int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable);
-- 
2.6.3
