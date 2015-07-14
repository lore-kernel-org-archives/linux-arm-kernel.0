From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:39:18 +0200
Subject: [PATCH v2 30/48] usb: gadget: s3c-hsudc: add ep capabilities support
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-31-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/s3c-hsudc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 85a712a..e9def42 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -1005,6 +1005,21 @@ static void s3c_hsudc_initep(struct s3c_hsudc *hsudc,
 	hsep->stopped = 0;
 	hsep->wedge = 0;
 
+	if (epnum == 0) {
+		hsep->ep.caps.type_control = true;
+		hsep->ep.caps.dir_in = true;
+		hsep->ep.caps.dir_out = true;
+	} else {
+		hsep->ep.caps.type_iso = true;
+		hsep->ep.caps.type_bulk = true;
+		hsep->ep.caps.type_int = true;
+	}
+
+	if (epnum & 1)
+		hsep->ep.caps.dir_in = true;
+	else
+		hsep->ep.caps.dir_out = true;
+
 	set_index(hsudc, epnum);
 	writel(hsep->ep.maxpacket, hsudc->regs + S3C_MPR);
 }
-- 
1.9.1
