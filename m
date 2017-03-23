From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Mar 2017 17:27:23 +0100
Subject: [RFT PATCH 0/6] pinctrl: meson: Fix gpio-ranged for GPIO Hog
Message-ID: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whem trying to add a gpio hog to enable the USB Hub on the Odroid-C2, I
encountered a strange bug where when calling gpiochip_add_data() the gpiolib
code was trying to add the Hog but failed because the gpio ranges were missing.

In the meson-pinctrl driver, the gpio ranges are added manually /after/ the
call to gpiochip_add_data().
The arch/arm meson8 and meson8b patches has not been tested, this is why this
patchset is an RFT.

So this patchset uses the DT gpio-ranges attribute instead and solves the issue.

The final patch is the actual GPIO Hog for the Odroid-C2 board, which is an ugly
hack but is necessary to have USB Ports working on the board until the generic
power sequence framework is merged.

Neil Armstrong (6):
  ARM64: dts: meson-gxbb: Add gpio-ranges properties
  ARM64: dts: meson-gxl: Add gpio-ranges properties
  ARM: dts: meson8: Add gpio-ranges properties
  ARM: dts: meson8b: Add gpio-ranges properties
  pinctrl: meson: use gpio-ranges from DT
  ARM64: dts: meson-gxbb: Add USB Hub GPIO hog

 arch/arm/boot/dts/meson8.dtsi                       |  2 ++
 arch/arm/boot/dts/meson8b.dtsi                      |  2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi         |  2 ++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi          |  2 ++
 drivers/pinctrl/meson/pinctrl-meson.c               | 14 +-------------
 6 files changed, 24 insertions(+), 13 deletions(-)

-- 
1.9.1
