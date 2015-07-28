From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 28 Jul 2015 07:20:02 +0200
Subject: [PATCH 5/7] usb: gadget: f_ecm/f_ncm: check quirk instead of UDC name
In-Reply-To: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
References: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438060804-21706-6-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic mechanism to check if UDC controller supports zlp.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/function/f_ecm.c | 4 ++--
 drivers/usb/gadget/function/f_ncm.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 798760f..7b7424f 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -585,8 +585,8 @@ static int ecm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			/* Enable zlps by default for ECM conformance;
 			 * override for musb_hdrc (avoids txdma ovhead).
 			 */
-			ecm->port.is_zlp_ok = !(gadget_is_musbhdrc(cdev->gadget)
-				);
+			ecm->port.is_zlp_ok =
+				gadget_is_zlp_supported(cdev->gadget);
 			ecm->port.cdc_filter = DEFAULT_FILTER;
 			DBG(cdev, "activate ecm\n");
 			net = gether_connect(&ecm->port);
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index bdcda9f..3f05c6bd 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -853,9 +853,8 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			/* Enable zlps by default for NCM conformance;
 			 * override for musb_hdrc (avoids txdma ovhead)
 			 */
-			ncm->port.is_zlp_ok = !(
-				gadget_is_musbhdrc(cdev->gadget)
-				);
+			ncm->port.is_zlp_ok =
+				gadget_is_zlp_supported(cdev->gadget);
 			ncm->port.cdc_filter = DEFAULT_FILTER;
 			DBG(cdev, "activate ncm\n");
 			net = gether_connect(&ncm->port);
-- 
1.9.1
