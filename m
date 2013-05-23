From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 23 May 2013 16:41:43 +0530
Subject: [RFC V6 PATCH 0/3] USB: OHCI: Start splitting up the driver
In-Reply-To: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1369307506-4458-1-git-send-email-manjunath.goudar@linaro.org>
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

Patch 2/3 is part of separating the ohci pci host controller
driver from ohci-hcd host code.
Moved sb800_prefetch() function from ohci-pci.c to pci-quirks.c file 
and EXPORTed, this is part of the effort to move the ohci pci related 
code to generic pci code.

Patch 3/3  separate out ohci-pci into independent driver modules.
 


Manjunath Goudar (3):
  USB: OHCI: prepare to make ohci-hcd a library module
  USB: OHCI: Generic changes to make ohci-pci a separate driver
  USB: OHCI: make ohci-pci a separate driver

 drivers/usb/host/Kconfig      |    4 +-
 drivers/usb/host/Makefile     |    3 +
 drivers/usb/host/ohci-hcd.c   |  129 +++++++++++++++++++++++++---------
 drivers/usb/host/ohci-hub.c   |    1 -
 drivers/usb/host/ohci-pci.c   |  152 ++++++++++++-----------------------------
 drivers/usb/host/ohci-q.c     |    8 ++-
 drivers/usb/host/ohci.h       |   21 ++++++
 drivers/usb/host/pci-quirks.c |   14 ++++
 drivers/usb/host/pci-quirks.h |    3 +
 9 files changed, 189 insertions(+), 146 deletions(-)

-- 
1.7.9.5
