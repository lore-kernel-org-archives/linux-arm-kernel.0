From: gregkh@suse.de (Greg Kroah-Hartman)
Date: Tue, 10 Aug 2010 14:49:41 -0700
Subject: [PATCH 081/148] USB: otg/ulpi.c : fix register write
In-Reply-To: <20100810214419.GA17385@kroah.com>
References: <20100810214419.GA17385@kroah.com>
Message-ID: <1281477048-17635-81-git-send-email-gregkh@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric B?nard <eric@eukrea.com>

ulpi_set_vbus and ulpi_set_flags are using ULPI_SET(register) to write
to the PHY's registers, which means we can only set bits in the PHY's
register and not clear them.
By directly using the address of the register without any offset, we
now get the expected behaviour for these functions.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/otg/ulpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
index d331b22..10a1df6 100644
--- a/drivers/usb/otg/ulpi.c
+++ b/drivers/usb/otg/ulpi.c
@@ -54,7 +54,7 @@ static int ulpi_set_flags(struct otg_transceiver *otg)
 	if (otg->flags & USB_OTG_EXT_VBUS_INDICATOR)
 		flags |= ULPI_OTG_CTRL_EXTVBUSIND;
 
-	return otg_io_write(otg, flags, ULPI_SET(ULPI_OTG_CTRL));
+	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
 }
 
 static int ulpi_init(struct otg_transceiver *otg)
@@ -95,7 +95,7 @@ static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
 			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
 	}
 
-	return otg_io_write(otg, flags, ULPI_SET(ULPI_OTG_CTRL));
+	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
 }
 
 struct otg_transceiver *
-- 
1.7.2
