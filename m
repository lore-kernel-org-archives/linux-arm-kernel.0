From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 23:16:42 +0100
Subject: [PATCH 2/9] Revert parts of "hlist: drop the node parameter from
 iterators"
In-Reply-To: <1362521809-22989-1-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
Message-ID: <1362521809-22989-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b67bfe0d42 "hlist: drop the node parameter from iterators"
did a lot of nice changes but also contains two small hunks that
seem to have slipped in accidentally and have no apparent
connection to the intent of the patch.

This reverts the two extraneous changes.

Cc: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/smpboot.c      | 2 +-
 net/9p/trans_virtio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index b9bde57..d4abac2 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -131,7 +131,7 @@ static int smpboot_thread_fn(void *data)
 			continue;
 		}
 
-		//BUG_ON(td->cpu != smp_processor_id());
+		BUG_ON(td->cpu != smp_processor_id());
 
 		/* Check for state change setup */
 		switch (td->status) {
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 74dea37..de2e950 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -655,7 +655,7 @@ static struct p9_trans_module p9_virtio_trans = {
 	.create = p9_virtio_create,
 	.close = p9_virtio_close,
 	.request = p9_virtio_request,
-	//.zc_request = p9_virtio_zc_request,
+	.zc_request = p9_virtio_zc_request,
 	.cancel = p9_virtio_cancel,
 	/*
 	 * We leave one entry for input and one entry for response
-- 
1.8.1.2
