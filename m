From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  9 Mar 2018 23:23:09 +0100
Subject: [PATCH v5 18/36] drm/bridge: analogix_dp: Reset aux channel if an
 error occurred
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Message-ID: <20180309222327.18689-19-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lin Huang <hl@rock-chips.com>

AUX errors are caused by many different reasons. We may not know what
happened in aux channel on failure, so let's reset aux channel if some
errors occurred.

Cc: ?? ? <wzz@rock-chips.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index dee1ba109b5f..7b7fd227e1f9 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -466,6 +466,10 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
 	reg = RPLY_RECEIV | AUX_ERR;
 	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA);
 
+	analogix_dp_set_analog_power_down(dp, AUX_BLOCK, true);
+	usleep_range(10, 11);
+	analogix_dp_set_analog_power_down(dp, AUX_BLOCK, false);
+
 	analogix_dp_reset_aux(dp);
 
 	/* Disable AUX transaction H/W retry */
@@ -1159,7 +1163,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 				 reg, !(reg & AUX_EN), 25, 500 * 1000);
 	if (ret) {
 		dev_err(dp->dev, "AUX CH enable timeout!\n");
-		return -ETIMEDOUT;
+		goto aux_error;
 	}
 
 	/* TODO: Wait for an interrupt instead of looping? */
@@ -1168,7 +1172,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 				 reg, reg & RPLY_RECEIV, 10, 20 * 1000);
 	if (ret) {
 		dev_err(dp->dev, "AUX CH cmd reply timeout!\n");
-		return -ETIMEDOUT;
+		goto aux_error;
 	}
 
 	/* Clear interrupt source for AUX CH command reply */
@@ -1178,7 +1182,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
 	if (reg & AUX_ERR) {
 		writel(AUX_ERR, dp->reg_base + ANALOGIX_DP_INT_STA);
-		return -EREMOTEIO;
+		goto aux_error;
 	}
 
 	/* Check AUX CH error access status */
@@ -1186,7 +1190,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 	if ((reg & AUX_STATUS_MASK)) {
 		dev_err(dp->dev, "AUX CH error happened: %d\n\n",
 			reg & AUX_STATUS_MASK);
-		return -EREMOTEIO;
+		goto aux_error;
 	}
 
 	if (msg->request & DP_AUX_I2C_READ) {
@@ -1212,4 +1216,10 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
 
 	return num_transferred > 0 ? num_transferred : -EBUSY;
+
+aux_error:
+	/* if aux err happen, reset aux */
+	analogix_dp_init_aux(dp);
+
+	return -EREMOTEIO;
 }
-- 
2.16.1
