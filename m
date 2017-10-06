From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri,  6 Oct 2017 12:13:28 +0200
Subject: [PATCH 00/16] Support armada-37xx second UART port
Message-ID: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for the armada-37xx extended UART port. The new
capabilities of this IP compared to the standard port are the possibility
to use DMA, it has bigger FIFOs (128 bytes instead of 32/64), it is
possible to fill the FIFO byte-per-byte or 4 bytes at a time, it as RTC
and CTS control, it supports transfer count for RX/TX with transfer
finish status and finally it may achieve higher baudrates by the use of
special dividers.

Almost none of these extended features is implemented though. For now,
the extended UART is just supported with the same features as the
standard UART.

This IP is present on the Armada 3720 SoC and is now enabled by the
device tree related patches on the Armada-3720-DB. As adding the node to
enable the second port on Armada-3720-ESPRESSObin could break existing
users by changing the configuration of some pins on the main headers,
only a side note is added on how to do it easily.

- The driver patches should go through Greg KH.
- The DT patches should go through the mvebu maintainers.
- We would also like the DT binding documentation update to go through
  the mvebu maintainers, as it conflicts with another DT change.

Thank you,
Miquel

Allen Yan (5):
  serial: mvebu-uart: support probe of multiple ports
  serial: mvebu-uart: add soft reset at probe
  serial: mvebu-uart: add function to change baudrate
  serial: mvebu-uart: clear state register before IRQ request
  serial: mvebu-uart: add TX interrupt trigger for pulse interrupts

Miquel Raynal (10):
  dt-bindings: mvebu-uart: update documentation with extended UART
  pinctrl: dt-bindings: Fix A37xx uart2 group name
  serial: mvebu-uart: use a generic way to access the registers
  serial: mvebu-uart: dissociate RX and TX interrupts
  serial: mvebu-uart: augment the maximum number of ports
  serial: mvebu-uart: support extended port registers layout
  arm64: dts: marvell: armada-37xx: add UART clock
  arm64: dts: marvell: armada-37xx: add second UART port
  arm64: dts: marvell: armada-3720-db: enable second UART port
  arm64: dts: marvell: armada-3720-espressobin: fill UART nodes

Yehuda Yitschak (1):
  serial: mvebu-uart: use driver name when requesting an interrupt

 .../pinctrl/marvell,armada-37xx-pinctrl.txt        |   4 +-
 .../devicetree/bindings/serial/mvebu-uart.txt      |  49 ++-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   9 +-
 .../boot/dts/marvell/armada-3720-espressobin.dts   |   8 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  19 +-
 drivers/tty/serial/mvebu-uart.c                    | 474 +++++++++++++++++----
 6 files changed, 461 insertions(+), 102 deletions(-)

-- 
2.11.0
