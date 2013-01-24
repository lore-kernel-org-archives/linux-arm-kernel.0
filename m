From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:46:08 +0200
Subject: [RFC/PATCH 30/32] usb: chipidea: register debugging syfs on our device
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-31-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't register anything non-generic under
the gadget's device as we don't really *own*
it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/chipidea/udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2f45bba..f64fbea 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1767,7 +1767,7 @@ static int udc_start(struct ci13xxx *ci)
 		goto put_transceiver;
 	}
 
-	retval = dbg_create_files(&ci->gadget.dev);
+	retval = dbg_create_files(ci->dev);
 	if (retval)
 		goto unreg_device;
 
@@ -1796,7 +1796,7 @@ remove_trans:
 
 	dev_err(dev, "error = %i\n", retval);
 remove_dbg:
-	dbg_remove_files(&ci->gadget.dev);
+	dbg_remove_files(ci->dev);
 unreg_device:
 	device_unregister(&ci->gadget.dev);
 put_transceiver:
@@ -1836,7 +1836,7 @@ static void udc_stop(struct ci13xxx *ci)
 		if (ci->global_phy)
 			usb_put_phy(ci->transceiver);
 	}
-	dbg_remove_files(&ci->gadget.dev);
+	dbg_remove_files(ci->dev);
 	device_unregister(&ci->gadget.dev);
 	/* my kobject is dynamic, I swear! */
 	memset(&ci->gadget, 0, sizeof(ci->gadget));
-- 
1.8.1.rc1.5.g7e0651a
