From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:31:50 +0200
Subject: [PATCH v3 03/46] usb: gadget: add endpoint capabilities helper macros
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-4-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macros useful while initializing array of endpoint capabilities
structures. These macros makes structure initialization more compact
to decrease number of code lines and increase readability of code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 include/linux/usb/gadget.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 6f3e0fb..e6cbc25 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -158,6 +158,26 @@ struct usb_ep_caps {
 	unsigned dir_out:1;
 };
 
+#define USB_EP_CAPS_TYPE_CONTROL     0x01
+#define USB_EP_CAPS_TYPE_ISO         0x02
+#define USB_EP_CAPS_TYPE_BULK        0x04
+#define USB_EP_CAPS_TYPE_INT         0x08
+#define USB_EP_CAPS_TYPE_ALL \
+	(USB_EP_CAPS_TYPE_ISO | USB_EP_CAPS_TYPE_BULK | USB_EP_CAPS_TYPE_INT)
+#define USB_EP_CAPS_DIR_IN           0x01
+#define USB_EP_CAPS_DIR_OUT          0x02
+#define USB_EP_CAPS_DIR_ALL  (USB_EP_CAPS_DIR_IN | USB_EP_CAPS_DIR_OUT)
+
+#define USB_EP_CAPS(_type, _dir) \
+	{ \
+		.type_control = !!(_type & USB_EP_CAPS_TYPE_CONTROL), \
+		.type_iso = !!(_type & USB_EP_CAPS_TYPE_ISO), \
+		.type_bulk = !!(_type & USB_EP_CAPS_TYPE_BULK), \
+		.type_int = !!(_type & USB_EP_CAPS_TYPE_INT), \
+		.dir_in = !!(_dir & USB_EP_CAPS_DIR_IN), \
+		.dir_out = !!(_dir & USB_EP_CAPS_DIR_OUT), \
+	}
+
 /**
  * struct usb_ep - device side representation of USB endpoint
  * @name:identifier for the endpoint, such as "ep-a" or "ep9in-bulk"
-- 
1.9.1
