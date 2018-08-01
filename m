From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  1 Aug 2018 11:48:33 +0200
Subject: [PATCH] tee: optee: take DT status property into account
Message-ID: <20180801094833.8361-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes may have a 'status' property which, if set to anything other
than 'ok' or 'okay', indicates to the OS that the DT node should be
treated as if it was not present. So add that missing logic to the
OP-TEE driver.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/tee/optee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e5fd5ed217da..69ea1efbb051 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -696,7 +696,7 @@ static int __init optee_driver_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, optee_match);
-	if (!np)
+	if (!np || !of_device_is_available(np))
 		return -ENODEV;
 
 	optee = optee_probe(np);
-- 
2.18.0
