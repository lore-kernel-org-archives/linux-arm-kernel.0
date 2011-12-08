From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  8 Dec 2011 16:32:01 +0100
Subject: [PATCH 2/2] ARM: at91: usb ohci rename vbus_pin_inverted to
 vbus_pin_active_low
In-Reply-To: <1323358321-19918-1-git-send-email-plagnioj@jcrosoft.com>
References: <1323358321-19918-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1323358321-19918-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as everywhere else and allow to configure independently each vbus_pin

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-usb at vger.kernel.org
---
Hi,

	can we apply via at91 as it's depend on patch already on arm-soc

Best Regarfds,
J.
 arch/arm/mach-at91/include/mach/board.h |    2 +-
 drivers/usb/host/ohci-at91.c            |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index d0b377b..3b33f07 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -88,7 +88,7 @@ extern void __init at91_add_device_eth(struct macb_platform_data *data);
 struct at91_usbh_data {
 	u8		ports;		/* number of ports on root hub */
 	int		vbus_pin[2];	/* port power-control pin */
-	u8              vbus_pin_inverted;
+	u8              vbus_pin_active_low[2];
 	u8              overcurrent_supported;
 	int             overcurrent_pin[2];
 	u8              overcurrent_status[2];
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index dc33517..77afabc 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -244,7 +244,8 @@ static void ohci_at91_usb_set_power(struct at91_usbh_data *pdata, int port, int
 	if (!gpio_is_valid(pdata->vbus_pin[port]))
 		return;
 
-	gpio_set_value(pdata->vbus_pin[port], !pdata->vbus_pin_inverted ^ enable);
+	gpio_set_value(pdata->vbus_pin[port],
+		       !pdata->vbus_pin_active_low[port] ^ enable);
 }
 
 static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
@@ -255,7 +256,8 @@ static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
 	if (!gpio_is_valid(pdata->vbus_pin[port]))
 		return -EINVAL;
 
-	return gpio_get_value(pdata->vbus_pin[port]) ^ !pdata->vbus_pin_inverted;
+	return gpio_get_value(pdata->vbus_pin[port]) ^
+		!pdata->vbus_pin_active_low[port];
 }
 
 /*
-- 
1.7.7
