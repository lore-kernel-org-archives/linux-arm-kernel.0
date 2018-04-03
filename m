From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 3 Apr 2018 15:15:50 +0800
Subject: [PATCH v1 0/7] add support for Bluetooth on MT7622 SoC
Message-ID: <cover.1522736996.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Hi,

This patchset introduces built-in Bluetooth support on MT7622 SoC.
And, it should be simple to make an extension to support other
MediaTek SoCs with adjusting a few of changes on the initialization
sequence of the device.

Before the main driver is being introduced, a few of things about
power-domain management should be re-worked for serdev core and MediaTek
SCPSYS to allow the Bluetooth to properly power up.

Patch 2: add a generic way attaching power domain to serdev
Patch 3 and 4: add cleanups with reuse APIs from Linux core
Patch 5: fix a limitation about power enablement Bluetooth depends on
Patch 1, 6 and 7: the major part of adding Bluetooth support to MT7622
	
	Sean

Sean Wang (7):
  dt-bindings: net: bluetooth: Add mediatek-bluetooth
  serdev: add dev_pm_domain_attach|detach()
  soc: mediatek: reuse read[l,x]_poll_timeout helpers
  soc: mediatek: reuse regmap_read_poll_timeout helpers
  soc: mediatek: add a fixed wait for SRAM stable
  Bluetooth: hci_mediatek: Add protocol support for MediaTek serial
    devices
  MAINTAINERS: add an entry for MediaTek Bluetooth driver

 .../devicetree/bindings/net/mediatek-bluetooth.txt |  35 ++
 MAINTAINERS                                        |   8 +
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/hci_mediatek.c                   | 499 +++++++++++++++++++++
 drivers/bluetooth/hci_uart.h                       |   3 +-
 drivers/soc/mediatek/mtk-infracfg.c                |  45 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |  98 ++--
 drivers/tty/serdev/core.c                          |  14 +-
 9 files changed, 610 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_mediatek.c

-- 
2.7.4
