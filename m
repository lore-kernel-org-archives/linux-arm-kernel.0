From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 15 Jan 2017 23:20:27 +0100
Subject: [PATCH 0/2] add support for uart_AO_B
Message-ID: <20170115222029.8271-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the uart_AO_B serial port and the related pinctrl nodes to
meson-gx.

Due to a bug in the current GXBB and GXL/GXM pinctrl code uart_AO_B
could not be used when uart_AO(_A) was enabled at the same time. The
reason for this is that uart_AO_A and uart_AO_B were both trying to
request the same pin as their RX pin (GPIOAO_1). uart_AO_B also
requests a second pin for it's RX (GPIOAO_5), which does not make any
sense.
Thus uart_AO_B is changed to only use GPIOAO_5 for RX and GPIOAO_4
for TX, which is also what the Amlogic reference kernel does.

Adding uart_AO_B is preparation work for adding support for the
Khadas VIM and VIM Pro boards, as these are both exposing uart_AO_B
on the pin-header.


Martin Blumenstingl (2):
  pinctrl: meson: fix uart_ao_b for GXBB and GXL/GXM
  ARM64: dts: meson-gx: add the missing uart_AO_B

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 7 +++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 7 +++----
 drivers/pinctrl/meson/pinctrl-meson-gxl.c   | 7 +++----
 5 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.11.0
