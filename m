From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 26 Dec 2017 10:08:01 +0800
Subject: [RFC PATCH v12 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci
 core
Message-ID: <20171226020806.32710-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Currently we are handling wake irq in mrvl wifi driver. Move it into
pci core.

Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).


Changes in v12:
Enable the wake irq in noirq stage to avoid possible irq storm.

Changes in v11:
Only add irq definitions for PCI devices and rewrite the commit message.
Address Brian's comments.
Only support 1-per-device PCIe WAKE# pin as suggested.
Move to pcie port as Brian suggested.

Changes in v10:
Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
since dedicated wakeirq will be lost in device_set_wakeup_enable(false).

Changes in v9:
Add section for PCI devices and rewrite the commit message.
Fix check error in .cleanup().
Move dedicated wakeirq setup to setup() callback and use
device_set_wakeup_enable() to enable/disable.
Rewrite the commit message.

Changes in v8:
Add optional "pci", and rewrite commit message.
Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
Rewrite the commit message.

Changes in v7:
Move PCIE_WAKE handling into pci core.

Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Move to pci.txt
Rebase.
Use "wakeup" instead of "wake"

Changes in v3:
Fix error handling.

Changes in v2:
Use dev_pm_set_dedicated_wake_irq.

Jeffy Chen (5):
  dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
  of/irq: Adjust of_pci_irq parsing for multiple interrupts
  mwifiex: Disable wakeup irq handling for pcie
  PCI / PM: Add support for the PCIe WAKE# signal for OF
  arm64: dts: rockchip: Move PCIe WAKE# irq to pcie port for Gru

 Documentation/devicetree/bindings/pci/pci.txt | 10 ++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 11 ++--
 drivers/net/wireless/marvell/mwifiex/main.c   |  4 ++
 drivers/of/of_pci_irq.c                       | 74 ++++++++++++++++++++++++--
 drivers/pci/Makefile                          |  1 +
 drivers/pci/pci-driver.c                      | 10 ++++
 drivers/pci/pci-of.c                          | 75 +++++++++++++++++++++++++++
 include/linux/of_pci.h                        |  9 ++++
 8 files changed, 186 insertions(+), 8 deletions(-)
 create mode 100644 drivers/pci/pci-of.c

-- 
2.11.0
