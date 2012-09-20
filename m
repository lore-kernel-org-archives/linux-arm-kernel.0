From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:53:11 +0200
Subject: [RFC 0/6] pinctrl: samsung: Remove static platform-specific data
Message-ID: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC series is a work on replacing static platform-specific data in
pinctrl-samsung driver with data dynamically parsed from device tree.

It aims at reducing the SoC-specific part of the driver and thus the
amount of modifications to driver sources when adding support for next
SoCs (like Exynos4x12).

Furthermore, moving definitions of pin banks to device tree will allow
to simplify GPIO and GEINT specification to a format similar to used
previously by gpiolib-based implementation, using a phandle to the bank
and pin index inside the bank, e.g.
	gpios = <&gpa1 4 0>;
	interrupt-parent = <&gpa1>;
	interrupts = <4 0>;

Any comments are welcome.

TODO:
 - bindings documentation
 - per-bank GPIO and GEINT specification

Tomasz Figa (6):
  pinctrl: exynos: Parse wakeup-eint parameters from DT
  pinctrl: samsung: Parse pin banks from DT
  pinctrl: exynos: Remove static platform-specific data
  pinctrl: samsung: Parse bank-specific eint offset from DT
  ARM: dts: exynos4210: Remove legacy gpio nodes
  ARM: dts: exynos4210: Add platform-specific descriptions for pin
    controllers

 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi | 605 ++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi       |   2 +
 arch/arm/boot/dts/exynos4210.dtsi               | 241 +---------
 drivers/pinctrl/pinctrl-exynos.c                | 124 ++---
 drivers/pinctrl/pinctrl-exynos.h                | 157 ------
 drivers/pinctrl/pinctrl-samsung.c               | 153 +++++-
 drivers/pinctrl/pinctrl-samsung.h               |  19 +-
 7 files changed, 813 insertions(+), 488 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi

-- 
1.7.12
