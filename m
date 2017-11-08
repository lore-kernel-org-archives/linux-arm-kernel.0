From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  8 Nov 2017 14:07:52 +0100
Subject: [PATCH] optee: fix invalid of_node_put() in optee_driver_init()
Message-ID: <1510146472-24069-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first node supplied to of_find_matching_node() has its reference
counter decreased as part of call to that function. In optee_driver_init()
after calling of_find_matching_node() it's invalid to call of_node_put() on
the supplied node again.

So remove the invalid call to of_node_put().

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 58169e519422..18c8c0a50d37 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -589,7 +589,6 @@ static int __init optee_driver_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, optee_match);
-	of_node_put(fw_np);
 	if (!np)
 		return -ENODEV;
 
-- 
2.7.4
