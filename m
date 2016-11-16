From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 16 Nov 2016 08:13:39 +0800
Subject: [PATCH] drm/bridge: analogix_dp: return error if transfer none byte
Message-ID: <1479255219-7243-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference from drm_dp_aux description (about transfer):
Upon success, the implementation should return the number of payload bytes
that were transferred, or a negative error-code on failure. Helpers
propagate errors from the .transfer() function, with the exception of
the -EBUSY error, which causes a transaction to be retried. On a short,
helpers will return -EPROTO to make it simpler to check for failure.

The analogix_dp_transfer will return num_transferred, but if there is none
byte been transferred, the return value will be 0, which means success, we
should return error-code if transfer none byte.

for (retry = 0; retry < 32; retry++) {
	err = aux->transfer(aux, &msg);
	if (err < 0) {
		if (err == -EBUSY)
			continue;

		goto unlock;
	}
}

Cc: zain wang <wzz@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index cd37ac0..303083a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1162,5 +1162,5 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 		 (msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_READ)
 		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
 
-	return num_transferred;
+	return num_transferred > 0 ? num_transferred : -EBUSY;
 }
-- 
1.9.1
