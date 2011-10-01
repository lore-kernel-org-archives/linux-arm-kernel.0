From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:33 +0200
Subject: [PATCH 01/26] usb/gadget/pxa25x: is_vbus_present is gone
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent commit obsoleted the is_vbus_present function, so
we must not use it any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/pxa25x_udc.h |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.h b/drivers/usb/gadget/pxa25x_udc.h
index f572c56..6119900 100644
--- a/drivers/usb/gadget/pxa25x_udc.h
+++ b/drivers/usb/gadget/pxa25x_udc.h
@@ -161,8 +161,6 @@ static struct pxa25x_udc *the_controller;
 
 #ifdef DEBUG
 
-static int is_vbus_present(void);
-
 static const char *state_name[] = {
 	"EP0_IDLE",
 	"EP0_IN_DATA_PHASE", "EP0_OUT_DATA_PHASE",
@@ -214,8 +212,7 @@ dump_state(struct pxa25x_udc *dev)
 	u32		tmp;
 	unsigned	i;
 
-	DMSG("%s %s, uicr %02X.%02X, usir %02X.%02x, ufnr %02X.%02X\n",
-		is_vbus_present() ? "host " : "disconnected",
+	DMSG("%s, uicr %02X.%02X, usir %02X.%02x, ufnr %02X.%02X\n",
 		state_name[dev->ep0state],
 		UICR1, UICR0, USIR1, USIR0, UFNRH, UFNRL);
 	dump_udccr("udccr");
@@ -232,9 +229,6 @@ dump_state(struct pxa25x_udc *dev)
 	} else
 		DMSG("ep0 driver '%s'\n", dev->driver->driver.name);
 
-	if (!is_vbus_present())
-		return;
-
 	dump_udccs0 ("udccs0");
 	DMSG("ep0 IN %lu/%lu, OUT %lu/%lu\n",
 		dev->stats.write.bytes, dev->stats.write.ops,
-- 
1.7.5.4
