From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 16:21:39 +0200
Subject: [PATCH v3 37/41] xenbus: use virt_xxx barriers
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Message-ID: <1452426622-4471-38-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/xen/xenbus/xenbus_comms.c uses
full memory barriers to communicate with the other side.

For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
would be sufficient, so mb() and wmb() here are only needed if
a non-SMP guest runs on an SMP host.

Switch to virt_xxx barriers which serve this exact purpose.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Vrabel <david.vrabel@citrix.com>
---
 drivers/xen/xenbus/xenbus_comms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index fdb0f33..ecdecce 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -123,14 +123,14 @@ int xb_write(const void *data, unsigned len)
 			avail = len;
 
 		/* Must write data /after/ reading the consumer index. */
-		mb();
+		virt_mb();
 
 		memcpy(dst, data, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see new producer until data is there. */
-		wmb();
+		virt_wmb();
 		intf->req_prod += avail;
 
 		/* Implies mb(): other side will see the updated producer. */
@@ -180,14 +180,14 @@ int xb_read(void *data, unsigned len)
 			avail = len;
 
 		/* Must read data /after/ reading the producer index. */
-		rmb();
+		virt_rmb();
 
 		memcpy(data, src, avail);
 		data += avail;
 		len -= avail;
 
 		/* Other side must not see free space until we've copied out */
-		mb();
+		virt_mb();
 		intf->rsp_cons += avail;
 
 		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);
-- 
MST
