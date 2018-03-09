From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  9 Mar 2018 23:22:59 +0100
Subject: [PATCH v5 08/36] drm/bridge: analogix_dp: Check AUX_EN status when
 doing AUX transfer
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Message-ID: <20180309222327.18689-9-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lin Huang <hl@rock-chips.com>

We should check AUX_EN bit to confirm the AUX CH operation is completed.

Cc: St?phane Marchesin <marcheu@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 25 +++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 9df2f3ef000c..e78c861b9e06 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1073,9 +1073,9 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 {
 	u32 reg;
 	u8 *buffer = msg->buffer;
-	int timeout_loop = 0;
 	unsigned int i;
 	int num_transferred = 0;
+	int ret;
 
 	/* Buffer size of AUX CH is 16 bytes */
 	if (WARN_ON(msg->size > 16))
@@ -1139,17 +1139,20 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 
 	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
 
-	/* Is AUX CH command reply received? */
+	ret = readx_poll_timeout(readl, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2,
+				 reg, !(reg & AUX_EN), 25, 500 * 1000);
+	if (ret) {
+		dev_err(dp->dev, "AUX CH enable timeout!\n");
+		return -ETIMEDOUT;
+	}
+
 	/* TODO: Wait for an interrupt instead of looping? */
-	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-	while (!(reg & RPLY_RECEIV)) {
-		timeout_loop++;
-		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
-			dev_err(dp->dev, "AUX CH command reply failed!\n");
-			return -ETIMEDOUT;
-		}
-		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
-		usleep_range(10, 11);
+	/* Is AUX CH command reply received? */
+	ret = readx_poll_timeout(readl, dp->reg_base + ANALOGIX_DP_INT_STA,
+				 reg, reg & RPLY_RECEIV, 10, 20 * 1000);
+	if (ret) {
+		dev_err(dp->dev, "AUX CH cmd reply timeout!\n");
+		return -ETIMEDOUT;
 	}
 
 	/* Clear interrupt source for AUX CH command reply */
-- 
2.16.1
