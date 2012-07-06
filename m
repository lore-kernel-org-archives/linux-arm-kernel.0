From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 06 Jul 2012 13:56:54 +0900
Subject: [PATCH 3/3] hwspinlock/core: allow hwspinlock_device to have
 bank-specific private data
In-Reply-To: <4FF66FBD.5090601@renesas.com>
References: <4FF66FBD.5090601@renesas.com>
Message-ID: <4FF67016.1000806@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It would be useful, for example, to save ioremap()ed 'io_base' address,
when a platform-specific driver uses 'priv' in 'struct hwspinlock' for
something different.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/hwspinlock/hwspinlock_internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index c60318c..dc7e522 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -57,6 +57,9 @@ struct hwspinlock {
  * @ops: platform-specific hwspinlock handlers
  * @base_id: id index of the first lock in this device
  * @num_locks: number of locks in this device
+ * @bank_data: private data which can be shared across 'struct hwspinlock'
+ *	       instances in this device, owned by the underlying platform-
+ *	       specific hwspinlock driver
  * @lock: dynamically allocated array of 'struct hwspinlock' (must be placed
  *	  at the end of the hwspinlock_device)
  */
@@ -65,6 +68,7 @@ struct hwspinlock_device {
 	const struct hwspinlock_ops *ops;
 	int base_id;
 	int num_locks;
+	void *bank_data;
 	struct hwspinlock lock[0];
 };
 
-- 
1.7.11.1
