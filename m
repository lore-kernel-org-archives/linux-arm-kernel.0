From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 12 Nov 2011 16:46:13 +0100
Subject: [PATCH] at91: at91-ohci: fix set/get power
Message-ID: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in commit aa6e52a35 we introduce the support of overcurrent notification
but the set and get of the power without checking if the gpio is valid or not

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/host/ohci-at91.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index ba3a46b..95a9fec 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -223,6 +223,9 @@ static void ohci_at91_usb_set_power(struct at91_usbh_data *pdata, int port, int
 	if (port < 0 || port >= 2)
 		return;
 
+	if (pdata->vbus_pin[port] <= 0)
+		return;
+
 	gpio_set_value(pdata->vbus_pin[port], !pdata->vbus_pin_inverted ^ enable);
 }
 
@@ -231,6 +234,9 @@ static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
 	if (port < 0 || port >= 2)
 		return -EINVAL;
 
+	if (pdata->vbus_pin[port] <= 0)
+		return -EINVAL;
+
 	return gpio_get_value(pdata->vbus_pin[port]) ^ !pdata->vbus_pin_inverted;
 }
 
-- 
1.7.7
