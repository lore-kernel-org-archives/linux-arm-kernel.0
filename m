From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  9 Jun 2017 11:49:09 +0200
Subject: [PATCH v4 0/7] tty/serial: meson_uart: add support for core clock
 handling
Message-ID: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a re-spin of Helmut Klein's v3 patchset at [0].

Initially, the original patchset was made to enable usage on the non-AO UARTS
not enabled by the Bootloader (uart_B and uart_C), but the patchset needed
an overall change to have clean and stable DT bindings.

The Amlogic Meson UART Driver did not have stable DT bindings and mismatched
clock handling on non-AO UARTs since these "EE" UARTs needs a clock gate to
be ungated to works correctly.
In the same way, the AO UARTs does not need gating and can be used as
Early Consoles.

In the same time, the UART Interfaces can take clock input for the baudrate
generate from either the external Xtal or the internal Bus Clock (clk81).

So new bindings was necessary to meet these requirements and the DT
maintainers requirements.

The "legacy" binding actually used in the driver is left until all the DT
files are switched to the new bindings.

The GX DT has been tested, but the last 4 Meson6/Meson8/b are only
compile-tested, and testing is welcome.
Thus only the first 3 patches can be merged until the Meson6/Meson8/b are
formally tested.

It must be noted that the meson6 cannot work today except using an early
console since the UART driver could not probe without a clocks property.

[0] 20170331165437.26227-1-hgkr.klein at gmail.com

Helmut Klein (3):
  dt-bindings: serial: Add bindings for the Amlogic Meson UARTs
  tty/serial: meson_uart: update to stable bindings
  ARM64: dts: meson-gx: use stable UART bindings with correct gate clock

Neil Armstrong (4):
  ARM: dts: meson: use meson6 UART compatible like other nodes
  ARM: dts: meson6: switch to new bindings for UART nodes
  ARM: dts: meson8: switch to new bindings for UART nodes
  ARM: dts: meson8b: switch to new bindings for UART nodes

 .../bindings/serial/amlogic,meson-uart.txt         |  38 +++++++
 arch/arm/boot/dts/meson.dtsi                       |   8 +-
 arch/arm/boot/dts/meson6.dtsi                      |  28 ++++++
 arch/arm/boot/dts/meson8.dtsi                      |  23 ++++-
 arch/arm/boot/dts/meson8b.dtsi                     |  23 ++++-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |  12 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  25 +++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  25 +++++
 drivers/tty/serial/meson_uart.c                    | 109 +++++++++++++++++++--
 9 files changed, 266 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt

-- 
1.9.1
