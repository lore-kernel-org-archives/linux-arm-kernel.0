From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  4 Apr 2017 13:32:18 +0100
Subject: [PATCH 1/2] [media] cec: Move capability check inside #if
Message-ID: <20170404123219.22040-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_RC_CORE is not enabled then none of the RC code will be
executed anyway, so we're placing the capability check inside the

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/media/cec/cec-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/cec-core.c b/drivers/media/cec/cec-core.c
index 37217e2..06a312c 100644
--- a/drivers/media/cec/cec-core.c
+++ b/drivers/media/cec/cec-core.c
@@ -234,10 +234,10 @@ struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
 		return ERR_PTR(res);
 	}
 
+#if IS_REACHABLE(CONFIG_RC_CORE)
 	if (!(caps & CEC_CAP_RC))
 		return adap;
 
-#if IS_REACHABLE(CONFIG_RC_CORE)
 	/* Prepare the RC input device */
 	adap->rc = rc_allocate_device(RC_DRIVER_SCANCODE);
 	if (!adap->rc) {
-- 
2.9.3
