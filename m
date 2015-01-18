From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 15:51:19 +0100
Subject: [PATCHv2 0/2] USB: gadget: atmel_usba_udc: Enable/disable USB PLL on
 Vbus change
In-Reply-To: <20150117110710.GB24176@gradator.net>
References: <20150117110710.GB24176@gradator.net>
Message-ID: <1421592681-28317-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce
power consumption if USB PLL is not already necessary for OHCI or EHCI.
If USB host is not connected we can sleep with USB PLL stopped.

This driver does not support suspend/resume yet, not suspending if we
are still attached to an USB host is fine for what I need, this patch
allow suspending with USB PLL stopped when USB device is not currently
used.

Change since v1:
  * Using a threaded irq and mutex instead of spinclock as suggested
  * Moved a silently fixed bug in a separate patch (1/2)

Sylvain Rochet (2):
  USB: gadget: atmel_usba_udc: Fixed vbus_prev initial state
  USB: gadget: atmel_usba_udc: Enable/disable USB PLL on Vbus change

 drivers/usb/gadget/udc/atmel_usba_udc.c | 97 ++++++++++++++++++++++++---------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++
 2 files changed, 75 insertions(+), 26 deletions(-)

-- 
2.1.4
