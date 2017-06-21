From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 21 Jun 2017 16:42:10 +0200
Subject: [PATCH v5.1 0/2] tty/serial: meson_uart: add support for core clock
 handling
Message-ID: <1498056132-18508-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a re-spin of Helmut Klein's v3 patchset at [0] and the v4/v5 patchset at [1] & [2].

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

Changes since v5 at [2]:
 - Dropped bindings and tty patch since merged by greg kh into tty next branch
 - Keep old bindings in DT files for retro-compatibility

Changes since v4 at [1]:
 - Droped meson8/meson8b DT patches
 - Fixes copy/paste error in patch 2
 - Refactored clock probing in patch 2
 - merged meson6 patches together to avoid breaking bisect

[0] http://lkml.kernel.org/r/20170331165437.26227-1-hgkr.klein at gmail.com
[1] http://lkml.kernel.org/r/1497001756-942-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1497428957-19942-1-git-send-email-narmstrong at baylibre.com

Helmut Klein (1):
  ARM64: dts: meson-gx: use stable UART bindings with correct gate clock

Neil Armstrong (1):
  ARM: dts: meson6: use stable UART bindings

 arch/arm/boot/dts/meson.dtsi                |  8 ++++----
 arch/arm/boot/dts/meson6.dtsi               | 28 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 12 +++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 25 +++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 25 +++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 11 deletions(-)

-- 
1.9.1
