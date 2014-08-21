From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 21 Aug 2014 17:24:45 +0800
Subject: [PATCH v2 3/3] [media] rc: remove change_protocol in rc-ir-raw.c
In-Reply-To: <1408613086-12538-1-git-send-email-zhangfei.gao@linaro.org>
References: <1408613086-12538-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1408613086-12538-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 4924a311a62f ("[media] rc-core: rename ir-raw.c"),
empty change_protocol was introduced.
As a result, rc_register_device will set dev->enabled_protocols
addording to rc_map->rc_type, which prevent using all protocols.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/media/rc/rc-ir-raw.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index e8fff2a..a118539 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -240,12 +240,6 @@ ir_raw_get_allowed_protocols(void)
 	return protocols;
 }
 
-static int change_protocol(struct rc_dev *dev, u64 *rc_type)
-{
-	/* the caller will update dev->enabled_protocols */
-	return 0;
-}
-
 /*
  * Used to (un)register raw event clients
  */
@@ -263,7 +257,6 @@ int ir_raw_event_register(struct rc_dev *dev)
 
 	dev->raw->dev = dev;
 	dev->enabled_protocols = ~0;
-	dev->change_protocol = change_protocol;
 	rc = kfifo_alloc(&dev->raw->kfifo,
 			 sizeof(struct ir_raw_event) * MAX_IR_EVENT_SIZE,
 			 GFP_KERNEL);
-- 
1.7.9.5
