From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  4 Apr 2017 13:32:19 +0100
Subject: [PATCH 2/2] [media] cec: Fix runtime BUG when (CONFIG_RC_CORE &&
 !CEC_CAP_RC)
In-Reply-To: <20170404123219.22040-1-lee.jones@linaro.org>
References: <20170404123219.22040-1-lee.jones@linaro.org>
Message-ID: <20170404123219.22040-2-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently when the RC Core is enabled (reachable) core code located
in cec_register_adapter() attempts to populate the RC structure with
a pointer to the 'parent' passed in by the caller.

Unfortunately if the caller did not specify RC capibility when calling
cec_allocate_adapter(), then there will be no RC structure to populate.

This causes a "NULL pointer dereference" error.

Fixes: f51e80804f0 ("[media] cec: pass parent device in register(), not allocate()")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/media/cec/cec-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/cec-core.c b/drivers/media/cec/cec-core.c
index 06a312c..d64937b 100644
--- a/drivers/media/cec/cec-core.c
+++ b/drivers/media/cec/cec-core.c
@@ -286,8 +286,8 @@ int cec_register_adapter(struct cec_adapter *adap,
 	adap->devnode.dev.parent = parent;
 
 #if IS_REACHABLE(CONFIG_RC_CORE)
-	adap->rc->dev.parent = parent;
 	if (adap->capabilities & CEC_CAP_RC) {
+		adap->rc->dev.parent = parent;
 		res = rc_register_device(adap->rc);
 
 		if (res) {
-- 
2.9.3
