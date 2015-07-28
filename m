From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 28 Jul 2015 07:20:03 +0200
Subject: [PATCH 6/7] usb: gadget: apply generic altsetting support check
 mechanism
In-Reply-To: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
References: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438060804-21706-7-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace calls of gadget_supports_altsettings() function (which check altset
support by comparing UDC controller name with hardcoded names) with
gadget_is_altset_supported() which checks generic quirk bitfield.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/function/f_obex.c  | 2 +-
 drivers/usb/gadget/function/u_ether.h | 2 +-
 drivers/usb/gadget/legacy/nokia.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_obex.c b/drivers/usb/gadget/function/f_obex.c
index 5519f85..2682d59 100644
--- a/drivers/usb/gadget/function/f_obex.c
+++ b/drivers/usb/gadget/function/f_obex.c
@@ -297,7 +297,7 @@ static inline bool can_support_obex(struct usb_configuration *c)
 	 *
 	 * Altsettings are mandatory, however...
 	 */
-	if (!gadget_supports_altsettings(c->cdev->gadget))
+	if (!gadget_is_altset_supported(c->cdev->gadget))
 		return false;
 
 	/* everything else is *probably* fine ... */
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 334b3894..1384f00 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -259,7 +259,7 @@ void gether_disconnect(struct gether *);
 /* Some controllers can't support CDC Ethernet (ECM) ... */
 static inline bool can_support_ecm(struct usb_gadget *gadget)
 {
-	if (!gadget_supports_altsettings(gadget))
+	if (!gadget_is_altset_supported(gadget))
 		return false;
 
 	/* Everything else is *presumably* fine ... but this is a bit
diff --git a/drivers/usb/gadget/legacy/nokia.c b/drivers/usb/gadget/legacy/nokia.c
index 8902f45..264c97e 100644
--- a/drivers/usb/gadget/legacy/nokia.c
+++ b/drivers/usb/gadget/legacy/nokia.c
@@ -292,7 +292,7 @@ static int nokia_bind(struct usb_composite_dev *cdev)
 	nokia_config_500ma_driver.iConfiguration = status;
 	nokia_config_100ma_driver.iConfiguration = status;
 
-	if (!gadget_supports_altsettings(gadget)) {
+	if (!gadget_is_altset_supported(gadget)) {
 		status = -ENODEV;
 		goto err_usb;
 	}
-- 
1.9.1
