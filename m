From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue, 28 May 2013 18:34:48 +0530
Subject: [PATCH V8 0/3] USB: OHCI: Start splitting up the driver
In-Reply-To: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1369746291-21788-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches begins the process of splitting ohci-hcd up into
a core library module and independent pci driver modules.

Patch 1/3 prepares the way by exporting a few functions from ohci-hcd
and adding a new mechanism for platform-specific drivers to initialize
their hc_driver structures.  This deserves to be done in the core
because almost all of the entries in these structures are pure
boilerplate -- practically none of the drivers need to override more
than three of the standard core values.

Change from V7 to V8
ohci_hcd_init() is called by ohci_setup() to make generic ohci 
initialization in all ohci drivers.

Patch 2/3 is part of separating the ohci pci host controller
driver from ohci-hcd host code.
Moved sb800_prefetch() function from ohci-pci.c to pci-quirks.c file
and EXPORTed, this is part of the effort to move the ohci pci related
code to generic pci code.

Change from V7 to V8
no change.

Patch 3/3  separate out ohci-pci into independent driver modules.

Change from V7 to V8
USB_OHCI_HCD_PCI symbol no longer dependence on STB03xxx, PPC_MPC52xx and         
USB_OHCI_HCD_PPC_OF that's what removed.

Manjunath Goudar (3):
  USB: OHCI: prepare to make ohci-hcd a library module
  USB: OHCI: Generic changes to make ohci-pci a separate driver
  USB: OHCI: make ohci-pci a separate driver

 drivers/usb/host/Kconfig      |    6 +-
 drivers/usb/host/Makefile     |    3 +
 drivers/usb/host/ohci-hcd.c   |  134 ++++++++++++++++++++++++++----------
 drivers/usb/host/ohci-hub.c   |    1 -
 drivers/usb/host/ohci-pci.c   |  151 ++++++++++++-----------------------------
 drivers/usb/host/ohci-q.c     |    6 +-
 drivers/usb/host/ohci.h       |   17 +++++
 drivers/usb/host/pci-quirks.c |   13 ++++
 drivers/usb/host/pci-quirks.h |    2 +
 9 files changed, 184 insertions(+), 149 deletions(-)

-- 
1.7.9.5
