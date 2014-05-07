From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  7 May 2014 15:52:06 +0200
Subject: [PATCHv4 00/20] USB support for Armada 38x and Armada 375
Message-ID: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds the USB support for the Armada 38x and Armada 375
SOCs. These SoCs use an xHCI but still need specific initialization,
mainly to setup the MBus memory windows. They also have another USB
controller for EHCI, identical to the one used on other mvebu SOCs.

This series is also available in
the branch USB-375-38x-3.15-rc1-V4
https://github.com/MISL-EBU-System-SW/mainline-public.git

Changes since v3:

 * Additional patch that removes the use of of_irq_parse_and_map() in
   ehci-orion, and just uses platform_get_irq() instead, to avoid a
   different case between DT and non-T.

 * Additional patch that renames the ehci-orion error handling goto
   labels to have more meaningful names, in preparation for handling
   of additional error cases in followup patches.

 * Additional patch to update the ehci-orion Device Tree binding
   documentation.

 * Merge of 375/38x XHCI support patches: one patch for the driver,
   one patch for the Device Tree binding documentation (instead of one
   patch of these, for each SoC).

 * Update of the XHCI Device Tree binding documentation to indicate
   the new optional clocks property.

 * Update of armada-375.dtsi to add missing spaces in the phy-names
   definition.

 * Update of armada-38x.dtsi to use 0x4000 instead of 0x3fff for the
   register area length. Noticed by Andrew Lunn.

 * Changed the PHY driver Kconfig option to only be enabled either
   when MACH_ARMADA_375 or COMPILE_TEST are enabled. In the previous
   version, the PHY driver was always enabled, regardless of the
   platform.

 * Various improvements to the PHY driver:

    - Rename USB2_PHY_CONFIG_ENABLE to USB2_PHY_CONFIG_DISABLE, as
      suggested by Ezequiel Garcia.
    - Simplify the logic of armada375_usb_phy_init() by handling the
      !cluster_phy->enable case first.
    - Use devm_ioremap_resource() in the ->probe() function instead of
      of_iomap().
    - Bail out from ->probe() when a PHY cannot be created.
    - Fix typos in comments.

 * Reworded the Kconfig prompt and help text of XHCI_MVEBU to indicate
   that it's for both 375 and 38x (it was only indicating 38x until
   now).

 * Changed the Makefile bit of the xhci-mvebu driver according to the
   suggestion of Felipe Balbi, so that things work properly when
   CONFIG_USB_XHCI_MVEBU is 'm'.

 * Various improvements in the ehci-orion driver:

    - Use better goto labels for error handling in ->probe().
    - Use devm_phy_optional_get() instead of devm_phy_get(), which
      allows to handle EPROBE_DEFER cases nicely.
    - Call phy_power_off() when needed (probe error handling, and
      remove).
    - Use __initconst instead of __initdata for override structure, as
      noticed by checkpatch.
    - Fix use after free errors noticed by Felipe Balbi.

 * Various improvements to the XHCI driver:

    - Don't make xhci_mvebu_mbus_config() an __init function, since
      it's called from probe(), which isn't in __init.
    - Don't use the buggy 'priv[0]' solution implemented in the
      previous version of the patch set (see in
      http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/253871.html
      the details of why it doesn't work). Instead, add a 'struct
      clk*' field in xhci_hcd to support the clock in xhci-plat,
      exactly like xhci_hcd has msix_count and msix_entries for
      xhci-pci.
    - Misc minor code style improvements.

Thomas

Gregory CLEMENT (17):
  usb: ehci-orion: fix clock reference leaking
  usb: ehci-orion: add optional PHY support
  usb: host: xhci-plat: sort the headers in alphabetic order
  usb: host: xhci-plat: add clock support
  usb: host: xhci-plat: add support for the Armada 375/38x XHCI
    controllers
  Documentation: dt-bindings: update xhci-platform DT binding
  phy: add support for USB cluster on the Armada 375 SoC
  Documentation: dt-bindings: document the Armada 375 USB cluster
    binding
  ARM: mvebu: add USB3 support for Armada 38x
  ARM: mvebu: add USB3 support for Armada 375
  ARM: configs: enable XHCI mvebu support in mvebu_v7_defconfig
  ARM: configs: enable XHCI mvebu support in multi_v7_defconfig
  ARM: mvebu: add Device Tree description of xHCI controllers on Armada
    38x
  ARM: mvebu: add Device Tree description of the EHCI controller on
    Armada 38x
  ARM: mvebu: add Device Tree description of USB cluster controller on
    Armada 375
  ARM: mvebu: add Device Tree description of the xHCI controller on
    Armada 375
  ARM: mvebu: add Device Tree description of the EHCI controller on
    Armada 375

Thomas Petazzoni (3):
  usb: ehci-orion: use platform_get_irq() for DT probing
  usb: ehci-orion: rename error goto labels in ehci_orion_drv_probe()
  Documentation: dt-bindings: update ehci-orion binding documentation

 .../bindings/phy/armada-375-usb-phy-cluster.txt    |  19 +++
 .../devicetree/bindings/usb/ehci-orion.txt         |   5 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   7 +-
 arch/arm/boot/dts/armada-375-db.dts                |   8 ++
 arch/arm/boot/dts/armada-375.dtsi                  |  34 +++++
 arch/arm/boot/dts/armada-385-db.dts                |  12 ++
 arch/arm/boot/dts/armada-385-rd.dts                |   4 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  25 ++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/mvebu_v7_defconfig                |   1 +
 arch/arm/mach-mvebu/Kconfig                        |   2 +
 drivers/phy/Kconfig                                |   6 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-armada375-usb2.c                   | 157 +++++++++++++++++++++
 drivers/usb/host/Kconfig                           |   8 ++
 drivers/usb/host/Makefile                          |   3 +
 drivers/usb/host/ehci-orion.c                      |  92 ++++++++----
 drivers/usb/host/xhci-mvebu.c                      |  70 +++++++++
 drivers/usb/host/xhci-mvebu.h                      |  21 +++
 drivers/usb/host/xhci-plat.c                       |  42 +++++-
 drivers/usb/host/xhci.h                            |   2 +
 21 files changed, 488 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/armada-375-usb-phy-cluster.txt
 create mode 100644 drivers/phy/phy-armada375-usb2.c
 create mode 100644 drivers/usb/host/xhci-mvebu.c
 create mode 100644 drivers/usb/host/xhci-mvebu.h

-- 
1.9.2
