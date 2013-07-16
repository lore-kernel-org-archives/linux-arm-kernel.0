From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 16 Jul 2013 17:03:15 +0200
Subject: [PATCH v3 0/7] ARM: at91: prepare transition to common clk framework
Message-ID: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series prepares the transition to common clk framework by
1) replacing all the clk_enable and clk_disable calls by clk_prepare_unable and
   clk_disable_unprepare to avoid common clock framework warnings.
2) adding explicit configuration of clk (set_rate) within drivers instead of
   default configuration done in arch/arm/mach-at91/clock.c (udc and ohci
   drivers)

If the second part of this patch series (the last 2 patches) does not belong
here, please tell me and I'll move it into the "move to common clk framework"
series.

Best Regards,
Boris

Changes since v2:
 - add configuraton of usb clock in ohci and udc drivers
 - add clk_prepare patch for usba udc driver
 - add clk_prepare patch for spi driver
 - remove already applied udc clk_prepare patch

Changes since v1:
 - remove unneeded clk_unprepare in mci driver
 - remove already applied patches (ehci, ohci, dma and serial)

Changes since common clk patch series:
 - add clk_prepare_enable return check
 - fix a deadlock in atmel-mci (missing spin_unlock)
 - remove already applied patches (atmel-ssc and pwm-atmel-tcb)


Boris BREZILLON (7):
  ARM: at91/tc/clocksource: replace clk_enable/disable with
    clk_prepare_enable/disable_unprepare.
  mmc: atmel-mci: prepare clk before calling enable
  at91/avr32/atmel_lcdfb: prepare clk before calling enable
  USB: gadget: atmel_usba: prepare clk before calling enable
  spi: atmel: prepare clk before calling enable
  USB: ohci-at91: add usb_clk for transition to common clk framework
  usb: gadget: at91_udc: add usb_clk for transition to common clk
    framework

 drivers/clocksource/tcb_clksrc.c    |   10 +++++-----
 drivers/mmc/host/atmel-mci.c        |   27 ++++++++++++++++++---------
 drivers/spi/spi-atmel.c             |   12 +++++++-----
 drivers/usb/gadget/at91_udc.c       |   12 ++++++++++++
 drivers/usb/gadget/at91_udc.h       |    2 +-
 drivers/usb/gadget/atmel_usba_udc.c |   28 +++++++++++++++++++++-------
 drivers/usb/host/ohci-at91.c        |   18 +++++++++++++++---
 drivers/video/atmel_lcdfb.c         |    8 ++++----
 8 files changed, 83 insertions(+), 34 deletions(-)

-- 
1.7.9.5
