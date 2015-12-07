From: ykk@rock-chips.com (Yakir Yang)
Date: Mon,  7 Dec 2015 14:41:06 +0800
Subject: [PATCH v10 17/17] drm: bridge: analogix/dp: expand the look time for
 waiting AUX CH reply
In-Reply-To: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
References: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1449470466-31649-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After test on rockchiop platform, i found sometims driver would failed
at reading EDID message. After debugging more, i found that it's okay
to read_a byte from i2c, but it would failed at AUX transcation if we
try to ready multi-bytes from i2c.

Driver just can't received the AUX CH reply command, even no AUX error
code. I may guess that the AUX wait time is not enough, so I try to
expand the AUX wait time, and i do see this could fix the EDID read
failed at rockchip platform.

And I thought that expand the wait time won't hurt Exynos platform too
much, cause Exynos didn't have this problem, then driver would received
the reply command very soon, so no more additional wait time would bring
to Exynos platform.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index c7e2959..dc376bd 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -482,7 +482,7 @@ int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
 	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
 	while (!(reg & RPLY_RECEIV)) {
 		timeout_loop++;
-		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
+		if (DP_TIMEOUT_LOOP_COUNT * 10 < timeout_loop) {
 			dev_err(dp->dev, "AUX CH command reply failed!\n");
 			return -ETIMEDOUT;
 		}
-- 
1.9.1
