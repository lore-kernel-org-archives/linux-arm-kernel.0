From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 18:24:33 +0100
Subject: [PATCHv3 0/2] USB: gadget: atmel_usba_udc: Enable/disable USB PLL on
 Vbus change
In-Reply-To: <20150118175621.6b519cdc@bbrezillon>
References: <20150118175621.6b519cdc@bbrezillon>
Message-ID: <1421601875-9436-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce
power consumption if USB PLL is not already necessary for OHCI or EHCI.
If USB host is not connected we can sleep with USB PLL stopped.

This driver does not support suspend/resume yet, not suspending if we
are still attached to an USB host is fine for what I need, this patch
allow suspending with USB PLL stopped when USB device is not currently
used.

Changes since v2:
  * Use spin_lock_irqsave/unlock_irqrestore instead of spin_lock/unlock in
    threaded interrupt because we are not in irq context anymore
  * Removed useless and probably harmful IRQF_NO_SUSPEND from
    devm_request_threaded_irq() flags

Changes since v1:
  * Using a threaded irq and mutex instead of spinclock as suggested
  * Moved a silently fixed bug in a separate patch (1/2)

Sylvain Rochet (2):
  USB: gadget: atmel_usba_udc: Fixed vbus_prev initial state
  USB: gadget: atmel_usba_udc: Enable/disable USB PLL on Vbus change

 drivers/usb/gadget/udc/atmel_usba_udc.c | 98 ++++++++++++++++++++++++---------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++
 2 files changed, 76 insertions(+), 26 deletions(-)

-- 
2.1.4
