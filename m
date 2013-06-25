From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue, 25 Jun 2013 11:53:22 +0530
Subject: [PATCH V3 0/6]  USB: OHCI: more bus glues as separate modules 
In-Reply-To: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1372141408-9894-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are for separating the SOC On-Chip ohci host controller
from ohci-hcd host code into its own driver module.
This work is part of enabling multi-platform kernels on ARM;
it would be nice to have in 3.11.

V2:
  In patch 5/6 and 6/6:
  -Set non-standard fields in hc_driver manually, rather than
   relying on an expanded struct ohci_driver_overrides.
  -Save orig_ohci_hub_control and orig_ohci_hub_status_data rather than
   relying on ohci_hub_control and hub_status_data being exported.

  In patch 1/6 to 4/6
  -ohci_setup() has been removed because it is called in .reset member
   of the ohci_hc_driver structure.

V3:
 In patch 5/6 and 6/6:
 -ohci_setup() has been removed because it is called in .reset member
  of the ohci_hc_driver structure.
 
 In patch 5/6:
 -The ohci_restart() function is not required in  current scenario,
  only discarding connection state of integrated transceivers is sufficient,
  for this directly handling ohci->hc_control.
 
 In patch 2/6 :
 -rewritten if (config->otg || config->rwc) block statements into
  two separate 'if blocks' to handle below scenarios
  1. config->otg set scenario.
  2. if any of these (config->otg, config->rwc) are set, this
     scenario should be handled only after ohci_setup()

 In patch 1/6 and 4/6:
  No change. 

Manjunath Goudar (6):
  USB: OHCI: make ohci-exynos a separate driver
  USB: OHCI: make ohci-omap a separate driver
  USB: OHCI: make ohci-omap3 a separate driver
  USB: OHCI: make ohci-spear a separate driver
  USB: OHCI: make ohci-at91 a separate driver
  USB: OHCI: make ohci-s3c2410 a separate driver

 drivers/usb/host/Kconfig        |   30 ++++++-
 drivers/usb/host/Makefile       |    6 ++
 drivers/usb/host/ohci-at91.c    |  151 ++++++++++++++++-------------------
 drivers/usb/host/ohci-exynos.c  |  167 ++++++++++++++++-----------------------
 drivers/usb/host/ohci-hcd.c     |  108 -------------------------
 drivers/usb/host/ohci-omap.c    |  157 +++++++++++++-----------------------
 drivers/usb/host/ohci-omap3.c   |  113 ++++++++------------------
 drivers/usb/host/ohci-s3c2410.c |  128 +++++++++++++-----------------
 drivers/usb/host/ohci-spear.c   |  140 +++++++++++++-------------------
 9 files changed, 369 insertions(+), 631 deletions(-)

-- 
1.7.9.5
