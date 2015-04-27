From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 27 Apr 2015 15:37:13 -0700
Subject: [PATCH V7 0/9] Tegra xHCI support
Message-ID: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
 - patches 1, 2, and 3: minor cleanups for mailbox framework and xHCI,
 - patches 4 and 5: adding an MFD driver for the XUSB cmoplex,
 - patches 6 and 7: adding a driver for the mailbox used to communicate
   with the xHCI controller's firmware, and
 - patches 8 and 9: adding a xHCI host-controller driver.

The addition of USB PHY support to the XUSB padctl driver has been dropped
from v7.  Thierry will be posting those patches later.

Given the many compile and run-time dependencies in this series, it is probably
best if the first 3 patches are picked up by the relevant maintainers in topic
branches so that the remainder of the series can go through the Tegra tree.

Tested on Jetson TK1 and Nyan-Big with a variety of USB2.0 and USB3.0 memory
sticks and ethernet dongles.  This has also been tested, with additional
out-of-tree patches, on a Tegra132-based board.

Based on v4.1-rc1.  A branch with the entire series is available at:
  https://github.com/abrestic/linux/tree/tegra-xhci-v7

Changes from v6:
 - Dropped PHY changes from series.  Will be posted later by Thierry.
 - Added an MFD device with the mailbox and xHCI host as sub-devices.

Changes from v5:
 - Addressed review comments from Jassi and Felipe.

Changes from v4:
 - Made USB support optional in padctl driver.
 - Made usb3-port a pinconfig property again.
 - Cleaned up mbox_request_channel() error handling and allowed it to defer
   probing (patch 3).
 - Minor xHCI (patch 1) and mailbox framework (patch 2) cleanups suggested
   by Thierry.
 - Addressed Thierry's review comments.

Changes from v3:
 - Fixed USB2.0 flakiness on Jetson-TK1.
 - Switched to 32-bit DMA mask for host.
 - Addressed Stephen's review comments.

Chagnes from v2:
 - Dropped mailbox channel specifier.  The mailbox driver allocates virtual
   channels backed by the single physical channel.
 - Added support for HS_CURR_LEVEL adjustment pinconfig property, which
   will be required for the Blaze board.
 - Addressed Stephen's review comments.

Changes from v1:
 - Converted mailbox driver to use the common mailbox framework.
 - Fixed up host driver so that it can now be built and used as a module.
 - Addressed Stephen's review comments.
 - Misc. cleanups.

Andrew Bresticker (8):
  xhci: Set shared HCD's hcd_priv in xhci_gen_setup
  mailbox: Make struct mbox_controller's ops field const
  mfd: Add binding document for NVIDIA Tegra XUSB
  mfd: Add driver for NVIDIA Tegra XUSB
  mailbox: Add NVIDIA Tegra XUSB mailbox binding
  mailbox: Add NVIDIA Tegra XUSB mailbox driver
  usb: Add NVIDIA Tegra xHCI controller binding
  usb: xhci: Add NVIDIA Tegra xHCI host-controller driver

Benson Leung (1):
  mailbox: Fix up error handling in mbox_request_channel()

 .../bindings/mailbox/nvidia,tegra124-xusb-mbox.txt |  30 +
 .../bindings/mfd/nvidia,tegra124-xusb.txt          |  46 +
 .../bindings/usb/nvidia,tegra124-xhci.txt          |  90 ++
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox.c                          |  11 +-
 drivers/mailbox/omap-mailbox.c                     |   6 +-
 drivers/mailbox/tegra-xusb-mailbox.c               | 275 ++++++
 drivers/mfd/Kconfig                                |   7 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/tegra-xusb.c                           | 167 ++++
 drivers/usb/host/Kconfig                           |  10 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/xhci-pci.c                        |   5 -
 drivers/usb/host/xhci-plat.c                       |   5 -
 drivers/usb/host/xhci-tegra.c                      | 946 +++++++++++++++++++++
 drivers/usb/host/xhci.c                            |   6 +-
 include/linux/mailbox_controller.h                 |   2 +-
 include/soc/tegra/xusb.h                           |  49 ++
 19 files changed, 1647 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt
 create mode 100644 drivers/mailbox/tegra-xusb-mailbox.c
 create mode 100644 drivers/mfd/tegra-xusb.c
 create mode 100644 drivers/usb/host/xhci-tegra.c
 create mode 100644 include/soc/tegra/xusb.h

-- 
2.2.0.rc0.207.ga3a616c
