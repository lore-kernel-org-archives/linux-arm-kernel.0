From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 20 Jan 2015 22:23:27 +0100
Subject: [PATCHv4 0/3] USB: gadget: atmel_usba_udc: Start clocks on rising
 edge of the Vbus signal, stop clocks on falling edge of the Vbus signal
Message-ID: <1421789010-21900-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If USB PLL is not necessary for other USB drivers (e.g. OHCI and EHCI) 
reduce power consumption by switching off the USB PLL if no USB Host is 
currently connected to this USB Device.

Changes since v3:
  * Added stable tag for the first patch
  * As suggested, removed the unused check for udc->driver is not NULL in 
    Vbus IRQ by requesting IRQ after udc->driver is set and by releasing 
    IRQ before udc->driver is cleared
  * Rebased the core patch of this series against the just explained changes

Changes since v2:
  * Use spin_lock_irqsave/unlock_irqrestore instead of spin_lock/unlock in
    threaded interrupt because we are not in irq context anymore
  * Removed useless and probably harmful IRQF_NO_SUSPEND from
    devm_request_threaded_irq() flags

Changes since v1:
  * Using a threaded irq and mutex instead of spinclock as suggested
  * Moved a silently fixed bug in a separate patch (1/2)

Sylvain Rochet (3):
  USB: gadget: atmel_usba_udc: Fixed vbus_prev initial state
  USB: gadget: atmel_usba_udc: Enable Vbus signal IRQ in UDC start
    instead of UDC probe
  USB: gadget: atmel_usba_udc: Start clocks on rising edge of the Vbus
    signal, stop clocks on falling edge of the Vbus signal

 drivers/usb/gadget/udc/atmel_usba_udc.c | 130 +++++++++++++++++++++-----------
 drivers/usb/gadget/udc/atmel_usba_udc.h |   4 +
 2 files changed, 89 insertions(+), 45 deletions(-)

-- 
2.1.4
