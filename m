From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 16:21:56 +0200
Subject: [PATCH v3 39/41] xen/events: use virt_xxx barriers
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Message-ID: <1452426622-4471-40-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/xen/events/events_fifo.c uses rmb() to communicate with the
other side.

For guests compiled with CONFIG_SMP, smp_rmb would be sufficient, so
rmb() here is only needed if a non-SMP guest runs on an SMP host.

Switch to the virt_rmb barrier which serves this exact purpose.

Pull in asm/barrier.h here to make sure the file is self-contained.

Suggested-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/xen/events/events_fifo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 96a1b8d..eff2b88 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -41,6 +41,7 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 
+#include <asm/barrier.h>
 #include <asm/sync_bitops.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
@@ -296,7 +297,7 @@ static void consume_one_event(unsigned cpu,
 	 * control block.
 	 */
 	if (head == 0) {
-		rmb(); /* Ensure word is up-to-date before reading head. */
+		virt_rmb(); /* Ensure word is up-to-date before reading head. */
 		head = control_block->head[priority];
 	}
 
-- 
MST
