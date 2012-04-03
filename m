From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  3 Apr 2012 09:32:46 +0200
Subject: [PATCH v2 02/13] USB: ohci-at91: fix vbus_pin_active_low handling
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <9dbb6af7686b5604dec5eebbc54b39be895b1e74.1333437885.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The information is not properly taken into account
for {get|set}_power() functions.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: stable <stable@vger.kernel.org>		[3.2+]
---
 drivers/usb/host/ohci-at91.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index db8963f..4d266ae 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -247,7 +247,7 @@ static void ohci_at91_usb_set_power(struct at91_usbh_data *pdata, int port, int
 		return;
 
 	gpio_set_value(pdata->vbus_pin[port],
-		       !pdata->vbus_pin_active_low[port] ^ enable);
+		       pdata->vbus_pin_active_low[port] ^ enable);
 }
 
 static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
@@ -259,7 +259,7 @@ static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
 		return -EINVAL;
 
 	return gpio_get_value(pdata->vbus_pin[port]) ^
-		!pdata->vbus_pin_active_low[port];
+		pdata->vbus_pin_active_low[port];
 }
 
 /*
-- 
1.7.9.4
