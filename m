From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:38:53 +0200
Subject: [PATCH v2 05/48] usb: chipidea: udc: add ep capabilities support
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-6-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/chipidea/udc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 764f668..eff7cfb 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1624,6 +1624,20 @@ static int init_eps(struct ci_hdrc *ci)
 
 			hwep->ep.name      = hwep->name;
 			hwep->ep.ops       = &usb_ep_ops;
+
+			if (i == 0) {
+				hwep->ep.caps.type_control = true;
+			} else {
+				hwep->ep.caps.type_iso = true;
+				hwep->ep.caps.type_bulk = true;
+				hwep->ep.caps.type_int = true;
+			}
+
+			if (j == TX)
+				hwep->ep.caps.dir_in = true;
+			else
+				hwep->ep.caps.dir_out = true;
+
 			/*
 			 * for ep0: maxP defined in desc, for other
 			 * eps, maxP is set by epautoconfig() called
-- 
1.9.1
