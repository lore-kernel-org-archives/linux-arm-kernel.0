From: s-anna@ti.com (Suman Anna)
Date: Wed, 30 Apr 2014 19:34:34 -0500
Subject: [PATCHv5 RFC 13/15] hwspinlock/omap: use OF helper to get reserved
 locks
In-Reply-To: <1398904476-26200-1-git-send-email-s-anna@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
Message-ID: <1398904476-26200-14-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Retrieve the number of reserved locks for OMAP by using the
of_hwspin_lock_get_num_reserved_locks() OF helper function
provided by the hwspinlock core. The range sanity check will
be performed by the hwspinlock core during the registration.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 1d0c78e..0dad783 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -143,6 +143,12 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
 		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
+	reserved_locks = of_hwspin_lock_get_num_reserved_locks(node);
+	if (reserved_locks < 0) {
+		ret = -EINVAL;
+		goto iounmap_base;
+	}
+
 	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
 					base_id, num_locks, reserved_locks);
 	if (ret)
-- 
1.9.2
