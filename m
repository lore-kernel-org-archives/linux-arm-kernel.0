From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 22 Dec 2015 12:27:35 +0800
Subject: [PATCH] [media] rc: sunxi-cir: Initialize the spinlock properly
Message-ID: <1450758455-22945-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver allocates the spinlock but fails to initialize it correctly.
The kernel reports a BUG indicating bad spinlock magic when spinlock
debugging is enabled.

Call spin_lock_init() on it to initialize it correctly.

Fixes: b4e3e59fb59c ("[media] rc: add sunxi-ir driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/media/rc/sunxi-cir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 7830aef3db45..40f77685cc4a 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -153,6 +153,8 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 	if (!ir)
 		return -ENOMEM;
 
+	spin_lock_init(&ir->ir_lock);
+
 	if (of_device_is_compatible(dn, "allwinner,sun5i-a13-ir"))
 		ir->fifo_size = 64;
 	else
-- 
2.6.4
