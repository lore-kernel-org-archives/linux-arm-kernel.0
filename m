From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 15 Jan 2017 23:32:51 +0100
Subject: [PATCH 0/4] Bluetooth support for GXBB/GXL/GXM based devices
Message-ID: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the missing kernel bits for Bluetooth support on the
Tronsmart Vega S95 (GXBB based) boards as well as for the GXL
P230/P231 and GXM Q200/Q201 reference boards.

The Bluetooth functionality on these boards is provided by the
SDIO wifi/Bluetooth combo-chip (Broadcom bcm43xx based). The
Bluetooth module on that combo-chip has to be taken out of reset,
which is taken care of the GPIO in the sdio_pwrseq.

Once the module is taken out of reset it can be set up from userspace
using the "hciattach" tool from bluez, which talks to the Bluetooth
module which is connected to one of the serial ports (in our case
uart_A). To get the Bluetooth module initialized within the timeout
defined by "hciattach" (and to achieve usable speeds for Bluetooth
transfers) the communication uses a speed of 2000000 baud, which was
not supported by meson_uart before.

NOTE: The .dts-changes from this series depends on my previous series
"add support for uart_AO_B" - see [0]


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-January/001982.html


Martin Blumenstingl (4):
  tty: serial: meson: allow baud-rates higher than 115200
  ARM64: dts: meson-gx: add the serial CTS and RTS pin groups
  ARM64: dts: meson-gx-p23x-q20x: enable the Bluetooth module
  ARM64: dts: meson-gxbb-vega-s95: enable the Bluetooth module

 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 ++++++-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  9 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 40 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 40 ++++++++++++++++++++++
 drivers/tty/serial/meson_uart.c                    |  2 +-
 5 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.11.0
