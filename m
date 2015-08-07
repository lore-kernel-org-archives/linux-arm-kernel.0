From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 7 Aug 2015 17:46:50 +0100
Subject: [PATCH v3 11/20] tty/hvc: xen: Use xen page definition
In-Reply-To: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1438966019-19322-12-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The console ring is always based on the page granularity of Xen.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linuxppc-dev at lists.ozlabs.org

    Changes in v3:
        - Some changes has been moved in the series "Use correctly the
        Xen memory terminologies in Linux".
        - Add Stefano's reviewed-by
---
 drivers/tty/hvc/hvc_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 10beb15..0599d9d 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
 	if (r < 0 || v == 0)
 		goto err;
 	gfn = v;
-	info->intf = xen_remap(gfn << PAGE_SHIFT, PAGE_SIZE);
+	info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, PAGE_SIZE);
 	if (info->intf == NULL)
 		goto err;
 	info->vtermno = HVC_COOKIE;
@@ -472,7 +472,7 @@ static int xencons_resume(struct xenbus_device *dev)
 	struct xencons_info *info = dev_get_drvdata(&dev->dev);
 
 	xencons_disconnect_backend(info);
-	memset(info->intf, 0, PAGE_SIZE);
+	memset(info->intf, 0, XEN_PAGE_SIZE);
 	return xencons_connect_backend(dev, info);
 }
 
-- 
2.1.4
