From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:23 +0100
Subject: [PATCH v2 11/20] tty/hvc: xen: Use xen page definition
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-12-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The console ring is always based on the page granularity of Xen.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linuxppc-dev at lists.ozlabs.org
---
 drivers/tty/hvc/hvc_xen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index a9d837f..2135944 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
 	if (r < 0 || v == 0)
 		goto err;
 	mfn = v;
-	info->intf = xen_remap(mfn << PAGE_SHIFT, PAGE_SIZE);
+	info->intf = xen_remap(mfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
 	if (info->intf == NULL)
 		goto err;
 	info->vtermno = HVC_COOKIE;
@@ -392,7 +392,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 	if (xen_pv_domain())
 		mfn = virt_to_mfn(info->intf);
 	else
-		mfn = __pa(info->intf) >> PAGE_SHIFT;
+		mfn = __pa(info->intf) >> XEN_PAGE_SHIFT;
 	ret = gnttab_alloc_grant_references(1, &gref_head);
 	if (ret < 0)
 		return ret;
@@ -476,7 +476,7 @@ static int xencons_resume(struct xenbus_device *dev)
 	struct xencons_info *info = dev_get_drvdata(&dev->dev);
 
 	xencons_disconnect_backend(info);
-	memset(info->intf, 0, PAGE_SIZE);
+	memset(info->intf, 0, XEN_PAGE_SIZE);
 	return xencons_connect_backend(dev, info);
 }
 
-- 
2.1.4
