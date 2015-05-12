From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 12 May 2015 09:26:24 +0530
Subject: [PATCH v8 0/9] Tegra xHCI support
In-Reply-To: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
Message-ID: <CABb+yY2WhH2gGbCr4n=m9HOa_843MuZDp=QWNDHbtB8AMYYwYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 4, 2015 at 11:06 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
>  - patches 1, 2, and 3: minor cleanups for mailbox framework and xHCI,
>  - patches 4 and 5: adding an MFD driver for the XUSB cmoplex,
>  - patches 6 and 7: adding a driver for the mailbox used to communicate
>    with the xHCI controller's firmware, and
>  - patches 8 and 9: adding a xHCI host-controller driver.
>
> The addition of USB PHY support to the XUSB padctl driver has been dropped.
> Thierry will be posting those patches later.
>
> Given the many compile and run-time dependencies in this series, it is probably
> best if the first 3 patches are picked up by the relevant maintainers in topic
> branches so that the remainder of the series can go through the Tegra tree.
>
> Tested on Jetson TK1 and Nyan-Big with a variety of USB2.0 and USB3.0 memory
> sticks and ethernet dongles.  This has also been tested, with additional
> out-of-tree patches, on Tegra132 and Tegra210 based boards.
>
> Based on v4.1-rc2.  A branch with the entire series is available at:
>   https://github.com/abrestic/linux/tree/tegra-xhci-v8
>
> Cc: Jon Hunter <jonathanh@nvidia.com>
>
> Changes from v7:
>  - Move non-shared resources into child nodes of MFD.
>  - Fixed a couple of mailbox driver bugs.
>
> Changes from v6:
>  - Dropped PHY changes from series.  Will be posted later by Thierry.
>  - Added an MFD device with the mailbox and xHCI host as sub-devices.
>
> Changes from v5:
>  - Addressed review comments from Jassi and Felipe.
>
> Changes from v4:
>  - Made USB support optional in padctl driver.
>  - Made usb3-port a pinconfig property again.
>  - Cleaned up mbox_request_channel() error handling and allowed it to defer
>    probing (patch 3).
>  - Minor xHCI (patch 1) and mailbox framework (patch 2) cleanups suggested
>    by Thierry.
>  - Addressed Thierry's review comments.
>
> Changes from v3:
>  - Fixed USB2.0 flakiness on Jetson-TK1.
>  - Switched to 32-bit DMA mask for host.
>  - Addressed Stephen's review comments.
>
> Chagnes from v2:
>  - Dropped mailbox channel specifier.  The mailbox driver allocates virtual
>    channels backed by the single physical channel.
>  - Added support for HS_CURR_LEVEL adjustment pinconfig property, which
>    will be required for the Blaze board.
>  - Addressed Stephen's review comments.
>
> Changes from v1:
>  - Converted mailbox driver to use the common mailbox framework.
>  - Fixed up host driver so that it can now be built and used as a module.
>  - Addressed Stephen's review comments.
>  - Misc. cleanups.
>
> Andrew Bresticker (8):
>   xhci: Set shared HCD's hcd_priv in xhci_gen_setup
>   mailbox: Make mbox_chan_ops const
>   mfd: Add binding document for NVIDIA Tegra XUSB
>   mfd: Add driver for NVIDIA Tegra XUSB
>   mailbox: Add NVIDIA Tegra XUSB mailbox binding
>   mailbox: Add NVIDIA Tegra XUSB mailbox driver
>   usb: Add NVIDIA Tegra xHCI controller binding
>   usb: xhci: Add NVIDIA Tegra xHCI host-controller driver
>
> Benson Leung (1):
>   mailbox: Fix up error handling in mbox_request_channel()
>
>  .../bindings/mailbox/nvidia,tegra124-xusb-mbox.txt |  32 +
>  .../bindings/mfd/nvidia,tegra124-xusb.txt          |  37 +
>  .../bindings/usb/nvidia,tegra124-xhci.txt          |  96 +++
>  drivers/mailbox/Kconfig                            |   8 +
>  drivers/mailbox/Makefile                           |   2 +
>  drivers/mailbox/arm_mhu.c                          |   2 +-
>  drivers/mailbox/mailbox-altera.c                   |   2 +-
>  drivers/mailbox/mailbox.c                          |  11 +-
>  drivers/mailbox/omap-mailbox.c                     |   8 +-
>  drivers/mailbox/pcc.c                              |   2 +-
>  drivers/mailbox/tegra-xusb-mailbox.c               | 290 +++++++
>  drivers/mfd/Kconfig                                |   7 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/tegra-xusb.c                           |  75 ++
>  drivers/usb/host/Kconfig                           |  10 +
>  drivers/usb/host/Makefile                          |   1 +
>  drivers/usb/host/xhci-pci.c                        |   5 -
>  drivers/usb/host/xhci-plat.c                       |   5 -
>  drivers/usb/host/xhci-tegra.c                      | 947 +++++++++++++++++++++
>  drivers/usb/host/xhci.c                            |   6 +-
>  include/linux/mailbox_controller.h                 |   2 +-
>  include/soc/tegra/xusb.h                           |  43 +
>  22 files changed, 1568 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt
>  create mode 100644 drivers/mailbox/tegra-xusb-mailbox.c
>  create mode 100644 drivers/mfd/tegra-xusb.c
>  create mode 100644 drivers/usb/host/xhci-tegra.c
>  create mode 100644 include/soc/tegra/xusb.h
>
Applied patches 2, 3, 6 & 7

Thanks.
